# QEMU configuration for loading DragonflyBSD
``` qemu-system-x86_64 -m 4096 -drive if=virtio,file=dragonflybsd.qcow2,format=qcow2,index=0,id=disk -device ahci,id=disk -smp 4 -cpu max -enable-kvm -display gtk ```
