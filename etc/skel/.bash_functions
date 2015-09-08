##############################################
### Un certain nombre de fonction bien utile #
##############################################

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

#function mkcd () { mkdir $1 && cd $1 }
function mkcd() { mkdir -p "$@" && cd "$_"; }
alias mkcd="mkcd"
