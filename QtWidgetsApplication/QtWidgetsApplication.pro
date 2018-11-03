#-------------------------------------------------
#
# Project created by QtCreator 2017-02-19T11:50:17
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = QtWidgetsApplication
TEMPLATE = app

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0


SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h

FORMS    += mainwindow.ui

TRANSLATIONS = i18n/org.appimage.qtwidgetsapplication_es.ts

target.path = $$PREFIX/bin

QMAKE_EXTRA_COMPILERS += lrelease
lrelease.input         = TRANSLATIONS
lrelease.output        = i18n/${QMAKE_FILE_BASE}.qm
lrelease.commands      = $$[QT_INSTALL_BINS]/lrelease ${QMAKE_FILE_IN} -qm i18n/${QMAKE_FILE_BASE}.qm
lrelease.CONFIG       += no_link target_predeps

translations.path = $$PREFIX/share/org.appimage.qtwidgetsapplication/translations
translations.files = i18n/org.appimage.qtwidgetsapplication_es.qm

icon.path = $$PREFIX/share/icons/hicolor/512x512/apps
icon.files = QtWidgetsApplication.png

desktop_entry.path = $$PREFIX/share/applications
desktop_entry.files = QtWidgetsApplication.desktop
INSTALLS += target translations icon desktop_entry
