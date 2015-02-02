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
    property int waitstep : 3000
    property int wavePathDuration
    property int waveTotalDelay: waveLastDelay+wavePathDuration+waitstep


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

    Component.onCompleted: {
        console.log("Creating Enemy Wave " + enemyWave);
        console.log("@EnemyWave - Enemy Wave Total Delay: " + waveTotalDelay);
        receiveWaveTotalDelay(waveTotalDelay);
    }
}
