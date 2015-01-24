import QtQuick 2.0

    PathAnimation {

        property variant enemyShip : target
        //property alias enemShip : enemyShip

        running: true
        duration: 10000
        easing.type: Easing.InOutQuad
        //target: enemyShip
        orientation: PathAnimation.RightFirst
        anchorPoint: Qt.point(enemyShip.width/2,
                              enemyShip.height/2)
        path: Path {
            startX: enemyShip.width/2
            startY: enemyShip.height/2
            PathCubic {
                x: page.width - enemyShip.width/2
                y: page.height - enemyShip.height/2
                control1X: x; control1Y: enemyShip.height/2
                control2X: enemyShip.width/2; control2Y: y
            }
        }
    }


