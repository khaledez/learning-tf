#!/bin/sh

sudo apt update
sudo apt -y upgrade
sudo apt install -y nginx
sudo systemctl enable --now nginx
echo "hello"