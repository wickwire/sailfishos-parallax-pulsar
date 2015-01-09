import QtQuick 2.0
import QtQuick.Particles 2.0

Item{

    property alias sequence1 : seq1
    property alias sequence2 : seq2

    Rectangle{
        id: sandaarScumHolder
        color: "lightblue"
        opacity: 0.5
        x: 0
        y: parent.height-height/2
        width: sandaarScum.width
        height: sandaarScum.height
        rotation: 90

        SequentialAnimation{
            id: seq1
            running: false
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


        SequentialAnimation{
            id: seq2
            running: false
            loops: Animation.Infinite

            NumberAnimation{
                target: sandaarScumHolder
                property: "y"
                to: root.height
                duration: 3000
            }

            NumberAnimation{
                target: sandaarScumHolder
                property: "y"
                to: 0
                duration: 3000
            }
        }

        Text {
            color: "white"
            text: score
            rotation: 180
            anchors.bottom: parent.bottom
        }

    }

    Image {
        id: sandaarScum
        source: "qrc:///images/sandaarScum.svg"
        rotation: 270
        anchors.centerIn: sandaarScumHolder
    }

    GroupGoal {
        groups: ["shot"]
        system: particles
        goalState: "target"
        jump: true
        anchors.fill: sandaarScum
    }



}
