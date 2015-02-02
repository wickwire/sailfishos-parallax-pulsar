import QtQuick 2.0
import QtQuick.Particles 2.0

//phone with screen facing up
Item{
    id: ppulsarShip
    width:76
    height: 76
    //    x: qmlAccelcontrols.valAccelZ;
    //    y: qmlAccelcontrols.valAccelY;
    x: qmlAccelcontrols.valAccelX;
    y: qmlAccelcontrols.valAccelY;

    property int ppulsarShipCenterX : Math.floor(x+height/2)
    property int ppulsarShipCenterY : Math.floor(y+width/2)

    property int pulsarDestroyX : 0
    property int pulsarDestroyY : 0

    Image {
        id: ppulsarSvg
        source: "qrc:///images/spaceship.svg"
        anchors.centerIn: ppulsarShipHolder
        sourceSize.width: 76
        sourceSize.height: 76
    }

    //onXChanged: console.log("PPULSAR: " + x + ":" + y + "-" + ppulsarShipCenterX + ":" + ppulsarShipCenterY);

    Item {
        id: ppulsarShipHolder
        width: ppulsarSvg.width
        height: ppulsarSvg.height

        ShipExplosion{
            id: ppulsarExplosion
            explosionEnabled: false
            anchors.centerIn: parent
        }
    }


    Timer {
        id: shipExplode
        interval: 500;
        running: exploding;
        repeat: false
        onTriggered: {
            ppulsarExplosion.explosionEnabled=false;
            ppulsarExplosion.destroy();
            if(ppulsarShip){
                ppulsarShip.enabled=false;
            }
            if(parallaxGoal){
                parallaxGoal.destroy();
            }
        }
        property bool exploding
    }

    function destroyShip(){
        //console.log("destroyShip");

        if(parallaxPulsarShot){
            parallaxPulsarShot.destroyShot()
        }

        if(pulsarDestroyX == 0)
            pulsarDestroyX = ppulsarShip.x;

        if(pulsarDestroyY == 0)
            pulsarDestroyY = ppulsarShip.y;

        ppulsarSvg.visible=false;

        if(ppulsarExplosion){
            ppulsarExplosion.explosionEnabled = true;
            shipExplode.exploding=true;
        }
    }
}
