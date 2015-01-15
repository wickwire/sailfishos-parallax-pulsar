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
    }

    EnemyShip{
        id: sandaarShip2
        x: 165
        sequence2.running: applicationActive
        shipHitState: "target2"
    }


    ParticleGroup{
        name: "target1"
        system: parallaxPulsarShot.shotParticles
        onEntered: {
            sandaarShip1.score++;
            console.log("hit landed on 1: " + sandaarShip1.score);
        }
    }

    ParticleGroup{
        name: "target2"
        system: parallaxPulsarShot.shotParticles
        onEntered: {
            sandaarShip2.score++;
            console.log("hit landed on 2: " + sandaarShip2.score);
        }
    }

}
