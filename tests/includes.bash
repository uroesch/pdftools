# include file for bats tests

# -----------------------------------------------------------------------------
# Globals
# -----------------------------------------------------------------------------
export PATH=${BATS_TEST_DIRNAME}/../bin:${PATH}
export IMG2PDF_VERSION="v0.2.5"
export OCRPDF_VERSION="v0.4.0"
export PDF2PDFA_VERSION="v0.1.2"
export PDFMETA_VERSION="v0.1.5"
export PDFRESIZE_VERSION="v0.0.5"
export SCAN2PDF_VERSION="v0.4.2"
export SCAN2JPG_VERSION="v0.4.2"
export SCAN2PNG_VERSION="v0.4.2"
export TZ=UTC

# -----------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------
function test::create-tempdir() {
  local prefix=${1:-test};
  local tempdir=${BATS_TMPDIR}/${prefix}-$$
  mkdir -p ${tempdir}
  export TEMPDIR=${tempdir}
}
