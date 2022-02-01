#!/bin/sh

hostname="$1"
hosts=/etc/hosts
hname=/etc/hostname
old_hostname="$(hostname)"

if test $# -eq 0
then
    echo "required argument 'hostname' not provided"
    exit 1
fi
echo "$old_hostname" " >> " "$hostname"

if [ "$old_hostname" = "$hostname" ]
then
  echo "no changes"
else
  sed -i 'auto-provisioned' "$hosts"
  sed -i "$old_hostname" "$hosts"
  echo "$hostname" | sudo tee  "$hname"
  sudo sed -i -e 's/^.*auto-provisioned.*$//g' "$hosts"
  echo "127.0.1.1      " "$hostname" " ### auto-provisioned"  | sudo tee -a "$hosts"

  echo "$hostname" | sudo tee "$hname"

  hostnamectl set-hostname "$hostname"
  systemctl restart avahi-daemon
fi
