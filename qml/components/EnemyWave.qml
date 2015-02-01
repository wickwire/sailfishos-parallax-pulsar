import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: root
    width: page.width
    height: page.height
    color: "transparent"

    property int waveShipDelay : 300
    property int waveDelay: 2000
    property int totalShips : 10
    property int waveCounter : 0
    property int waveLastDelay : waveShipDelay*(totalShips-1)

    signal waveDestroy

    Repeater{

        id: enemyShipGenerator
        model: totalShips

        Item{
            id: enemyShotHolder

            Timer{
                id: sandaarWaveTimer
                interval: waveShipDelay*index
                running: true
                repeat: false
                onTriggered: {
                    waveCounter+=1;
                    sandaarPath.running=true;
                }
            }

            EnemyShip{
                id: sandaarShip
            }
            EnemyWavePath{
                id: sandaarPath
                running: false
            }
        }
    }


    onWaveDestroy: {
        console.log("Destroying: Wave > " + root);
        root.destroy();
    }
}
