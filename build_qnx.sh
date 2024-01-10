#!/bin/bash

###############################################################################
#   user configurations

_CFG_build_target="1.14.1-qnx710-aarch64le" # possible values: 1.8.2-qnx700-aarch64le, 1.14.1-qnx710-aarch64le
_CFG_qnx700_inst_dir=~/qnx/qnx700/
_CFG_qnx710_inst_dir=~/qnx/qnx710/
_CFG_tmp_dir=~/ort_qnx/

###############################################################################
#   internal configs (do not touch)

_CFG_qnx700_inst_dir=$(realpath $_CFG_qnx700_inst_dir)
_CFG_qnx710_inst_dir=$(realpath $_CFG_qnx710_inst_dir)
_CFG_tmp_dir=$(realpath $_CFG_tmp_dir)
_CFG_patches_dir=$(realpath $(dirname $0))

echo "                   C O N F I G S"
echo "------------------------------------------------------------------------"
echo "     building for target | $_CFG_build_target"
echo " qnx700 sdp installed at | $_CFG_qnx700_inst_dir"
echo " qnx710 sdp installed at | $_CFG_qnx710_inst_dir"
echo "         temporary draft | $_CFG_tmp_dir"
echo "      patches located at | $_CFG_patches_dir"
echo "------------------------------------------------------------------------"
echo ""

###############################################################################
#   utils

function INFO__() {
    printf "\e[33minfo: \e[1;33m$1\e[0m\n"
}

function OK__() {
    printf "\e[32msuccess: \e[1;32m$1\e[0m\n"
}

function ERROR__() {
    printf "\e[31merror: \e[1;31m$1\e[0m\n"
}

###############################################################################
#   qnx system headers

function _patch_sys_headers_qnx710() {
    __headers_root=$_CFG_qnx710_inst_dir/target/qnx7/usr/include/c++/8.3.0

    # $_CFG_qnx710_inst_dir/target/qnx7/usr/include/c++/8.3.0/bits/stl_map.h:638:26: error: expected nested-name-specifier before numeric constant
    #        template <typename _C2>
    #                           ^~~
    cat $__headers_root/bits/stl_map.h | grep "_C2" >/dev/null
    if [ $? -eq 0 ]; then
        INFO__ "[qnx710] patching <bits/stl_map.h>"
        sed --in-place=.bak 's/_C2/_CC/g' $__headers_root/bits/stl_map.h
    fi

    # $_CFG_qnx710_inst_dir/target/qnx7/usr/include/c++/8.3.0/bits/stl_multimap.h:654:25: error: expected nested-name-specifier before numeric constant
    #        template<typename _C2>
    #                          ^~~
    cat $__headers_root/bits/stl_multimap.h | grep "_C2" >/dev/null
    if [ $? -eq 0 ]; then
        INFO__ "[qnx710] patching <bits/stl_multimap.h>"
        sed --in-place=.bak 's/_C2/_CC/g' $__headers_root/bits/stl_multimap.h
    fi

    # # reason unknown
    # cat $__headers_root/thread | grep "#include <ctime>" >/dev/null
    # if [ $? -ne 0 ]; then
    #     INFO__ "[qnx710] patching <thread>"
    #     sed --in-place=.bak 's/#include <chrono>/#include <chrono>\n#include <ctime>/g' $__headers_root/thread
    # fi

    OK__ "[qnx710] system libcxx headers patched"
}

###############################################################################
#   boost library

