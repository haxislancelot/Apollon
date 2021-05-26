#!/system/bin/sh
# Apollon by haxis
MODDIR=${0%/*}

# EXECUTE
/system/bin/cpu
/system/bin/dns
/system/bin/taskkiller
/system/bin/netspeed

# PERM
set_perm(0, 0, 0777, "/system/etc/init.d/01cpu");
set_perm(0, 0, 0777, "/system/etc/init.d/02taskkiller");
set_perm(0, 0, 0777, "/system/etc/init.d/03netspeed");

# ZRAM
sleep 10
echo 1536M >/sys/block/zram0/disksize
mkswap /dev/block/zram0
swapon  /dev/block/zram0

# HCONFIGS
sleep 30
$MODDIR/./hconfig
./hconfig

# VM TWEAKS
stop perfd
echo '100' > /proc/sys/vm/swappiness
echo '0' > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
echo '0' > /proc/sys/vm/overcommit_ratio
echo '100' > /proc/sys/vm/vfs_cache_pressure
echo '29615' > /proc/sys/vm/extra_free_kbytes
echo '256' > /proc/sys/kernel/random/read_wakeup_threshold
echo '256' > /proc/sys/kernel/random/write_wakeup_threshold
echo '2048' > /sys/block/mmcblk0/queue/read_ahead_kb
echo '0' > /sys/block/mmcblk0/queue/iostats
echo '1' > /sys/block/mmcblk0/queue/add_random
echo '2048' > /sys/block/mmcblk1/queue/read_ahead_kb
echo '0' > /sys/block/mmcblk1/queue/iostats
echo '1' > /sys/block/mmcblk1/queue/add_random
echo '4096' > /proc/sys/vm/min_free_kbytes
echo '0' > /proc/sys/vm/oom_kill_allocating_task
echo '40' > /proc/sys/vm/dirty_ratio
echo '10' > /proc/sys/vm/dirty_background_ratio
chmod 666 /sys/module/lowmemorykiller/parameters/minfree
chown root /sys/module/lowmemorykiller/parameters/minfree
echo '20949,27932,34915,76813,104745,111728' > /sys/module/lowmemorykiller/parameters/minfree