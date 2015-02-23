import QtQuick 2.0
import QtMultimedia 5.0

Audio {
    id: playMusic
    autoLoad: true
    autoPlay: true
    loops: Animation.Infinite
    source: "../soundtracks/level.001.mp3"
    volume: 0.1
}
