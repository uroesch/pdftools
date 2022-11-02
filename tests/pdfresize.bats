#!/usr/bin/env bats

load includes

@test "pdfresize: Common option --help" {
  output=$(pdfresize --help 2>&1)
  [[ ${output} =~ ' --help ' ]]
  [[ ${output} =~ ' --input ' ]]
  [[ ${output} =~ ' --output ' ]]
  [[ ${output} =~ ' --quality ' ]]
  [[ ${output} =~ ' --version ' ]]
}

@test "pdfresize: Common option -h" {
  output=$(pdfresize -h 2>&1)
  [[ ${output} =~ ' -h ' ]]
  [[ ${output} =~ ' -i ' ]]
  [[ ${output} =~ ' -o ' ]]
  [[ ${output} =~ ' -q ' ]]
  [[ ${output} =~ ' -V ' ]]
}

@test "pdfresize: Common option --version" {
  pdfresize --version | grep -w ${PDFRESIZE_VERSION}
}

@test "pdfresize: Common option -V" {
  pdfresize -V | grep -w ${PDFRESIZE_VERSION}
}

@test "pdfresize: Convert to default" {
  ::pdfresize default
}

@test "pdfresize: Convert to screen" {
  ::pdfresize screen
}

@test "pdfresize: Convert to ebook" {
  ::pdfresize ebook
}

@test "pdfresize: Convert to printer" {
  ::pdfresize printer
}

@test "pdfresize: Convert to prepress" {
  ::pdfresize prepress
}
