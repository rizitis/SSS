#!/bin/bash

# Slackware System Setup (SSS.sh)
# Script for setting up my new Slackware current installations
# rizitis 

# autoslack-initrd, slackup-grub #
cd /etc/rc.d/  || exit 
wget -c https://raw.githubusercontent.com/rizitis/autoslack-initrd/main/autoslack-initrd.sh
chmod +x autoslack-initrd.sh
# EDIT /etc/rc.d/rc.6
sed -i '79 i #' rc.6
wait
sed -i '80 i # autoslack-initrd' rc.6
wait
sed -i '81 i if [ -x /etc/rc.d/autoslack-initrd.sh ]; then' rc.6
wait
sed -i '82 i /etc/rc.d/autoslack-initrd.sh' rc.6
wait
sed -i '83 i fi' rc.6


wget -c https://raw.githubusercontent.com/rizitis/slackup-grub/main/slackup-grub.sh
chmod +x /etc/rc.d/slackup-grub.sh
# EDIT /etc/rc.d/rc.6
sed -i '84 i # slackup-grub' rc.6
wait
sed -i '85 i if [ -x /etc/rc.d/slackup-grub.sh ]; then' rc.6
wait
sed -i '86 i /etc/rc.d/slackup-grub.sh' rc.6
wait
sed -i '87 i fi' rc.6
bash /etc/rc.d/autoslack-initrd.sh
wait 
bash /etc/rc.d/slackup-grub.sh
wait

# Slackware-Commander #
cd /tmp || exit
wget -c https://github.com/rizitis/Slackware-Commander/releases/download/0.7/Slackware-Commander-0.7-x86_64-1_rtz.tgz
upgradepkg --install-new --reinstall Slackware-Commander-0.7-x86_64-1_rtz.tgz

# sbopkg
wget -c https://github.com/sbopkg/sbopkg/releases/download/0.38.2/sbopkg-0.38.2-noarch-1_wsr.tgz
upgradepkg --install-new --reinstall sbopkg-0.38.2-noarch-1_wsr.tgz
cd /root || exit
touch .sbopkg.conf
echo "REPO_NAME=SBo-git" > .sbopkg.conf
echo "REPO_BRANCH=current" >> .sbopkg.conf
cat .sbopkg.conf
sleep 3
sbopkg -r
wait
sed -i 's/OPT_JOBS=1/OPT_JOBS=$(getconf _NPROCESSORS_ONLN)/' /usr/sbin/sqg
wait
sqg -a

# slpkg
sbopkg -i slpkg

# DEPS
touch my-queue.sqf
echo "zenity" > my-queue.sqf
echo "yad" >> my-queue.sqf
echo "gtkdialog" >> my-queue.sqf
sbopkg -i my-queue.sqf

# GFS-tracker
cd /usr/local/bin/ || exit
wget -c https://github.com/rizitis/GFS-tracker/archive/refs/heads/main.zip
unzip main.zip && cd GFS-tracker-main/GFS-tracker.SlackBuild/
bash GFS-tracker.SlackBuild
upgradepkg --install-new --reinstall /tmp/GFS-tracker-100-x86_64-1_rtz.tgz

# SBKS
wget -c https://raw.githubusercontent.com/rizitis/SBKS/main/SBKS
chmod +x SBKS

# System
cd
bash pipewire-enable
echo "http://slackware.uk/slackware/slackware64-current/" >> /etc/slackpkg/mirrors
touch /etc/rc.d/rc.local_shutdown
echo "#!/bin/bash" > /etc/rc.d/rc.local_shutdown
chmod +x /etc/rc.d/rc.local_shutdown
bash adduser
echo "so good, so far"
sleep 2
bash visudo

