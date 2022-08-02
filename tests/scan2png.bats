#!/usr/bin/env bats

load includes

@test "scan2png: Common option --help" {
  output=$(scan2png --help 2>&1)
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

@test "scan2png: Common option -h" {
  output=$(scan2png -h 2>&1)
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

@test "scan2png: Common option --version" {
  scan2png --version | grep -w ${SCAN2PNG_VERSION}
}

@test "scan2png: Common option -V" {
  scan2png -V | grep -w ${SCAN2PNG_VERSION}
}
