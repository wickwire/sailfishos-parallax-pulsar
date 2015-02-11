import QtQuick 2.0

PathCubic {

    property variant enemyShip
    property int waveIndex

    x: page.width - enemyShip.width/2
    y: page.height - enemyShip.height/2
    control1X: x
    control2Y: y
    control1Y: enemyShip.height/2
    control2X: enemyShip.width/2

    Component.onCompleted: console.log("waveIndex " + waveIndex);
}


