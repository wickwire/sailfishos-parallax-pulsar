import QtQuick 2.0
import QtQuick.Particles 2.0

Item{
    id: enemyShip
    property int sandaarScumCenterX : Math.floor(x+sandaarShip.height/2)
    property int sandaarScumCenterY : Math.floor(y+sandaarShip.width/2)
    property bool sandaarScumVisible : sandaarShip.visible

    property int sandaarDestroyX : 0
    property int sandaarDestroyY : 0

    property variant sandaarExplosion

    x: -sandaarShip.width
    y: -sandaarShip.height

    EnemyShot{
        id: sandaarShot
    }

    Image {

        id: sandaarShip
        //source: "qrc:///images/sandaarScum.svg"
        anchors.centerIn: parent
        sourceSize.width: 76
        sourceSize.height: 76
        rotation: 180

        Component.onCompleted: {
            if(enemyWaveCounter==0){
               source="qrc:///images/sandaarScum.svg"
            }
            else if(enemyWaveCounter==1){
                source="qrc:///images/sandaarScum001.png"
             }
            else if(enemyWaveCounter==2){
                source="qrc:///images/sandaarScum002.png"
             }
            else if(enemyWaveCounter==3){
                source="qrc:///images/sandaarScum003.png"
             }
            else if(enemyWaveCounter==4){
                source="qrc:///images/sandaarScum004.png"
             }
            else{
                source="qrc:///images/sandaarScum.svg"
             }
        }
    }

    GroupGoal{
        id: sandaarHitArea
        jump: true
        anchors.fill: sandaarShip
        goalState: "sandaarTarget"
        system: pulsarShotSystem
        enabled: enemyShotHolder.sandaarHitAreaGoalState

        //        Component.onCompleted:{
        //            console.log( "Creating: Pulsar Group Goal > " + sandaarHitArea);
        //        }

        //        Component.onDestruction:{
        //            console.log( "Destroying: Pulsar Group Goal > " + sandaarHitArea);
        //        }

        onAffected: {
            sandaarShotDown=enemyShip.toString();
            //            console.log("SANDAAR WAS HIT!! " + sandaarShotDown);
        }
    }

    Timer {
        id: shipExplode
        interval: 500;
        running: exploding;
        repeat: false
        onTriggered: {
            sandaarExplosion.explosionEnabled=false;
            sandaarExplosion.destroy();
        }
        property bool exploding
    }

    function destroyShip(){
//        console.log("@EnemyShip - destroyShip()");

        sandaarShip.visible=false;

        if(sandaarDestroyX == 0)
            sandaarDestroyX = enemyShip.x;

        if(sandaarDestroyY == 0)
            sandaarDestroyY = enemyShip.y;

//        console.log("sandaarDestroyX " + sandaarDestroyX + "sandaarDestroyY " + sandaarDestroyY);

        if(sandaarExplosion){
            sandaarExplosion.x=sandaarDestroyX;
            sandaarExplosion.y=sandaarDestroyY;
            sandaarExplosion.explosionEnabled = true;
            shipExplode.exploding=true;
        }

    }

    //    Component.onDestruction: {
    //        console.log( "Destroying: Enemy Ship > " + enemyShip);
    //    }

    //    Component.onCompleted:{
    //        console.log("Creating Enemy Ship " + enemyShip);
    //    }
}
