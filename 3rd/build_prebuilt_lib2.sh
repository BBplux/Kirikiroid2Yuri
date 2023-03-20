#!/usr/bin/bash

export NDK=/root/android-ndk-r25b
export ANDROID_HOME=/root/Android/Sdk
export ANDROID_SDK_TOOLS=/root/Android/Sdk/platform-tools
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
export SYSROOT=/root/android-ndk-r25b/toolchains/llvm/prebuilt/linux-x86_64/sysroot:/usr/local/bin

build_opus() {
  mkdir -p build_and/opus
  cd build_and/opus
  cmake \
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=$ABI \
    -DANDROID_PLATFORM=android-$MINSDKVERSION \
    ../../opus
  make
  make install
  cd ../..
}

build_ogg() {
  mkdir -p build_and/ogg
  cd build_and/ogg
  cmake \
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=$ABI \
    -DANDROID_PLATFORM=android-$MINSDKVERSION \
    ../../ogg
  make
  make install
  cd ../..
}

build_vorbis() {
  mkdir -p build_and/vorbis
  cd build_and/vorbis
  cmake \
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=$ABI \
    -DANDROID_PLATFORM=android-$MINSDKVERSION \
    -DOGG_ROOT=/usr/local/ \
    ../../vorbis
  make
  make install
  cd ../..
}

build_opusfile() {
  mkdir -p build_and/opusfile
  cd build_and/opusfile
  cmake \
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=$ABI \
    -DANDROID_PLATFORM=android-$MINSDKVERSION \
    -DOP_DISABLE_HTTP=ON \
    -DOP_DISABLE_DOCS=ON \
    -DOP_DISABLE_EXAMPLES=ON \
    ../../opusfile
  make
  make install
  cd ../..
}

build_openal-soft() {
  mkdir -p build_and/openal-soft
  cd build_and/openal-soft
  cmake \
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=$ABI \
    -DANDROID_PLATFORM=android-$MINSDKVERSION \
    ../../openal-soft
  make
  make install
  cd ../..
}

build_SDL() {
  mkdir -p build_and/SDL
  cd build_and/SDL
  cmake \
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=$ABI \
    -DANDROID_PLATFORM=android-$MINSDKVERSION \
    ../../SDL
  make
  make install
  cd ../..
}

build_opencv() {
  mkdir -p build_and/opencv
  cd build_and/opencv
  cmake \
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=$ABI \
    -DANDROID_PLATFORM=android-$MINSDKVERSION \
    -DANDROID_HOME=/root/Android/Sdk \
    -DANDROID_SDK_TOOLS=/root/Android/Sdk/platform-tools \
    -DJAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 \
    -DBUILD_ANDROID_PROJECTS=OFF \
    -DBUILD_ANDROID_EXAMPLES=OFF \
    ../../opencv
  make
  make install
  cd ../..
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
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=$ABI \
    -DANDROID_PLATFORM=android-$MINSDKVERSION \
    ../../libjpeg-turbo
  make
  make install
  cd ../..
}

build_oboe() {
  mkdir -p build_and/oboe
  cd build_and/oboe
  cmake \
    -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=$ABI \
    -DANDROID_PLATFORM=android-$MINSDKVERSION \
    ../../oboe
  make
  make install
  cd ../..
}

build_opus
build_ogg
build_vorbis
build_opusfile
build_openal-soft
build_SDL
build_breakpad
build_jpegturbo
build_opencv
build_oboe