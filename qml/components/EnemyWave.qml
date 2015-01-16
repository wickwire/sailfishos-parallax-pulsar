import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: root
    width: page.width
    height: page.height
    color: "transparent"

    EnemyShip{
        id: sandaarShip1
        shipHitState: "target1"
        y: 0

        Timer {
            id: enemyPathGo1
            interval: 0; running: true; repeat: false
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
            interval: 1000; running: true; repeat: false
            onTriggered: sandaarPath2.running=true
        }

        EnemyWavePath{
            id: sandaarPath2
            enemyShip: sandaarShip2
            running: false
        }
    }


    ParticleGroup{
        name: "target1"
        system: parallaxPulsarShot.shotParticles
        onEntered: {
            if(sandaarShip1){
                if(sandaarShip1.score == 0){
                    sandaarShip1.score++;
                    console.log("hit landed on 1: " + sandaarShip1.score);
                }
                sandaarShip1.destroyShip();
            }
        }
    }

    ParticleGroup{
        name: "target2"
        system: parallaxPulsarShot.shotParticles
        onEntered: {
            if(sandaarShip2){
                if(sandaarShip2.score == 0){
                    sandaarShip2.score++;
                    console.log("hit landed on 2: " + sandaarShip2.score);
                }
                sandaarShip2.destroyShip();
            }
        }
    }
}
