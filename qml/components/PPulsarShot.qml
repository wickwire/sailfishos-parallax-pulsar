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

    property int cenas1 : 0
    property int cenas2 : 0
    property int cenas3 : 100
    property int cenas4 : 100

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

        ParticleGroup{
            name: "shot"
            ImageParticle {
                source: "qrc:///images/star.png"
                color: "#0FF06600"
                colorVariation: 0.3
            }
            GroupGoal{
                whenCollidingWith: ["target"]
                goalState: "colliding"
            }
        }

        ParticleGroup{
            name: "colliding"
            duration: 100
            to: {"target":1}
        }

        ParticleGroup{
            name: "target"
            onEntered: score++
        }

        Emitter {
            group: "shot"
            emitRate: 6
            lifeSpan: 2000
            enabled: true
            size: 140
            velocity: PointDirection { x: -512; }
            //x: ship.x + ship.width
            //y: ship.y + ship.height/2
            x: shipX + shipWidth
            y: shipY + shipHeight/2 - 3
        }

        ImageParticle {
            id: sandaarScum
            groups: ["sandaarScum"]
            source: "qrc:///images/sandaarScum.svg"
            //source: "qrc:///images/star.png"
            colorVariation: 0.1
            color: "#00ff400f"
            rotation: 270
            width: 200
            height: 200
        }



        Emitter {



            id: targetGenerator
            x: root.width/4
            anchors.verticalCenter: parent.verticalCenter
            group: "sandaarScum"
            emitRate: 1
            lifeSpan: 6000
            size: 200
            sizeVariation: 0
            endSize: 200
            velocity: PointDirection { x:0; yVariation: 0; xVariation: 0 }
            GroupGoal {
                groups: ["shot"]
                goalState: "target"
                jump: true
                system: particles
                x: cenas1
                y: cenas2
                height: cenas3
                width: cenas4
            }

            Component.onCompleted: {
                root.sandaarScumX = targetGenerator.x;
                root.sandaarScumY = targetGenerator.y;
                root.sandaarScumWidth = sandaarScum.width;
                root.sandaarScumHeight = sandaarScum.height;

                console.log(root.sandaarScumX + ":" + root.sandaarScumY + ":" + root.sandaarScumWidth + ":" + root.sandaarScumHeight);
            }
        }


    }


}
