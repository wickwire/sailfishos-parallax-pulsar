import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: root
    width: page.width
    height: page.height
    color: "transparent"

    property int waveDelay : 300

    EnemyShip{
        id: sandaarShip1
        shipHitState: "target1"
        y: 0

        Timer {
            id: enemyPathGo1
            interval: 0*waveDelay; running: true; repeat: false
            onTriggered: sandaarPath1.running=true
        }

        EnemyWavePath{
            id: sandaarPath1
            enemyShip: sandaarShip1
            running: false
        }
    }

    EnemyShip{
        id: sandaarShip2
        y: 0
        shipHitState: "target2"

        Timer {
            id: enemyPathGo2
            interval: 1*waveDelay; running: true; repeat: false
            onTriggered: sandaarPath2.running=true
        }

        EnemyWavePath{
            id: sandaarPath2
            enemyShip: sandaarShip2
            running: false
        }
    }

    EnemyShip{
        id: sandaarShip3
        y: 0
        shipHitState: "target3"

        Timer {
            id: enemyPathGo3
            interval: 2*waveDelay; running: true; repeat: false
            onTriggered: sandaarPath3.running=true
        }

        EnemyWavePath{
            id: sandaarPath3
            enemyShip: sandaarShip3
            running: false
        }
    }

    EnemyShip{
        id: sandaarShip4
        y: 0
        shipHitState: "target4"

        Timer {
            id: enemyPathGo4
            interval: 3*waveDelay; running: true; repeat: false
            onTriggered: sandaarPath4.running=true
        }

        EnemyWavePath{
            id: sandaarPath4
            enemyShip: sandaarShip4
            running: false
        }
    }
}
