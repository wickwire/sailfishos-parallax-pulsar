import QtQuick 2.0

Timer{
    id: sandaarWaveTimer
    interval: waveShipDelay*index
    running: true
    repeat: false
    onTriggered: {
        waveCounter+=1;
        sandaarPath.running=true;
    }

    Component.onCompleted:{
        console.log("Creating Enemy Wave Timer " + sandaarWaveTimer);
    }

    Component.onDestruction:{
        console.log("Destroying Enemy Shot " + sandaarWaveTimer);
    }
}
