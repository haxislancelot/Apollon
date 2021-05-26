unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
unzip -o "$ZIPFILE" 'mode/*' -d $TMPDIR >&2
mkdir -p $MODPATH/system/bin
mkdir -p $MODPATH/system/etc/sysconfig

ui_print ""
sleep 0.3
ui_print " Vol. + To Choose , Vol. - Select"
ui_print ""
sleep 0.3
ui_print "=========================="
ui_print "-        Low Ram         -"
ui_print "=========================="
sleep 0.2
ui_print " 1 - Enable "
sleep 0.2
ui_print " 2 - Disable "
ui_print ""
sleep 0.1
ui_print " Select : "
GU=1
while true; do
	ui_print "  $GU"
	if $VKSEL; then
		GU=$((GU + 1))
	else 
		break
	fi
	if [ $GU -gt 2 ]; then
		GU=1
	fi
done
#
case $GU in
 1 ) FCTEXT="Enable"; sed -i '/ro.config.low_ram/s/.*/ro.config.low_ram=true/' $MODPATH/system.prop;;
 2 ) FCTEXT="Disabled"; sed -i '/ro.config.low_ram/s/.*/ro.config.low_ram=false/' $MODPATH/system.prop;;
esac
ui_print ""
ui_print "- Mode Selected : $FCTEXT "
ui_print "" 

dbg "Finished with $ERR_CNT failed writes."