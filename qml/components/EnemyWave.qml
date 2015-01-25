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
        model: 10

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