function _build_boost_1_71_0_qnx700() {
    INFO__ "[boost] downloading boost_1_71_0.tar.gz..."
    __boost_archive=$_CFG_tmp_dir/boost_1_71_0.tar.gz
    if [ ! -f $__boost_archive ]; then
        mkdir -p $_CFG_tmp_dir
        wget https://boostorg.jfrog.io/artifactory/main/release/1.71.0/source/boost_1_71_0.tar.gz -O $__boost_archive
    fi

    INFO__ "[boost] extracting source files..."
    __boost_extract_dir=$_CFG_tmp_dir/boost
    rm -rf $__boost_extract_dir
    mkdir -p $__boost_extract_dir
    tar --extract --file $__boost_archive --directory $__boost_extract_dir
    if [ $? -ne 0 ]; then
        ERROR__ "[boost] failed to extract archive $__boost_archive"
        exit 1
    fi

    INFO__ "[boost] setting up build environment"
    __boost_workspace=$__boost_extract_dir/boost_1_71_0
    cd $__boost_workspace
    ./bootstrap.sh
    cat $_CFG_patches_dir/boost_cfg_1.71.0_qnx700.jam >./boost_user_config.jam

    INFO__ "[boost] running build on qnx700-nto-i386"
    export QNX_TARGET_ARCH=i386
    ./b2 -a -q --user-config=./boost_user_config.jam target-os=qnxnto architecture=x86 address-model=32 link=static variant=release threading=multi --layout=versioned --with-filesystem --with-program_options --with-system --prefix=$QNX_TARGET/x86/usr install
    if [ $? -ne 0 ]; then
        ERROR__ "[boost] build target qnx700-nto-i386 failed"
        exit 1
    fi

    INFO__ "[boost] running build on qnx700-nto-amd64"
    export QNX_TARGET_ARCH=amd64
    ./b2 -a -q --user-config=./boost_user_config.jam target-os=qnxnto architecture=x86 address-model=64 link=static variant=release threading=multi --layout=versioned --with-filesystem --with-program_options --with-system --prefix=$QNX_TARGET/x86_64/usr install
    if [ $? -ne 0 ]; then
        ERROR__ "[boost] build target qnx700-nto-amd64 failed"
        exit 1
    fi

    INFO__ "[boost] running build on qnx700-nto-armv7"
    export QNX_TARGET_ARCH=armv7
    ./b2 -a -q --user-config=./boost_user_config.jam target-os=qnxnto architecture=arm address-model=32 link=static variant=release threading=multi --layout=versioned --with-filesystem --with-program_options --with-system --prefix=$QNX_TARGET/armle-v7/usr install
    if [ $? -ne 0 ]; then
        ERROR__ "[boost] build target qnx700-nto-armv7 failed"
        exit 1
    fi

    INFO__ "[boost] running build on qnx700-nto-aarch64"
    export QNX_TARGET_ARCH=aarch64
    ./b2 -a -q --user-config=./boost_user_config.jam target-os=qnxnto architecture=arm address-model=64 link=static variant=release threading=multi --layout=versioned --with-filesystem --with-program_options --with-system --prefix=$QNX_TARGET/aarch64le/usr install
    if [ $? -ne 0 ]; then
        ERROR__ "[boost] build target qnx700-nto-aarch64 failed"
        exit 1
    fi

    INFO__ "[boost] fixing binary paths for cmake"
    __qnxlibs="$QNX_TARGET/x86/usr/lib"
    rm -f "$__qnxlibs/libboost_filesystem.a"
    rm -f "$__qnxlibs/libboost_program_options.a"
    rm -f "$__qnxlibs/libboost_system.a"
    cp "$__qnxlibs/libboost_filesystem-qcc-mt-x32-1_71.a" "$__qnxlibs/libboost_filesystem.a"
    cp "$__qnxlibs/libboost_program_options-qcc-mt-x32-1_71.a" "$__qnxlibs/libboost_program_options.a"
    cp "$__qnxlibs/libboost_system-qcc-mt-x32-1_71.a" "$__qnxlibs/libboost_system.a"
    __qnxlibs="$QNX_TARGET/x86_64/usr/lib"
    rm -f "$__qnxlibs/libboost_filesystem.a"
    rm -f "$__qnxlibs/libboost_program_options.a"
    rm -f "$__qnxlibs/libboost_system.a"
    cp "$__qnxlibs/libboost_filesystem-qcc-mt-x64-1_71.a" "$__qnxlibs/libboost_filesystem.a"
    cp "$__qnxlibs/libboost_program_options-qcc-mt-x64-1_71.a" "$__qnxlibs/libboost_program_options.a"
    cp "$__qnxlibs/libboost_system-qcc-mt-x64-1_71.a" "$__qnxlibs/libboost_system.a"
    __qnxlibs="$QNX_TARGET/armle-v7/usr/lib"
    rm -f "$__qnxlibs/libboost_filesystem.a"
    rm -f "$__qnxlibs/libboost_program_options.a"
    rm -f "$__qnxlibs/libboost_system.a"
    cp "$__qnxlibs/libboost_filesystem-qcc-mt-a32-1_71.a" "$__qnxlibs/libboost_filesystem.a"
    cp "$__qnxlibs/libboost_program_options-qcc-mt-a32-1_71.a" "$__qnxlibs/libboost_program_options.a"
    cp "$__qnxlibs/libboost_system-qcc-mt-a32-1_71.a" "$__qnxlibs/libboost_system.a"
    __qnxlibs="$QNX_TARGET/aarch64le/usr/lib"
    rm -f "$__qnxlibs/libboost_filesystem.a"
    rm -f "$__qnxlibs/libboost_program_options.a"
    rm -f "$__qnxlibs/libboost_system.a"
    cp "$__qnxlibs/libboost_filesystem-qcc-mt-a64-1_71.a" "$__qnxlibs/libboost_filesystem.a"
    cp "$__qnxlibs/libboost_program_options-qcc-mt-a64-1_71.a" "$__qnxlibs/libboost_program_options.a"
    cp "$__qnxlibs/libboost_system-qcc-mt-a64-1_71.a" "$__qnxlibs/libboost_system.a"

    OK__ "[boost] build complete"
}

