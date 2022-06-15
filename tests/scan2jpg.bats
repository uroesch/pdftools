#!/usr/bin/env bats

load includes

@test "scan2jpg: Common option --version" {
  scan2jpg --version | grep -w ${SCAN2JPG_VERSION}
}

@test "scan2jpg: Common option -V" {
  scan2jpg -V | grep -w ${SCAN2JPG_VERSION}
}
