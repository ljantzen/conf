# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
#export ZSH_THEME="robbyrussell"
export ZSH_THEME="clean"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh
source ~/.git-flow-completion.zsh

# Customize to your needs...
export PATH=:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:$HOME/bin:$SCALA_HOME/bin:$GRAILS_HOME/bin::/opt/Wimp/bin:~/dev/android/sdk/tools:~/bk:/home/leif/apps/mule/bin:/home/leif/apps/jboss/bin:/home/leif/apps/soapui/bin:/home/leif/dev/groovy/grails/bin:/home/leif/dev/java/tools/cxf/bin

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias lr='ls -lrt'
alias ack=ack-grep

alias ff='find . -name '
alias oas='ssh -l oracle -Y suse-oas-portal'
alias oks='ssh -l oracle -Y suse-oks-portal'
alias db='ssh -l oracle -Y suse-db-portal'
alias app='ssh -l root -Y suse64-app-portal'
alias soa='ssh -l mule -Y test-soa-utv'
alias mci='mvn clean install'
alias moci='mvn -o clean install'
alias mct='mvn clean install -Dmaven.test.skip=true '
alias msr='mvn  scala:run'
alias x='cd  -'
alias md='mkdir -p'
alias apt-get='sudo apt-get'
alias st='git status'
alias vpn='sudo openvpn --config ~/.vpn/client.ovpn'
alias gimli='sudo mount -t nfs 192.168.1.12:QMultimedia /media/gimli/'
alias vbrc='vi ~/.bashrc && . ~/.bashrc'
alias vi=vim
alias go=gnome-open
alias Z='z && ls'
alias q='qgit --all &'

export EDITOR=vim

export SCALA_HOME=/opt/scala/current

export JDK_HOME=/usr/lib/jvm/java-6-sun
export JAVA_HOME=$JDK_HOME
export IMQ_JAVAHOME=$JDK_HOME

export LANG=en_US.UTF-8

export GRAILS_HOME=/home/leif/dev/groovy/grails
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

unsetopt correct_all

function ffind {
if [ "$2" == "" ] ; then 
        find . -name "$1" -type f | xargs ls -lrt 
else 
        find $1 -name "$2" -type f | xargs ls -lrt 
fi 
}


function z {
LIMIT=$1
if [[ "$LIMIT" == "" ]]   { LIMIT=1 }

P=$PWD
for  i in {1..$LIMIT}
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

function m2 {
  
  if [[ "$1" == "" ]] ; then 
    ls -l $HOME/.m2/settings.xml
  fi 

  if [[ "$1" == "home" ]] ; then  
     rm $HOME/.m2/settings.xml
     ln -s $HOME/.m2/home.xml $HOME/.m2/settings.xml
  fi 

  if [[ "$1" == "bk" ]] ; then  
     rm $HOME/.m2/settings.xml
     ln -s $HOME/.m2/bk.xml $HOME/.m2/settings.xml
  fi 

}

