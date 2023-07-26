#!/bin/bash
LazVer="lazarus-2.2.4"
Name=matheusconf/lazarus-crossbuilder

docker image build \
  -t ${Name}:$LazVer \
  -f Dockerfile \
  --build-arg "BUILD_DATE=$(date '+%FT%T%:z')" \
  --build-arg "DESCRICAO=lazarus cross-compiler (Lazarus $LazVer)" \
  --no-cache .
