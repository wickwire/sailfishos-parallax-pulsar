import QtQuick 2.0

//phone with screen facing up
Item{

    id: ppulsarShip
    width:75
    height: 75
    //    x: qmlAccelcontrols.valAccelZ;
    //    y: qmlAccelcontrols.valAccelY;
    x: qmlAccelcontrols.valAccelX;
    y: qmlAccelcontrols.valAccelY;

    Image {
        id: ppulsarSvg
        source: "qrc:///images/spaceship.svg"
        anchors.centerIn: ppulsarShip
        anchors.fill: parent
    }
}
