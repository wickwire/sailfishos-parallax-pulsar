import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: pulsarHolder
    width: page.width
    height: page.height
    color: "transparent"

    property int enemyShipX
    property int enemyShipY

    signal pulsarCheckCollision
    signal pulsarShipBlasted

    ParticleSystem {
        id: pulsarShotparticles
        anchors.fill: parent
        paused: !applicationActive
    }


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

    onPulsarCheckCollision: {
        if(Math.abs(parallaxPulsar.ppulsarShipCenterX-enemyShipX)<32){
            if(Math.abs(parallaxPulsar.ppulsarShipCenterY-enemyShipY)<32){
                parallaxPulsar.destroyShip();
            }
        }
    }

    onPulsarShipBlasted: {
        console.log( "Pulsar Explosion finished!");
        parallaxPulsarBlasted();
        pulsarHolder.destroy();
    }
}
