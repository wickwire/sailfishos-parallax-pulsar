import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: sandaarExplosion
    color: "transparent"

    property bool explosionEnabled

    ParticleSystem {

        id: sandaarExplosionParticles
        anchors.fill: parent
        paused: !applicationActive

        ImageParticle {
            system: sandaarExplosionParticles
            groups: ["explosion"]
            source: "qrc:///images/star.png"
            color: "#0FF06600"
            colorVariation: 0.3
        }

        Emitter {
            id: pulseEmitter
            system: sandaarExplosionParticles
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

        console.log( "Destroying: Sandaar Explosion > " + sandaarExplosion);
    }
}

