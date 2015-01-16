import QtQuick 2.0
import QtQuick.Particles 2.0

Item{
    id: enemyShip
    property alias sequence1 : seq1
    property alias sequence2 : seq2

    property int score

    property alias shipHitState: groupGoal.goalState

    Image {
        id: sandaarScum
        source: "qrc:///images/sandaarScum.svg"
        rotation: 270
        anchors.centerIn: sandaarScumHolder
        sourceSize.width: 50
        sourceSize.height: 50
    }

    Item{
        id: sandaarScumHolder
        x: 0
        y: parent.height-height/2
        width: sandaarScum.width
        height: sandaarScum.height
        rotation: 90

//        PathAnimation {
//            id: seq1
//            duration: 5000
//            easing.type: Easing.InOutQuad
//            target: sandaarShip1
//            orientation: PathAnimation.RightFirst
//            anchorPoint: Qt.point(sandaarShip1.width/2,
//                                  sandaarShip1.height/2)
//            loops: Animation.Infinite
//            running: applicationActive
//            path: Path {
//                startX: sandaarShip1.width/2
//                startY: sandaarShip1.height/2
//                PathCubic {
//                    x: page.height - sandaarShip1.width/2
//                    y: page.width - sandaarShip1.height/2
//                    control1X: x; control1Y: sandaarShip1.height/2
//                    control2X: sandaarShip1.width/2; control2Y: y
//                }
//            }
//        }

        SequentialAnimation{
            id: seq1
            running: false
            loops: Animation.Infinite

            NumberAnimation{
                target: sandaarScumHolder
                property: "x"
                to: 0
                duration: 5000
            }

            NumberAnimation{
                target: sandaarScumHolder
                property: "x"
                to: page.width
                duration: 5000
            }
        }


        SequentialAnimation{
            id: seq2
            running: false
            loops: Animation.Infinite

            NumberAnimation{
                target: sandaarScumHolder
                property: "x"
                to: page.width
                duration: 3000
            }

            NumberAnimation{
                target: sandaarScumHolder
                property: "x"
                to: 0
                duration: 3000
            }
        }

//        Text {
//            color: "white"
//            text: score
//            rotation: 180
//            anchors.bottom: parent.bottom
//        }

        ShipExplosion{
            id: enemyExplosion
            explosionEnabled: false
            anchors.centerIn: parent
        }

    }

    GroupGoal {
        id: groupGoal
        system: parallaxPulsarShot.shotParticles
        jump: true
        anchors.fill: sandaarScum
    }


    Timer {
        id: shipExplode
        interval: 500; running: exploding; repeat: false
        onTriggered: enemyShip.destroy();

        property bool exploding
    }

    function destroyShip(){
        sandaarScum.visible=false;
        seq1.running=false;
        seq2.running=false;
        enemyExplosion.explosionEnabled = true;
        shipExplode.exploding=true;
    }
}
