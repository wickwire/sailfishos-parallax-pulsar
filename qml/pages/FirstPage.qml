/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"
import QtQuick.Particles 2.0

Page {

    objectName: "initialPage"
    id: page

    property variant enemyWaveComponent
    property variant enemyWaveObject
    property variant parallaxShipComponent
    property variant parallaxShipObject
    property variant parallaxShotComponent
    property variant parallaxShotObject
    property int enemyWaveTotalDelay
    property int pulsarLives : 3
    property int gameScore : 0

    signal receiveWaveTotalDelay(int totalDelay)
    signal enemyShipXchanged(int enemyShipCurrentX, bool enemyShipCurrentVisibility)
    signal enemyShipYchanged(int enemyShipCurrentY, bool enemyShipCurrentVisibility)
    signal parallaxPulsarBlasted
    property int enemyWaveCounter

    ParticleSystem {
        id: pulsarShotParticles
        anchors.fill: parent
        paused: !applicationActive

//        Component.onCompleted: console.log("Creating Pulsar Particle System " + pulsarShotParticles)
//        Component.onDestruction: console.log("Destroying Pulsar Particle System " + pulsarShotParticles)
    }

    ParticleGroup{
        id: sandaarParticleGroup
        name: "sandaarTarget"
        system: pulsarShotParticles
        onEntered:{
            //console.log("Sandaar was SHOT DOWN!");
            enemyWaveObject.sandaarDestroy();
        }

//        Component.onCompleted:{
//            console.log( "Creating: Pulsar ParticleGroup > " + pulsarParticleGroup);
//        }

//        Component.onDestruction:{
//            console.log( "Destroying: Pulsar ParticleGroup > " + pulsarParticleGroup);
//        }
    }

    ParticleSystem {
        id: enemyShotParticles
        anchors.fill: parent
        paused: !applicationActive

//        Component.onCompleted: console.log("Creating Sandaar Particle System " + enemyShotParticles)
//        Component.onDestruction: console.log("Destroying Sandaar Particle System " + enemyShotParticles)
    }

    ParticleGroup{
        id: pulsarParticleGroup
        name: "pulsarTarget"
        system: enemyShotParticles
        onEntered:{
//            console.log("Parallax Pulsar was SHOT DOWN!")
            parallaxShipObject.parallaxDestroy();
        }

//        Component.onCompleted:{
//            console.log( "Creating: Pulsar ParticleGroup > " + pulsarParticleGroup);
//        }

//        Component.onDestruction:{
//            console.log( "Destroying: Pulsar ParticleGroup > " + pulsarParticleGroup);
//        }
    }

    onParallaxPulsarBlasted:{

        pulsarLives--;

        if(pulsarLives > 0){
//            console.log("Parallax Blasted, lives left: " + pulsarLives);

            if(pulsarLives == (pulsarLives-1)){
                ppulsarLivesTimer.interval=0
            }
            else{
                ppulsarLivesTimer.interval=3000
            }

//            console.log("ppulsarLivesTimer.interval: " + ppulsarLivesTimer.interval)

            ppulsarLivesTimer.restart()
        }
//        else{
//            console.log("Parallax Blasted, no more lives - Game Over!");
//        }

    }

    onReceiveWaveTotalDelay: {
        enemyWaveTotalDelay=totalDelay;
        //console.log("@FirstPage > " + enemyWaveTotalDelay);
        enemyShotParticles.reset();
    }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("Show Page 2")
                onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
        }
    }

    Timer{
        id: waveGenTimer
        triggeredOnStart: true
        interval: enemyWaveTotalDelay
        running: applicationActive
        repeat: true
        onTriggered: {
            enemyWaveObject = enemyWaveComponent.createObject(page,{"objectName": "enemyWave","sandaarShotSys":enemyShotParticles,"pulsarShotSystem":pulsarShotParticles,"sandaarHitAreaGoalState":true});
            enemyWaveCounter++;
//            console.log("created the enemy Wave " + enemyWaveObject.objectName);
        }
    }

    Timer{
        id: ppulsarLivesTimer
        running: applicationActive
        repeat: false
        //interval: 3000
        onTriggered:{
            parallaxShipObject = parallaxShipComponent.createObject(page,{"objectName":"parallaxPulsar","sandaarShotSystem":enemyWaveObject.sandaarShotSys});
//            console.log("Parallax Regenerated!");
            pulsarShotParticles.reset();

        }
    }

    Component.onCompleted:
    {
        enemyWaveComponent = Qt.createComponent("../components/EnemyWave.qml");
        parallaxShipComponent = Qt.createComponent("../components/PPulsarHolder.qml");
    }

    onEnemyShipXchanged:{
        if(parallaxShipObject){
            parallaxShipObject.enemyShipX=enemyShipCurrentX;
            parallaxShipObject.enemyShipVisible=enemyShipCurrentVisibility;
            parallaxShipObject.pulsarCheckCollision();
        }
    }

    onEnemyShipYchanged:{
        if(parallaxShipObject){
            parallaxShipObject.enemyShipY=enemyShipCurrentY;
            parallaxShipObject.enemyShipVisible=enemyShipCurrentVisibility;
            parallaxShipObject.pulsarCheckCollision();
        }
    }


    Text{
        id: pulsarLiveCounter
        text: pulsarLives > 0 ? "PP Lives: " + pulsarLives : "Game Over!"
        color: "white"
        rotation: -90
        y: parent.height-pulsarLiveCounter.width
        x: parent.width-pulsarLiveCounter.width
    }

    Text{
        id: scoreCounter
        text: "Score: " + gameScore
        color: "white"
        rotation: -90
        y: pulsarLiveCounter.width
        x: parent.width-pulsarLiveCounter.width
    }
}
