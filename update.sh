#!/usr/bin/env bash
sudo git pull
sudo FLAKE=/etc/nixos nh os switch -R -v
