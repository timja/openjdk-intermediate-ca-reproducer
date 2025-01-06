#!/usr/bin/env bash

set -ex

cd "$(dirname "$0")"
pushd ../ca

openssl genrsa -out intermediate-2.key 2048
openssl req -new -sha256 -nodes -key intermediate-2.key \
  -subj "/C=UK/ST=ES/O=TIMJA/CN=TIMJA-INTERMEDIATE-2" -out intermediate-2.csr

openssl x509 -req \
 -extensions v3_ca \
 -in intermediate-2.csr \
 -CA intermediate.crt \
 -CAkey intermediate.key \
 -CAcreateserial \
 -out intermediate-2.crt \
 -days 365 \
 -sha256 \
 -extfile /System/Library/OpenSSL/openssl.cnf

rm -f intermediate-2.csr

popd
