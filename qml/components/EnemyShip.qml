import QtQuick 2.0
import QtQuick.Particles 2.0

Item{
    id: enemyShip

    property int score
    property alias shipHitState: groupGoal.goalState
    signal enemyShipHit

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
        width: sandaarScum.width
        height: sandaarScum.height
        rotation: 90

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
        }
        property bool exploding
    }

    function destroyShip(){
        sandaarPath.running=false;
        sandaarScum.visible=false;
        enemyExplosion.explosionEnabled = true;
        shipExplode.exploding=true;
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

