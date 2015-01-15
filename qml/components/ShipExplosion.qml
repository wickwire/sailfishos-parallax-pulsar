import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: root
    width: page.width
    height: page.height
    color: "transparent"

    property alias shotParticles: particles

    property int explosionX
    property int explosionY
    property bool explosionEnabled

    ParticleSystem {

        id: particles
        anchors.fill: parent
        paused: !applicationActive

        ImageParticle {
            system: particles
            groups: ["explosion"]
            source: "qrc:///images/star.png"
            color: "#0FF06600"
            colorVariation: 0.3
        }

        Emitter {
            id: pulseEmitter
            group: "explosion"
            emitRate: 50
            maximumEmitted: 50
            lifeSpan: 700
            enabled: explosionEnabled
            velocity: AngleDirection{magnitude: 64; angleVariation: 360}
            size: 100
            sizeVariation: 20
            anchors.centerIn: parent
        }
    }
}
