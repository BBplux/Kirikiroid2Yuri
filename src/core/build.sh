#!/usr/bin/bash

export NDK=/root/android-ndk-r25b
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64
export TARGET=aarch64-linux-android
# Set this to your minSdkVersion.
export API=23
export MINSDKVERSION=23
export ABI=arm64-v8a
# Configure and build.
export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/$TARGET$API-clang
export AS=$CC
export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip
export NM=$TOOLCHAIN/bin/llvm-nm

export ARCH=aarch64
export CPU=armv8-a
export PLATFORM=aarch64
export SYSROOT=/root/android-ndk-r25b/toolchains/llvm/prebuilt/linux-x86_64/sysroot


build_krkr() {
    mkdir -p build
    cd build
    cmake \
        -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
        -DANDROID_ABI=$ABI \
        -DANDROID_PLATFORM=android-$MINSDKVERSION \
        ..
    make
    make install

}

build_krkr
