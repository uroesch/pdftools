#!/usr/bin/env bats

load includes

@test "pdfmeta: Common option --version" {
  pdfmeta --version | grep -w ${PDFMETA_VERSION}
}

@test "pdfmeta: Common option -V" {
  pdfmeta -V | grep -w ${PDFMETA_VERSION}
}
