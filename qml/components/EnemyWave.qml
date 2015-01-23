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

    property string shipId
    property string shipTarget
    property string wavePath

    property int totalShips : 10

    Timer {
        id: enemyPathGo
        interval: waveDelay;
        running: false;
        repeat: true;
        onTriggered: spriteWavePath.running=true
    }

    function createSpriteObjects() {

        componentEnemyShip = Qt.createComponent("EnemyShip.qml");
        componentEnemyPath = Qt.createComponent("EnemyWavePath.qml");

        for(var count=0; count<totalShips; count++){

            shipId = "sandaarShip"+count;
            shipTarget = "target"+count;
            wavePath = "sandaarPath"+count;

            spriteShip = componentEnemyShip.createObject(root,
                {
                    "id": shipId,
                    "shipHitState": shipTarget,
                    "y": 0
                }
            );

            spriteWavePath = componentEnemyPath.createObject(root,
                {
                    "id": wavePath,
                    "enemyShip": spriteShip,
                    "running": false
                }
            );

            enemyPathGo.running=true;

        }
    }

    Component.onCompleted: createSpriteObjects();

//    EnemyShip{
//        id: sandaarShip1
//        shipHitState: "target1"
//        y: 0

//        Timer {
//            id: enemyPathGo1
//            interval: 0*waveDelay; running: true; repeat: false
//            onTriggered: sandaarPath1.running=true
//        }

//        EnemyWavePath{
//            id: sandaarPath1
//            enemyShip: sandaarShip1
//            running: false
//        }
//    }

//    EnemyShip{
//        id: sandaarShip2
//        y: 0
//        shipHitState: "target2"

//        Timer {
//            id: enemyPathGo2
//            interval: 1*waveDelay; running: true; repeat: false
//            onTriggered: sandaarPath2.running=true
//        }

//        EnemyWavePath{
//            id: sandaarPath2
//            enemyShip: sandaarShip2
//            running: false
//        }
//    }

//    EnemyShip{
//        id: sandaarShip3
//        y: 0
//        shipHitState: "target3"

//        Timer {
//            id: enemyPathGo3
//            interval: 2*waveDelay; running: true; repeat: false
//            onTriggered: sandaarPath3.running=true
//        }

//        EnemyWavePath{
//            id: sandaarPath3
//            enemyShip: sandaarShip3
//            running: false
//        }
//    }

//    EnemyShip{
//        id: sandaarShip4
//        y: 0
//        shipHitState: "target4"

//        Timer {
//            id: enemyPathGo4
//            interval: 3*waveDelay; running: true; repeat: false
//            onTriggered: sandaarPath4.running=true
//        }

//        EnemyWavePath{
//            id: sandaarPath4
//            enemyShip: sandaarShip4
//            running: false
//        }
//    }

//    EnemyShip{
//        id: sandaarShip5
//        y: 0
//        shipHitState: "target5"

//        Timer {
//            id: enemyPathGo5
//            interval: 4*waveDelay; running: true; repeat: false
//            onTriggered: sandaarPath5.running=true
//        }

//        EnemyWavePath{
//            id: sandaarPath5
//            enemyShip: sandaarShip5
//            running: false
//        }
//    }

//    EnemyShip{
//        id: sandaarShip6
//        y: 0
//        shipHitState: "target6"

//        Timer {
//            id: enemyPathGo6
//            interval: 5*waveDelay; running: true; repeat: false
//            onTriggered: sandaarPath6.running=true
//        }

//        EnemyWavePath{
//            id: sandaarPath6
//            enemyShip: sandaarShip6
//            running: false
//        }
//    }

//    EnemyShip{
//        id: sandaarShip7
//        y: 0
//        shipHitState: "target7"

//        Timer {
//            id: enemyPathGo7
//            interval: 6*waveDelay; running: true; repeat: false
//            onTriggered: sandaarPath7.running=true
//        }

//        EnemyWavePath{
//            id: sandaarPath7
//            enemyShip: sandaarShip7
//            running: false
//        }
//    }

//    EnemyShip{
//        id: sandaarShip8
//        y: 0
//        shipHitState: "target8"

//        Timer {
//            id: enemyPathGo8
//            interval: 7*waveDelay; running: true; repeat: false
//            onTriggered: sandaarPath8.running=true
//        }

//        EnemyWavePath{
//            id: sandaarPath8
//            enemyShip: sandaarShip8
//            running: false
//        }
//    }

//    EnemyShip{
//        id: sandaarShip9
//        y: 0
//        shipHitState: "target9"

//        Timer {
//            id: enemyPathGo9
//            interval: 8*waveDelay; running: true; repeat: false
//            onTriggered: sandaarPath9.running=true
//        }

//        EnemyWavePath{
//            id: sandaarPath9
//            enemyShip: sandaarShip9
//            running: false
//        }
//    }

//    EnemyShip{
//        id: sandaarShip10
//        y: 0
//        shipHitState: "target10"

//        Timer {
//            id: enemyPathGo10
//            interval: 9*waveDelay; running: true; repeat: false
//            onTriggered: sandaarPath10.running=true
//        }

//        EnemyWavePath{
//            id: sandaarPath10
//            enemyShip: sandaarShip10
//            running: false
//        }
//    }

}
