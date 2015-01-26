import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: root
    width: page.width
    height: page.height
    color: "transparent"

    property int waveDelay : 300
    property int totalShips : 10

    Repeater{
        model: 1

        EnemyShip{
            id: sandaarShip
            shipHitState: "target"+index+1
            y: 0

            signal sandaarVSparallaxX
            signal sandaarVSparallaxY

            property int sandaarShipCenterX : Math.floor(sandaarShip.x+sandaarShip.enemyShipWidth/2)
            property int sandaarShipCenterY : Math.floor(sandaarShip.y+sandaarShip.enemyShipHeight/2)

            property int hitDistX
            property int hitDistY

            property int shipHitRadius : Math.floor((parallaxPulsar.width+sandaarShip.enemyShipWidth)/2)

            Timer {
                interval: waveDelay*(index+1);
                running: true;
                repeat: false
                onTriggered: sandaarPath.running=true
            }

            EnemyWavePath{
                id: sandaarPath
                enemyShip: sandaarShip
                running: false
            }

            onYChanged:{
                hitDistX = Math.abs(sandaarShipCenterX - parallaxPulsar.ppulsarShipCenterX);
                hitDistY = Math.abs(sandaarShipCenterY - parallaxPulsar.ppulsarShipCenterY);
                if(hitDistX < shipHitRadius && hitDistY < shipHitRadius){
                    console.log("Hit on Y: " + hitDistX + "x" + hitDistY);
                }
            }

            onXChanged:{
                hitDistX = Math.abs(sandaarShipCenterX - parallaxPulsar.ppulsarShipCenterX);
                hitDistY = Math.abs(sandaarShipCenterY - parallaxPulsar.ppulsarShipCenterY);
                if(hitDistX < shipHitRadius && hitDistY < shipHitRadius){
                    console.log("Hit on X: " + hitDistX + "x" + hitDistY);
                }
            }
        }
    }
}
