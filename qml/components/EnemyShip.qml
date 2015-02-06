import QtQuick 2.0
import QtQuick.Particles 2.0

Item{
    id: enemyShip
    property int sandaarScumCenterX : Math.floor(x+sandaarShip.height/2)
    property int sandaarScumCenterY : Math.floor(y+sandaarShip.width/2)

    EnemyShot{
        id: sandaarShot
    }

    Image {

        id: sandaarShip
        source: "qrc:///images/sandaarScum.svg"
        anchors.centerIn: parent
        sourceSize.width: 76
        sourceSize.height: 76
        rotation: 180
    }

    GroupGoal{
        id: sandaarHitArea
        jump: true
        anchors.fill: sandaarShip
        goalState: "sandaarTarget"
        system: pulsarShotSystem

        Component.onCompleted:{
            console.log( "Creating: Pulsar Group Goal > " + sandaarHitArea);
        }

        Component.onDestruction:{
            console.log( "Destroying: Pulsar Group Goal > " + sandaarHitArea);
        }
    }

    Component.onDestruction: {
        console.log( "Destroying: Enemy Ship > " + enemyShip);
    }

    Component.onCompleted:{
        console.log("Creating Enemy Ship " + enemyShip);
    }
}