function _build_boost_1_80_0_qnx710() {
    INFO__ "[boost] downloading boost_1_80_0.tar.gz..."
    __boost_archive=$_CFG_tmp_dir/boost_1_80_0.tar.gz
    if [ ! -f $__boost_archive ]; then
        mkdir -p $_CFG_tmp_dir
        wget https://boostorg.jfrog.io/artifactory/main/release/1.80.0/source/boost_1_80_0.tar.gz -O $__boost_archive
    fi

    INFO__ "[boost] extracting source files..."
    __boost_extract_dir=$_CFG_tmp_dir/boost
    rm -rf $__boost_extract_dir
    mkdir -p $__boost_extract_dir
    tar --extract --file $__boost_archive --directory $__boost_extract_dir
    if [ $? -ne 0 ]; then
        ERROR__ "[boost] failed to extract archive $__boost_archive"
        exit 1
    fi

    INFO__ "[boost] setting up build environment"
    __boost_workspace=$__boost_extract_dir/boost_1_80_0
    cd $__boost_workspace
    ./bootstrap.sh
    cat $_CFG_patches_dir/boost_cfg_1.80.0_qnx710.jam >./boost_user_config.jam

    INFO__ "[boost] running build on qnx710-nto-amd64"
    export QNX_TARGET_ARCH=amd64
    ./b2 -a -q --user-config=./boost_user_config.jam target-os=qnxnto architecture=x86 address-model=64 link=static link=shared variant=release threading=multi --layout=versioned --with-filesystem --with-program_options --with-system --prefix=${QNX_TARGET}/x86_64/usr install
    if [ $? -ne 0 ]; then
        ERROR__ "[boost] build target qnx710-nto-amd64 failed"
        exit 1
    fi

    INFO__ "[boost] running build on qnx710-nto-armv7"
    export QNX_TARGET_ARCH=armv7
    ./b2 -a -q --user-config=./boost_user_config.jam target-os=qnxnto architecture=arm address-model=32 link=static link=shared variant=release threading=multi --layout=versioned --with-filesystem --with-program_options --with-system --prefix=${QNX_TARGET}/armle-v7/usr install
    if [ $? -ne 0 ]; then
        ERROR__ "[boost] build target qnx710-nto-armv7 failed"
        exit 1
    fi

    INFO__ "[boost] running build on qnx710-nto-aarch64"
    export QNX_TARGET_ARCH=aarch64
    ./b2 -a -q --user-config=./boost_user_config.jam target-os=qnxnto architecture=arm address-model=64 link=static link=shared variant=release threading=multi --layout=versioned --with-filesystem --with-program_options --with-system --prefix=${QNX_TARGET}/aarch64le/usr install
    if [ $? -ne 0 ]; then
        ERROR__ "[boost] build target qnx710-nto-aarch64 failed"
        exit 1
    fi

    INFO__ "[boost] fixing binary paths for cmake"
    __qnxlibs="$QNX_TARGET/x86_64/usr/lib"
    rm -f "$__qnxlibs/libboost_atomic.a"
    rm -f "$__qnxlibs/libboost_filesystem.a"
    rm -f "$__qnxlibs/libboost_program_options.a"
    rm -f "$__qnxlibs/libboost_system.a"
    cp "$__qnxlibs/libboost_atomic-qcc-mt-x64-1_80.a" "$__qnxlibs/libboost_atomic.a"
    cp "$__qnxlibs/libboost_filesystem-qcc-mt-x64-1_80.a" "$__qnxlibs/libboost_filesystem.a"
    cp "$__qnxlibs/libboost_program_options-qcc-mt-x64-1_80.a" "$__qnxlibs/libboost_program_options.a"
    cp "$__qnxlibs/libboost_system-qcc-mt-x64-1_80.a" "$__qnxlibs/libboost_system.a"
    __qnxlibs="$QNX_TARGET/armle-v7/usr/lib"
    rm -f "$__qnxlibs/libboost_atomic.a"
    rm -f "$__qnxlibs/libboost_filesystem.a"
    rm -f "$__qnxlibs/libboost_program_options.a"
    rm -f "$__qnxlibs/libboost_system.a"
    cp "$__qnxlibs/libboost_atomic-qcc-mt-a32-1_80.a" "$__qnxlibs/libboost_atomic.a"
    cp "$__qnxlibs/libboost_filesystem-qcc-mt-a32-1_80.a" "$__qnxlibs/libboost_filesystem.a"
    cp "$__qnxlibs/libboost_program_options-qcc-mt-a32-1_80.a" "$__qnxlibs/libboost_program_options.a"
    cp "$__qnxlibs/libboost_system-qcc-mt-a32-1_80.a" "$__qnxlibs/libboost_system.a"
    __qnxlibs="$QNX_TARGET/aarch64le/usr/lib"
    rm -f "$__qnxlibs/libboost_atomic.a"
    rm -f "$__qnxlibs/libboost_filesystem.a"
    rm -f "$__qnxlibs/libboost_program_options.a"
    rm -f "$__qnxlibs/libboost_system.a"
    cp "$__qnxlibs/libboost_atomic-qcc-mt-a64-1_80.a" "$__qnxlibs/libboost_atomic.a"
    cp "$__qnxlibs/libboost_filesystem-qcc-mt-a64-1_80.a" "$__qnxlibs/libboost_filesystem.a"
    cp "$__qnxlibs/libboost_program_options-qcc-mt-a64-1_80.a" "$__qnxlibs/libboost_program_options.a"
    cp "$__qnxlibs/libboost_system-qcc-mt-a64-1_80.a" "$__qnxlibs/libboost_system.a"

    OK__ "[boost] build complete"
}

