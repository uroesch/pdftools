#!/usr/bin/env bats

load includes

@test "pdfmeta: Common option --help" {
  output=$(pdfmeta --help 2>&1)
  [[ ${output} =~ ' --help ' ]]
  [[ ${output} =~ ' --keywords ' ]]
  [[ ${output} =~ ' --subject ' ]]
  [[ ${output} =~ ' --title ' ]]
  [[ ${output} =~ ' --creator ' ]]
  [[ ${output} =~ ' --producer ' ]]
  [[ ${output} =~ ' --creation-date ' ]]
  [[ ${output} =~ ' --modification-date ' ]]
  [[ ${output} =~ ' --version ' ]]
}

@test "pdfmeta: Common option -h" {
  output=$(pdfmeta -h 2>&1)
  [[ ${output} =~ ' -h ' ]]
  [[ ${output} =~ ' -k ' ]]
  [[ ${output} =~ ' -s ' ]]
  [[ ${output} =~ ' -t ' ]]
  [[ ${output} =~ ' -c ' ]]
  [[ ${output} =~ ' -p ' ]]
  [[ ${output} =~ ' -C ' ]]
  [[ ${output} =~ ' -M ' ]]
  [[ ${output} =~ ' -V ' ]]
}

@test "pdfmeta: Common option --version" {
  pdfmeta --version | grep -w ${PDFMETA_VERSION}
}

@test "pdfmeta: Common option -V" {
  pdfmeta -V | grep -w ${PDFMETA_VERSION}
}

@test "pdfmeta: Change PDF creator" {
  ::copy-sample-pdf
  pdf="${TEMP_DIR}/${SAMPLE_PDF}"
  pdfmeta --creator 'Batman' "${pdf}"
  ::pdf-info "${pdf}" 'Creator' 'Batman'
}

@test "pdfmeta: Change PDF creation date" {
  ::copy-sample-pdf
  pdf="${TEMP_DIR}/${SAMPLE_PDF}"
  pdfmeta --creation-date '2022-12-06 01:02:03' "${pdf}"
  ::pdf-info "${pdf}" 'CreationDate' 'Tue Dec  6 01:02:03 2022 UTC'
}

@test "pdfmeta: Change PDF modification date" {
  ::copy-sample-pdf
  pdf="${TEMP_DIR}/${SAMPLE_PDF}"
  pdfmeta --modification-date '2022-12-06 11:22:33' "${pdf}"
  ::pdf-info "${pdf}" 'ModDate' 'Tue Dec  6 11:22:33 2022 UTC'
}

@test "pdfmeta: Change PDF keywords" {
  ::copy-sample-pdf
  pdf="${TEMP_DIR}/${SAMPLE_PDF}"
  pdfmeta --keywords 'bats, test' "${pdf}"
  ::pdf-info "${pdf}" 'Keywords' 'bats, test'
}

@test "pdfmeta: Change PDF producer" {
  ::copy-sample-pdf
  pdf="${TEMP_DIR}/${SAMPLE_PDF}"
  pdfmeta --producer 'Bats producer' "${pdf}"
  ::pdf-info "${pdf}" 'Producer' 'Bats producer'
}

@test "pdfmeta: Change PDF subject" {
  ::copy-sample-pdf
  pdf="${TEMP_DIR}/${SAMPLE_PDF}"
  pdfmeta --subject 'Bats subject' "${pdf}"
  ::pdf-info "${pdf}" 'Subject' 'Bats subject'
}

@test "pdfmeta: Change PDF title" {
  ::copy-sample-pdf
  pdf="${TEMP_DIR}/${SAMPLE_PDF}"
  pdfmeta --title 'Bats title' "${pdf}"
  ::pdf-info "${pdf}" 'Title' 'Bats title'
}
