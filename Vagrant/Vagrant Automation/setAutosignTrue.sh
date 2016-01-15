#!/usr/bin/env bash
echo "autosign=true" >> /etc/puppetlabs/puppet/puppet.conf
echo "Rebooting now"
sudo reboot