#!/bin/bash

if [ -f /usr/bin/gnome-terminal ]
then
	/usr/bin/gnome-terminal -t "SQL*Plus" -e "/usr/lib/oracle/xe/app/oracle/product/10.2.0/server/config/scripts/sqlplus.sh"
else
	/usr/bin/xterm  -T "SQL*Plus" -n "SQL*Plus" -e "/usr/lib/oracle/xe/app/oracle/product/10.2.0/server/config/scripts/sqlplus.sh"
fi
