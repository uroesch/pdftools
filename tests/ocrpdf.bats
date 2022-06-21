#!/usr/bin/env bats

load includes

@test "ocrpdf: Common option --help" {
  output=$(ocrpdf --help 2>&1)
  [[ ${output} =~ ' --help ' ]]
  [[ ${output} =~ ' --quiet ' ]]
  [[ ${output} =~ ' --lang ' ]]
  [[ ${output} =~ ' --version ' ]]
}

@test "ocrpdf: Common option -h" {
  output=$(ocrpdf -h 2>&1)
  [[ ${output} =~ ' -h ' ]]
  [[ ${output} =~ ' -q ' ]]
  [[ ${output} =~ ' -l ' ]]
  [[ ${output} =~ ' -V ' ]]
}

@test "ocrpdf: Common option --version" {
  ocrpdf --version | grep -w ${OCRPDF_VERSION}
}

@test "ocrpdf: Common option -V" {
  ocrpdf -V | grep -w ${OCRPDF_VERSION}
}
