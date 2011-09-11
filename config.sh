#!/bin/sh

has_idfile() {
  if [ -e "$HOME/.ssh/$1" ]; then
    result="IdentityFile ~/.ssh/$1"
  else
    result=""
  fi
}

has_idfile "id_jointwork"
JOINTWORK=$result

cat << EOF

HashKnownHosts no

Host github-thumper
  Hostname github.com
  HostKeyAlias github.com
  User git

Host jointwork
  Hostname collab.jointwork.net
  HostKeyAlias collab.jointwork.net
  User gitosis
  $JOINTWORK


Host *
  # PubkeyAuthentication no
  GSSAPIAuthentication no
  # GSSAPIDelegateCredentials yes
  PreferredAuthentications publickey,password
  PubkeyAuthentication yes
  ServerAliveInterval 300
  TCPKeepAlive yes
  Protocol 2
  Compression yes
  ForwardAgent yes
  ForwardX11 yes
  ForwardX11Trusted yes


EOF
exit 0
