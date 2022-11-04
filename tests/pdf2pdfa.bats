#!/usr/bin/env bats

load includes

@test "pdf2pdfa: Common option --help" {
  output=$(pdf2pdfa --help 2>&1)
  [[ ${output} =~ ' --help ' ]]
  [[ ${output} =~ ' --suffix ' ]]
  [[ ${output} =~ ' --version ' ]]
}

@test "pdf2pdfa: Common option -h" {
  output=$(pdf2pdfa -h 2>&1)
  [[ ${output} =~ ' -h ' ]]
  [[ ${output} =~ ' -s ' ]]
  [[ ${output} =~ ' -V ' ]]
}

@test "pdf2pdfa: Common option --version" {
  pdf2pdfa --version | grep -w ${PDF2PDFA_VERSION}
}

@test "pdf2pdfa: Common option -V" {
  pdf2pdfa -V | grep -w ${PDF2PDFA_VERSION}
}
