#!/bin/bash

set -e

./docker-mkdocs.sh build
find ../* -maxdepth 0 -type d -not -name mkdocs | xargs rm -rf
mv site/* ..
rmdir site

