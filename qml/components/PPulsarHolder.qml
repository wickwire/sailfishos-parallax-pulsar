import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: pulsarHolder
    width: page.width
    height: page.height
    color: "transparent"

    property int enemyShipX
    property int enemyShipY

    property variant sandaarShotSystem
    property variant pulsarShotSystem

    signal pulsarCheckCollision
    signal pulsarShipBlasted

//    ParticleSystem {
//        id: pulsarShotparticles
//        anchors.fill: parent
//        paused: !applicationActive
//    }

    PPulsarShip{
        id: parallaxPulsar
    }

    PPulsarShot{
        id: parallaxPulsarShot
        shipX: parallaxPulsar.x
        shipY: parallaxPulsar.y
        shipWidth: parallaxPulsar.width
        shipHeight: parallaxPulsar.height
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
        pulsarHolder.destroy(parallaxPulsarShot.ppulsarEmitterLifeSpan);
        parallaxPulsarBlasted();
    }

    Component.onCompleted: console.log("Creating Pulsar Holder " + pulsarHolder)

    Component.onDestruction: console.log("Destroying Pulsar Holder " + pulsarHolder)
}
