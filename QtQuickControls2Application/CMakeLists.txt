cmake_minimum_required(VERSION 3.1.0)

project(QtQuickControls2Application)

# Find includes in corresponding build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

# Find the QtWidgets library
find_package(Qt5Widgets CONFIG REQUIRED)
find_package(Qt5Qml CONFIG REQUIRED)

add_executable(QtQuickControls2Application src/main.cpp src/qml.qrc)
target_link_libraries(QtQuickControls2Application Qt5::Widgets Qt5::Qml)

install(TARGETS QtQuickControls2Application DESTINATION bin COMPONENT binaries)
install(FILES QtQuickControls2Application.desktop DESTINATION share/applications/ COMPONENT desktop)
install(FILES QtQuickControls2Application.svg DESTINATION share/icons/hicolor/scalable/apps/ COMPONENT desktop)

set(APP_NAME QtQuickControls2Application)
set(APP_TARGET_ARCH x86_64)
set(APP_DESKTOP_FILE_PATH AppDir/${CMAKE_INSTALL_PREFIX}/share/applications/QtQuickControls2Application.desktop)
set(APP_ICON_FILE_PATH AppDir/${CMAKE_INSTALL_PREFIX}/share/icons/hicolor/scalable/apps/QtQuickControls2Application.svg)

set(ENV ARCH=${APP_TARGET_ARCH})
add_custom_target(AppImage
        COMMENT "Creating AppImage of ${APP_NAME}"
        COMMAND make install DESTDIR=AppDir
        COMMAND wget -nc https://github.com/TheAssassin/linuxdeploy/releases/download/continuous/linuxdeploy-${APP_TARGET_ARCH}.AppImage
        COMMAND chmod +x ./linuxdeploy-${APP_TARGET_ARCH}.AppImage
        COMMAND export ARCH=${APP_TARGET_ARCH} USES_TERMINAL
        COMMAND ./linuxdeploy-${APP_TARGET_ARCH}.AppImage -n ${APP_NAME} --appdir AppDir --init-appdir -d ${APP_DESKTOP_FILE_PATH}
            -i ${APP_ICON_FILE_PATH} --output appimage
        )