import QtQuick 2.0

Rectangle {
    id: canvas
    width: page.width
    height: page.height
    color: "black"

    property int initialRunDuration : 30000


    Image {
        id: image2
        source: "qrc:///images/background002.jpg"
        fillMode: Image.PreserveAspectFit
        smooth: true

        PropertyAnimation on y{
            id: img2run
            running: Qt.application.active
            duration: initialRunDuration*2
            from: -canvas.height
            to: canvas.height
        }

        onYChanged: {
            if(Math.floor(y) == 0){
                //console.log("resetting image1");
                img1run.from=-canvas.height;
                img1run.duration=initialRunDuration*2;
                img1run.restart();
            }
        }
    }

    Image {
        id: image1
        source: "qrc:///images/background001.jpg"
        fillMode: Image.PreserveAspectFit
        smooth: true

        PropertyAnimation on y{
            id: img1run
            running: Qt.application.active
            duration: initialRunDuration
            from: 0
            to: canvas.height
        }

        onYChanged: {
            if(Math.floor(y) == 0){
                //console.log("resetting image2");
                img2run.duration=initialRunDuration*2;
                img2run.restart();
            }
        }
    }

    Image{
        id: planet1
        source: "qrc:///images/planet001.png"
        x: canvas.width*0.0005

        PropertyAnimation on y{
            id: planet1run
            running: Qt.application.active
            duration: initialRunDuration*3
            from: -canvas.height
            to: canvas.height*1.5
            loops: Animation.Infinite
        }

    }

    Image{
        id: planet2
        source: "qrc:///images/planet002.png"
        x: canvas.width*0.5

        PropertyAnimation on y{
            id: planet2run
            running: Qt.application.active
            duration: initialRunDuration*6
            from: -canvas.height*2.2
            to: canvas.height*2.2
            loops: Animation.Infinite
        }
    }

    Image{
        id: asteroids1
        source: "qrc:///images/asteroids001.png"
        x: canvas.width*0.007

        PropertyAnimation on y{
            id: asteroids001run
            running: Qt.application.active
            duration: initialRunDuration/1.5
            from: -canvas.height
            to: canvas.height
            loops: Animation.Infinite
        }
    }

    Image{
        id: asteroids2
        source: "qrc:///images/asteroids002.png"
        x: canvas.width*0.5

        PropertyAnimation on y{
            id: asteroids002run
            running: Qt.application.active
            duration: initialRunDuration/3
            from: -canvas.height*1.2
            to: canvas.height*1.2
            loops: Animation.Infinite
        }
    }
}
