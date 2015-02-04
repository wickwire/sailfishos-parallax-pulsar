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

    ShipExplosion{
        id: ppulsarExplosion
        explosionEnabled: false
        anchors.centerIn: ppulsarShipHolder
    }

    Item {
        id: ppulsarShipHolder
        width: ppulsarSvg.width
        height: ppulsarSvg.height
    }


    Timer {
        id: shipExplode
        interval: 500;
        running: exploding;
        repeat: false
        onTriggered: {
            ppulsarExplosion.explosionEnabled=false;
            ppulsarExplosion.destroy();
        }
        property bool exploding
    }

    function destroyShip(){

        if(pulsarHitArea){
            pulsarHitArea.destroy();
        }

        if(parallaxPulsarShot){
            parallaxPulsarShot.destroyShot()
        }

        ppulsarSvg.visible=false;

        if(pulsarDestroyX == 0)
            pulsarDestroyX = ppulsarShip.x;

        if(pulsarDestroyY == 0)
            pulsarDestroyY = ppulsarShip.y;

        if(ppulsarExplosion){
            ppulsarShip.x=pulsarDestroyX;
            ppulsarShip.y=pulsarDestroyY;
            ppulsarExplosion.explosionEnabled = true;
            shipExplode.exploding=true;
        }

    }


    GroupGoal{
        id: pulsarHitArea
        jump: true
        anchors.fill: ppulsarShip
        goalState: "pulsarTarget"
        system: sandaarShotSystem

        Component.onCompleted:{
            console.log( "Creating: Pulsar Group Goal > " + pulsarHitArea);
        }

        Component.onDestruction:{
            console.log( "Destroying: Pulsar Group Goal > " + pulsarHitArea);
        }
    }

    Component.onCompleted:{
        console.log( "Creating: Pulsar Ship > " + ppulsarShip);
    }

    Component.onDestruction:{
        console.log( "Destroying: Pulsar Ship > " + ppulsarShip);
    }
}
