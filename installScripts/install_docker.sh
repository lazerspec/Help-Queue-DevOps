#!/bin/bash
sudo apt-get update
curl https://get.docker.com | sudo bash
sudo usermod -aG docker $(whoami)