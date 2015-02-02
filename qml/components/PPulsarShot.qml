import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: ppulsarShot
    width: page.width
    height: page.height
    color: "transparent"

    property int shipX
    property int shipY
    property int shipWidth
    property int shipHeight
    property alias ppulsarEmitterLifeSpan: parallaxPulsarShotEmitter.lifeSpan

    ParticleSystem {
        id: pulsarShotparticles
        anchors.fill: parent
        paused: !applicationActive
    }

    ImageParticle {
        system: pulsarShotparticles
        groups: ["pulsarShot"]
        source: "qrc:///images/star.png"
        color: "#0FF06600"
        colorVariation: 0.3
    }

    Emitter {
        id: parallaxPulsarShotEmitter
        system: pulsarShotparticles
        group: "pulsarShot"
        emitRate: 5
        lifeSpan: 2000
        size: 140
        velocity: PointDirection { y: -512; }
        x: shipX + shipWidth/2
        y: shipY + shipHeight/2
        enabled: qmlWeaponTrigger.valProxim
    }

    Timer{
        id: shotDestroyDelay
        interval: parallaxPulsarShotEmitter.lifeSpan
        running: false
        repeat: false
        onTriggered: ppulsarShot.destroy();
    }

    function destroyShot(){
        parallaxPulsarShotEmitter.enabled=false
        shotDestroyDelay.running=true
    }

    function disableShot(){
        parallaxPulsarShotEmitter.enabled=false
    }

    function enableShot(){
        parallaxPulsarShotEmitter.enabled=true
    }

    Component.onDestruction:{
        console.log( "Destroying: Pulsar Shot > " + ppulsarShot);
    }
}
