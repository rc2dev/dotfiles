#
# Rafael Cavalcanti

include /etc/firejail/chromium-browser.profile

# Diretórios que uso
whitelist ~/Imagens
blacklist ~/Imagens/Fotos

# Deixar só ver ~/Dropbox/tmp
whitelist ~/Dropbox
noblacklist ~/Dropbox/tmp
blacklist ~/Dropbox/*
