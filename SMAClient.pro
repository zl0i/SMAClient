QT += quick qml location network charts svg

CONFIG += c++11

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
        carworker.cpp \
        fieldworker.cpp \
        main.cpp \
        mainworker.cpp \
        sensorworker.cpp \
        serverworker.cpp \
        weatherplacemodel.cpp \
        weatherworker.cpp

RESOURCES += qml.qrc \
    image.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = $$PWD D:\Project\Qt\ModuleQML
QML2_IMPORT_PATH = $$PWD D:\Project\Qt\ModuleQML

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    carworker.h \
    fieldworker.h \
    mainworker.h \
    sensorworker.h \
    serverworker.h \
    weatherplacemodel.h \
    weatherworker.h

DISTFILES += \
    exampleCurrentWeather.json \
    exampleFiveDayForecast.json \
    exampleTwoForecast.json \
    protocol.json \
    supporteedOsmMap.json \
    city.list.json
