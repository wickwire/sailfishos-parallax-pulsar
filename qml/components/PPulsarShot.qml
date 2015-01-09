import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: root
    width: page.width
    height: page.height
    color: "transparent"

    property double squareInitX
    property double squareInitY
    property double squareY
    property int shipX
    property int shipY
    property int shipWidth
    property int shipHeight

    property int sandaarScumX
    property int sandaarScumY
    property int sandaarScumWidth
    property int sandaarScumHeight

    property int score

    ParticleSystem {

        id: particles
        anchors.fill: parent

        ImageParticle {
            system: particles
            groups: ["shot","target"]
            source: "qrc:///images/star.png"
            color: "#0FF06600"
            colorVariation: 0.3
        }

        Emitter {
            group: "shot"
            emitRate: 6
            lifeSpan: 2000
            enabled: true
            size: 140
            velocity: PointDirection { x: -512; }
            x: shipX + shipWidth
            y: shipY + shipHeight/2 - 3
        }

        ParticleGroup{
            name: "target"
            onEntered: score++
        }

        EnemyGrunt{
            id: sandaarShip
            sequence1.running: true
        }

        EnemyGrunt{
            id: sandaarShip2
            x: 165
            sequence2.running: true
        }

    }
}
