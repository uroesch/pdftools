#!/usr/bin/env bats

load includes

@test "pdfresize: Common option --version" {
  pdfresize --version | grep -w ${PDFRESIZE_VERSION}
}

@test "pdfresize: Common option -V" {
  pdfresize -V | grep -w ${PDFRESIZE_VERSION}
}
