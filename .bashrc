#!bin/bash 
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='DIR=`pwd|sed -e "s!$HOME!~!"`; if [ ${#DIR} -gt 30 ]; then CurDir=${DIR:0:12}...${DIR:${#DIR}-15}; else CurDir=$DIR; fi'
    #PS1="[\$CurDir] \$ "
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias lr='ls -lrt'
alias ack=ack-grep

alias ff='find . -name '
alias g=git
alias oas='ssh -l oracle -Y suse-oas-portal'
alias oks='ssh -l oracle -Y suse-oks-portal'
alias db='ssh -l oracle -Y suse-db-portal'
alias app='ssh -l root -Y suse64-app-portal'
alias soa='ssh -l mule -Y test-soa-utv'
alias mci='mvn clean install'
alias mct='mvn clean install -Dmaven.test.skip=true '
alias msr='mvn  scala:run'
alias x='cd  -'
alias md='mkdir -p'
alias apt-get='sudo apt-get'
#alias g='git'
alias st='git status'
alias vpn='sudo openvpn --config ~/.vpn/client.ovpn'
alias gimli='sudo mount -t nfs 192.168.1.12:QMultimedia /media/gimli/'
alias vbrc='vi ~/.bashrc && . ~/.bashrc'
alias vi=vim
alias go=gnome-open
alias Z='z && ls'
alias q='qgit --all &'
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
complete -o default -o nospace -F _git g

export EDITOR=vim

export SCALA_HOME=/opt/scala/current

export JDK_HOME=/usr/lib/jvm/java-6-sun
export JAVA_HOME=$JDK_HOME
export IMQ_JAVAHOME=$JDK_HOME

export LANG=en_US.UTF-8

export GRAILS_HOME=/home/leif/dev/groovy/grails

export PATH=:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin:$SCALA_HOME/bin:$GRAILS_HOME/bin::/opt/Wimp/bin:~/dev/android/sdk/tools:~/bk

export APACHE_CONF=/u01/app/apache_conf/

export MULE_HOME=/home/leif/apps/mule
export PATH=$PATH:$MULE_HOME/bin

export JBOSS_HOME=/home/leif/apps/jboss 
export PATH=$PATH:$JBOSS_HOME/bin

export SOAPUI_HOME=/home/leif/apps/soapui
export PATH=$PATH:$SOAPUI_HOME/bin

export CDPATH=.:~:
export HISTIGNORE="&:ls:[bf]g:exit" 

export MAVEN_OPTS="-Xms128m -Xmx1024m -XX:MaxPermSize=256m"

function ffind {
if [ "$2" == "" ] ; then 
        find . -name "$1" -type f | xargs ls -lrt 
else 
        find $1 -name "$2" -type f | xargs ls -lrt 
fi 
}


function z {
LIMIT=$1
if [ "$LIMIT" == "" ] ; then 
        LIMIT=1
fi

P=$PWD
for ((i=1; i <= LIMIT; i++))
do
        P=$P/..
done
cd $P
}

function qc {
if [ "$2" == "" ] ; then 
        scp $1 root@suse64-app-portal:~/tmp
else 
        scp $1 root@suse64-app-portal:~/$2
fi 
}

function cdp {
if [ "$1" == "" ] ; then 
        cd $(pwd -P)
else 
        cd $1
        cd $(pwd -P)
fi 
}

function jcat {
cp $1 /tmp
cd /tmp
jar xvf $1 $2
cat $2
rm $1
cd -
}

function apt-find {
apt-cache search $1 
} 


function b4 {

if [ "$1" == "" ] ; then 
    echo "b4 [d|a|p] [-u] [-c] [-i] [-C]"
    echo "-u update"
    echo "-c clean"
    echo "-i install"
    echo "-C copy"
    return
fi 

ENVI="development"
if [ "$1" == "d" -o "$1" == "dev" ] ; then 
        ENVI="development"
fi 
if [ "$1" == "a" -o "$1" == "test" ] ; then 
        ENVI="acceptance"
fi 
if [ "$1" == "p" -o "$1" == "prod" ] ; then 
        ENVI="production"
fi 

echo "Building for $ENVI"

if [ "$2" == "-u"  -o "$3" == "-u" -o "$4" == "-u" -o "$5" == "-u" ] ; then  
        echo "svn up"
        svn up 
fi

CLEAN=""
if [ "$2" == "-c" -o "$3" == "-c" -o "$4" == "-c" -o "$5" == "-c" ] ; then 
        CLEAN="clean"
fi 

if [ "$2" == "-i" -o "$3" == "-i" -o "$4" == "-i" -o "$5" == "-i" ] ; then 
        mvn $CLEAN install 
fi 

if [ "$1" == "d" ] ; then 
  ant -q $CLEAN package.release -Dtarget.environment=$ENVI
fi

if [ "$2" == "-C" -o "$3" == "-C" -o "$4" == "-C" -o "$5" == "-C" ] ; then 
        if [ "$ENVI" == "development" ] ; then 
                scp target/$ENVI/appserver-$ENVI.zip oracle@suse-oks-portal:~/tmp/
        fi 



        if [ "$ENVI" == "acceptance" -o "$ENVI" == "production" ] ; then 
                cp target/$ENVI/appserver-$ENVI.zip /media/KINGSTON
                cp target/$ENVI/portalserver-$ENVI.zip /media/KINGSTON
                if [ "$2" == "-m" -o "$3" == "-m"  -o "$4" == "-m" -o "$5" == "-m" -o "$6" == "-m" ] ; then 
                        umount /media/KINGSTON
                fi 
        fi 
fi 

}

function dircomp {
diff -qsr "$1" "$2" | grep -v 'are identical$'
}

if [ "$PS1" ]; then
        # Disables the bloody CapsLock button
        xmodmap -e "remove lock = Caps_Lock"
fi


#function fj {
#if [ "$2" == "" ] ; then 
#        class=$1
#        dir="."
#else 
#        class=$2
#        dir=$1
#fi
#
#find $dir -type f -name "*.jar" | xargs -n1 -i -t jar tvf '{}' |grep -i -w $class
#}


function m2 {
  
  if [ "$1" == "" ] ; then 
    ls -l $HOME/.m2/settings.xml
  fi 

  if [ "$1" == "home" ] ; then  
     rm $HOME/.m2/settings.xml
     ln -s $HOME/.m2/home.xml $HOME/.m2/settings.xml
  fi 

  if [ "$1" == "bk" ] ; then  
     rm $HOME/.m2/settings.xml
     ln -s $HOME/.m2/bk.xml $HOME/.m2/settings.xml
  fi 

}

