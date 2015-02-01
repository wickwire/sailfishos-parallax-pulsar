import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle{
    id: root
    width: page.width
    height: page.height
    color: "transparent"

    property int waveShipDelay : 1000
    property int waveDelay: 2000
    property int totalShips : 10

    property int waveLastIndex : enemyShipGenerator.index

    signal waveDestroy

    Repeater{

        id: enemyShipGenerator
        model: totalShips

        Item{
            id: enemyShotHolder

            EnemyShip{
                id: sandaarShip
            }


            EnemyWavePath{
                id: sandaarPath
                running: true
            }
        }

        onCountChanged: {
            console.log("waveLastIndex > " + waveLastIndex)
        }
    }


    onWaveDestroy: {
        console.log("Destroying: Wave > " + root);
        root.destroy();
    }
}
