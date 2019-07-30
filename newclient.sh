#! /bin/bash

sudo apt-get update
# Install openLDAP server quietly
export DEBIAN_FRONTEND=noninteractive

echo -e " 
slapd slapd/password1 password royal
slapd slapd/internal/adminpw password royal
slapd slapd/internal/generated_adminpw password royal
slapd slapd/password2 password royal
slapd slapd/root_password password royal
slapd slapd/root_password_again password royal
slapd slapd/unsafe_selfwrite_acl note
slapd slapd/purge_database boolean false
slapd slapd/domain string clemson.cloudlab.us
slapd slapd/ppolicy_schema_needs_update select abort installation
slapd slapd/invalid_config boolean true
slapd slapd/move_old_database boolean false
slapd slapd/backend select MDB
slapd shared/organization string clemson.cloudlab.us
slapd slapd/dump_database_destdir string /var/backups/slapd-VERSION
slapd slapd/allow_ldap_v2 boolean false
slapd slapd/no_configuration boolean false
slapd slapd/dump_database select when needed
slapd slapd/password_mismatch note
" | sudo debconf-set-selections

#sudo apt-get update

# Grab slapd and ldap-utils (pre-seeded)
sudo apt-get install -y slapd ldap-utils

# Must reconfigure slapd for it to work properly 
#sudo dpkg-reconfigure slapd

# Enable firewall rule 
sudo ufw allow ldap 

# Populate LDAP
ldapadd -x -D cn=admin,dc=clemson,dc=cloudlab,dc=us -w royal -f basedn.ldif

# Generate password hash
PASS=$(slappasswd -s rammy)
cat <<EOF >/local/repository/users.ldif
dn: uid=student,ou=People,dc=clemson,dc=cloudlab,dc=us
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: student
sn: Ram
givenName: Golden
cn: student
displayName: student
uidNumber: 10000
gidNumber: 5000
userPassword: $PASS
gecos: Golden Ram
loginShell: /bin/dash
homeDirectory: /home/student
EOF

# Populate LDAP
ldapadd -x -D cn=admin,dc=clemson,dc=cloudlab,dc=us -w royal -f users.ldif 

# Test LDAP
ldapsearch -x -LLL -b dc=clemson,dc=cloudlab,dc=us 'uid=student' cn gidNumber
