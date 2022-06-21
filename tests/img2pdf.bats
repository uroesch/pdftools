#!/usr/bin/env bats

load includes

@test "img2pdf: Common option --help" {
  output=$(img2pdf --help 2>&1)
  [[ ${output} =~ ' --help ' ]]
  [[ ${output} =~ ' --delete ' ]]
  [[ ${output} =~ ' --output ' ]]
  [[ ${output} =~ ' --rotate ' ]]
  [[ ${output} =~ ' --version ' ]]
}

@test "img2pdf: Common option -h" {
  output=$(img2pdf -h 2>&1)
  [[ ${output} =~ ' -h ' ]]
  [[ ${output} =~ ' -d ' ]]
  [[ ${output} =~ ' -o ' ]]
  [[ ${output} =~ ' -r ' ]]
  [[ ${output} =~ ' -V ' ]]
}

@test "img2pdf: Common option --version" {
  img2pdf --version | grep -w ${IMG2PDF_VERSION}
}

@test "img2pdf: Common option -V" {
  img2pdf -V | grep -w ${IMG2PDF_VERSION}
}
