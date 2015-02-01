import QtQuick 2.0

PathAnimation {

    id: enemyPath

    target: sandaarShip
    orientation: PathAnimation.Fixed
    running: true
    duration: 10000
    easing.type: Easing.InOutQuad
    anchorPoint: Qt.point(sandaarShip.width/2,
                          sandaarShip.height/2)
    path: Path {
        startX: sandaarShip.width/2
        startY: sandaarShip.height/2
        PathCubic {
            x: page.width - sandaarShip.width/2
            y: page.height - sandaarShip.height/2
            control1X: x
            control2Y: y
            control1Y: sandaarShip.height/2
            control2X: sandaarShip.width/2
        }
    }

    onStopped: {
        if(sandaarWaveTimer.interval == waveLastDelay){
            console.log("Repeater Index > " + waveCounter);
            waveDestroy();
        }
    }

    Component.onDestruction: {
        console.log( "Destroying: path > " + enemyPath);
    }
}
