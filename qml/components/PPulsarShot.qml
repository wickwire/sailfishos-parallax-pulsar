import QtQuick 2.0

Rectangle{
    id: shot
    width: 18
    height: 6
    color: "red"
    visible: false
    property double squareInitX : PPulsarShipXPos-PPulsarShipHeight/2
    property double squareInitY
    y: shot.squareInitY
    Connections {
        target: qmlWeaponTrigger
        onValProximChanged: {
            if(qmlWeaponTrigger.valProxim == true){
                shot.squareInitY = square.y+square.width/2
                shot.visible = true;
                shotFired.running = true;
                shotFired.running = true;
                shotFired.running = true;
            }else{
                shotFired.running = false;
            }

            console.log(qmlWeaponTrigger.valProxim + ":" + shot.squareInitX + shot.squareInitY);
        }
    }

    PropertyAnimation on x{
        id: shotFired
        from: shot.squareInitX
        to: 0-shot.width
        duration: (Math.abs(((shot.width)-shot.squareInitX))/page.width*300)
        running: false
    }
}
