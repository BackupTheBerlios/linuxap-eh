#! /bin/sh
#
# wlan0
# Just turns on the card / sets up wep
#
DRIVER=hostap_cs
SSID=test
CHANNEL=1
NWDS=0

[ -f $CFGD/wlan0 ] && . $CFGD/wlan0

case "$1" in
    2) pargs="iw_mode=2" ;;
    3|4) pargs="iw_mode=3 channel=$CHANNEL" ;;
esac

case "$1" in
  2|3|4)
    echo -n "Starting wlan0: "
    kver=`cat /proc/version | cut -d ' ' -f 3`
    if [ -f /lib/modules/$kver/pcmcia/pcmcia_core.o ]
    then
        insmod pcmcia_core
        insmod i82365 # ignore=1
        insmod ds
    fi
    if [ -f /lib/modules/$kver/net/hostap_crypt.o ]
    then
        insmod hostap_crypt
    fi
    insmod hostap
    insmod $DRIVER ignore_cis_vcc=1 essid=$SSID $pargs
    insmod hostap_crypt_wep
    cardmgr -o
    if ifconfig wlan0 > /dev/null 2>&1
    then
        #iwconfig wlan0 txpower 20
        iwconfig wlan0 rate 11Mb
# Set the eth0 interface to the same mac
        HWADDR=`/sbin/ifconfig wlan0 | sed -n 's/.*HWaddr\(.*\)/\1/p'`
        ifconfig eth0 hw ether $HWADDR
    fi
    if [ "$wep" ]
    then
        iwconfig wlan0 enc $wep
        prism2_param wlan0 host_encrypt 1
        prism2_param wlan0 host_decrypt 1
    fi
    if [ \( $1 = 3 -o $1 = 4 \) -a $NWDS -gt 0 ]
    then
        prism2_param wlan0 max_wds $NWDS
        prism2_param wlan0 autom_ap_wds 1
        prism2_param wlan0 ap_bridge_packets 1
	prism2_param wlan0 other_ap_policy 1
    fi
    echo "Done."
    ;;
  stop|0|6)
    echo -n "Stopping wlan0: "
    ifconfig wlan0 down
# remove modules
    rmmod $DRIVER
    insmod hostap
    insmod hostap_crypt_wep
    insmod hostap_crypt
    if [ -f /lib/modules/$kver/pcmcia/pcmcia_core.o ]
    then
        rmmod ds
        rmmod i82365
        rmmod pcmcia_core
    fi
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
