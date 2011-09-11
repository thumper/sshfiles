# sshfiles

> This is the <tt>ssh</tt> configuration I wish I would have had
when starting out with this program, so that it would have been
more plain to me how best to use this program.


This repository contains the <tt>ssh</tt> configuration files I use
to make life easier across the several hosts that I use.
Everywhere that I have an account, I checkout this repository
and run "make" to setup the symlinks and install the
<tt>~/.ssh/config</tt> file (which is generated from a template).
Before I setup this repository, I either just typed my password
every time, or I'd create a new private/public keypair on a particular
host that I needed access from.
Managing my keypairs became a nightmare, so in recent years I've fallen back to
just always typing my password --- but that's dangerous because
[programmers are lazy.](http://en.wikipedia.org/wiki/Larry_Wall#Virtues_of_a_programmer)


To make this work, I generate a different private/public key pair on every
machine I have physical access to (my desktop, and two laptops).
One way to do this that I like is to generate a completely random
passphrase, and then have the passphrase stored in my login keychain.

    openssl rand -base64 24
    ssh-keygen -t rsa -b 2048

The first time you use the key for an <tt>ssh</tt> connection to
another host, both Ubuntu and OSX prompt for the passphrase and
have an option that will store the passphrase in your login keychain.
The advantage of this is that you never have to remember passphrases,
and only worry about the strength of your login password.

I then add the public key to the <tt>authorized_keys</tt> file
in this repository, making it easy to distribute the key to
all the hosts that I have access to.
And when I finally graduate and have to return my school laptop,
I can easily remove the authorization for that particular keypair
and update all the hosts that I have accounts on.


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
Turning on <tt>ForwardAgent</tt> allows the credentials from
my laptop to be passed along if I am chaining from one host to another.
(See my [dotfiles](https://github.com/thumper/dotfiles/blob/master/bash/aliases)
repository for how I update the agent connection in my <tt>tmux</tt>
session.  Bash completion for ssh hostnames is also worth checking out.)

Another setting that I considered is the <tt>ControlMaster</tt>
option to allow connection sharing; it's worth googling if
speed matters to you.

