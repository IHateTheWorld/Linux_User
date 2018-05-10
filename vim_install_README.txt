git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
Add and edit ~/.vimrc
Install Plugins:
    Launch vim and run :PluginInstall
    To install from command line: vim +PluginInstall +qall

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

Question:
    The following languages will be built: c,c++,fortran,java,lto,objc
    *** This configuration is not supported in the following subdirectories:
         gnattools target-libada target-libgo target-libbacktrace
        (Any other directories should still work fine.)
    checking for default BUILD_CONFIG... bootstrap-debug
    checking for --enable-vtable-verify... no
    /usr/bin/ld: cannot find crt1.o: No such file or directory
    /usr/bin/ld: cannot find crti.o: No such file or directory
    /usr/bin/ld: skipping incompatible /usr/lib/gcc/x86_64-linux-gnu/4.6/libgcc.a when searching for -lgcc
    /usr/bin/ld: cannot find -lgcc
    /usr/bin/ld: skipping incompatible /usr/lib/gcc/x86_64-linux-gnu/4.6/libgcc_s.so when searching for -lgcc_s
    /usr/bin/ld: cannot find -lgcc_s
    /usr/bin/ld: cannot find -lc
    /usr/bin/ld: skipping incompatible /usr/lib/gcc/x86_64-linux-gnu/4.6/libgcc.a when searching for -lgcc
    /usr/bin/ld: cannot find -lgcc
    /usr/bin/ld: skipping incompatible /usr/lib/gcc/x86_64-linux-gnu/4.6/libgcc_s.so when searching for -lgcc_s
    /usr/bin/ld: cannot find -lgcc_s
    /usr/bin/ld: cannot find crtn.o: No such file or directory
    collect2: ld returned 1 exit status
    configure: error: I suspect your system does not have 32-bit developement libraries (libc and headers). If you have them, rerun configure with --enable-multilib. If you do not have them, and want to build a 64-bit-only compiler, rerun configure with --disable-multilib.
Answer:
    sudo apt-get install gcc-multilib

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

Question: Full Screen
Answer:
    sudo pacman -S wmctrl
    sudo vim .vimrc
        function! MaximizeWindow()
            silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
        endfunction

        if has('win32')
            au GUIEnter * simalt ~x
        else
            au GUIEnter * call MaximizeWindow()
        endif

Question:
    Can't find the CMakeList.txt in third_party/ycmd/third_party/cregex
Answer:
    sudo rm -r third_party/ycmd/third_party/cregex
    git submodule update --init --recursive

Question:
    Traceback (most recent call last):
    File "/home/cchhit/.vim/bundle/YouCompleteMe/third_party/ycmd/ycmd/server_utils.py", line 96, in CompatibleWithCurrentCore
    ycm_core = ImportCore()
    File "/home/cchhit/.vim/bundle/YouCompleteMe/third_party/ycmd/ycmd/server_utils.py", line 88, in ImportCore
    import ycm_core as ycm_core
    ImportError: libtinfo.so.5: cannot open shared object file: No such file or directory
Answer:
    TODO, may be this is not a problem!

