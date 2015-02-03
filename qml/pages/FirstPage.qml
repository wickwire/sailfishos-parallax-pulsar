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

    signal receiveWaveTotalDelay(int totalDelay)
    signal enemyShipXchanged(int enemyShipCurrentX)
    signal enemyShipYchanged(int enemyShipCurrentY)
    signal parallaxPulsarBlasted



    onParallaxPulsarBlasted:{
        if(pulsarLives > 0){
            pulsarLives--;
            console.log("Parallax Blasted, lives left: " + pulsarLives);
            ppulsarLivesTimer.restart()
        }
        else{
            console.log("Parallax Blasted, no more lives - Game Over!");
        }
    }

    onReceiveWaveTotalDelay: {
        enemyWaveTotalDelay=totalDelay;
        console.log("@FirstPage > " + enemyWaveTotalDelay);
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
            enemyWaveObject = enemyWaveComponent.createObject(page,{"objectName": "enemyWave2"});
            console.log("created the enemy Wave " + enemyWaveObject.objectName);
        }
    }

    Timer{
        id: ppulsarLivesTimer
        running: applicationActive
        repeat: false
        interval: 5000
        onTriggered:{
            parallaxShipObject = parallaxShipComponent.createObject(page,{"objectName":"parallaxPulsar"});
            console.log("Parallax Regenerated!");
        }
    }

    Component.onCompleted:
    {
        enemyWaveComponent = Qt.createComponent("../components/EnemyWave.qml");
        parallaxShipComponent = Qt.createComponent("../components/PPulsarHolder.qml");
        parallaxShotComponent = Qt.createComponent("../components/PPulsarShot.qml");
    }

    onEnemyShipXchanged:{
        if(parallaxShipObject){
            parallaxShipObject.enemyShipX=enemyShipCurrentX;
            parallaxShipObject.pulsarCheckCollision();
        }
    }

    onEnemyShipYchanged:{
        if(parallaxShipObject){
            parallaxShipObject.enemyShipY=enemyShipCurrentY;
            parallaxShipObject.pulsarCheckCollision();
        }
    }
}
