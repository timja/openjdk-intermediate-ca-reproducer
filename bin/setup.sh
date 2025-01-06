#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"

./issue-root.sh
./issue-intermediate.sh
./issue-intermediate-2.sh
./issue-leaf.sh
./issue-leaf-from-intermediate-2.sh
./issue-leaf-from-root.sh

docker compose build
