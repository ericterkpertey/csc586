#!/bin/bash

export DEBIAN_FRONTEND='non-interactive'
echo -e "slapd slapd/root_password password eric" |debconf-set-selections
echo -e "slapd slapd/root_password_again password eric" |debconf-set-selections
echo -e "slapd slapd/internal/adminpw password eric" |debconf-set-selections
echo -e "slapd slapd/internal/generated_adminpw password eric" |debconf-set-selections
echo -e "slapd slapd/password2 password eric" |debconf-set-selections
echo -e "slapd slapd/password1 password eric" |debconf-set-selections
echo -e "slapd slapd/domain string clemson.cloudlab" |debconf-set-selections
echo -e "slapd shared/organization string IT410" |debconf-set-selections
echo -e "slapd slapd/backend string MDB" |debconf-set-selections
echo -e "slapd slapd/purge_database boolean false" |debconf-set-selections
echo -e "slapd slapd/move_old_database boolean true" |debconf-set-selections
echo -e "slapd slapd/allow_ldap_v2 boolean false" |debconf-set-selections
echo -e "slapd slapd/no_configuration boolean false" |debconf-set-selections

# Grab slapd and ldap-utils (pre-seeded)
#apt-get install -y slapd ldap-utils phpldapadmin

# Must reconfigure slapd for it to work properly 
#sudo dpkg-reconfigure slapd 
#sudo ufw allow ldap

