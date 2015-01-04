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
import QtSensors 5.0


Page {
    id: page

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
            PageHeader {
                title: qsTr("UI Template")
            }
            Label {
                x: Theme.paddingLarge
                text: qsTr("Hello Sailors")
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }
        }
    }

    ProximitySensor {
        id: proxi
        active: true
    }

    Accelerometer{
        id: xMeter
        active: false
    }

    Text {
        id: proxitext
        height: 30
        verticalAlignment: Text.AlignVCenter
        color: "white"
        text: "Proximity: " +
              (proxi.active ? (proxi.reading.near ? "Near" : "Far") : "Unknown")
    }

//    Text {
//        id: xAccel
//        height: 100
//        verticalAlignment: Text.AlignVCenter
//        color: "white"
//        text: "xAccel: " + xMeter.reading.x.toFixed(1)
//    }

//    Text {
//        id: yAccel
//        height: 150
//        verticalAlignment: Text.AlignVCenter
//        color: "white"
//        text: "yAccel: " + xMeter.reading.y.toFixed(1)
//    }

//    Text {
//        id: zAccel
//        height: 200
//        verticalAlignment: Text.AlignVCenter
//        color: "white"
//        text: "zAccel: " + xMeter.reading.z.toFixed(1)
//    }

    //phone with screen facing up
//    Rectangle{
//        id: square
//        width:50
//        height: 50
//        color: "yellow"
//        x: -(xMeter.reading.x.toFixed(1)*100 - parent.width/2 + width/2)
//        y: (xMeter.reading.y.toFixed(1)*100 + parent.height/2 - height/2)
//    }

    //phone with screen facing sideways
//    Rectangle{
//      id: square
//      width:50
//      height: 50
//      color: "yellow"
//      x: -(xMeter.reading.z.toFixed(1)*100 - parent.width/2 + width/2)
//      y: (xMeter.reading.y.toFixed(1)*100 + parent.height/2 - height/2)
//    }
}


