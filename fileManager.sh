#!/bin/bash

case $1 in

addTeam)
    groupadd $2
;;

addUser)
    useradd -m -g $3 $2
    mkdir /home/$2/team
    mkdir /home/$2/ninja
    chown -R $2:$3 /home/$2
    chmod 751 /home/$2
    chmod 770 /home/$2/team
    usermod -aG ninja $2
    chgrp ninja /home/$2/ninja
    chmod 770 /home/$2/ninja
;;

changePasswd)
    passwd $2
;;

changeShell)
    usermod -s $3 $2
;;

delUser)
    userdel -r $2
;;

delTeam)
    groupdel $2
;;

ls)
    if [ "$2" = "User" ]; then
        cut -d: -f1 /etc/passwd
    elif [ "$2" = "Team" ]; then
        cut -d: -f1 /etc/group
    else
        echo "Usage: ./UserManager.sh ls User|Team"
    fi
;;

esac
~                                                                                                                                                            
                      
