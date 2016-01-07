#!/usr/bin/env bash
echo "node master.breakfastclub.com {" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
echo "include pe_repo::platform::el_7_x86_64" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
echo "}" >> /etc/puppetlabs/code/environments/production/manifests/site.pp


echo "node master.breakfastclub.com { include pe_repo::platform::el_7_x86_64 }" >> /etc/puppetlabs/code/environments/production/manifests/site.pp