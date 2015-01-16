import QtQuick 2.0
import QtQuick.Particles 2.0

Item{
    id: enemyShip

    property int score
    property alias shipHitState: groupGoal.goalState

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
        x: 0
        y: parent.height-height/2
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
        interval: 500; running: exploding; repeat: false
        onTriggered: enemyShip.destroy();

        property bool exploding
    }

    function destroyShip(){
        sandaarScum.visible=false;
        enemyExplosion.explosionEnabled = true;
        shipExplode.exploding=true;
    }
}
