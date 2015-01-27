import QtQuick 2.0
import QtQuick.Particles 2.0

Item{
    id: enemyShip

//    EnemyShot{
//        id : enemyShot
//        shipX: sandaarScum.x
//        shipY: sandaarScum.y
//        shipWidth: sandaarScum.width
//        shipHeight: sandaarScum.height
//    }

    property int score
    property alias shipHitState: groupGoal.goalState
    signal enemyShipHit

    property int enemyShipWidth : sandaarScum.sourceSize.width
    property int enemyShipHeight : sandaarScum.sourceSize.height

    Image {

        id: sandaarScum
        source: "qrc:///images/sandaarScum.svg"
        anchors.centerIn: sandaarScumHolder
        sourceSize.width: 76
        sourceSize.height: 76
        rotation: 180
        property int sandaarScumCenterX : Math.floor(x+sourceSize.height/2)
        property int sandaarScumCenterY : Math.floor(y+sourceSize.width/2)
    }

    Item{

        id: sandaarScumHolder
        width: sandaarScum.width
        height: sandaarScum.height

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
        interval: 500;
        running: exploding;
        repeat: false
        onTriggered: {
            enemyExplosion.explosionEnabled=false;
            enemyExplosion.destroy();
            if(enemyShip){
                enemyShip.enabled=false;
            }
            if(groupGoal){
                groupGoal.destroy();
            }

        }
        property bool exploding
    }

    function destroyShip(){
        if(sandaarPath){
            sandaarPath.destroy();
        }
        if(enemyShot){
            enemyShot.destroy();
        }

        sandaarScum.visible=false;
        if(enemyExplosion){
            enemyExplosion.explosionEnabled = true;
            shipExplode.exploding=true;
        }
    }

    ParticleGroup{
        name: shipHitState
        system: parallaxPulsarShot.shotParticles
        onEntered: {
            if(enemyShip){
                if(enemyShip.score == 0){
                    enemyShip.score++;
                    console.log("hit landed on: " + enemyShip + " : " + enemyShip.score);
                }/*else{
                    console.log("fire skipping! " + enemyShip + " : " + enemyShip.score);
                }*/

                enemyShip.destroyShip();
            }/*else{
                console.log("not on enemyship!");
            }*/
        }
    }
}
