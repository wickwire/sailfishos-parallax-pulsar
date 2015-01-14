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

    Text {
        color: "white"
        text: score
        rotation: 180
        anchors.top: parent.top
    }

    ParticleSystem {

        id: particles
        anchors.fill: parent
        paused: !applicationActive

        ParticleGroup{
            name: "enemyWave"

            ImageParticle {
                id: sandaarShip
                system: particles
                source: "qrc:///images/sandaarScum.svg"
                rotation: 180
            }
        }

        GroupGoal{
            groups: ["shot"]
            whenCollidingWith: ["enemyWave"]
            goalState: "target1"
            jump: true
        }

        GroupGoal{
            groups: ["enemyWave"]
            whenCollidingWith: ["shot"]
            goalState: "target2"
            jump: true
        }

        Emitter {
            id: enemyShips
            group: "enemyWave"
            emitRate: 1
            lifeSpan: 15000
            size: 50

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

        ParticleGroup{
            name: "shot"

            ImageParticle {
                system: particles
                source: "qrc:///images/star.png"
                color: "#0FF06600"
                colorVariation: 0.3
            }
        }

        Emitter {
            group: "shot"
            emitRate: 1
            lifeSpan: 20000
            size: 140
            velocity: PointDirection { y: -100; }
            x: shipX + shipWidth
            y: shipY + shipHeight/2 - 3
            enabled: qmlWeaponTrigger.valProxim
        }



        ParticleGroup{
            name: "target1"
            onEntered: {
                console.log("Score: " + score);
                score++;
            }
        }

        ParticleGroup{
            name: "target2"
            onEntered: {
                console.log("hit: " + score);
                score++;
            }
        }
    }
}
