#!/usr/bin/env bash
cd /home/vagrant
echo "Making module directories"
cd /etc/puppetlabs/code/environments/production/modules
echo "Working directory:"
echo | pwd 
cd /home/vagrant/TheBreakfastClub/Puppet/Modules
echo "Working directory: "
echo | pwd
sudo cp -r artifactory /etc/puppetlabs/code/environments/production/modules
sudo cp -r eclipse /etc/puppetlabs/code/environments/production/modules
sudo cp -r elasticsearch /etc/puppetlabs/code/environments/production/modules
sudo cp -r graphite /etc/puppetlabs/code/environments/production/modules
sudo cp -r graylog /etc/puppetlabs/code/environments/production/modules
sudo cp -r java /etc/puppetlabs/code/environments/production/modules
sudo cp -r mongodb /etc/puppetlabs/code/environments/production/modules
sudo cp -r mysql /etc/puppetlabs/code/environments/production/modules
sudo cp -r snort /etc/puppetlabs/code/environments/production/modules
sudo cp -r travis /etc/puppetlabs/code/environments/production/modules
cd /etc/puppetlabs/code/environments/production/modules
echo "Working directory: "
echo | pwd
echo "Folders:"
# echo | ls