###############################################################################
#   protoc

function _setup_protoc() {
    local __arg_version=$1

    if [ "$__arg_version" == "3.16.0" ]; then
        __protoc_fn="protoc-3.16.0-linux-x86_64.zip"
        __protoc_url="https://github.com/protocolbuffers/protobuf/releases/download/v3.16.0/protoc-3.16.0-linux-x86_64.zip"
    elif [ "$__arg_version" == "3.20.3" ]; then
        __protoc_fn="protoc-3.20.3-linux-x86_64.zip"
        __protoc_url="https://github.com/protocolbuffers/protobuf/releases/download/v3.20.3/protoc-3.20.3-linux-x86_64.zip"
    else
        ERROR__ "[protoc] unsupported version: $version"
        exit 1
    fi

    INFO__ "[protoc] downloading $__protoc_fn..."
    __protoc_archive=$_CFG_tmp_dir/$__protoc_fn
    if [ ! -f $__protoc_archive ]; then
        mkdir -p $_CFG_tmp_dir 
        wget -O $__protoc_archive $__protoc_url
    fi

    INFO__ "[protoc] extracting source files..."
    __protoc_extract_dir=$_CFG_tmp_dir/protoc
    rm -rf $__protoc_extract_dir
    mkdir -p $__protoc_extract_dir
    unzip $__protoc_archive -d $__protoc_extract_dir
    if [ $? -ne 0 ]; then
        ERROR__ "[protoc] failed to extract archive $__protoc_archive"
        exit 1
    fi

    INFO__ "[protoc] copying binary to /usr/bin/protoc"
    sudo cp $__protoc_extract_dir/bin/protoc /usr/bin/protoc
    sudo chmod 777 /usr/bin/protoc
    rm -rf $__protoc_extract_dir

    OK__ "[protoc] installation complete"
}

