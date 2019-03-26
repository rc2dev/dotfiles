# Perfil para o Kodi
# Criado a partir de generic GUI application profile
# habilitando ~/.kodi e comandos de comentário do site
#
# Autor: Rafael Cavalcanti

noblacklist ${HOME}/.kodi
include /etc/firejail/disable-common.inc
include /etc/firejail/disable-programs.inc
include /etc/firejail/disable-passwdmgr.inc

# Permitir ~/.kodi
mkdir ${HOME}/.kodi
whitelist ${HOME}/.kodi
include /etc/firejail/whitelist-common.inc

# Meus diretórios
whitelist ${HOME}/Downloads
whitelist ${HOME}/Música
read-only ${HOME}/Música
whitelist ${HOME}/Vídeos
read-only ${HOME}/Vídeos

# Só ver Code/data
whitelist ${HOME}/Code
noblacklist ${HOME}/Code/data
blacklist ${HOME}/Code/*
read-only ${HOME}/Code

caps.drop all
netfilter
nonewprivs
noroot
protocol unix,inet,inet6,netlink
seccomp

# Adicionado de comentário no site do Firejail,
# junto com "netlink" em protocol
nogroups
shell none
private-dev
