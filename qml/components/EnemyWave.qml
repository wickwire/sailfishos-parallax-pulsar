import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: enemyWave
    width: page.width
    height: page.height
    color: "transparent"

    property int waveShipDelay : 2000
    property int totalShips : 10
    property int waveCounter : 0
    property int waveLastDelay : waveShipDelay*(totalShips-1)
    property int waitstep : 3000
    property int wavePathDuration
    property int waveTotalDelay: waveLastDelay+wavePathDuration+waitstep
    property variant pulsarShotSystem
    property variant sandaarShotSys: enemyShotParticles

    signal waveDestroy

    function sandaarDestroy(){
        console.log("Sandaar 'Destroy'");
        gameScore=gameScore+50;
        enemyShipGenerator.itemAt(5).visible=false;
        enemyShipGenerator.itemAt(5).sandaarHitAreaGoalState=false;
    }

    Repeater{

        id: enemyShipGenerator
        model: totalShips

        Item{
            id: enemyShotHolder

            property bool sandaarHitAreaGoalState : true

            EnemyWaveTimer{
                id: sandaarTimer
            }

            EnemyShip{
                id: sandaarShip

                onXChanged:{
                    //console.log("sandaarScumCenterX " + sandaarScumCenterX);
                    enemyShipXchanged(sandaarScumCenterX);
                }

                onYChanged:{
                    //console.log("sandaarScumCenterY " + sandaarScumCenterY);
                    enemyShipYchanged(sandaarScumCenterY);
                }
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