###############################################################################
#   onnxruntime

function _clone_onnxruntime() {
    local __arg_version=$1

    if [ "$__arg_version" == "1.8.2" ]; then
        __onnxruntime_git_url="https://github.com/microsoft/onnxruntime.git"
        __onnxruntime_git_branch="rel-1.8.2"
    elif [ "$__arg_version" == "1.14.1" ]; then
        __onnxruntime_git_url="https://github.com/microsoft/onnxruntime.git"
        __onnxruntime_git_branch="rel-1.14.1"
    else
        ERROR__ "[onnxruntime] unsupported version: $version"
        exit 1
    fi

    INFO__ "[onnxruntime] cloning onnxruntime source..."
    if [ -d $_CFG_tmp_dir/onnxruntime ]; then
        INFO__ "[onnxruntime] source directory already exists, cleaning up"
        cd $_CFG_tmp_dir/onnxruntime
        git add *
        git restore --recurse-submodules .
        git reset --hard HEAD
        OK__ "[onnxruntime] repo ready"
        return
    fi
    git clone --branch $__onnxruntime_git_branch --depth=1 $__onnxruntime_git_url $_CFG_tmp_dir/onnxruntime
    if [ $? -ne 0 ]; then
        ERROR__ "[onnxruntime] failed to clone source"
        exit 1
    fi

    INFO__ "[onnxruntime] initializing repo..."
    cd $_CFG_tmp_dir/onnxruntime
    git lfs install --local
    git lfs fetch
    git submodule sync --recursive
    git submodule update --init --force --depth=1 --recursive

    OK__ "[onnxruntime] repo ready"
}

