#!/bin/bash

sudo apt-get update

export DEBIAN_FRONTEND=noninteractive
echo -e "slapd slapd/root_password password eric" |sudo debconf-set-selections
echo -e "slapd slapd/root_password_again password eric" |sudo debconf-set-selections
echo -e "slapd slapd/internal/adminpw password eric" |sudo debconf-set-selections
echo -e "slapd slapd/internal/generated_adminpw password eric" |sudo debconf-set-selections
echo -e "slapd slapd/password2 password eric" |sudo debconf-set-selections
echo -e "slapd slapd/password1 password eric" |sudo debconf-set-selections
echo -e "slapd slapd/domain string clemson.cloudlab.us" |sudo debconf-set-selections
echo -e "slapd shared/organization string WestChester" |sudo debconf-set-selections
echo -e "slapd slapd/backend string MDB" |sudo debconf-set-selections
echo -e "slapd slapd/purge_database boolean false" |sudo debconf-set-selections
echo -e "slapd slapd/move_old_database boolean true" |sudo debconf-set-selections
echo -e "slapd slapd/allow_ldap_v2 boolean false" |sudo debconf-set-selections
echo -e "slapd slapd/no_configuration boolean false" |sudo debconf-set-selections

# Grab slapd and ldap-utils (pre-seeded)
sudo apt-get install -y slapd ldap-utils
 
#sudo ufw allow ldap

