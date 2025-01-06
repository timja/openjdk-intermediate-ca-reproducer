#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"
pushd ../ca

openssl genrsa -out enduser-from-intermediate-2.key 2048
openssl req -new \
  -sha256 \
  -nodes \
  -key enduser-from-intermediate-2.key \
  -subj "/C=UK/ST=ES/O=TIMJA/CN=localhost" \
  -out enduser-from-intermediate-2.csr
openssl x509 -req \
 -in enduser-from-intermediate-2.csr \
 -CA intermediate-2.crt \
 -CAkey intermediate-2.key \
 -CAcreateserial \
 -out enduser-from-intermediate-2.crt \
 -days 90 \
 -extfile <(printf "subjectAltName=DNS:localhost") \
 -sha256

rm -f enduser-from-intermediate-2.csr

popd
