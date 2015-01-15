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

    property int score

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
            lifeSpan: 2000
            size: 140
            velocity: PointDirection { x: -512; }
            x: shipX + shipWidth
            y: shipY + shipHeight/2 - 3
            enabled: qmlWeaponTrigger.valProxim
        }

        ParticleGroup{
            name: "target1"
            onEntered: {
                sandaarShip1.score++
            }
        }
        ParticleGroup{
            name: "target2"
            onEntered: {
                sandaarShip2.score++
            }
        }

    }
}
