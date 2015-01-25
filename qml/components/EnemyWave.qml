import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: root
    width: page.width
    height: page.height
    color: "transparent"

    property int waveDelay : 300

    property variant componentEnemyShip;
    property variant componentEnemyPath;
    property variant componentEnemyTimer;

    property variant spriteShip;
    property variant spriteTimer;
    property variant spriteWavePath;

    property variant shipId
    property variant shipTarget
    property variant wavePath
    property variant shipTimer

    property int shipCount

    property int totalShips : 3

    property int enemyShipDelay;


//    function generateEnemyWave() {

//        componentEnemyShip = Qt.createComponent("EnemyShip.qml");
//        componentEnemyPath = Qt.createComponent("EnemyWavePath.qml");
//        componentEnemyTimer = Qt.createComponent("EnemyWaveTimer.qml");

//        for(shipCount=0; shipCount<totalShips; shipCount++){

//            enemyShipDelay = waveDelay*shipCount;

//            shipId = "sandaarShip"+shipCount;
//            shipTarget = "target"+shipCount;
//            wavePath = "sandaarPath"+shipCount;
//            shipTimer = "enemyPathGo"+shipCount;

//            spriteShip = componentEnemyShip.createObject(root,
//                {
//                    "id": shipId,
//                    "shipHitState": shipTarget,
//                    "y": 0
//                }
//            );

//            if(componentEnemyShip.status == Component.Ready){
//                spriteWavePath = componentEnemyPath.createObject(spriteShip,
//                    {
//                        "id": wavePath,
//                        "enemyShip": spriteShip,
//                        "running": false
//                    }
//                );
//                //console.log("enemyShip ready: " + spriteShip + " enemyPath ready:" + spriteWavePath);

//                spriteTimer = componentEnemyTimer.createObject(spriteShip,
//                    {
//                        "id": shipTimer,
//                        "interval": waveDelay*shipCount,
//                        //"onTriggered": console.log("timer: " + spriteShip + waveDelay*shipCount)
//                        "onTriggered": spriteWavePath.running=true
//                    }
//                );

////                console.log("enemyShip ready: " + spriteShip + " enemyPath ready:" + spriteWavePath + "spriteTimer: " + spriteTimer + ":" + spriteTimer.interval);
//            }
//        }
//    }

//    Component.onCompleted: {
//        generateEnemyWave();
//    }


    Repeater{
        model: 3

            EnemyShip{
                id: sandaarShip
                shipHitState: "target"+index+1
                y: 0

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
            }


    }
}
