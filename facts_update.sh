#!/bin/bash
environment=$(terraform workspace show)
echo "address = {$environment = \"$(terraform output ip)\"}" > ./segregation/$environment.auto.tfvars
