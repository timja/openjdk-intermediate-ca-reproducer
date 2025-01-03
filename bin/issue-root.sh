#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"
pushd ../ca

openssl genrsa -out root.key 2048
openssl req -x509 -sha256 -nodes -extensions v3_ca -key root.key \
  -subj "/C=UK/ST=ES/O=TIMJA/CN=TIMJA-ROOT" -days 365 -out root.crt

popd