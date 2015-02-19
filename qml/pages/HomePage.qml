import QtQuick 2.0
import Qt3D 2.0
import "../components"
import Sailfish.Silica 1.0

Page {
    objectName: "initialPage"
    id: page

    Rectangle {
        id: root
        color: "grey"
        width: page.width
        height: page.height

        Image{
            anchors.fill: parent
            source: "qrc:///images/space.jpg"
        }

        Viewport {
            id: view
            anchors.fill: parent
            blending: true

            navigation: false
            camera: Camera {
                id: viewCamera
                eye: cameraVectorStandartLeft

                property variant cameraVectorStandartLeft:    Qt.vector3d(20,20,20)

            }

            Parallax3D {
                id: parallax
            }
        }
    }

    Button{
        anchors.fill: parent
        opacity: 0
        onPressed: {
            console.log("pressed!");
            pageStack.push("FirstPage.qml");
        }
    }
}

