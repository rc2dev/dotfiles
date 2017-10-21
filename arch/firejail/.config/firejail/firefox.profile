#
# Rafael Cavalcanti

include /etc/firejail/firefox.profile

# Diretórios que uso
whitelist ~/Imagens
blacklist ~/Imagens/Fotos
whitelist ~/.dotfiles/arch/firefox

# Deixar só ver ~/Dropbox/tmp
whitelist ~/Dropbox
noblacklist ~/Dropbox/tmp
blacklist ~/Dropbox/*
