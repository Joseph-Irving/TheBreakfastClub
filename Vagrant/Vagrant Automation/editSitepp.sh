#!/usr/bin/env bash
# MySQL
echo "node mysql.breakfastclub.com {" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
echo "}" >> /etc/puppetlabs/code/environments/production/manifests/site.pp

# Eclipse
echo "node dev1.breakfastclub.com {" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
echo "  include eclipse" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
echo "}" >> /etc/puppetlabs/code/environments/production/manifests/site.pp

# Travis
echo "node travisAnt.breakfastclub.com {" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
echo "  include travis" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
echo "}" >> /etc/puppetlabs/code/environments/production/manifests/site.pp

# Artifactory
echo "node artifactory.breakfastclub.com {" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
echo "  include artifactory" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
echo "}" >> /etc/puppetlabs/code/environments/production/manifests/site.pp

echo "node master.breakfastclub.com {" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
echo "  include pe_repo::platform::el_7_x86_64" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
echo "}" >> /etc/puppetlabs/code/environments/production/manifests/site.pp

echo "node graylog.breakfastclub.com {" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
echo "  include graylog" >> /etc/puppetlabs/code/environments/production/manifests/site.pp
echo "}" >> /etc/puppetlabs/code/environments/production/manifests/site.pp

