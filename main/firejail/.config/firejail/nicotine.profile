################################
# Generic GUI application profile
# (funcionando corretamente para Nicotine)
# Rafael Cavalcanti
################################

noblacklist ${HOME}/.nicotine
include /etc/firejail/disable-common.inc
include /etc/firejail/disable-programs.inc
include /etc/firejail/disable-passwdmgr.inc

# Permitir ~/.nicotine
mkdir ${HOME}/.nicotine
whitelist ${HOME}/.nicotine
include /etc/firejail/whitelist-common.inc

# Diretório de download
whitelist ${HOME}/Downloads

caps.drop all
netfilter
nonewprivs
noroot
protocol unix,inet,inet6
seccomp
