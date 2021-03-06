#!/bin/bash
# Script used to cmake and then make mosquitto for android on MacOSX with android-ndk-r8e and a patched mosquitto source.
# Update paths below and run it from inside the root mosquitto dir (right in the one you clone from hg)

# Used patched mosquitto from: https://bitbucket.org/andreasjk/mosquitto
# Used NDK: http://dl.google.com/android/ndk/android-ndk-r8e-darwin-x86_64.tar.bz2
# Used cmake toolchain file from https://github.com/Itseez/opencv/blob/master/android/android.toolchain.cmake

# Threading has to be disabled since android doesn't support it fully
# Also disabled TLS since I couldn't get cmake to find the openssl lib properly

# CURRENT_DIR=$(dirname $(readlink -f $0))
CURRENT_DIR=$(cd `dirname $0`; pwd)

# ANDROID_NDK=/Users/dengziyue/Library/Android/sdk/ndk-bundle
ANDROID_NDK=/Users/dengziyue/Library/Android/ndk/android-ndk-r12b

# ANDROID_CAMEK="${CURRENT_DIR}/android-cmake/android.toolchain.cmake"
ANDROID_CAMEK=~/Library/Android/sdk/cmake/3.10.2.4988404/android.toolchain.cmake

ANDROID_API_LEVEL=23
ANDROID_ABI="armeabi-v7a"

OPENSSL_ROOT_DIR=$CURRENT_DIR/openssl-$ANDROID_API_LEVEL

cd mosquitto

cmake \
   -DANDROID_NDK=${ANDROID_NDK} \
   -DANDROID_ABI=${ANDROID_ABI} \
   -DANDROID_NDK_HOST_X64="YES" \
   -DANDROID_NATIVE_API_LEVEL=$ANDROID_API_LEVEL \
   -DANDROID_TOOLCHAIN_NAME="arm-linux-androideabi-4.9" \
   -DCMAKE_TOOLCHAIN_FILE=$ANDROID_CAMEK \
   -DOPENSSL_CRYPTO_LIBRARY="$OPENSSL_ROOT_DIR/lib/libcrypto.a" \
   -DOPENSSL_INCLUDE_DIR="$OPENSSL_ROOT_DIR/include" \
   -DOPENSSL_SSL_LIBRARY="$OPENSSL_ROOT_DIR/lib/libcrypto.a;$OPENSSL_ROOT_DIR/lib/libssl.a" \
   -DWITH_TLS=ON \
   -DWITH_THREADING=OFF \
   .

echo "Start building android ..."
make clean
make mosquitto