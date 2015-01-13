import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: root
    width: page.width
    height: page.height
    color: "transparent"


    ParticleSystem {

        id: particles
        anchors.fill: parent
        paused: !applicationActive

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
