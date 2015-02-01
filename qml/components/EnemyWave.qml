import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: enemyWave
    width: page.width
    height: page.height
    color: "transparent"

    property int waveShipDelay : 300
    property int waveDelay: 2000
    property int totalShips : 10
    property int waveCounter : 0
    property int waveLastDelay : waveShipDelay*(totalShips-1)

    signal waveDestroy

    ParticleSystem {
        id: enemyShotParticles
        anchors.fill: parent
        paused: !applicationActive
    }

    Repeater{

        id: enemyShipGenerator
        model: totalShips

        Item{
            id: enemyShotHolder

            EnemyWaveTimer{
                id: sandaarTimer
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
        console.log("Destroying: Wave > " + enemyWave);
        enemyWave.destroy();
    }
}
