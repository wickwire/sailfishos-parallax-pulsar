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
    property string sandaarShotDown

    //property variant enemyWavePair

    signal waveDestroy

    function sandaarDestroy(){
        console.log("Sandaar 'Destroy' " + sandaarShotDown);
        gameScore=gameScore+50;

        for (var repeatArrayCnt = 0; repeatArrayCnt < enemyWavePair.length; repeatArrayCnt++) {
            if(sandaarShotDown == enemyWavePair[repeatArrayCnt].idx[1].sandaarID){
                console.log("@EnemyWave MATCH: " + "Sandaar Shot Down: " + sandaarShotDown + " enemyWavePair: " + enemyWavePair[repeatArrayCnt].idx[0].repeaterIdx + " >< " + enemyWavePair[repeatArrayCnt].idx[1].sandaarID);
            }
        }

//        enemyShipGenerator.itemAt(5).visible=false;
//        enemyShipGenerator.itemAt(5).sandaarHitAreaGoalState=false;
    }

    property variant enemyWavePair

    Repeater{

        id: enemyShipGenerator
        model: totalShips

        Item{
            id: enemyShotHolder

            property bool sandaarHitAreaGoalState : true
            property variant enemyWavePairArray : enemyShipGenerator.enemyWavePair

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

            Component.onCompleted: {
                if(index === 0){
                    var enemyWavePairTmp = [];
                }
                else{
                    enemyWavePairTmp = enemyWavePair;
                }

                enemyWavePairTmp.push({"idx":
                                              [
                                              {"repeaterIdx":index.toString()},
                                              {"sandaarID":sandaarShip.toString()}
                                          ]
                                      })

                enemyWavePair=enemyWavePairTmp;

                //console.log("@EnemyWave: " + " Repeater Index > " + index + " enemyShotHolder > " + enemyShotHolder + " sandaarTimer > " + sandaarTimer + " sandaarShip > " + sandaarShip + " sandaarPath > " + sandaarPath);
                //console.log("@EnemyWave : " + enemyWavePairTmp[index].idx[0].repeaterIdx + " >< " + enemyWavePairTmp[index].idx[1].sandaarID);
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
