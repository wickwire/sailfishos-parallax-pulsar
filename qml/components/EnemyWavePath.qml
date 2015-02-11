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
        startX: -sandaarShip.width/2
        startY: -sandaarShip.height/2

        PathLine {id: checkpoint1}
        PathLine {id: checkpoint2}
        PathLine {id: checkpoint3}

        Component.onCompleted: {
            if(enemyWaveCounter==0){
                startX=-page.width*0.25
                checkpoint1.x=-page.width*0.25
                checkpoint1.y=page.height*0.2
                checkpoint2.x=page.width*0.75
                checkpoint2.y=checkpoint1.y
                checkpoint3.x=checkpoint2.x
                checkpoint3.y=page.height*1.2
            }
            else if(enemyWaveCounter==1){
                startX=page.width*1.2
                checkpoint1.x=-page.width*(Math.random(0.10))
                checkpoint1.y=page.height*(Math.random(0.50))
                checkpoint2.x=page.width*(Math.random(0.10))
                checkpoint2.y=-page.height*(Math.random(0.10))
                checkpoint3.x=page.width*(Math.random(0.10))
                checkpoint3.y=page.height*1.2
            }
            else if(enemyWaveCounter==2){
                startX=page.width*1.2
                checkpoint1.x=-page.width*(Math.random(0.10))
                checkpoint1.y=page.height*(Math.random(0.50))
                checkpoint2.x=page.width*(Math.random(0.25))
                checkpoint2.y=-page.height*(Math.random(0.25))
                checkpoint3.x=page.width*(Math.random(0.3))
                checkpoint3.y=page.height*1.2
            }
            else if(enemyWaveCounter==3){
                startX=-page.width*0.25
                checkpoint1.x=page.width*0.5
                checkpoint1.y=page.height*0.25
                checkpoint2.x=page.width*0.25
                checkpoint2.y=page.height*0.16
                checkpoint3.x=page.width*1.2
                checkpoint3.y=page.height*1.2
            }
            else{
                startX=-page.width*0.25
                checkpoint1.x=-page.width*(Math.random(0.3))
                checkpoint1.y=page.height*(Math.random(0.3))
                checkpoint2.x=page.width*(Math.random(0.3))
                checkpoint2.y=-page.height*(Math.random(0.3))
                checkpoint3.x=page.width*(Math.random(0.3))
                checkpoint3.y=page.height*1.2
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
