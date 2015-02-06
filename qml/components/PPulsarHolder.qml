import QtQuick 2.0
import QtQuick.Particles 2.0

Item{
    id: pulsarHolder
    width: page.width
    height: page.height

    property int enemyShipX
    property int enemyShipY
    property int ppulsarEmitterLifeSpan

    property variant sandaarShotSystem
    property variant pulsarShotSystem

    signal pulsarCheckCollision
    signal pulsarShipBlasted

    PPulsarShip{
        id: parallaxPulsar
    }

    function parallaxDestroy(){
        parallaxPulsar.destroyShip();
    }

    onPulsarCheckCollision: {
        if(Math.abs(parallaxPulsar.ppulsarShipCenterX-enemyShipX)<32){
            if(Math.abs(parallaxPulsar.ppulsarShipCenterY-enemyShipY)<32){
                parallaxPulsar.destroyShip();
            }
        }
    }

    onPulsarShipBlasted: {
        console.log( "Pulsar Explosion finished!");
        pulsarHolder.destroy(ppulsarEmitterLifeSpan);
        parallaxPulsarBlasted();
    }

    Component.onCompleted: console.log("Creating Pulsar Holder " + pulsarHolder)

    Component.onDestruction: console.log("Destroying Pulsar Holder " + pulsarHolder)
}
