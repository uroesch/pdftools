#!/usr/bin/env bats

load includes

@test "scan2png: Common option --version" {
  scan2png --version | grep -w ${SCAN2PNG_VERSION}
}

@test "scan2png: Common option -V" {
  scan2png -V | grep -w ${SCAN2PNG_VERSION}
}
