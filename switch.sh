#!/usr/bin/env bash
sudo rm -rf /etc/nixos
sudo cp -r ./ /etc/nixos
sudo nh os switch
