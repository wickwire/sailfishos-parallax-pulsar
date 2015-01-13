# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-parallaxpulsar

CONFIG += sailfishapp

SOURCES += src/harbour-parallaxpulsar.cpp \
    src/parallaxcontrols.cpp \
    src/parallaxcontrolsfilter.cpp \
    src/parallaxweapon.cpp

OTHER_FILES += qml/harbour-parallaxpulsar.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/harbour-parallaxpulsar.changes.in \
    rpm/harbour-parallaxpulsar.spec \
    rpm/harbour-parallaxpulsar.yaml \
    translations/*.ts \
    harbour-parallaxpulsar.desktop \
    qml/components/* \
    qml/components/PPulsarShip.qml \
    qml/components/PPulsarShot.qml \
    qml/components/EnemyGrunt.qml \
    qml/components/EnemyWavePath.qml \
    qml/components/EnemyWave.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-parallaxpulsar-de.ts

QT += sensors

HEADERS += \
    src/parallaxcontrols.h \
    src/parallaxcontrolsfilter.h \
    src/parallaxweapon.h

RESOURCES += \
    resources.qrc
