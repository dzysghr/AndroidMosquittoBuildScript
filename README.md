# AndroidMosquittoBuildScript


# How to build
0. Download [mosquitto](https://github.com/eclipse/mosquitto) from github
1. Bbuild OpenSSL for android [AndroidOpenSSLBuildScript](https://gitlab.gz.cvte.cn/v_sw_rd/AndroidOpenSSLBuildScript)
2. Check [mosquitto_android_cmake.sh](mosquitto_android_cmake.sh) and update your local value
3. Run mosquitto_android_cmake.sh
4. Fix error by "Include <syslog.h> instead of <sys/syslog.h>"
5. Run mosquitto_android_cmake.sh