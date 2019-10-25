#!/bin/sh

sed -e 's/^#PRIVATE//' < Dockerfile > Dockerfile.full
