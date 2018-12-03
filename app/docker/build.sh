#!/bin/bash
sudo docker build -t app .
sudo docker tag app malferov/app:$1
sudo docker login
sudo docker push malferov/app
