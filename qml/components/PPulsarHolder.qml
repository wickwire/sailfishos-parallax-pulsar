import QtQuick 2.0
import QtQuick.Particles 2.0

Item{
    id: pulsarHolder
    width: page.width
    height: page.height

    property int enemyShipX
    property int enemyShipY
    property bool enemyShipVisible
    property int shipDistX
    property int shipDistY
    property int ppulsarEmitterLifeSpan
    property variant sandaarShotSystem
    property bool pulsarInvencibility : true

    signal pulsarCheckCollision
    signal pulsarShipBlasted

    Timer{
        id: pulsarRespawnTimer
        running: true
        repeat: false
        interval: 5000
        onTriggered: {
            pulsarInvencibility=false;
        }
    }

    PPulsarShip{
        id: parallaxPulsar
    }

    function parallaxDestroy(){
        parallaxPulsar.destroyShip();
    }

    onPulsarCheckCollision: {
        shipDistX=Math.abs(parallaxPulsar.ppulsarShipCenterX-enemyShipX);
        shipDistY=Math.abs(parallaxPulsar.ppulsarShipCenterY-enemyShipY);
        if(Math.abs(shipDistX-parallaxPulsar.width) < 2.5){
            if(Math.abs(shipDistY-parallaxPulsar.height) < 2.5){
                //console.log("shipDistX: " + shipDistX + "shipDistY: " + shipDistY + "|" + parallaxPulsar.width + "x" + parallaxPulsar.height);
                parallaxPulsar.destroyShip();
            }
        }
    }

    onPulsarShipBlasted: {
        //        console.log( "Pulsar Explosion finished!");
        pulsarHolder.destroy(ppulsarEmitterLifeSpan);
        parallaxPulsarBlasted();
    }

    //    Component.onCompleted: console.log("Creating Pulsar Holder " + pulsarHolder)

    //    Component.onDestruction: console.log("Destroying Pulsar Holder " + pulsarHolder)
}
