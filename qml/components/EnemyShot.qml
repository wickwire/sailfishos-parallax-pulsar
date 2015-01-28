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

    property alias enemyEmitterLifeSpan: enemyShotEmitter.lifeSpan
    property alias enemyEmitter: enemyShotEmitter.enabled

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
            emitRate: 1
            lifeSpan: 2000
            size: 40
            velocity: PointDirection { y: 512; }
            enabled: true
        }
}

