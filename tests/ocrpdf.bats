#!/usr/bin/env bats

load includes

@test "ocrpdf: Common option --version" {
  ocrpdf --version | grep -w ${OCRPDF_VERSION}
}

@test "ocrpdf: Common option -V" {
  ocrpdf -V | grep -w ${OCRPDF_VERSION}
}
