#!/bin/bash

# Slackware System Setup (SSS.sh)
# Script for setting up my new Slackware current installations
# rizitis 
# MIT License

# Copyright (c) 2023 Anagnostakis Ioannis

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# autoslack-initrd, slackup-grub, auto-elilo #
cd /etc/rc.d/  || exit 

wget -c https://raw.githubusercontent.com/rizitis/autoslack-initrd/main/autoslack-initrd.sh
chmod +x autoslack-initrd.sh
# EDIT /etc/rc.d/rc.6
#sed -i '79 i #' rc.6
#wait
#sed -i '80 i # autoslack-initrd' rc.6
#wait
#sed -i '81 i if [ -x /etc/rc.d/autoslack-initrd.sh ]; then' rc.6
#wait
#sed -i '82 i /etc/rc.d/autoslack-initrd.sh' rc.6
#wait
#sed -i '83 i fi' rc.6


wget -c https://raw.githubusercontent.com/rizitis/slackup-grub/main/slackup-grub.sh
chmod +x /etc/rc.d/slackup-grub.sh
# EDIT /etc/rc.d/rc.6
#sed -i '84 i # slackup-grub' rc.6
#wait
#sed -i '85 i if [ -x /etc/rc.d/slackup-grub.sh ]; then' rc.6
#wait
#sed -i '86 i /etc/rc.d/slackup-grub.sh' rc.6
#wait
#sed -i '87 i fi' rc.6
#wait

wget -c https://raw.githubusercontent.com/rizitis/auto-elilo/main/auto-elilo.sh
chmod +x auto-elilo.sh
# EDIT /etc/rc.d/rc.6
#sed -i '88 i # auto-elilo' rc.6
#wait
#sed -i '89 i if [ -x /etc/rc.d/auto-elilo.sh ]; then' rc.6
#wait 
#sed -i '90 i /etc/rc.d/auto-elilo.sh' rc.6
#wait
#sed -i '91 i fi' rc.6
#wait

# Create database 
bash /etc/rc.d/autoslack-initrd.sh
wait 
bash /etc/rc.d/slackup-grub.sh
wait
bash /etc/rc.d/auto-elilo.sh



# it works but i dont like it as idea so... ## 
# aaa_kernels and zzz_kernels
#wget -c https://raw.githubusercontent.com/rizitis/kernelsANDboots/main/aaa_kernels.sh
#chmod +x aaa_kernels.sh
#wget -c https://raw.githubusercontent.com/rizitis/kernelsANDboots/main/zzz_kernels.sh
##chmod +x zzz_kernels.sh
#cd /tmp || exit
#wget -c https://raw.githubusercontent.com/rizitis/kernelsANDboots/main/rc.local
#cat rc.local >> /etc/rc.d/rc.local
#rm /tmp/rc.local

#sed -i '84 i # zzz_kernels' rc.6
#wait
#sed -i '85 i if [ -x /etc/rc.d/zzz_kernels.sh ]; then' rc.6
#wait
#sed -i '86 i /etc/rc.d/zzz_kernels.sh' rc.6
#wait
#sed -i '87 i fi' rc.6
#wait

# CREATE NEW rc.6 
###########***********************###############****************************####################################
#-------------- NOTE:   NOTE:   NOTE:   NOTE:   NOTE:    NOTE:    NOTE:   NOTE:   NOTE:    NOTE:-------------   #
# If you use custom rc.6 then commend next 3 lines and uncommend ALL ^before  lines with sed -i commands        #
###########***********************###############****************************####################################
#cd /etc/rc.d || exit
#mv rc.6 rc.6.BAK
#wget -c https://raw.githubusercontent.com/rizitis/kernelsANDboots/main/rc.6
#chmod +x rc.6


# since /etc/rc.d/rc.local_shutdown works ok, no reason to touch rc.6
cd /tmp || exit
wget -c https://raw.githubusercontent.com/rizitis/SSS/main/rc.local_shutdown
touch /etc/rc.d/rc.local_shutdown
cat rc.local_shutdown >> /etc/rc.d/rc.local_shutdown
chmod +x /etc/rc.d/rc.local_shutdown
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
wait

# slpkg
sbopkg -i slpkg

# DEPS
sbopkg -i zenity
sbopkg -i yad
sbopkg -i gtkdialog

# GFS-tracker
cd /usr/local/bin/ || exit
wget -c https://github.com/rizitis/GFS-tracker/archive/refs/heads/main.zip
unzip main.zip && cd GFS-tracker-main/GFS-tracker.SlackBuild/
chmod +x GFS-tracker.SlackBuild
bash GFS-tracker.SlackBuild
upgradepkg --install-new --reinstall /tmp/GFS-tracker-100-x86_64-1_rtz.tgz

# SBKS
wget -c https://raw.githubusercontent.com/rizitis/SBKS/main/SBKS
chmod +x SBKS

# System
cd || exit
bash pipewire-enable
echo "http://ftp.cc.uoc.gr/mirrors/linux/slackware/slackware64-current/" >> /etc/slackpkg/mirrors
touch /etc/rc.d/rc.local_shutdown
echo "#!/bin/bash" > /etc/rc.d/rc.local_shutdown
chmod +x /etc/rc.d/rc.local_shutdown
bash adduser
echo "so far,so good... "
echo ""
echo "*********************************************"
echo "*"
echo "* visudo is  THE friend for your new user...*"
echo "*"
echo "*********************************************"
echo ""
neofetch
