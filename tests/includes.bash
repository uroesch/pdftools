# include file for bats tests

trap ::cleanup EXIT

# -----------------------------------------------------------------------------
# Globals
# -----------------------------------------------------------------------------
export PATH=${BATS_TEST_DIRNAME}/../bin:${PATH}
export IMG2PDF_VERSION="v0.2.6"
export OCRPDF_VERSION="v0.5.0"
export PDFCAT_VERSION="v0.3.0"
export PDF2PDFA_VERSION="v0.2.0"
export PDFMETA_VERSION="v0.1.5"
export PDFRESIZE_VERSION="v0.0.5"
export SCAN2PDF_VERSION="v0.5.0"
export SCAN2JPG_VERSION="v0.5.0"
export SCAN2PNG_VERSION="v0.5.0"
export GS_VERSION=$(gs --version | awk -F . '{ print $1$2 }')
export FILES_DIR=${BATS_TEST_DIRNAME}/files
export SAMPLE_PDF=lorem-ipsum.pdf
export BASE_TEMP_DIR="${HOME}/tmp"
export TEMP_PREFIX=pdftools-test
export TZ=UTC

# -----------------------------------------------------------------------------
# Functions
# -----------------------------------------------------------------------------
function ::cleanup() {
  rm -rf ${BASE_TEMP_DIR}/${TEMP_PREFIX}-[0-9]*
}

function ::create-tempdir() {
  local prefix=${1:-pdftools-test};
  local temp_dir=${BASE_TEMP_DIR}/${TEMP_PREFIX}-$$
  [[ -d ${temp_dir} ]] || mkdir -p ${temp_dir} && :
  export TEMP_DIR="${temp_dir}"
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
  cp ${FILES_DIR}/${SAMPLE_PDF} ${TEMP_DIR}
}

function ::pdf-to-images() {
  local format=${1}; shift;
  local resolution=${1:-}
  ::create-tempdir
  pdftocairo \
   -${format} \
   ${resolution:+-r ${resolution}} \
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

function ::pdf-size() {
  local original="${1}"; shift;
  local resized="${1}"; shift;
  ::is-pdf "${resized}"
  local size_before=$(du -b "${original}" | cut -f 1 )
  local size_after=$(du -b "${resized}" | cut -f 1 )
  (( size_before > size_after ))
}

function ::pdfresize() {
  ::create-tempdir
  local quality="${1}"
  local pdf="${TEMP_DIR}/pdfresize-${quality}.pdf"
  pdfresize \
    --quality ${quality} \
    --input "${FILES_DIR}/${SAMPLE_PDF}" \
    --output "${pdf}"
  ::pdf-size "${FILES_DIR}/${SAMPLE_PDF}" "${pdf}"
}

function ::pdf-info() {
  local pdf="${1}"; shift;
  local key="${1}"; shift;
  local value="${1}"; shift;
  LC_ALL=C TZ=UTC pdfinfo "${pdf}" | grep "${key^}:.*${value}"
}
