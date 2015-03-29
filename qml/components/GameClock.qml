import QtQuick 2.0

Item{
    id: worldClock

    property string currentTimestamp

    signal fireStuff


    Timer{
        id: sandaarWaveTimer
        //interval: waveShipDelay*index
        interval: 2000
        running: true
        repeat: true

        signal launchWaveShip

        onTriggered: {
            currentTimestamp=new Date().toString();
            //console.log("Firing signal to EnemyWave! " + currentTimestamp);
            launchWaveShip();
        }

        onLaunchWaveShip: fireStuff()

        //    Component.onCompleted:{
        //        console.log("Creating Enemy Wave Timer " + sandaarWaveTimer);
        //    }

        //    Component.onDestruction:{
        //        console.log("Destroying Enemy Wave Timer " + sandaarWaveTimer);
        //    }
    }



}

