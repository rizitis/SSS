# SSS
Slackware System Setup (SSS.sh)


Script that helping me setting up every new Slackware current installation
# INSTALL
After your NEW Slackware installation finish (VM or bare metal), on first reboot command
```
mkdir -p /opt/SSS && cd  /opt/SSS
wget -c https://raw.githubusercontent.com/rizitis/SSS/main/SSS.sh
chmod +x SSS.sh
./SSS.sh
```
## NOTE
This script is how I like my Slackware current system.
But thats me...

What this script does is:
It REPLACE OR EDIT rc.6 file and prepare it for (default is replace, better chose if you have stock slackware /etc/rc.d/rc.6):

1. install [autoslack-initrd](https://github.com/rizitis/autoslack-initrd), a script that every time 

```
slackpkg upgrade-all
```
upgrade systems kernel , then run mkinitrd and create a generic kernel without touching your custom kernel if existed.

2) install [slackup-grub](https://github.com/rizitis/slackup-grub), a script that everytime slackpkg upgrade your kernel then update-grub also before shutdown pc. If you have grub in the installation. 
```
grub-mkconfig -o /boot/grub/grub.cfg
```
3) install [auto-elilo](https://github.com/rizitis/auto-elilo), a script that everytime slackpkg upgrade your kernel then before shutdown 
```
 eliloconfig
```
executed, the rest of the job is yours...

4) install sbopkg, rsync it with ponce repo, and create package.sqf files for all SBo source packages. 
```
sqg -a
```
Also edit /usr/sbin/sqg
```
OPT_JOBS=$(getconf _NPROCESSORS_ONLN)
```
To take the maximum power of your CPU.

5) install slpkg. To setup slpkg repos properly is your hand job...
6) install [GFS-tracker](https://github.com/rizitis/GFS-tracker). A very usefull script if you have Gnome in your installation. 
7) install SBKS. A tool for easy build and install your own custom generic kernels in your Slackware system. Also install zenity from ponce repo. zenity is dep for SBKS.
8) install [Slackware-Commander](https://github.com/rizitis/Slackware-Commander). A gtkdialog and yad tool for easy maintain and control your Slackware system. gtkdialog and yad are deps and script installs them from ponce repo.
9) set pipewire-enable... after reboot as always in Slack...
10) create a rc.local_shutdown file...
11) execute adduser command, to create your first user in the system. visudo is your job after that...
12) install [aaa_kernels and zzz_kernels scripts](https://github.com/rizitis/kernelsANDboots) a compination of
2 scripts that works together with autoslack-initrd and slackup-grub or auto-elilo. This scripts keeping the official slackware kernel in system when upgradepkg remove it when install new kernel. So you can have 2 officiall slackware kernels in your bootloader every time...

# REMEMBER
This is my way, because I have to install more than often Slackware-current in Virtual Box to build and check Gnome SlackBuilds in a clean Slackware system... So this script save for me some time, or help me to maintain better a fresh Slackware system.

So this script is written to ran only ONE time in every system, exactly after Slackware installation finish at first reboot. 
If you ran it more than one time at the same system, then your system will break. 

So if you DONT like all these I m doing, but you like some of tools that script install, then feel free to find these tools in my github and install them separate or hack them and make them better... 
