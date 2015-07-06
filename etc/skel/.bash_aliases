#
# do not delete / or prompt if deleting more than 3 files at a time #
alias rm='rm -v -I --preserve-root --verbose'
# confirmation #
alias mv='mv -i -v'
alias cp='cp -i -v'
alias ln='ln -i'
# Parenting changing perms on / #
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
# Some more alias to avoid making mistakes:
#alias df='df -hT'
alias df='dfc -To'

# handy short cuts #
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias find='find -L'
alias md='mkdir -p -v'
alias e='$EDITOR'
alias se='sudo $EDITOR'
alias ss='sudo su'
alias s='sudo'
alias debvers='lsb_release -a'
alias meteo='/opt/ansiweather/ansiweather'

## Colorize the ls output ##
alias ls='ls --color=auto'
 
## Use a long listing format ##
alias ll='ls -la'
 
## Show hidden files ##
alias l.='ls -d .* --color=auto'

## get rid of command not found ##
alias cd..='cd ..'
 
## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Lynis
alias lynischk='sudo /usr/local/lynis/lynis --check-all -Q'
alias lynwarn='sudo grep Warning /var/log/lynis.log'
alias lynsugg='sudo grep Suggestion /var/log/lynis.log'
 
# Motion
alias mocap='cd /srv/motion/capture'
alias moetc='cd /etc/motion'
#alias molog='sudo tail -f /var/log/alternatives.log | grep motion'
alias molog='sudo tail -f /var/log/motion.log | ccze'
alias morestart='sudo service motion restart'
alias mostart='sudo service motion start'
alias mostate='sudo ps -A | grep motion'
alias mostop='sudo service motion stop'
alias mopaus='curl http://127.0.0.1:7070/1/detection/pause'
alias modec='curl http://127.0.0.1:7070/1/detection/start'
alias moliv0='mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0'

# Eliminer les commentaires d'un fichier
alias cgrep="grep -E -v '^(#|$|;)'"
alias nocomment='cgrep'

# Reviens à faire  cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak 
function cpb() { cp $@{,.bak} ;}
# Crée une sauvegarde du fichier passé en paramètre, en rajoutant l'heure et la date
function bak() { cp "$1" "$1_`date +%Y-%m-%d_%H-%M-%S`" ; }
alias bak="bak"
alias back="bak"

# Êtres gentil avec les ressources de son système
function nicecool() {
    if ! [ -z "$1" ] 
    then
        # Prendre en paramètre un pid
        ionice -c3 -p$1 ; renice -n 19 -p $1
    else
        # Si il n'y a pas de paramètre on nice le pid courant (le bash)
        ionice -c3 -p$$ ; renice -n 19 -p $$
    fi
}
alias niceprod="nicecool"
alias np="niceprod"

alias lstar='tar -tf'
alias mktar='tar -cvf archive.tar'
alias untar='tar -xvf'

function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
alias extract="extract"
alias unall="extract"

function sd (){ ($@)
if [ $? = 0 ]; then
	/usr/local/bin/nma.sh "RPi cmd" "Réussi" "$@" 2
else
	/usr/local/bin/nma.sh "RPi cmd" "Raté" "$@" 2
fi
}

# Bannir l'IP d'un méchant rapidement
function ban() {
    if [ "`id -u`" == "0" ] ; then
        iptables -A INPUT -s $1 -j DROP
    else
        sudo iptables -A INPUT -s $1 -j DROP
    fi
}
alias ban="ban"

function me {
        sudo chown -R $USER $@
        sudo chgrp -R $USER $@
}

function root {
        sudo chown -R root $@
        sudo chgrp -R root $@
}

function up {
        echo -e "${BOLD}Mises à jour de la base de donnée ...$DEF"
        sudo updatedb
        echo -e "${BOLD}Mises à jour des paquets ...$DEF"
        sudo dpkg --configure -a
        sudo apt-get install -f
        sudo apt-get check -qq
        sudo apt-get update -qq
        sudo apt-get upgrade
        sudo apt-get autoremove --purge
        sudo apt-get clean -qq
        sudo apt-get autoclean -qq
	/usr/local/bin/nma.sh "MÀJ RPi" "Réussi" "Le Raspberry a été mise à jour." 2
}

