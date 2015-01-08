import QtQuick 2.0
import QtQuick.Particles 2.0


ParticleSystem {

    property double squareInitX
    property double squareInitY
    property double squareY
    property int shipX
    property int shipY
    property int shipWidth
    property int shipHeight

    property int score: 0
    Text {
        color: "white"
        anchors.left: page.left
        anchors.top: page.top
        text: "score"

        Rotation{
            angle: 90
        }
    }

    id: root
    width: page.width
    height: page.height

        ImageParticle {
            id: shot
            groups: ["shot"]
            //source: "qrc:///particleresources/star.png"
            source: "qrc:///images/star.png"

            color: "#0FF06600"
            colorVariation: 0.3
        }

        Emitter {
            group: "shot"
            emitRate: 4
            lifeSpan: 2000
            enabled: true
            size: 160
            velocity: PointDirection { x: -512; }
            //x: ship.x + ship.width
            //y: ship.y + ship.height/2
            x: shipX + shipWidth
            y: shipY + shipHeight/2 - 3
        }

        GroupGoal{
            whenCollidingWith: ["target"]
        }

        Rectangle{
            id: target
            color: "red"
            width: 80
            height: 80
            anchors.horizontalCenter: root.horizontalCenter-50
            anchors.verticalCenter: root.verticalCenter
        }
}
