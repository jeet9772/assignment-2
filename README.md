# Assignment 2 — UserManager.sh

## Overview

`UserManager.sh` is a Bash utility for practicing Linux user management, group/team management, permissions, ownership, shared directories, shell management, and password management.

### Features

- Add teams/groups
- Add users under a team
- Create team and ninja shared directories
- Configure home-directory permissions
- Change user password
- Change user shell
- Delete users
- Delete teams/groups
- List users
- List teams/groups

> Run this assignment on Linux with root/sudo privileges because commands such as `useradd`, `groupadd`, `usermod`, `passwd`, `userdel`, and `groupdel` require administrative privileges.

---

# 1. Script Setup

## Make the script executable

```bash
chmod +x UserManager.sh
```

## Check syntax

```bash
bash -n UserManager.sh
```

![UserManager.sh script](https://github.com/user-attachments/assets/b0421352-7d7c-4988-9543-42a42ee27876)

---

# 2. Add a Team

The `addTeam` operation creates Linux groups.

```bash
./UserManager.sh addTeam amigo
./UserManager.sh addTeam unixkings
```

## Verify

```bash
getent group amigo
getent group unixkings
```

This creates the teams/groups:

```text
amigo
unixkings
```

![Add teams](https://github.com/user-attachments/assets/07ead4bf-0dc3-481e-bcfb-602fc1b9aa1e)

---

# 3. Add Users Under Teams

Users can be created under a particular team.

```bash
./UserManager.sh addUser Rakesh amigo
./UserManager.sh addUser Sandeep unixkings
```

The script creates the users and their home directories.

It also creates:

```text
/home/Rakesh/team
/home/Rakesh/ninja

/home/Sandeep/team
/home/Sandeep/ninja
```

## Expected Structure

```text
/home
├── Rakesh
│   ├── team
│   └── ninja
└── Sandeep
    ├── team
    └── ninja
```

## Verify

```bash
ls -l /home
ls -l /home/Rakesh
ls -l /home/Sandeep
```

![Users and directories](https://github.com/user-attachments/assets/07ead4bf-0dc3-481e-bcfb-602fc1b9aa1e)

---

# 4. Permissions and Ownership

## Home Directory

The home directory uses:

```bash
chmod 751 /home/$2
```

### Permission breakdown

```text
751

Owner  = rwx
Group  = r-x
Others = --x
```

Therefore:

- Owner has read, write and execute.
- Group has read and execute.
- Others have execute only.

---

## Team Directory

The team directory uses:

```bash
chmod 770 /home/$2/team
```

```text
770

Owner  = rwx
Group  = rwx
Others = ---
```

This allows the owner and group to fully access the directory while denying access to others.

---

## Ninja Directory

The ninja directory is assigned to the `ninja` group:

```bash
chgrp ninja /home/$2/ninja
chmod 770 /home/$2/ninja
```

Users are added to the ninja group with:

```bash
usermod -aG ninja $2
```

This provides a shared directory for members of the ninja group.

![Directory permissions](https://github.com/user-attachments/assets/e9b17628-49a4-4ceb-95dc-b54a3e372c7b)

---

# 5. Change User Password

The `changePasswd` operation changes the password of a user.

```bash
./UserManager.sh changePasswd Rakesh
```

Internally it uses:

```bash
passwd Rakesh
```

The system asks for the new password.

---

# 6. Change User Shell

The `changeShell` operation changes the user's login shell.

```bash
./UserManager.sh changeShell Rakesh /bin/bash
```

Internally:

```bash
usermod -s /bin/bash Rakesh
```

## Verify

```bash
getent passwd Rakesh
```

---

# 7. List Users

The script can list Linux users:

```bash
./UserManager.sh ls User
```

Internally:

```bash
cut -d: -f1 /etc/passwd
```

This lists usernames from `/etc/passwd`.

---

# 8. List Teams / Groups

The script can list Linux groups:

```bash
./UserManager.sh ls Team
```

Internally:

```bash
cut -d: -f1 /etc/group
```

This lists group names from `/etc/group`.

![Users and groups](https://github.com/user-attachments/assets/22862073-46fc-482e-90fc-c4035f95cfa4)

---

# 9. Delete User

The `delUser` operation deletes a Linux user:

```bash
./UserManager.sh delUser Rakesh
```

Internally:

```bash
userdel -r Rakesh
```

The `-r` option also removes the user's home directory.

## Verify

```bash
id Rakesh
```

The same can be done for Sandeep:

```bash
./UserManager.sh delUser Sandeep
```

![User deletion / cleanup](https://github.com/user-attachments/assets/22862073-46fc-482e-90fc-c4035f95cfa4)

---

# 10. Delete Team

The `delTeam` operation deletes a Linux group:

```bash
./UserManager.sh delTeam amigo
```

Internally:

```bash
groupdel amigo
```

## Verify

```bash
getent group amigo
```

The group should no longer exist.

Delete the second team:

```bash
./UserManager.sh delTeam unixkings
```

![Team deletion / cleanup](https://github.com/user-attachments/assets/22862073-46fc-482e-90fc-c4035f95cfa4)

---

# 11. Complete Demo

## Create teams

```bash
./UserManager.sh addTeam amigo
./UserManager.sh addTeam unixkings
```

## Create users

```bash
./UserManager.sh addUser Rakesh amigo
./UserManager.sh addUser Sandeep unixkings
```

## Verify home directories

```bash
ls -l /home
ls -l /home/Rakesh
ls -l /home/Sandeep
```

## List users

```bash
./UserManager.sh ls User
```

## List teams

```bash
./UserManager.sh ls Team
```

## Change shell

```bash
./UserManager.sh changeShell Rakesh /bin/bash
```

## Change password

```bash
./UserManager.sh changePasswd Rakesh
```

---

# 12. Cleanup

After completing the demonstration:

```bash
./UserManager.sh delUser Rakesh
./UserManager.sh delUser Sandeep

./UserManager.sh delTeam amigo
./UserManager.sh delTeam unixkings
```

This removes the users, their home directories, and the created teams.

---

# 13. Problems / Important Points

The main administrative requirement was running user and group management commands with sufficient privileges.

Commands such as:

```text
useradd
groupadd
usermod
passwd
userdel
groupdel
```

require root/sudo privileges.

Another important part was understanding Linux numeric permissions:

```text
751
770
```

and the three permission classes:

```text
Owner
Group
Others
```

The assignment also demonstrates group ownership and shared-directory access using `chgrp`, `chmod`, and group membership.

---

# 14. Concepts Practiced

- Bash scripting
- Linux users
- Linux groups
- `useradd`
- `groupadd`
- `usermod`
- `passwd`
- `userdel`
- `groupdel`
- `chmod`
- `chgrp`
- File ownership
- Linux permissions
- Shared directories
- `/etc/passwd`
- `/etc/group`
- Login shells
- Administrative privileges

---

# 15. Learning

This assignment provided hands-on practice with Linux user and group administration through Bash.

### Main Learning Outcomes

1. Creating and deleting Linux users.
2. Creating and deleting groups.
3. Adding users to groups.
4. Creating shared directories.
5. Managing permissions using `chmod`.
6. Managing group ownership using `chgrp`.
7. Changing user passwords.
8. Changing login shells.
9. Listing users and groups.
10. Automating Linux administration tasks using Bash.

---

# Author

**Jeetender Singh**

Linux / DevOps Assignment 2
dd
