#!/bin/bash
export PATH=$PATH:/usr/local/go/bin
make deps build
chmod +x ../app
