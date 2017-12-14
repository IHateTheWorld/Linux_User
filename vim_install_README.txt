sudo apt-get install python3

sudo apt-get install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
    libcairo2-dev libx11-dev libxpm-dev libxt-dev \
    python-dev python3-dev ruby-dev liblua5.1 lua5.1-dev libperl-dev \
    mercurial checkinstall git
sudo apt-get remove vim vim-tiny vim-common vim-runtime gvim vim-gui-common
git clone https://github.com/vim/vim.git
cd vim/
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-python3interp=yes \
            --with-python3-config-dir=/usr/lib/python3.2/config \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 --enable-cscope \
            --prefix=/usr
make VIMRUNTIMEDIR=/usr/share/vim/vim80
sudo make install

./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-python3interp=yes \
            --with-python3-config-dir=/usr/local/python3.5/lib/python3.5/config-3.5m \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 --enable-cscope \
            --prefix=/usr

Question:
    The ycmd server SHUT DOWN (restart with ':YcmRestartServer'). YCM core lib... compile YCM before using it. Follow the instructions in the documentation.
Answer:
    cd ~/.vim/bundle/YouCompleteMe
    sudo apt-get install cmake
    ./install.py --all or ./install.py --clang-completer

Question: 
    CMake Error at CMakeLists.txt:224 (message):
    Your C++ compiler does NOT fully support C++11.
Answer: CXX="/usr/local/bin/gcc" ./install.py

Question:
    CMake 2.8.11 or higher is required.  You are running version 2.8.7
Answer:
    sudo apt-get remove cmake
    tar -zxvf CMake-3.9.4.tar.gz
    cd CMake-3.9.4
    ./bootstrap
    make && sudo make install

Question:
    Your C++ compiler does NOT fully support C++11.
Answer: Update gcc to version 4.9.4
    sudo apt-get install libisl-dev libcloog-isl-dev
    sudo apt-get install m4  //Question: configure:error:no usable m4 in$path or /user/5bin
    tar -xvf gmp-6.1.1.tar.bz2
    cd gmp-6.1.1
    ./configure
    make
    sudo make install
    tar -xvf mpfr-3.1.6.tar.gz
    cd mpfr-3.1.6
    ./configure
    make
    sudo make install
    tar -zxvf mpc-1.0.3.tar.gz
    //libmpfr not found or uses a different ABI (including static vs shared) ==> should install mpfr first
    //Attention: Order
    cd mpc-1.0.3
    ./configure
    make
    sudo make install
    tar -xvf isl-0.15.tar.bz2
    cd isl-0.15
    ./configure
    make
    sudo make install
    tar -zxvf gcc-4.9.4.tar.gz
    cd gcc-4.9.4
    ./configure
    //checking for suffix of object files... configure: error: in `/home/cchhit/software/gcc-4.9.4/x86_64-unknown-linux-gnu/libgcc':
    //configure: error: cannot compute suffix of object files: cannot compile
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
    make //try make -j4, speed up
    sudo make install

Question: Disk has no space
Answer: VBOX UBUNTU-VM
    ============Windows=============
    cd C:\Program Files\Oracle\VirtualBox
    VBoxManage list hdds
    VBoxManage modifyhd <UUID> --resize <SIZE>
    ============Linux=============
    sudo fdsk -l
    sudo fdisk /dev/sda
    sudo partprobe //partition table
    sudo mkfs.ext4 /dev/sda#
    sudo mkdir ~/work_zone
    sudo mount /dev/sda#/ ~/work_zone
    sudo vim /etc/fstab  <==add== /dev/sda# /home/cchhit/work_zone ext4 defaults 0 1

Question:
    /home/cchhit/work_zone/software/gcc-4.9.4/host-x86_64-unknown-linux-gnu/gcc/cc1: error while loading shared libraries: libmpc.so.3: cannot open shared object file: No such file or directory
Answer:
    //export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib //or add to /etc/profile, then source /etc/profile
    sudo ln -s /usr/local/lib/libmpc.so.3.0.0 /usr/lib/x86_64-linux-gnu/libmpc.so.3

Question:
    /home/cchhit/work_zone/software/CMake-3.9.4/Bootstrap.cmk/cmake: /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version `GLIBCXX_3.4.20' not found (required by /home/cchhit/work_zone/software/CMake-3.9.4/Bootstrap.cmk/cmake)
Answer:
    sudo rm libstdc++.so.6
    sudo ln -s /usr/local/lib64/libstdc++.so.6.0.20 /usr/lib/x86_64-linux-gnu/libstdc++.so.6
    strings /usr/lib/x86_64-linux-gnu/libstdc++.so.6 | grep GLIBCXX

Question:
    ycm_core.so: undefined symbol: ZTVN10__cxxabiv120_si_class_type_infoE
Answer: Because gcc is 4.6 and g++ is 4.9
    //update the gcc/g++
    sudo rm /usr/bin/gcc
    sudo ln -s /usr/local/bin/gcc /usr/bin/gcc
    sudo rm /usr/bin/g++
    sudo ln -s /usr/local/bin/g++ /usr/bin/g++