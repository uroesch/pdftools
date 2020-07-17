# vim: shiftwidth=2 tabstop=2 noexpandtab :
# -----------------------------------------------------------------------------
# Setup
# -----------------------------------------------------------------------------
SHELL := bash
.ONESHELL:
.SHELLFLAGS := -o errexit -o nounset -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# -----------------------------------------------------------------------------
# Globals
# -----------------------------------------------------------------------------
DIVIDER          t:= $$(printf "%0.1s" -{1..80})
OS_FAMILY        := $(shell lsb_release -i -s | tr "A-Z" "a-z")
OS_RELEASE       := $(shell lsb_release -r -s)
OS_NAME          := $(OS_FAMILY)_$(OS_RELEASE)
USER_BIN         := $(HOME)/bin
REPO_NAME        := $(shell basename $(CURDIR))
BASH_VERSIONS    := 4.0 4.1 4.2 4.3 4.4 5.0 5.1 5.2-rc
DEB_DEPENDENCIES := debhelper dpkg-dev

# -----------------------------------------------------------------------------
# Contidionally assigned globals
# -----------------------------------------------------------------------------
ifeq ($(OS_NAME), ubuntu_18.04)
	ASCIIDOCTOR_DEPENDENCIES := gem:public_suffix:4.0.7 gem:asciidoctor-pdf:1.6.2 

else
	ASCIIDOCTOR_DEPENDENCIES := deb:asciidoctor deb:ruby-asciidoctor-pdf
endif

.PHONY: test

# -----------------------------------------------------------------------------
# Document creation
# -----------------------------------------------------------------------------
asciidoctor_dependencies:
	@echo "Install asciidoctor dependencies $(ASCIIDOCTOR_DEPENDENCIES)"
	for pkg in $(ASCIIDOCTOR_DEPENDENCIES); do
		IFS=: read method name version <<< $${pkg}
		case $${method} in
		deb)
			if dpkg -l $${name} &>/dev/null; then
				echo "Package $${name} already installed"
			else
				sudo apt -y install $${name}
			fi
			;;
		gem)
			if gem list $${name} | grep -q ^$${name}; then
				echo "Ruby Gem $${name} already installed"
			else  
				gem install $${name} $${version:+--version $${version}}
			fi
			;;
		esac
	done
	@echo $(DIVIDER)

asciidoctor_dependencies:
	@echo "Install asciidoctor dependencies $(ASCIIDOCTOR_DEPENDENCIES)"
	for pkg in $(ASCIIDOCTOR_DEPENDENCIES); do
		if dpkg -l $${pkg} &>/dev/null; then
			echo "Package $${pkg} already installed"
		else
			sudo apt -y install $${pkg}
		fi
	done
	@echo $(DIVIDER)

deb_dependencies:
	@echo "Install debian build dependencies $(DEB_DEPENDENCIES)"
	for pkg in $(DEB_DEPENDENCIES); do
		if dpkg -l $${pkg} &>/dev/null; then
			echo "Package $${pkg} already installed"
		else
			sudo apt -y install $${pkg}
		fi
	done
	@echo $(DIVIDER)

deb: deb_dependencies
	@echo "Build debian package"
	dpkg-buildpackage --unsigned-changes --unsigned-source --root-command=fakeroot
	@echo $(DIVIDER)

docs/README.html: README.adoc
	@echo "Build HTML doc $<"
	asciidoctor -D docs $<
	@echo $(DIVIDER)

docs/README.pdf: README.adoc
	@echo "Build PDF doc $<"
	ruby --version
	asciidoctor-pdf --trace -D docs $<
	@echo $(DIVIDER)

docs: asciidoctor_dependencies docs/README.html docs/README.pdf

# -----------------------------------------------------------------------------
# User install
# -----------------------------------------------------------------------------
user_install:
	@echo "Install $(REPO_NAME) under $(USER_BIN)"
	mkdir -p $(USER_BIN) || :
	for script in bin/*; do
		basename=$${script##*/}
		install $${script} $(USER_BIN)/$${basename} &&
		echo "-> Installing $${script} to $(USER_BIN)/$${basename}"
	done

user_uninstall:
	@echo "Uninstall $(REPO_NAME) from $(USER_BIN)"
	for script in bin/*; do
		basename=$${script##*/}
		if [[ -f $(USER_BIN)/$${basename} ]]; then
			rm $(USER_BIN)/$${basename} &&
			echo "-> Unstalling $(USER_BIN)/$${basename}"
		fi
	done

# -----------------------------------------------------------------------------
# Janitor tasks
# -----------------------------------------------------------------------------
clean:
	test -d docs && \
		find docs \( -name "*.pdf" -or -name "*.html" \) -print -delete
# -----------------------------------------------------------------------------
# Run tests
# -----------------------------------------------------------------------------
test:
	bats tests/*bats

test-bash:
	@echo "Bash tests"
	declare -a VERSIONS=( $(BASH_VERSIONS) );
	function  setup() {
		apk add \
			bats \
			curl \
			file \
			grep \
			imagemagick \
			make \
			openjdk11-jre-headless \
			poppler-utils \
			sane-utils \
			tesseract-ocr; \
			curl -sJLO 'https://gitlab.com/pdftk-java/pdftk/-/jobs/812582458/artifacts/raw/build/libs/pdftk-all.jar?inline=false' && \
			mv pdftk-all.jar /usr/lib/ && \
			echo -e "#!/usr/bin/env bash\njava -jar /usr/lib/pdftk-all.jar \"\$$@\"" > /usr/bin/pdftk && \
			chmod 755 /usr/bin/pdftk
	};
	for version in $${VERSIONS[@]}; do
		@echo "Test bash version $${version}"
		docker run \
			--rm \
			--tty \
			--volume $$(pwd):/pdftools \
			--workdir /pdftools \
			bash:$${version} \
			bash -c "$$(declare -f setup); setup &>/dev/null && make test";
	done

# vim: shiftwidth=2 noexpandtab :
