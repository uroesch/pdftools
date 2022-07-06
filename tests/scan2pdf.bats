#!/usr/bin/env bats

load includes

@test "scan2pdf: Common option --help" {
  output=$(scan2pdf --help 2>&1)
  [[ ${output} =~ ' --help ' ]]
  [[ ${output} =~ ' --interactive ' ]]
  [[ ${output} =~ ' --type ' ]]
  [[ ${output} =~ ' --resolution ' ]]
  [[ ${output} =~ ' --page ' ]]
  [[ ${output} =~ ' --depth ' ]]
  [[ ${output} =~ ' --format ' ]]
  [[ ${output} =~ ' --quality ' ]]
  [[ ${output} =~ ' --mode ' ]]
  [[ ${output} =~ ' --ocr ' ]]
  [[ ${output} =~ ' --ocr-lang ' ]]
  [[ ${output} =~ ' --output ' ]]
  [[ ${output} =~ ' --orientation ' ]]
  [[ ${output} =~ ' --scanner ' ]]
  [[ ${output} =~ ' --version ' ]]
  [[ ${output} =~ ' --help ' ]]
}

@test "scan2pdf: Common option -h" {
  output=$(scan2pdf -h 2>&1)
  [[ ${output} =~ ' -h ' ]]
  [[ ${output} =~ ' -I ' ]]
  [[ ${output} =~ ' -t ' ]]
  [[ ${output} =~ ' -r ' ]]
  [[ ${output} =~ ' -p ' ]]
  [[ ${output} =~ ' -d ' ]]
  [[ ${output} =~ ' -f ' ]]
  [[ ${output} =~ ' -q ' ]]
  [[ ${output} =~ ' -m ' ]]
  [[ ${output} =~ ' -R ' ]]
  [[ ${output} =~ ' -L ' ]]
  [[ ${output} =~ ' -o ' ]]
  [[ ${output} =~ ' -O ' ]]
  [[ ${output} =~ ' -s ' ]]
  [[ ${output} =~ ' -V ' ]]
}

@test "scan2pdf: Common option --version" {
  scan2pdf --version | grep -w ${SCAN2PDF_VERSION}
}

@test "scan2pdf: Common option -V" {
  scan2pdf -V | grep -w ${SCAN2PDF_VERSION}
}
