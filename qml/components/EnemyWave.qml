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

            onXChanged:{
                //console.log("SANDAAR: " + Math.floor(x) + ":" + Math.floor(y) + "-" + sandaarShipCenterX + ":" + sandaarShipCenterY);
                if(sandaarShipCenterX == parallaxPulsar.ppulsarShipCenterX){
                    console.log("Hit on X: " + sandaarShipCenterX + ":" + parallaxPulsar.ppulsarShipCenterX);
                }
            }

            onYChanged:{
                //console.log("SANDAAR: " + Math.floor(x) + ":" + Math.floor(y) + "-" + sandaarShipCenterX + ":" + sandaarShipCenterY);
                if(sandaarShipCenterY == parallaxPulsar.ppulsarShipCenterY){
                    console.log("Hit on Y: " + sandaarShipCenterY + ":" + parallaxPulsar.ppulsarShipCenterY);
                }
            }
//            onYChanged: {
//                //calculate item center

//                if(Math.floor(sandaarShip.y) == parallaxPulsar.y){
//                    console.log("hitY");
//                    sandaarVSparallaxY();
//                }
//            }

//            onXChanged: {
//                if(Math.floor(sandaarShip.x) == parallaxPulsar.x){
//                    console.log("hitX");
//                    sandaarVSparallaxX();
//                }
//            }

//            onSandaarVSparallaxX: {
//                console.log("2hitX");
//                if(Math.floor(sandaarShip.y) == parallaxPulsar.y){
//                    console.log("X: " + Math.floor(sandaarShip.x) + ":" + parallaxPulsar.x + "-" + Math.floor(sandaarShip.y) + ":" + parallaxPulsar.y)
//                }
//            }

//            onSandaarVSparallaxY: {
//                console.log("2hitX");
//                if(Math.floor(sandaarShip.x) == parallaxPulsar.x){
//                    console.log("Y: " + Math.floor(sandaarShip.x) + ":" + parallaxPulsar.x + "-" + Math.floor(sandaarShip.y) + ":" + parallaxPulsar.y)
//                }
//            }
        }
    }
}
