#!/usr/bin/env bats

load includes

@test "scan2pdf: Common option --version" {
  scan2pdf --version | grep -w ${SCAN2PDF_VERSION}
}

@test "scan2pdf: Common option -V" {
  scan2pdf -V | grep -w ${SCAN2PDF_VERSION}
}
