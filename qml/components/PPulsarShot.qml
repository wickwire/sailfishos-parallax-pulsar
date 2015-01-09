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

    property int score: 0

    Text {
        anchors.left: parent.left
        anchors.top: parent.top
        color: "white"
        rotation: 270
        text: "Hits: " + score
        height: 110
        width: 110
    }

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



        Rectangle{
            id: sandaarScumHolder
            color: "lightblue"
            opacity: 0.5
            x: parent.width/2-width/1.2
            y: parent.height/2-height/2
            width: 300
            height: 150
            rotation: 90

            SequentialAnimation{
                running: true
                loops: Animation.Infinite

                NumberAnimation{
                    target: sandaarScumHolder
                    property: "y"
                    to: 0
                    duration: 5000
                }

                NumberAnimation{
                    target: sandaarScumHolder
                    property: "y"
                    to: root.height
                    duration: 5000
                }
            }


        }

        GroupGoal {
            groups: ["shot"]
            system: particles
            goalState: "target"
            jump: true
            anchors.fill: sandaarScum
        }

        Image {
            id: sandaarScum
            source: "qrc:///images/sandaarScum.svg"
            rotation: 270
            anchors.centerIn: sandaarScumHolder
        }
    }
}
