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
    property variant enemyWavePair

    signal waveDestroy

    function sandaarDestroy(){
        for (var repeatArrayCnt = 0; repeatArrayCnt < enemyWavePair.length; repeatArrayCnt++) {
            if(sandaarShotDown == enemyWavePair[repeatArrayCnt].idx[1].sandaarID){
                //console.log("@EnemyWave MATCH: " + "Sandaar Shot Down: " + sandaarShotDown + " enemyWavePair: " + enemyWavePair[repeatArrayCnt].idx[0].repeaterIdx + " >< " + enemyWavePair[repeatArrayCnt].idx[1].sandaarID);
                gameScore=gameScore+50;
                //enemyShipGenerator.itemAt(enemyWavePair[repeatArrayCnt].idx[0].repeaterIdx).visible=false;
                enemyShipGenerator.itemAt(enemyWavePair[repeatArrayCnt].idx[0].repeaterIdx).sandaarHitAreaGoalState=false;
                enemyShipGenerator.itemAt(enemyWavePair[repeatArrayCnt].idx[0].repeaterIdx).sandaarShotEmitter=false;
                enemyShipGenerator.itemAt(enemyWavePair[repeatArrayCnt].idx[0].repeaterIdx).sandaarShipDestroy();
            }
        }
    }


    Repeater{

        id: enemyShipGenerator
        model: totalShips

        Item{
            id: enemyShotHolder

            property bool sandaarHitAreaGoalState : true
            property bool sandaarShotEmitter: true
            property variant enemyWavePairArray : enemyShipGenerator.enemyWavePair

            EnemyWaveTimer{
                id: sandaarTimer
            }

            EnemyExplosion{
                id: sandaarShipExplosion
                explosionEnabled: false
            }

            EnemyShip{
                id: sandaarShip

                sandaarExplosion: sandaarShipExplosion

                onXChanged:{
                    //console.log("sandaarScumCenterX " + sandaarScumCenterX + sandaarScumVisible);
                    enemyShipXchanged(sandaarScumCenterX, sandaarScumVisible);
                }

                onYChanged:{
                    //console.log("sandaarScumCenterY " + sandaarScumCenterY + sandaarScumVisible);
                    enemyShipYchanged(sandaarScumCenterY, sandaarScumVisible);
                }
            }

            function sandaarShipDestroy(){
                //console.log("@sandaarShipDestroy");
                sandaarShip.destroyShip();
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
        //console.log("Destroying: Wave > " + enemyWave);
        enemyWave.destroy();
    }

    Component.onCompleted: {
        //console.log("Creating Enemy Wave " + enemyWave);
        //console.log("@EnemyWave - Enemy Wave Total Delay: " + waveTotalDelay);
        receiveWaveTotalDelay(waveTotalDelay);
    }
}
