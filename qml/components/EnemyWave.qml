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

    property int totalShips : 10

    function generateEnemyWave() {

        componentEnemyShip = Qt.createComponent("EnemyShip.qml");
        componentEnemyPath = Qt.createComponent("EnemyWavePath.qml");
//        componentEnemyTimer = Qt.createComponent("EnemyWaveTimer.qml");

        for(shipCount=0; shipCount<totalShips; shipCount++){

            shipId = "sandaarShip"+shipCount;
            shipTarget = "target"+shipCount;
            wavePath = "sandaarPath"+shipCount;
            shipTimer = "enemyPathGo"+shipCount;

            spriteShip = componentEnemyShip.createObject(root,
                {
                    "id": shipId,
                    "shipHitState": shipTarget,
                    "y": 0
                }
            );

            if(componentEnemyShip.status == Component.Ready){
                console.log("enemyShip ready!! " + componentEnemyPath);
                spriteWavePath = componentEnemyPath.createObject(spriteShip,
                    {
                        "id": wavePath,
                        "target": spriteShip,
                        "running": true
                    }
            );

//                spriteTimer = componentEnemyTimer.createObject(wavePath,
//                    {
//                        "id": shipTimer,
//                        "running": true,
//                        "repeat": false,
//                        "interval": waveDelay*shipCount,
//                        "onTriggered": wavePath.running=true
//                    }
//                );
            }
        }
    }

    Component.onCompleted: generateEnemyWave();
}
