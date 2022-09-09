QT += quick multimedia dbus xml
CONFIG += c++11
DBUS_INTERFACES += Dbus/climate.xml
# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        App/Climate/climatemodel.cpp \
        App/Media/player.cpp \
        App/Media/playlistmodel.cpp \
        applicationsmodel.cpp \
        main.cpp \
        translator.cpp \
        xmlreader.cpp \
        xmlwriter.cpp

RESOURCES += qml.qrc


DEFINES += PROJECT_PATH=\"\\\"$${_PRO_FILE_PWD_}/\\\"\"

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

TRANSLATIONS += Translator/translate_vn.ts \
                Translator/translate_us.ts \
                Translator/translate_jp.ts

HEADERS += \
    App/Climate/climatemodel.h \
    App/Media/player.h \
    App/Media/playlistmodel.h \
    applicationsmodel.h \
    translator.h \
    xmlreader.h \
    xmlwriter.h

#LIBS += -ltag

DISTFILES += \
    Dbus/climate.xml \
    Translator/translate_jp.qm \
    Translator/translate_us.qm \
    Translator/translate_vn.qm \
    applications.xml \
    translate/translate_us.qm \
    translate/translate_us.ts \
    translate/translate_vn.qm \
    translate/translate_vn.ts \
    translate_jp.qm \
    translate_jp.ts \
    translate_kr.ts \
    translate_us.qm \
    translate_us.ts \
    translate_vn.qm \
    translate_vn.ts

#===========start config taglib==========================
INCLUDEPATH += App/Media/MyTagLib/include

# Default rules for deployment.
linux {
    LIBS += -L$$PWD/App/Media/MyTagLib/ubuntu -lMyTagLib
}
#===========end config taglib==========================
