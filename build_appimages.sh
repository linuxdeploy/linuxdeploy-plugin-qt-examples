#! /bin/bash

ARCH="x86_64"

BASE_DIR=${PWD}
mkdir ${BASE_DIR}/out

# Download tools
#wget -N https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-"$ARCH".AppImage
#chmod +x linuxdeploy-"$ARCH".AppImage

#wget -N https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-"$ARCH".AppImage
#chmod +x linuxdeploy-plugin-qt-"$ARCH".AppImage

LINUXDEPLOY_BIN=${PWD}/linuxdeploy-"$ARCH".AppImage
LINUXDEPLOY_PLUGIN_QT_BIN=${PWD}/linuxdeploy-plugin-qt-"$ARCH".AppImage

build_appimage() {
    APP_NAME=$1
    APP_DIR=$2

    echo "Building AppImage for ${APP_NAME}"

    ${LINUXDEPLOY_BIN} --app-name ${APP_NAME} --appdir ${APP_DIR} --init-appdir || return 1
    ${LINUXDEPLOY_PLUGIN_QT_BIN} --appdir ${APP_DIR} || return 1
    ${LINUXDEPLOY_BIN} --app-name ${APP_NAME} --appdir ${APP_DIR} --output appimage || return 1

    mv -v *AppImage ${BASE_DIR}/out || return 1
}

### Build projects
pushd QtQuickControls2Application
    # This env variable is used by the qt plugin to search the qml sources in other paths than the AppDir
    # it's mandatory to use when your qml files are embed as Qt resources into the main binary.
    export QML_SOURCES_PATHS="${PWD}/src"

    # This env variable is used by the qt plugin to search the qml modules in other paths than the default
    # Qt qml dir.
    export QML_MODULES_PATHS=""

    mkdir build
    pushd build
        cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=/usr || exit 1
        DESTDIR=AppDir make install || exit 1

        build_appimage QtQuickControls2Application ${PWD}/AppDir || exit 1
    popd
popd

pushd QtWebEngineApplication
    export QML_SOURCES_PATHS="${PWD}"

    mkdir build
    pushd build
        qmake CONFIG+=release PREFIX=/usr ../QtWebEngineApplication.pro || exit 1
        INSTALL_ROOT=${PWD}/AppDir make install || exit 1

        build_appimage QtWebEngineApplication ${PWD}/AppDir || exit 1
    popd
popd

pushd QtWidgetsApplication
    export QML_SOURCES_PATHS="${PWD}"

    mkdir build
    pushd build
        qmake CONFIG+=release PREFIX=/usr ../QtWidgetsApplication.pro || exit 1
        INSTALL_ROOT=${PWD}/AppDir make install || exit 1

        build_appimage QtWidgetsApplication ${PWD}/AppDir || exit 1
    popd
popd
