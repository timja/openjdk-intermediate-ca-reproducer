#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"
pushd ../ca

openssl genrsa -out intermediate.key 2048
openssl req -new -sha256 -nodes -key intermediate.key \
  -subj "/C=UK/ST=ES/O=TIMJA/CN=TIMJA-INTERMEDIATE" -out intermediate.csr

openssl x509 -req \
 -extensions v3_ca \
 -in intermediate.csr \
 -CA root.crt \
 -CAkey root.key \
 -CAcreateserial \
 -out intermediate.crt \
 -days 365 \
 -sha256 \
 -extfile /System/Library/OpenSSL/openssl.cnf

rm -f intermediate.csr

popd
