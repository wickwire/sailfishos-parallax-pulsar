import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: root
    width: page.width
    height: page.height
    color: "transparent"

    property int shipX
    property int shipY
    property int shipWidth
    property int shipHeight

    property alias shotParticles: particles

    ParticleSystem {

        id: particles
        anchors.fill: parent
        paused: !applicationActive

        ImageParticle {
            system: particles
            groups: ["shot"]
            source: "qrc:///images/star.png"
            color: "#0FF06600"
            colorVariation: 0.3
        }

        Emitter {
            group: "shot"
            emitRate: 1
            lifeSpan: 10000
            size: 70
            velocity: PointDirection { x: 256; }
            x: shipX + shipWidth/2
            y: shipY + shipHeight/2
            enabled: true
        }
    }
}

