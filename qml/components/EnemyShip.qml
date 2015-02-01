import QtQuick 2.0
import QtQuick.Particles 2.0

Item{
    id: enemyShip

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
        property int sandaarScumCenterX : Math.floor(x+sourceSize.height/2)
        property int sandaarScumCenterY : Math.floor(y+sourceSize.width/2)
    }

    Component.onDestruction: {
        console.log( "Destroying: Enemy Ship > " + enemyShip);
    }

    Component.onCompleted:{
        console.log("Creating Enemy Ship " + enemyShip);
    }

}
