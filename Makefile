# -----------------------------------------------------------------------------
# Setup
# -----------------------------------------------------------------------------
SHELL := bash
.ONESHELL:
.SHELLFLAGS := -o errexit -o nounset -o pipefail -c
.DELETE_ON_ERROR:
.RECIPEPREFIX = >
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# -----------------------------------------------------------------------------
# Globals
# -----------------------------------------------------------------------------
DIVIDER    := $$(printf "%0.1s" -{1..80})
OS_FAMILY  := $(shell lsb_release -i -s | tr "A-Z" "a-z")
OS_RELEASE := $(shell lsb_release -r -s)
OS_NAME    := $(OS_FAMILY)_$(OS_RELEASE)
USER_BIN   := $(HOME)/bin

# -----------------------------------------------------------------------------
# Contidionally assigned globals
# -----------------------------------------------------------------------------
ifeq ($(OS_NAME), ubuntu_20.04)
  ASCIIDOCTOR_DEPENDENCIES := deb::asciidoctor deb::ruby-asciidoctor-pdf 
else
  ASCIIDOCTOR_DEPENDENCIES := deb::asciidoctor gem::asciidoctor-pdf 
endif

# -----------------------------------------------------------------------------
# Document creation
# -----------------------------------------------------------------------------
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

# -----------------------------------------------------------------------------
# User install
# -----------------------------------------------------------------------------
user_install:
> @echo "Install pdftools under $(USER_BIN)"
> mkdir -p $(USER_BIN) || :
> for script in bin/*; do
>   basename=$${script##*/}
>   install $${script} $(USER_BIN)/$${basename} && 
>     echo "-> Installing $${script} to $(USER_BIN)/$${basename}"
> done

user_uninstall:
> @echo "Uninstall pdftools from $(USER_BIN)"
> for script in bin/*; do
>   basename=$${script##*/}
>   if [[ -f $(USER_BIN)/$${basename} ]]; then
>     rm $(USER_BIN)/$${basename} && 
>       echo "-> Unstalling $(USER_BIN)/$${basename}"
>   fi
> done

# -----------------------------------------------------------------------------
# Janitor tasks
# -----------------------------------------------------------------------------
clean:
> rm docs/*.html docs/*.pdf
