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

@test "pdfmeta: Converto to PDF/A-1" {
  ::copy-sample-pdf
  pdf="${TEMP_DIR}/${SAMPLE_PDF}"
  pdf_a="${pdf//.pdf/_a1.pdf}"
  pdf2pdfa --suffix _a1 --level 1 --strict "${pdf}"
  ::pdf-info "${pdf_a}" 'Producer' 'GPL Ghostscript'
  ::pdf-info "${pdf_a}" 'PDF version' '1.4'
  ::pdf-info "${pdf_a}" 'Pages' '5'
}

@test "pdfmeta: Converto to PDF/A-2" {
  ::copy-sample-pdf
  pdf="${TEMP_DIR}/${SAMPLE_PDF}"
  pdf_a="${pdf//.pdf/_a2.pdf}"
  pdf2pdfa --suffix _a2 --level 2 --strict "${pdf}"
  ::pdf-info "${pdf_a}" 'Producer' 'GPL Ghostscript'
  ::pdf-info "${pdf_a}" 'PDF version' '1.7'
  ::pdf-info "${pdf_a}" 'Pages' '5'
}

@test "pdfmeta: Converto to PDF/A-3" {
  ::copy-sample-pdf
  pdf="${TEMP_DIR}/${SAMPLE_PDF}"
  pdf_a="${pdf//.pdf/_a3.pdf}"
  pdf2pdfa --suffix _a3 --level 3 --strict "${pdf}"
  ::pdf-info "${pdf_a}" 'Producer' 'GPL Ghostscript'
  ::pdf-info "${pdf_a}" 'PDF version' '1.7'
  ::pdf-info "${pdf_a}" 'Pages' '5'
}
