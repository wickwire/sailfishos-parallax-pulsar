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
    }

    Item{
        id: sandaarScumHolder
//        color: "lightblue"
//        opacity: 0.5
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
                property: "y"
                to: 0
                duration: 5000
            }

            NumberAnimation{
                target: sandaarScumHolder
                property: "y"
                to: page.height
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
                to: page.height
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

    GroupGoal {
        id: groupGoal
        system: parallaxPulsarShot.shotParticles
        jump: true
        anchors.fill: sandaarScum
    }

    function destroyShip(){
        enemyExplosion.explosionX = enemyShip.x;
        enemyExplosion.explosionY = enemyShip.y;
        enemyShip.destroy();
        enemyExplosion.explosionEnabled = true;
    }
}
