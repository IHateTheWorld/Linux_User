=====下载url=====
https://www.archlinux.org/download/

=====archlinux基本系统安装=====
# lsblk
# parted
    1.(parted) mklabel msdos                        ---创建MBR/msdos分区表
    2.(parted) mkpart primary ext4 1m 1g            ---大小为1G
    3.(parted) set 1 boot on                        ---设置boot为启动目录
    4.(parted) mkpart primary ext4 1g 11g
    5.(parted) mkpart primary linux-swap 11g 12g
    6.(parted) print #                              ----查看分区情况
    7.(parted) quit #                               ----退出parted
# mkfs.ext4 /dev/sda1
# mkfs.ext4 /dev/sda2
# mkswap /dev/sda3  ----格式化swap
# swapon /dev/sda3  ----启用swap
# mount /dev/sda2 /mnt
# mkdir /mnt/{boot,home}
# mount /dev/sda1 /mnt/boot
# cd /etc/pacman.d/mirrorlist
# cp /etc/pacman.d/mirrorlist/mirrorlist /etc/pacman.d/mirrorlist/bk_mirrorlist  ----备份
# cat bk_mirrorlist | grep 163 > mirrorlist  ----使用163源
# pacman -Syy  ---- 更新本地数据库
# pacstrap /mnt base base-devel  ----安装基本系统
# genfstab -U -p /mnt >> /mnt/etc/fstab  ----生成fatab，分区表
# arch-chroot /mnt /bin/bash
# pacman -S grub os-prober  ----安装grub
# grub-install --recheck /dev/sda  ----将引导写入sda
# grub-mkconfig -o /boot/grub/grub.cfg  ----生成grub菜单
# useradd -m -g users -s /bin/bash <use_name>
# passwd <user_name>
# vim /etc/sudoers  ----添加<user> ALL=(ALL) ALL
# exit
# reboot

====vbox虚拟机安装注意事项====
选择启动顺序，避免安装完archlinux后启动进入到live cd
# pacman -Syu virtualbox-guest-modules-arch virtualbox-guest-utils
# modprobe -a vboxguest vboxsf vboxvideo
# VBoxClient-all

=====联网问题=====
# dhcpcd  ----手动获取ip地址
# systemctl enable dhcpcd  ----设置开机启动

=====同步时间=====
# pacman -S ntp
# systemctl start ntpd.service
# systemctl enable ntpd.service

=====桌面环境=====
# pacman -S xf86-video-vesa  ----显卡驱动
# pacman -S xorg  ----需要xorg支持
# pacman -S xfce4 xfce4-goodies  ----Xfce桌面
# pacman -S sddm  ----桌面管理器
# systemctl enable sddm  ----支持多个桌面启动选择
# pacman -S screenfetch  ----系统logo和状态

=====安装yaourt=====
# vim /etc/pacman.conf  ----加入：
    [archlinuxfr]
    SigLevel = Never
    Server = http://repo.archlinux.fr/$arch
    
    [archlinuxcn]
    #The Chinese Arch Linux communities packages.
    SigLevel = Optional TrustAll
    Server = http://repo.archlinuxcn.org/$arch
# pacman -Sy yaourt
# pacman -S archlinuxcn-keyring
# pacman -S google-chrome  ----chorme安装包来自于前面添加的ArchLinuxCN源

=====声卡驱动=====
# pacman -S alsa-utils  ----包含的 alsamixer 工具允许用户在控制台或终端中配置声音设备
# alsamixer  ----使用说明如下：https://wiki.archlinux.org/index.php/Advanced_Linux_Sound_Architecture_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
    在 alsamixer 中，下方标有 MM 的声道是静音的，而标有 00 的通道已经启用。
    使用 ← 和 → 方向键，选中 Master 和 PCM 声道。按下 m 键解除静音。使用 ↑ 方向键增加音量，直到增益值为0。该值显示在左上方 Item: 字段后。过高的增益值会导致声音失真。

=====fcitx输入法=====
# pacman -S fcitx-im fcitx-configtool
# pacman -S fcitx-sogoupinyin
在~/.xinitrc文件(或者新建.xprofile文件)加入：
export LC_CTYPE=zh_CN.UTF-8 ----LC_ALL将是全局设置，不推荐
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=”@im=fcitx”

=====samba服务器(未设置成功)=====
# systemctl start smb.service nmb.service
# systemctl enable smb.service nmb.service
# vim /etc/samba/smb.conf  ----添加内容如下：

# pdbedit -a -u archlinux
# pdbedit -L -v

=====共享文件夹=====
宿主windows下vbox中设置共享文件
# mkdir /mnt/arch_share  ----arch_share对应设置的共享文件夹名称
# sudo mount -cit vboxsf arch_share /mnt/arch_share
# sudo mount -cit vboxsf -o uid=1000,gid=985 arch_share /mnt/arch_share  ----通过id <username>可以查看

开机自动挂载：在/etc/fstab文件中添加(未设置成功)
arch_share  /mnt/arch_share  vboxsf  uid=user,gid=group,rw,dmode=700,fmode=600,noauto,x-systemd.automount 

# vim /usr/lib/systemd/system/rc-local.service
    [Unit]
    Description=/etc/rc.local Compatibility

    [Service]
    Type=oneshot
    ExecStart=/etc/rc.local
    TimeoutSec=0
    StandardInput=tty
    RemainAfterExit=yes

    [Install]
    WantedBy=multi-user.target
# vim /etc/rc.local  ----往其中添加mount命令，注意在shell脚本的头部添加#!/bin/bash
    #!/bin/bash

    share_name="arch_share"
    share_path="/mnt/arch_share"

    if [ ! -d ${share_path} ]; then
        mkdir ${share_path}
    fi

    mount -cit vboxsf ${share_name} ${share_path}
# chmod +x /etc/rc.local
# systemctl enable rc-local.service

=====字体设置(具体的设置应该还是要通过fontconfig来实现)=====
# mkdir -p /usr/share/fonts/winFonts
# cp /mnt/arch_share/Fonts/* /usr/share/fonts/winFonts/
# mkfontscale
# mkfontdir
# fc-cache -vf  ----刷新字体缓存
# fc-match  ----查看默认字体
