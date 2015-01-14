import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: root
    width: page.width
    height: page.height
    color: "transparent"

    property int shipX
    property int shipY
    property int shipWidth
    property int shipHeight

    property int score

    property alias shotParticles: particles

    ParticleSystem {

        id: particles
        anchors.fill: parent
        paused: !applicationActive

        ParticleGroup{
            name: "shot"

            ImageParticle {
                system: particles
                groups: ["shot"]
                source: "qrc:///images/star.png"
                color: "#0FF06600"
                colorVariation: 0.3
            }

            GroupGoal{
                whenCollidingWith: ["enemyWave"]
                goalState: "target1"
                jump: true
            }
        }



        Emitter {
            group: "shot"
            emitRate: 6
            lifeSpan: 2000
            size: 140
            velocity: PointDirection { y: -512; }
            x: shipX + shipWidth
            y: shipY + shipHeight/2 - 3
            enabled: qmlWeaponTrigger.valProxim
        }

        ParticleGroup{
            name: "target1"
            onEntered: {
                console.log("Score: " + score);
                score++;
                //sandaarShip1.score++
            }
        }
        ParticleGroup{
            name: "target2"
            onEntered: {
                sandaarShip2.score++
            }
        }

        ImageParticle {
            system: particles
            groups: ["enemyWave"]
            source: "qrc:///images/sandaarScum.svg"
//            color: "#0FF06600"
//            colorVariation: 0.3
            rotation: 180
            id: sandaarShip
        }

        Emitter {
            group: "enemyWave"
            emitRate: 1
            lifeSpan: 15000
            size: 50
            //velocity: PointDirection { y: 100; }

            velocity: AngleDirection {
                angle: -96
                angleVariation: 0
                magnitude: 200
            }
            acceleration: AngleDirection {
                angle: 90
                magnitude: 25
            }


            x: root.width
            y: 900


        }


    }
}
