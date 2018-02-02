#!/bin/bash
environment=$(terraform workspace show)
echo "api_ip = {$environment = \"$(terraform output ip)\"}" > ./segregation/$environment.auto.tfvars
