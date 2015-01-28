import QtQuick 2.0
import QtQuick.Particles 2.0

//phone with screen facing up
Item{
    id: ppulsarShip
    width:76
    height: 76
    //    x: qmlAccelcontrols.valAccelZ;
    //    y: qmlAccelcontrols.valAccelY;
    x: qmlAccelcontrols.valAccelX;
    y: qmlAccelcontrols.valAccelY;

    property int ppulsarShipCenterX : Math.floor(x+height/2)
    property int ppulsarShipCenterY : Math.floor(y+width/2)

    property int pulsarDestroyX : 0
    property int pulsarDestroyY : 0

    property variant ppulsarParticleSystem

    Image {
        id: ppulsarSvg
        source: "qrc:///images/spaceship.svg"
        anchors.centerIn: ppulsarShipHolder
        sourceSize.width: 76
        sourceSize.height: 76
    }

    //onXChanged: console.log("PPULSAR: " + x + ":" + y + "-" + ppulsarShipCenterX + ":" + ppulsarShipCenterY);

    Item {
        id: ppulsarShipHolder
        width: ppulsarSvg.width
        height: ppulsarSvg.height

        ShipExplosion{
            id: ppulsarExplosion
            explosionEnabled: false
            anchors.centerIn: parent
        }
    }


    Timer {
        id: shipExplode
        interval: 500;
        running: exploding;
        repeat: false
        onTriggered: {
            ppulsarExplosion.explosionEnabled=false;
            ppulsarExplosion.destroy();
            if(ppulsarShip){
                ppulsarShip.enabled=false;
            }
            if(parallaxGoal){
                parallaxGoal.destroy();
            }
        }
        property bool exploding
    }

    function destroyShip(){
        //console.log("destroyShip");

        if(parallaxPulsarShot){
            parallaxPulsarShot.destroy()
        }

        if(pulsarDestroyX == 0)
            pulsarDestroyX = ppulsarShip.x;

        if(pulsarDestroyY == 0)
            pulsarDestroyY = ppulsarShip.y;

        ppulsarSvg.visible=false;

        if(ppulsarExplosion){
            ppulsarExplosion.explosionEnabled = true;
            shipExplode.exploding=true;
        }
    }

    onXChanged:
        if(ppulsarSvg.visible == false){
            if(pulsarDestroyX != 0){
                ppulsarShip.x = pulsarDestroyX
                console.log(pulsarDestroyX)
            }
        }

    onYChanged:
        if(ppulsarSvg.visible == false){
            if(pulsarDestroyY != 0){
                ppulsarShip.y = pulsarDestroyY
                console.log(pulsarDestroyY)
            }
        }

    GroupGoal {
        id: parallaxGoal
        system: ppulsarParticleSystem
        jump: true
        anchors.centerIn: ppulsarSvg
        anchors.fill: ppulsarSvg
        goalState: "ppulsarTarget"
    }

    ParticleGroup{
    id: parallaxGroup
    name: "ppulsarTarget"
    system: ppulsarParticleSystem
    onEntered: {
        if(ppulsarShip){
            if(ppulsarShip.score == 0){
                ppulsarShip.score++;
                console.log("hit landed on: " + ppulsarShip + " : " + ppulsarShip.score);
            }/*else{
                console.log("fire skipping! " + ppulsarShip + " : " + ppulsarShip.score);
            }*/

            ppulsarShip.destroyShip();
        }else{
            console.log("not on ppulsarShip!");
        }
    }
}
}
