TEMPLATE = app

QT += webengine

SOURCES += main.cpp

RESOURCES += qml.qrc

target.path = $$PREFIX/bin

icon.path = $$PREFIX/share/icons/hicolor/512x512/apps
icon.files = QtWebEngineApplication.png

desktop_entry.path = $$PREFIX/share/applications
desktop_entry.files = QtWebEngineApplication.desktop

INSTALLS += target icon desktop_entry
