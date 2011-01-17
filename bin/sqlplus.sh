#!/bin/bash
#
#       svaggu 09/28/05 -  Creation
#

ORACLE_HOME=/usr/lib/oracle/xe/app/oracle/product/10.2.0/server
export ORACLE_HOME
ORACLE_SID=XE
export ORACLE_SID
NLS_LANG=`$ORACLE_HOME/bin/nls_lang.sh`
export NLS_LANG
PATH=$ORACLE_HOME/bin:$PATH
export PATH
sqlplus /nolog
