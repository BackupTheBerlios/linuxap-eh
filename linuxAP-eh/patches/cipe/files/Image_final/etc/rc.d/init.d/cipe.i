#!/bin/sh
CFGDIR="/etc/cipe"
CFGFILE="cipe.conf"
set -e
[ -f $CFGDIR/$CFGFILE ] || exit 0

case "$1" in
  start|2|3|4)
    kver=`cat /proc/version | cut -d ' ' -f 3`
    /sbin/insmod -o cipcb0 /lib/modules/$kver/misc/cipcb.o
    chmod 600 $CFGDIR
    chmod 600 $CFGDIR/$CFGFILE
    /usr/local/sbin/ciped-cb -o $CFGDIR/$CFGFILE
    echo "Done."
  ;;
  stop|0|1|6)
    killall ciped-cb
    /sbin/rmmod cipcb0
    echo "Done."
  ;;
  restart)
  	$0 stop
	sleep 1
  	$0 start
	;;
  *)
	echo "Usage: $0 {start|stop|restart}" >&2
	exit 1
	;;
esac

exit 0
