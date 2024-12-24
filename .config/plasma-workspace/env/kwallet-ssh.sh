# Author: Rafael Cavalcanti <https://rafaelc.org/dev>

# Use KDE Wallet to store SSH key passphrases
# (<https://wiki.archlinux.org/title/KDE_Wallet#Using_the_KDE_Wallet_to_store_ssh_key_passphrases>)
export SSH_ASKPASS=/usr/bin/ksshaskpass
export SSH_ASKPASS_REQUIRE=prefer
