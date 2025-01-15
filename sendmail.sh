#!/bin/bash
set -e

# configure sendmail
hostname >> /etc/mail/relay-domains
m4 /etc/mail/sendmail.mc > /etc/mail/sendmail.cf
sed -i -e "s/Port=smtp,Addr=127.0.0.1, Name=MTA/Port=smtp, Name=MTA/g" /etc/mail/sendmail.mc
sendmail -bd

service sendmail restart
