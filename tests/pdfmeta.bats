#!/usr/bin/env bats

load includes

@test "pdfmeta: Common option --help" {
  output=$(pdfmeta --help 2>&1)
  [[ ${output} =~ ' --help ' ]]
  [[ ${output} =~ ' --keywords ' ]]
  [[ ${output} =~ ' --subject ' ]]
  [[ ${output} =~ ' --title ' ]]
  [[ ${output} =~ ' --creator ' ]]
  [[ ${output} =~ ' --producer ' ]]
  [[ ${output} =~ ' --creation-date ' ]]
  [[ ${output} =~ ' --modification-date ' ]]
  [[ ${output} =~ ' --version ' ]]
}

@test "pdfmeta: Common option -h" {
  output=$(pdfmeta -h 2>&1)
  [[ ${output} =~ ' -h ' ]]
  [[ ${output} =~ ' -k ' ]]
  [[ ${output} =~ ' -s ' ]]
  [[ ${output} =~ ' -t ' ]]
  [[ ${output} =~ ' -c ' ]]
  [[ ${output} =~ ' -p ' ]]
  [[ ${output} =~ ' -C ' ]]
  [[ ${output} =~ ' -M ' ]]
  [[ ${output} =~ ' -V ' ]]
}

@test "pdfmeta: Common option --version" {
  pdfmeta --version | grep -w ${PDFMETA_VERSION}
}

@test "pdfmeta: Common option -V" {
  pdfmeta -V | grep -w ${PDFMETA_VERSION}
}