function __apply_patches_recursive() {
    local __ARG_root=$1
    local __ARG_src=$2
    local __ARG_dst=$3

    for __item in $(ls $__ARG_src); do
        local __src_item=$__ARG_src/$__item
        local __dst_item=$__ARG_dst/$__item
        if [ -d $__src_item ]; then
            __apply_patches_recursive $__ARG_root $__src_item $__dst_item
        elif [ -f $__src_item ]; then
            __fn=${__src_item#"$__ARG_root"}
            INFO__ "    - applying patch $__fn"
            git apply --ignore-space-change --ignore-whitespace $__src_item
        fi
    done
}

function _apply_patches_onnxruntime() {
    local __arg_src_dir=$1
    local __arg_dst_dir=$2

    INFO__ "[onnxruntime] applying patches: $__arg_src_dir -> $__arg_dst_dir"
    cd $__arg_dst_dir
    if [[ `git status --porcelain` ]]; then
        ERROR__ "[onnxruntime] unclean repository"
        exit 1
    fi

    __apply_patches_recursive $__arg_src_dir $__arg_src_dir $__arg_dst_dir
    OK__ "[onnxruntime] applied patches"
}

function _build_onnxruntime_1_8_2_qnx700() {
    INFO__ "[onnxruntime] assuming onnxruntime source is at $_CFG_tmp_dir/onnxruntime"
    cd $_CFG_tmp_dir/onnxruntime
    if [ $? -ne 0 ]; then
        ERROR__ "[onnxruntime] cannot find source directory"
        exit 1
    fi

    INFO__ "[onnxruntime] configuring"
    cd $_CFG_tmp_dir/onnxruntime/cmake
    rm -rf ./build/
    mkdir -p ./build/
    cd ./build/
    cmake -DCMAKE_TOOLCHAIN_FILE="$_CFG_patches_dir/onnx_1.8.2_qnx700_aarch64le.cmake" ..
    if [ $? -ne 0 ]; then
        ERROR__ "[onnxruntime] cmake configuration failed"
        exit 1
    fi

    INFO__ "[onnxruntime] building"
    cmake --build . --config Release
    if [ $? -ne 0 ]; then
        ERROR__ "[onnxruntime] cmake build failed"
        exit 1
    fi

    local __output_dir=$(realpath $_CFG_tmp_dir/onnxruntime/cmake/build/)
    INFO__ "[onnxruntime] output directory: $__output_dir"
    OK__ "[onnxruntime] build complete"
}

function _build_onnxruntime_1_14_1_qnx710() {
    INFO__ "[onnxruntime] assuming onnxruntime source is at $_CFG_tmp_dir/onnxruntime"
    cd $_CFG_tmp_dir/onnxruntime
    if [ $? -ne 0 ]; then
        ERROR__ "[onnxruntime] cannot find source directory"
        exit 1
    fi

    INFO__ "[onnxruntime] configuring"
    cd $_CFG_tmp_dir/onnxruntime/cmake
    rm -rf ./build/
    mkdir -p ./build/
    cd ./build/
    cmake -DCMAKE_TOOLCHAIN_FILE="$_CFG_patches_dir/onnx_1.14.1_qnx710_aarch64le.cmake" ..
    if [ $? -ne 0 ]; then
        ERROR__ "[onnxruntime] cmake configuration failed"
        exit 1
    fi

    INFO__ "[onnxruntime] building"
    cmake --build . --config Release
    if [ $? -ne 0 ]; then
        ERROR__ "[onnxruntime] cmake build failed"
        exit 1
    fi

    local __output_dir=$(realpath $_CFG_tmp_dir/onnxruntime/cmake/build/)
    INFO__ "[onnxruntime] output directory: $__output_dir"
    OK__ "[onnxruntime] build complete"
}

###############################################################################
#   main logic

function _check_dep() {
    local __arg_command=$1
    local __arg_version=$2
    local __arg_match=$3
    local __arg_sed=$4

    eval "$__arg_command" >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        ERROR__ "'$__arg_command' not found"
        exit 1
    fi

    local __cur_ver=$(eval "$__arg_command" 2>&1 | grep $__arg_match | head -1 | sed "$__arg_sed")
    local __cur_ver_major=$(echo $__cur_ver | cut -d'.' -f1)
    local __cur_ver_minor=$(echo $__cur_ver | cut -d'.' -f2)
    local __cur_ver_bugfix=$(echo $__cur_ver | cut -d'.' -f3)
    local __arg_ver_major=$(echo $__arg_version | cut -d'.' -f1)
    local __arg_ver_minor=$(echo $__arg_version | cut -d'.' -f2)
    local __arg_ver_bugfix=$(echo $__arg_version | cut -d'.' -f3)

    if [ "$__cur_ver_major" -ne "$__arg_ver_major" ]; then
        ERROR__ "'$__arg_command' requires $__arg_version: ^$__cur_ver != ^$__arg_version"
        exit 1
    fi
    if [ "${__cur_ver_minor:-0}" -eq "${__arg_ver_minor:-0}" ]; then
        if [ "${__cur_ver_bugfix:-0}" -lt "${__arg_ver_bugfix:-0}" ]; then
            ERROR__ "'$__arg_command' requires $__arg_version: $__cur_ver < $__arg_version"
            exit 1
        fi
    elif [ "${__cur_ver_minor:-0}" -lt "${__arg_ver_minor:-0}" ]; then
        ERROR__ "'$__arg_command' requires $__arg_version: $__cur_ver < $__arg_version"
        exit 1
    fi

    INFO__ "detected '$__arg_command': $__cur_ver ~= $__arg_version"
    return
}

function _build_for_1_8_2_qnx700_aarch64le() {
    source $_CFG_qnx700_inst_dir/qnxsdp-env.sh
    if [ $? -ne 0 ]; then
        ERROR__ "cannot setup qnx700-nto toolchain"
        exit 1
    fi

    _check_dep 'qcc -V' '5.4.0' '[0-9]*\.[0-9]*\.[0-9]*' 's/,.*$//; s/^[^0-9]*//;'
    _check_dep 'q++ -V' '5.4.0' '[0-9]*\.[0-9]*\.[0-9]*' 's/,.*$//; s/^[^0-9]*//;'
    _check_dep 'cmake --version' '3.16.3' '[0-9]*\.[0-9]*\.[0-9]*' 's/^[^0-9]*//;'
    _check_dep 'wget --version' '1.20.3' '[0-9]*\.[0-9]*\.[0-9]*' 's/^[^0-9]*//; s/ built .*$//;'
    _check_dep 'unzip -v' '6.00' '[0-9]*\.[0-9]*' 's/^[^0-9]*//; s/ of .*//;'

    _clone_onnxruntime 1.8.2
    _apply_patches_onnxruntime $_CFG_patches_dir/onnxruntime_1.8.2_patch $_CFG_tmp_dir/onnxruntime
    _build_boost_1_71_0_qnx700
    _setup_protoc 3.16.0
    _build_onnxruntime_1_8_2_qnx700
}

function _build_for_1_14_1_qnx710_aarch64le() {
    source $_CFG_qnx710_inst_dir/qnxsdp-env.sh
    if [ $? -ne 0 ]; then
        ERROR__ "cannot setup qnx710-nto toolchain"
        exit 1
    fi

    _check_dep 'qcc -V' '8.3.0' '[0-9]*\.[0-9]*\.[0-9]*' 's/,.*$//; s/^[^0-9]*//;'
    _check_dep 'q++ -V' '8.3.0' '[0-9]*\.[0-9]*\.[0-9]*' 's/,.*$//; s/^[^0-9]*//;'
    _check_dep 'cmake --version' '3.28.1' '[0-9]*\.[0-9]*\.[0-9]*' 's/^[^0-9]*//;'
    _check_dep 'wget --version' '1.20.3' '[0-9]*\.[0-9]*\.[0-9]*' 's/^[^0-9]*//; s/ built .*$//;'
    _check_dep 'unzip -v' '6.00' '[0-9]*\.[0-9]*' 's/^[^0-9]*//; s/ of .*//;'

    _clone_onnxruntime 1.14.1
    _patch_sys_headers_qnx710
    _apply_patches_onnxruntime $_CFG_patches_dir/onnxruntime_1.14.1_patch $_CFG_tmp_dir/onnxruntime
    _build_boost_1_80_0_qnx710
    _setup_protoc 3.20.3
    _build_onnxruntime_1_14_1_qnx710
}

function _main() {
    sudo echo "acquiring sudo privileges..."
    if [ $? -ne 0 ]; then
        ERROR__ "requires sudo privileges"
        exit 1
    fi

    if [ "$_CFG_build_target" == "1.8.2-qnx700-aarch64le" ]; then
        _build_for_1_8_2_qnx700_aarch64le
    elif [ "$_CFG_build_target" == "1.14.1-qnx710-aarch64le" ]; then
        _build_for_1_14_1_qnx710_aarch64le
    else
        ERROR__ "unsupported build target: $_CFG_build_target"
        exit 1
    fi
}

_main
