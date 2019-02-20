#!/bin/bash
docker build -t mkdocs .
docker run -p 8000:8000 --rm --volume="$PWD:/docs" -it mkdocs mkdocs "$@"
