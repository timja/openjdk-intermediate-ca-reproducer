#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"

./issue-root.sh
./issue-intermediate.sh
./issue-leaf.sh

docker compose build