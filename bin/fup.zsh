#!/usr/bin/zsh 

function fup {
P=$PWD
while ( [[ "$P" != "/" ]] )
do
        P=$P/..
        ls -ld $P | grep $1 
done
}


fup x
