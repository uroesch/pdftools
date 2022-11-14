#!/usr/bin/env bats

load includes

@test "pdfcat: Common option --help" {
  output=$(pdf2pdfa --help 2>&1)
  [[ ${output} =~ ' --help ' ]]
  [[ ${output} =~ ' --version ' ]]
}

@test "pdfcat: Common option -h" {
  output=$(pdfcat -h 2>&1)
  [[ ${output} =~ ' -h ' ]]
  [[ ${output} =~ ' -V ' ]]
}

@test "pdfcat: Common option --version" {
  pdfcat --version | grep -w ${PDFCAT_VERSION}
}

@test "pdfcat: Common option -V" {
  pdfcat -V | grep -w ${PDFCAT_VERSION}
}

@test "pdfcat: Concat two PDFs" {
  ::create-tempdir
  input_pdf=${FILES_DIR}/${SAMPLE_PDF}
  output_pdf=${TEMP_DIR}/output.pdf
  pdfcat "${input_pdf}" "${input_pdf}" > "${output_pdf}"
  ::pdf-info "${output_pdf}" 'Title' "Lorem ipsum"
  ::pdf-info "${output_pdf}" 'Producer' 'Wikisource'
  ::pdf-info "${output_pdf}" 'Pages' '10'
  ::pdf-info "${output_pdf}" 'Page size' 'A4'
}
