# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

alias setup=". ./gmsetup.sh"
alias kubectl='sudo kubectl'
alias minikube='sudo minikube'
export PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
export GREYMATTER_CONSOLE_LEVEL=debug
export GREYMATTER_API_KEY=xxx
export GREYMATTER_API_INSECURE=true
export GREYMATTER_API_HOST=$(sudo minikube ip):30000
export GREYMATTER_API_PREFIX=/services/gm-control-api/latest
export GREYMATTER_API_SSL=true
export GREYMATTER_API_SSLCERT=./client.crt
export GREYMATTER_API_SSLKEY=./client.key
export EDITOR=vim
