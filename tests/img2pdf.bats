#!/usr/bin/env bats

load includes

@test "img2pdf: Common option --version" {
  img2pdf --version | grep -w ${IMG2PDF_VERSION}
}

@test "img2pdf: Common option -V" {
  img2pdf -V | grep -w ${IMG2PDF_VERSION}
}
