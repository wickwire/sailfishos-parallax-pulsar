import QtQuick 2.0
import QtQuick.Particles 2.0
import QtMultimedia 5.0

Rectangle{
    id: enemyShot
    width: page.width
    height: page.height
    color: "transparent"

    //    Component.onDestruction: {
    //        console.log("Destroying Enemy Shot " + enemyShot);
    //    }

    //    Component.onCompleted:{
    //        console.log("Creating Enemy Shot " + enemyShot);
    //    }


    property string currentTimestamp

//    Connections{
//        target: gmClock
//        onTestTimerChanged:{
//            currentTimestamp=new Date().toString();
//            console.log("@EnemyShot: received timer signal " + currentTimestamp);
//        }
//    }








//    Connections{
//            target: gameClock
//            onFireStuff:{
//                currentTimestamp=new Date().toString();
//                console.log("@EnemyShot: received timer signal " + currentTimestamp);
//            }
//        }

    ImageParticle {
        system: enemyShotParticles
        groups: ["enemyShot"]
        source: "qrc:///images/star.png"
        color: "#0FF06600"
        colorVariation: 0.3
    }

    Emitter {
        id: enemyShotEmitter
        system: enemyShotParticles
        group: "enemyShot"
        emitRate: 2
        lifeSpan: 2000
        size: 40
        velocity: PointDirection { y: 512; }
        enabled: enemyShotHolder.sandaarShotEmitter

//        onEmitParticles: {
//            sandaarShotSnd.play();
//        }
    }

    Timer{
        id: shotDestroyDelay
        interval: enemyShotEmitter.lifeSpan
        running: false
        repeat: false
        onTriggered: enemyShot.destroy();
    }

    function destroyShot(){
        enemyShotEmitter.enabled=false
        shotDestroyDelay.running=true
    }

    Audio {
        id: sandaarShotSnd
        autoLoad: false
        autoPlay: false
        source: "../soundeffects/sandaar.001.mp3"
        volume: 0.1
    }
}

