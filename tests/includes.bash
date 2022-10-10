# include file for bats tests

# -----------------------------------------------------------------------------
# Globals
# -----------------------------------------------------------------------------
export PATH=${BATS_TEST_DIRNAME}/../bin:${PATH}
export IMG2PDF_VERSION="v0.2.6"
export OCRPDF_VERSION="v0.5.0"
export PDF2PDFA_VERSION="v0.1.2"
export PDFMETA_VERSION="v0.1.5"
export PDFRESIZE_VERSION="v0.0.5"
export SCAN2PDF_VERSION="v0.5.0"
export SCAN2JPG_VERSION="v0.5.0"
export SCAN2PNG_VERSION="v0.5.0"
export FILES_DIR=${BATS_TEST_DIRNAME}/files
export SAMPLE_PDF=lorem-ipsum.pdf
export TZ=UTC

# -----------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------
function ::create-tempdir() {
  local prefix=${1:-pdftools-test};
  local tempdir=${BATS_TMPDIR}/${prefix}-$$
  mkdir -p ${tempdir}
  export TEMP_DIR=${tempdir}
}

function ::cleanup-tempdir() {
  [[ -d ${TEMP_DIR} ]] && rm -rf ${TEMP_DIR} || :
}

function ::is-pdf() {
  local pdf=${1}
  file ${pdf} | grep -q 'PDF document' 2>/dev/null
}

function ::copy-sample-pdf() {
  ::create-tempdir
  cp ${FILES_DIR}/${TEST_PDF} ${TEMP_DIR}
}

function ::pdf-to-images() {
  local format=${1:-jpeg}
  ::create-tempdir
  pdftocairo \
   -${format} \
   ${FILES_DIR}/${SAMPLE_PDF} \
   ${TEMP_DIR}/sample-image
}

function ::pdf-to-text() {
  local pdf=${1}; shift;
  local pattern=${1}; shift;
  local occurrence=${1}; shift;
  pdftotext "${pdf}"
  count=$(grep -c "${pattern}" ${pdf%%.*}.txt 2>/dev/null)
  (( count == occurrence ))
}

function ::img2pdf() {
  local output=${1}; shift;
  local source=${1}; shift;
  img2pdf \
    --output ${output} \
    $(find ${TEMP_DIR} -type f -name "*.${source}")
}
