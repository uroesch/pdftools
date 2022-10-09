#!/usr/bin/env bats

load includes

@test "ocrpdf: Common option --help" {
  output=$(ocrpdf --help 2>&1)
  [[ ${output} =~ ' --help ' ]]
  [[ ${output} =~ ' --lang ' ]]
  [[ ${output} =~ ' --quiet ' ]]
  [[ ${output} =~ ' --recompress ' ]]
  [[ ${output} =~ ' --version ' ]]
}

@test "ocrpdf: Common option -h" {
  output=$(ocrpdf -h 2>&1)
  [[ ${output} =~ ' -h ' ]]
  [[ ${output} =~ ' -l ' ]]
  [[ ${output} =~ ' -q ' ]]
  [[ ${output} =~ ' -R ' ]]
  [[ ${output} =~ ' -V ' ]]
}

@test "ocrpdf: Common option --version" {
  ocrpdf --version | grep -w ${OCRPDF_VERSION}
}

@test "ocrpdf: Common option -V" {
  ocrpdf -V | grep -w ${OCRPDF_VERSION}
}

@test "ocrpdf: OCR pdf with png base" {
  ::pdf-to-images png
  pdf=${TEMP_DIR}/ocrpdf-png.pdf
  ::img2pdf "${pdf}" png
  ocrpdf -q "${pdf}"
  ::is-pdf "${pdf}"
  ::pdf-to-text "${pdf}" "Lorem ipsum" 10
  ::cleanup-tempdir
}

@test "ocrpdf: OCR pdf with tiff base" {
  ::pdf-to-images tiff
  pdf=${TEMP_DIR}/ocrpdf-tiff.pdf
  ::img2pdf "${pdf}" tif
  ocrpdf -q "${pdf}"
  ::is-pdf "${pdf}"
  ::pdf-to-text "${pdf}" "Lorem ipsum" 10
  ::cleanup-tempdir
}

@test "ocrpdf: OCR pdf with jpeg base" {
  ::pdf-to-images jpeg
  pdf=${TEMP_DIR}/ocrpdf-jpeg.pdf
  ::img2pdf "${pdf}" jpg
  ocrpdf -q "${pdf}"
  ::is-pdf "${pdf}"
  ::pdf-to-text "${pdf}" "Lorem ipsum" 10
  ::cleanup-tempdir
}
