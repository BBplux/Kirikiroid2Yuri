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


build_unrar() {
  cd unrar
  make DESTDIR=$(pwd)/../prebuilt/unrar lib
  mv *.a ../prebuilt/unrar
  cd ..
}

build_breakpad() {
  cp linux-syscall-support/lss breakpad/src/third_party/ -r
  mkdir -p build_and/breakpad
  cd build_and/breakpad
  ../../breakpad/configure --host $TARGET --prefix=$(pwd)/../../prebuilt/breakpad --disable-tools
  make
  make install
  cd ../..
}

build_jpegturbo() {
  mkdir -p build_and/libjpeg-turbo
  cd build_and/libjpeg-turbo
  cmake \
    -G"Unix Makefiles" \
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=$ABI \
    -DANDROID_ARM_MODE=arm \
    -DANDROID_PLATFORM=android-$MINSDKVERSION \
    -DANDROID_TOOLCHAIN=clang\
    -DWITH_JPEG8=1 \
     ../../libjpeg-turbo

  make
  make install
  cd ../..
}

build_ffmpeg() {
  mkdir -p build_and/ffmpeg
  cd build_and/ffmpeg
  ../../ffmpeg/configure \
    --prefix=$(pwd)/../../prebuilt/ffmpeg \
    --cross-prefix=aarch64-linux-android- \
    --target-os=android \
    --arch=aarch64 \
    --cpu=$CPU \
    --cc=$CC \
    --cxx=$CXX \
    --nm=$NM \
    --strip=$STRIP \
    --enable-cross-compile \
    --sysroot=$SYSROOT \
    --ar=$AR \
    --ranlib=$RANLIB \
    --enable-pic

  make
  make install
  cd ../..
}

#build_unrar
#build_ffmpeg
build_jpegturbo
