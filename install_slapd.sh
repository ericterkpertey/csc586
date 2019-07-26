#!/bin/bash

export DEBIAN_FRONTEND='non-interactive'
echo -e "slapd slapd/root_password password eric" |debconf-set-selections
echo -e "slapd slapd/root_password_again password eric" |debconf-set-selections
echo -e "slapd slapd/internal/adminpw password test" |debconf-set-selections
echo -e "slapd slapd/internal/generated_adminpw password test" |debconf-set-selections
echo -e "slapd slapd/password2 password test" |debconf-set-selections
echo -e "slapd slapd/password1 password test" |debconf-set-selections


