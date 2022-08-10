#!/usr/bin/env bats

load includes

@test "img2pdf: Common option --help" {
  output=$(img2pdf --help 2>&1)
  [[ ${output} =~ ' --delete ' ]]
  [[ ${output} =~ ' --help ' ]]
  [[ ${output} =~ ' --output ' ]]
  [[ ${output} =~ ' --rotate ' ]]
  [[ ${output} =~ ' --version ' ]]
}

@test "img2pdf: Common option -h" {
  output=$(img2pdf -h 2>&1)
  [[ ${output} =~ ' -d ' ]]
  [[ ${output} =~ ' -h ' ]]
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

@test "img2pdf: Create pdf from png" {
  ::pdf-to-images png
  pdf=${TEMP_DIR}/img2pdf-from-png.pdf
  ::img2pdf "${pdf}" png
  ::is-pdf "${pdf}"
  ::cleanup-tempdir
}

@test "img2pdf: Create pdf from tiff" {
  ::pdf-to-images tiff
  pdf=${TEMP_DIR}/img2pdf-from-tiff.pdf
  ::img2pdf "${pdf}" tif
  ::is-pdf "${pdf}"
  ::cleanup-tempdir
}

@test "img2pdf: Create pdf from jpeg" {
  ::pdf-to-images jpeg
  pdf=${TEMP_DIR}/img2pdf-from-jpeg.pdf
  ::img2pdf "${pdf}" jpg
  ::is-pdf "${pdf}"
  ::cleanup-tempdir
}
