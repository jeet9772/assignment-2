Assignment 2: UserManager.sh

Overview

UserManager.sh is a Bash utility for practicing Linux user management, group/team management, permissions, ownership, shared directories, shell management, and password management.

Features

Add NinjaTeam (simulate a group)

Add a user under a team

Create team and ninja shared directories

Configure home-directory permissions

Change user password

Change user shell

Delete user

Delete team/group

List users

List teams/groups

Run this assignment on Linux with root/sudo privileges. Commands such as useradd, groupadd, usermod, passwd, userdel, and groupdel require administrative privileges.

1. Script

File name:

UserManager.sh

Make it executable:

chmod +x UserManager.sh

Check syntax:

bash -n UserManager.sh

2. Add a Team

./UserManager.sh addTeam amigo
./UserManager.sh addTeam unixkings

This creates Linux groups named amigo and unixkings.

Check:

getent group amigo
getent group unixkings

3. Add Users Under Teams

./UserManager.sh addUser Rakesh amigo
./UserManager.sh addUser Sandeep unixkings

The script creates the users and their home directories.

It also creates:

/home/Rakesh/team
/home/Rakesh/ninja

/home/Sandeep/team
/home/Sandeep/ninja

Expected structure:

/home
├── Rakesh
│   ├── team
│   └── ninja
└── Sandeep
    ├── team
    └── ninja

4. Permissions

The home directory uses:

chmod 751 /home/$2

751 means

Owner  = rwx
Group  = r-x
Others = --x

Therefore:

Owner has read, write, execute.

Same-team group has read and execute.

Others have execute only.

The team directory uses:

chmod 770 /home/$2/team

The ninja directory uses:

chgrp ninja /home/$2/ninja
chmod 770 /home/$2/ninja

770 means:

Owner  = rwx
Group  = rwx
Others = ---

Users are added to the ninja group with:

usermod -aG ninja $2

5. Change User Password

./UserManager.sh changePasswd Rakesh

Internally this uses:

passwd Rakesh

The system asks for the new password.

6. Change User Shell

./UserManager.sh changeShell Rakesh /bin/bash

Internally:

usermod -s /bin/bash Rakesh

Check:

getent passwd Rakesh

7. Delete User

./UserManager.sh delUser Rakesh

Internally:

userdel -r Rakesh

The -r option removes the user's home directory as well.

Check:

id Rakesh

8. Delete Team

./UserManager.sh delTeam amigo

Internally:

groupdel amigo

Check:

getent group amigo

9. List Users

./UserManager.sh ls User

The script uses:

cut -d: -f1 /etc/passwd

This lists usernames available on the Linux system.

10. List Teams

./UserManager.sh ls Team

The script uses:

cut -d: -f1 /etc/group

This lists Linux groups/teams.

11. Complete Demo

./UserManager.sh addTeam amigo
./UserManager.sh addTeam unixkings

./UserManager.sh addUser Rakesh amigo
./UserManager.sh addUser Sandeep unixkings

ls -l /home
ls -l /home/Rakesh
ls -l /home/Sandeep

./UserManager.sh ls User
./UserManager.sh ls Team

./UserManager.sh changeShell Rakesh /bin/bash
./UserManager.sh changePasswd Rakesh

Cleanup:

./UserManager.sh delUser Rakesh
./UserManager.sh delUser Sandeep

./UserManager.sh delTeam amigo
./UserManager.sh delTeam unixkings





<img width="1440" height="900" alt="Screenshot ass2first " src="https://github.com/user-attachments/assets/07ead4bf-0dc3-481e-bcfb-602fc1b9aa1e" />



<img width="1440" height="900" alt="Screenshot 2 secend" src="https://github.com/user-attachments/assets/e9b17628-49a4-4ceb-95dc-b54a3e372c7b" />



<img width="1440" height="900" alt="Screenshot 2ka 3" src="https://github.com/user-attachments/assets/7faae7e6-f674-4d53-ae82-e7d9bfa5912f" />



<img width="1440" height="900" alt="Screenshot 2 ka 4" src="https://github.com/user-attachments/assets/22862073-46fc-482e-90fc-c4035f95cfa4" />





<img width="1440" height="900" alt="Screenshot 2 script" src="https://github.com/user-attachments/assets/b0421352-7d7c-4988-9543-42a42ee27876" />





