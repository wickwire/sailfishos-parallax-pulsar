import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: pulsarExplosion
    color: "transparent"

    property bool explosionEnabled

    ParticleSystem {

        id: pulsarExplosionParticles
        anchors.fill: parent
        paused: !applicationActive

        ImageParticle {
            system: pulsarExplosionParticles
            groups: ["explosion"]
            source: "qrc:///images/star.png"
            color: "#0FF06600"
            colorVariation: 0.3
        }

        Emitter {
            id: pulseEmitter
            system: pulsarExplosionParticles
            group: "explosion"
            emitRate: 50
            maximumEmitted: 10
            lifeSpan: 700
            enabled: explosionEnabled
            velocity: AngleDirection{magnitude: 64; angleVariation: 360}
            size: 100
            sizeVariation: 20
            anchors.centerIn: parent
        }
    }

    Component.onDestruction:{
        if(parallaxShipObject){
            parallaxShipObject.pulsarShipBlasted();
        }
        //        console.log( "Destroying: Pulsar Explosion > " + pulsarExplosion);
    }
}
