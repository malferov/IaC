#!/bin/bash
printf "{\n\"access_key\": $(terraform output -json -module=management access_key | jq '.value')," > ../account.auto.tfvars.json
printf  "\n\"secret_key\": $(terraform output -json -module=management secret_key | jq '.value')\n}" >> ../account.auto.tfvars.json