# Misc
alias msgtail='sudo tail -n30 -f /var/log/messages | ccze'
alias systail='sudo tail -f /var/log/syslog | ccze'
alias wgett='wget -nc -c -v'
alias sget='aria2c --allow-overwrite=true -c --file-allocation=none --log-level=error -m2 --max-connection-per-server=2 --max-file-not-found=5 --min-split-size=5M --no-conf --remote-time=true --summary-interval=60 -t5'
alias mg='emacsclient -t'
alias bc='bc -l'
alias sha1='openssl sha1'
alias diff='colordiff'
alias head="sed '11 q'"
alias mount='mount |column -t'
alias inpkg='sudo apt-get install'
alias rmpkg='sudo apt-get autoremove --purge'
alias sepkg='apt-cache search'
alias sysup='sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade && sudo apt-get -y autoremove && sudo apt-get -y autoclean'
alias maj='sudo aptitude safe-upgrade -y'
alias yapyt='sudo yapyt'
alias q='exit'
alias c='clear'
alias wget='wget -c'
alias grepr='grep -r'
alias grep='grep -i --color'
alias tree="find . | sed 's/[^/]*\\//|   /g;s/| *\\([^| ]\\)/+--- \\1/'"
alias mkdir='mkdir -pv'
alias pg='ps aux | grep'
alias pl='ps faux | less'
#function mkcd () { mkdir $1 && cd $1 }
function mkcd() { mkdir -p "$@" && cd "$_"; }
alias mkcd="mkcd"

# SysAdmin
alias clexim='sudo exim -bp | sudo exiqgrep -i | sudo xargs exim -Mrm'
alias arm='sudo -u debian-tor arm'
# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'
# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'
alias ports='netstat -tulanp'
## shortcut  for iptables and pass it via sudo#
alias ipt='sudo /sbin/iptables'
# display all rules #
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist

# Log
alias minilog='tail -F /var/log/minidlna.log'
alias arialog='tail -F /var/log/aria2/aria2.log'
alias dmusb='dmesg | grep -i usb'
alias dmgmesg='sudo dmesg -n 1'
alias updlog='sudo tail -n 30 /var/log/aptitude'

## All of our servers eth1 is connected to the Internets via vlan / router etc  ##
alias dnstop='sudo dnstop -l 5 eth0'
alias vnstat='vnstat -i eth0'
alias iftop='sudo iftop -i eth0'
alias tcpdump='sudo tcpdump -i eth0'
alias ethtool='ethtool eth0'

## pass options to free ## 
alias meminfo='free -m -l -t' 
alias free='free -h'
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
## Get server cpu info ##
alias cpuinfo='lscpu'
## older system use /proc/cpuinfo ##
##alias cpuinfo='less /proc/cpuinfo' ##
## get GPU ram on desktop / laptop## 
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

# become root #
alias root='sudo -i'
#alias su='sudo -i'

# reboot / halt / poweroff
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'

# Sources : 
#  - http://root.abl.es/methods/1504/automatic-unzipuntar-using-correct-tool/
#  - http://forum.ubuntu-fr.org/viewtopic.php?id=20437&p=3

### Raspberry Pi Specific Aliases
## get model
alias model='cat /proc/cpuinfo'
## get temperature
alias tempinfo='sudo /opt/vc/bin/vcgencmd measure_temp'
## Overclock status
alias cpustatus='sudo cpustatus'
## WVC1 codec
alias hasVC1='/opt/vc/bin/vcgencmd codec_enabled WVC1 | grep enabled > /dev/null ; RETVAL=$?
[ $RETVAL -eq 0 ] && echo True
[ $RETVAL -ne 0 ] && echo False '
## MPG2 codec
alias hasMPG2='/opt/vc/bin/vcgencmd codec_enabled MPG2 | grep enabled > /dev/null ; RETVAL=$?
[ $RETVAL -eq 0 ] && echo True
[ $RETVAL -ne 0 ] && echo False '
## H.264 codec
alias hasH264='/opt/vc/bin/vcgencmd codec_enabled H264 | grep enabled > /dev/null ; RETVAL=$?
[ $RETVAL -eq 0 ] && echo True
[ $RETVAL -ne 0 ] && echo False '

# RPi Kernel Update
alias rpiu='sudo BRANCH=next rpi-update'
