#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"
pushd ../ca

openssl genrsa -out enduser.key 2048
openssl req -new \
  -sha256 \
  -nodes \
  -key enduser.key \
  -subj "/C=UK/ST=ES/O=TIMJA/CN=localhost" \
  -out enduser.csr
openssl x509 -req \
 -in enduser.csr \
 -CA intermediate.crt \
 -CAkey intermediate.key \
 -CAcreateserial \
 -out enduser.crt \
 -days 90 \
 -extfile <(printf "subjectAltName=DNS:localhost") \
 -sha256

rm -f enduser.csr

popd
