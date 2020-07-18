SHELL := bash
.ONESHELL:
.SHELLFLAGS := -o errexit -o nounset -o pipefail -c
.DELETE_ON_ERROR:
.RECIPEPREFIX = >
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

DIVIDER    := $$(printf "%0.1s" -{1..80})
OS_FAMILY  := $(shell lsb_release -i -s | tr "A-Z" "a-z")
OS_RELEASE := $(shell lsb_release -r -s)
OS_NAME    := $(OS_FAMILY)_$(OS_RELEASE)

ifeq ($(OS_NAME), ubuntu_20.04)
  ASCIIDOCTOR_DEPENDENCIES := deb::asciidoctor deb::ruby-asciidoctor-pdf 
else
  ASCIIDOCTOR_DEPENDENCIES := deb::asciidoctor gem::asciidoctor-pdf 
endif

asciidoctor_dependencies:
> @echo "Install asciidoctor dependencies $(ASCIIDOCTOR_DEPENDENCIES)"
> for pkg in $(ASCIIDOCTOR_DEPENDENCIES); do
>   method=$${pkg%%::*}
>   name=$${pkg##*::}
>   case $${method} in
>   deb)
>     if dpkg -l $${name} &>/dev/null; then
>       echo "Package $${name} already installed"
>     else
>       sudo apt -y install $${name}
>     fi
>     ;;
>   gem)
>     if gem list $${name} | grep -q ^$${name}; then
>       echo "Ruby Gem $${name} already installed"
>     else  
>       gem install $${name}
>     fi
>     ;;
>   esac
> done
> @echo $(DIVIDER)

docs/README.html: README.adoc
> @echo "Build $<"
> asciidoctor -D docs $<
> @echo $(DIVIDER)

docs/README.pdf: README.adoc
> @echo "Build $<"
> asciidoctor-pdf -D docs $<
> @echo $(DIVIDER)

docs: asciidoctor_dependencies docs/README.html docs/README.pdf

clean:
> rm docs/*.html docs/*.pdf
