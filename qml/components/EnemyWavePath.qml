import QtQuick 2.0

PathAnimation {

    id: enemyPath

    target: sandaarShip
    orientation: PathAnimation.Fixed
    running: ApplicationActive
    duration: 10000
    easing.type: Easing.InOutQuad
    anchorPoint: Qt.point(sandaarShip.width/2,
                          sandaarShip.height/2)
    path: Path {
        startX: sandaarShip.width/2
        startY: sandaarShip.height/2

        PathLine {id: checkpoint1}
        PathLine {id: checkpoint2}
        PathLine {id: checkpoint3}

        Component.onCompleted: {
            if(enemyWaveCounter==0){
                checkpoint1.x=0
                checkpoint1.y=page.height/5
                checkpoint2.x=page.width
                checkpoint2.y=checkpoint1.y
                checkpoint3.x=checkpoint2.x
                checkpoint3.y=page.height
            }
            else if(enemyWaveCounter==1){
                startX=page.width
                checkpoint1.x=page.width
                checkpoint1.y=page.height/6
                checkpoint2.x=0
                checkpoint2.y=checkpoint1.y
                checkpoint3.x=checkpoint2.x
                checkpoint3.y=page.height
            }
            else if(enemyWaveCounter==2){
                checkpoint1.x=page.width/3
                checkpoint1.y=page.height/2
                checkpoint2.x=page.width/1.5
                checkpoint2.y=checkpoint1.y
                checkpoint3.x=checkpoint2.x
                checkpoint3.y=page.height
            }
            else if(enemyWaveCounter==3){
                startX=page.width
                checkpoint1.x=page.width/2
                checkpoint1.y=page.height/4
                checkpoint2.x=page.width/2
                checkpoint2.y=checkpoint1.y
                checkpoint3.x=page.width/3
                checkpoint3.y=page.height/3
            }
            else{
                checkpoint1.x=page.width
                checkpoint1.y=page.height
                checkpoint2.x=page.width/2
                checkpoint2.y=checkpoint1.y
                checkpoint3.x=checkpoint2.x
                checkpoint3.y=page.height/4
            }
        }
    }

    onStopped: {
        if(sandaarTimer.interval == waveLastDelay){
            //            console.log("Repeater Index > " + waveCounter);
            waveDestroy();
        }
    }

    //    Component.onDestruction: {
    //        console.log( "Destroying: Enemy Path > " + enemyPath);
    //    }

    Component.onCompleted:{
        wavePathDuration=enemyPath.duration;
        //        console.log("Creating Enemy Path " + enemyPath);
        //        console.log("enemyWaveCounter " + enemyWaveCounter);
    }
}
