
cd ~

# update everything
apt-get update -y
apt-get upgrade -y
echo "Milrato-Setup [::] Updated and upgraded the Current System"

# ensure hostname
hostnamevar=$(hostname)
if ! grep -q $hostnamevar "/etc/hosts"; then
    echo "127.0.0.1 $hostnamevar" >> /etc/hosts && echo "::1 $hostnamevar" >> /etc/hosts
    echo "Added $hostnamevar - hostname"
    
fi


apt-get -y install sudo
echo "Milrato-Setup [::] Ensured sudo is installed"



apt-get purge -y --auto-remove apache*
echo "Milrato-Setup [::] Removed default installed apache package"



apt-get -y install screen git-all rsync curl jq file unzip make gcc g++ python python-dev libtool build-essential wget zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev libbz2-dev htop nano
echo "Milrato-Setup [::] Installed default utilities"



apt-get -y install ca-certificates gnupg fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgbm1 libgcc1 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 lsb-release xdg-utils
echo "Milrato-Setup [::] Installed default libs and encoders for many packages"


curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=16
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update && sudo apt-get install nodejs -y
echo "Milrato-Setup [::] Installed nodejs"

sudo apt-get install -y ffmpeg python3-pip
echo "Milrato-Setup [::] Installed pip3 and ffmpeg"


wget https://download.java.net/openjdk/jdk18/ri/openjdk-18+36_linux-x64_bin.tar.gz
sudo mkdir -p /usr/lib/jvm
sudo tar zxvf openjdk-18+36_linux-x64_bin.tar.gz -C /usr/lib/jvm
sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk-18/bin/java" 1
sudo update-alternatives --set java /usr/lib/jvm/jdk-18/bin/java
java -version
rm openjdk-18+36_linux-x64_bin.tar.gz
echo "Milrato-Setup [::] Installed java version 18 (openjdk)"



npm i -g pm2 npm-check-updates yarn npm@latest
echo "Milrato-Setup [::] Installed pm2, npm-check-updates yarn, npm@latest - via npm"



pm2 install pm2-logrotate
pm2 set pm2-logrotate:max_size 50M
pm2 set pm2-logrotate:compress true
pm2 set pm2-logrotate:rotateInterval '0 12 * * *'
echo "Milrato-Setup [::] Installed pm2-logrotate to keep pm2 logs low, flushing when logs exceed 50M and everyday at 12:00 of your cron-time via cron: '0 12 * * *'"



curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
sudo apt-get install speedtest
echo "Milrato-Setup [::] Installed speedtest"

set +e
bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"
set -e
echo "Milrato-Setup [::] Installed Oh-my-bash: https://github.com/ohmybash/oh-my-bash"

set +e
rm ~/.bashrc && wget -O ~/.bashrc https://raw.githubusercontent.com/Tomato6966/Debian-Cheat-Sheet-Setup/main/.bashrc
set -e

echo "Milrato-Setup [::] Applied custom .bashrc, to load it do: source ~/.bashrc, or reload the current session"

echo "Milrato-Setup [::] Everything is setup"
echo "Milrato-Setup [::] A reboot is recommended"
echo "Milrato-Setup [::] If you want more security against other user logins, check out"
echo "Milrato-Setup [::] https://github.com/Tomato6966/Debian-Cheat-Sheet-Setup/wiki/7-Linux-Security"
echo "Milrato-Setup [::] This is a Wiki from Tomato#6966 how he secures his VPS servers on a quick and easy base."
