#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"
pushd ../ca

openssl genrsa -out enduser-from-root.key 2048
openssl req -new \
  -sha256 \
  -nodes \
  -key enduser-from-root.key \
  -subj "/C=UK/ST=ES/O=TIMJA/CN=localhost" \
  -out enduser-from-root.csr
openssl x509 -req \
 -in enduser-from-root.csr \
 -CA root.crt \
 -CAkey root.key \
 -CAcreateserial \
 -out enduser-from-root.crt \
 -days 90 \
 -extfile <(printf "subjectAltName=DNS:localhost") \
 -sha256

rm -f enduser-from-root.csr

popd
