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
