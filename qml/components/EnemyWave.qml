import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: root
    width: page.width
    height: page.height
    color: "transparent"

    EnemyShip{
        id: sandaarShip1
        sequence1.running: applicationActive
        shipHitState: "target1"
        y: 200
    }

    EnemyShip{
        id: sandaarShip2
        y: 300
        sequence2.running: applicationActive
        shipHitState: "target2"
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
