# sshfiles

This repository contains the <tt>ssh</tt> configuration files I use
to make life easier across the several hosts that I use.
Everywhere that I have an account, I checkout this repository
and run "make" to setup the symlinks and install the
<tt>~/.ssh/config</tt> file (which is generated from a template).

By having the public part of my SSH keys in <tt>authorized_keys</tt>,
this allows me to seemly login from one machine to another without
having to type in passwords.
To make this work, I generate a private/public key pair on every
machine I have physical access to (my desktop, and two laptops).
These should be secured with a passphrase.

One way to do this that I like is to generate a completely random
passphrase, and then have the passphrase stored in my login keychain.
    openssl rand -base64 24
    ssh-keygen -t rsa -b 2048
The first time you use the key for an <tt>ssh</tt> connection to
another host, both Ubuntu and OSX prompt for the passphrase and
have an option that will store the passphrase in your login keychain.
The advantage of this is that you never have to remember passphrases,
and only worry about the strength of your login password.

## Configuration

The <tt>~/.ssh/config</tt> is mostly so simple that it could have
been a symbolic link as well.
I made it a template-script because I have a few private keys that
I need to copy from host to host, but I haven't bothered to install
them on most of my accounts.  So the script checks to see if the
key file exists, and adds a line to the configuration if it does.

Most of the configuration is done in the
    Host *
section at the end of <tt>config.sh</tt>,
and these are the settings that seem to work best for me.
Another setting that I considered is the <tt>ControlMaster</tt>
option to allow connection sharing; it's worth googling if
speed matters to you.

