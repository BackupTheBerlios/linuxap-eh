source:		linuxAP.eh[1]
Version:	?

Use:
"make" linuxAP-eh gets configured and then you can compile it
"make menuconfig" to reconfigure it and fater it make to compile
"make clean" to clean up the binaries 
"make distclean" it cleans all and even the binary and sources of the unpackaged
software (busybox, iptables, etc...)

The next info is focused to  Eumitcom WL11000 SA-N platform, but there can be
problematic versions of this software, and other that can run perfectly for you.

The versions in the conf menu are:

Utility 		Available and tested versions
-------- 		--------------------------------
kernel 			2.4.20
hostap 			2002-10-12, 0.0.3, 0.0.4 (*)
kernel-aodv 		v2.0,v2.1 (**)

(*) this version have no txpower (it makes distorsions on radio signal)

(**) very alpha phase, it doesn't work yet.

The default versions of unchoosable version software from menuconfig are:

Utility		        Available and tested versions
--------		--------------------------------
bridge-utils		0.9.6
busybox			0.60.5, 1.00-pre2(*)
cipe			1.5.4
cramfs			1.1
iptables		1.2.7a
linux			2.4.20
openvpn			1.5-beta7
pcmcia-cs		3.2.3
uClibc			0.9.17, 0.9.20(*)
wireless_tools		25

(*) default used versions

[1] http://linuxAP-eh.berlios.de
