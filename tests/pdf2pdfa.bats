#!/usr/bin/env bats

load includes

@test "pdf2pdfa: Common option --help" {
  output=$(pdf2pdfa --help 2>&1)
  [[ ${output} =~ ' --color-model ' ]]
  [[ ${output} =~ ' --help ' ]]
  [[ ${output} =~ ' --level ' ]]
  [[ ${output} =~ ' --strict ' ]]
  [[ ${output} =~ ' --suffix ' ]]
  [[ ${output} =~ ' --version ' ]]
}

@test "pdf2pdfa: Common option -h" {
  output=$(pdf2pdfa -h 2>&1)
  [[ ${output} =~ ' -c ' ]]
  [[ ${output} =~ ' -h ' ]]
  [[ ${output} =~ ' -l ' ]]
  [[ ${output} =~ ' -S ' ]]
  [[ ${output} =~ ' -s ' ]]
  [[ ${output} =~ ' -V ' ]]
}

@test "pdf2pdfa: Common option --version" {
  pdf2pdfa --version | grep -w ${PDF2PDFA_VERSION}
}

@test "pdf2pdfa: Common option -V" {
  pdf2pdfa -V | grep -w ${PDF2PDFA_VERSION}
}

@test "pdf2pdfa: Converto to PDF/A-1" {
  # gs 9.26 generates pdf version 1.7 instead of 1.4
  (( ${GS_VERSION} < 950 )) && skip
  ::copy-sample-pdf
  pdf="${TEMP_DIR}/${SAMPLE_PDF}"
  pdf_a="${pdf//.pdf/_a1.pdf}"
  pdf2pdfa --suffix _a1 --level 1 "${pdf}"
  ::pdf-info "${pdf_a}" 'Producer' 'GPL Ghostscript'
  ::pdf-info "${pdf_a}" 'PDF version' '1.4'
  ::pdf-info "${pdf_a}" 'Pages' '5'
}

@test "pdf2pdfa: Converto to PDF/A-2" {
  # gs 9.50 does throw errors in level 2
  (( ${GS_VERSION} < 955 )) && skip
  ::copy-sample-pdf
  pdf="${TEMP_DIR}/${SAMPLE_PDF}"
  pdf_a="${pdf//.pdf/_a2.pdf}"
  # strict doesn't work on gs 9.50
  pdf2pdfa --suffix _a2 --level 2 --strict "${pdf}"
  ::pdf-info "${pdf_a}" 'Producer' 'GPL Ghostscript'
  ::pdf-info "${pdf_a}" 'PDF version' '1.7'
  ::pdf-info "${pdf_a}" 'Pages' '5'
}

@test "pdf2pdfa: Converto to PDF/A-3" {
  ::copy-sample-pdf
  pdf="${TEMP_DIR}/${SAMPLE_PDF}"
  pdf_a="${pdf//.pdf/_a3.pdf}"
  pdf2pdfa --suffix _a3 --level 3 "${pdf}"
  ::pdf-info "${pdf_a}" 'Producer' 'GPL Ghostscript'
  ::pdf-info "${pdf_a}" 'PDF version' '1.7'
  ::pdf-info "${pdf_a}" 'Pages' '5'
}
