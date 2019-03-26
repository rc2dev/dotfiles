#!/bin/bash
# Mounts an Encfs partition with dialogues, and a password stored in KDE Wallet.
# The first parameter is the encrypted directory and the second parameter is the mount point.
# If the password is not present in kwallet, then it is entered via a dialogue and then stored in the wallet.
#
# Original script by Taboom (version 1.2) found at http://www.kde-apps.org/content/show.php/Truecrypt+mount+and+unmount+scripts?content=53634

# [RC modified] Comentado
#SOURCE=$1
#DESTINATION=$2

# [RC added]
SOURCE="/mnt/hdd-data/encrypted"
DESTINATION="$HOME/Private"

APPID=encfs # The application ID that KDE Wallet will recognise
kwalletd5=/usr/bin/kwalletd5 # location of kwalletd5

# Check for an X session
if [ -z $DISPLAY ]; then
  echo "X not running"
  exit
fi

$kwalletd5

#If parameters are missing
if [ -z "$SOURCE" ]; then
  SOURCE=$(kdialog --title "Encrypted directory" --getexistingdirectory . )
  [ -z "$SOURCE" ] && exit;
fi


if [ -z "$DESTINATION" ]; then
  DESTINATION=$(kdialog --title "Mount point" --getexistingdirectory . )
  [ -z "$DESTINATION" ] && exit;
fi

#Is this Encfs partiton mounted?
if [ "$(mount | grep $DESTINATION)" != "" ]; then
	# [RC modified] Comentado, para não surgir popup toda vez que relogar.
  #$(/usr/bin/kdialog --passivepopup "Encfs: $DESTINATION is already mounted")
	printf
else
  # Ensure kwallet is running on KDE startup
  while [ "$(qdbus org.kde.kwalletd5 /modules/kwalletd5 org.kde.KWallet.isEnabled)" != "true" ]
  do
    $kwalletd5
  done

  #Get the key from KDE Wallet, if nonexisting ask for the key and store it later to KDE Wallet
  WALLETID=$(qdbus org.kde.kwalletd5 /modules/kwalletd5 org.kde.KWallet.open kdewallet 0 $APPID)

  PASSWORD=$(qdbus org.kde.kwalletd5 /modules/kwalletd5 org.kde.KWallet.readPassword $WALLETID Passwords $DESTINATION $APPID)
  #By default assume that the password was fetched from KDE Wallet
  PASSWORD_FETCHED=0

  #Password does not exist - ask for it from the user
  if [ -z "$PASSWORD" ]; then
    PASSWORD=$(kdialog --title "Encfs: Mount $DESTINATION?" --password "Please enter passphrase for $DESTINATION.")
    PASSWORD_FETCHED=$?
  fi

  #If password is fetched or given
  if [ $? != "" ];
    then
    #Try mounting the Encfs partition
    A=$(echo $PASSWORD | encfs -S $SOURCE $DESTINATION )
    #If successful mount
    if [ $? == "0" ]
      then
      #If password was asked from the user, save it to KDE Wallet
      if [ "$PASSWORD_FETCHED" = "0" ]; then
        A=$(qdbus org.kde.kwalletd5 /modules/kwalletd5 org.kde.KWallet.writePassword $WALLETID Passwords $DESTINATION "$PASSWORD" $APPID)
      fi
#      /usr/bin/kdialog --passivepopup "Encfs partition $DESTINATION mounted successfully"
    else
      #Unsuccessful mount
      /usr/bin/kdialog --title "Encfs: Failed to mount $DESTINATION" --error "Failed to mount Encfs partition $DESTINATION. \n\nIncorrect password or error."
    fi
    #Close KDE Wallet -- can't seem to make it work with qdbus
    #qdbus org.kde.kwalletd5 /modules/kwalletd5 org.kde.KWallet.close $WALLETID false $APPID
    #dbus-send --session --dest=org.kde.kwalletd5 --type=method_call  /modules/kwalletd5 org.kde.KWallet.close int32:$WALLETID boolean:false string:"$APPID"
  fi
fi
