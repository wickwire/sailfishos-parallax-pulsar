import QtQuick 2.0

//phone with screen facing up
Rectangle{

    property alias PPulsarShipHeight: height
    property alias PPulsarShipWidth: width
    property alias PPulsarShipXPos: x
    property alias PPulsarShipYPos: y

    id: square
    width:50
    height: 50
    color: "yellow"
    x: qmlAccelcontrols.valAccelX;
    y: qmlAccelcontrols.valAccelY;
}
