import QtQuick 2.0

PathAnimation {
    duration: 2000
    easing.type: Easing.InOutQuad
    target: sandaarShip1
    orientation: PathAnimation.RightFirst
    anchorPoint: Qt.point(sandaarShip1.width/2,
                          sandaarShip1.height/2)
    path: Path {
        startX: sandaarShip1.width/2
        startY: sandaarShip1.height/2
        PathCubic {
            x: window.width - sandaarShip1.width/2
            y: window.height - sandaarShip1.height/2
            control1X: x; control1Y: sandaarShip1.height/2
            control2X: sandaarShip1.width/2; control2Y: y
        }
    }
}
