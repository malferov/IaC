#!/bin/bash
#packerio validate -var-file=.key/cred.json do_test.json
packerio build -var-file=.key/cred.json do_test.json
