import QtQuick 2.0
import QtQuick.Particles 2.0

Item{
    id: ppulsarShot

    ImageParticle {
        id: pulsarShotParticle
        system: pulsarShotParticles
        groups: ["pulsarShot"]
        source: "qrc:///images/star.png"
        color: "#0FF06600"
        colorVariation: 0.3
    }

    Emitter {
        id: parallaxPulsarShotEmitter
        system: pulsarShotParticles
        group: "pulsarShot"
        emitRate: 5
        lifeSpan: 2000
        size: 140
        velocity: PointDirection { y: -512; }
        enabled: qmlWeaponTrigger.valProxim

//        onEmitParticles: console.log("Pulsar Shot Fired!" + pulsarShotParticle + " Particle System " + pulsarShotParticles);
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

//    Component.onDestruction:{
//        console.log( "Destroying Pulsar Shot > " + ppulsarShot);
//    }

    Component.onCompleted:{
        ppulsarEmitterLifeSpan=parallaxPulsarShotEmitter.lifeSpan;
//        console.log("Creating Pulsar Shot " + ppulsarShot);
    }
}
