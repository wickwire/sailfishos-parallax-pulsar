import QtQuick 2.0

Item {
    width: page.width
    height: page.height

    Rectangle{
        anchors.centerIn: parent
        rotation: -90
        color: "red"
        opacity: 1
        width: parent.height/3
        height: parent.width/3

        Text{
            id: gameoverTag
            width: parent.width
            height: parent.height/2
            text: "Game Over!"
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop
        }

        Text{
            width: parent.width/2
            height: parent.height
            text: "Restart"
            color: "white"
            anchors.left: parent.left
            anchors.top: gameoverTag.bottom
            horizontalAlignment: Text.AlignHCenter

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    console.log("Restart Game");
                    appGoingForGameRestart();
                }
            }
        }

        Text{
            width: parent.width/2
            height: parent.height
            text: "Main Menu"
            color: "white"
            anchors.right: parent.right
            anchors.top: gameoverTag.bottom
            horizontalAlignment: Text.AlignHCenter

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    console.log("HomePage");
                    appGoingForHomePage();
                }
            }
        }
    }
}
