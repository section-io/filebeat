#!/bin/bash
test -z "${DEBUG}" || set -o xtrace

cd -P -- "$(dirname "${0}")"

readonly filebeat_version=5.4.0
readonly filebeat_sha1=545fbb229c958f2379b17efe3825bf0c30e3039b

readonly tar_url="https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${filebeat_version}-linux-x86_64.tar.gz"
readonly tar_file=$(basename "${tar_url}")

test_hash () {
  printf '%s %s' "${filebeat_sha1}" "${tar_file}" | sha1sum -c - >/dev/null
}


if [ -f "${tar_file}" ]
then
  if test_hash
  then
    exit
  fi
fi

wget --timestamping -- "${tar_url}" \
  && test_hash
