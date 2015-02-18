import QtQuick 2.0
import QtGraphicalEffects 1.0

Glow {
    id: ppulsarSvgGlow
    anchors.fill: ppulsarSvg
    radius: 8
    samples: 16
    color: "white"
    source: ppulsarSvg
    visible: pulsarInvencibility

    SequentialAnimation{

        running: pulsarInvencibility
        loops: Animation.Infinite

        NumberAnimation{
            target: ppulsarSvgGlow
            property: "spread"
            from: 0
            to: 0.8
            duration: 200
        }

        NumberAnimation{
            target: ppulsarSvgGlow
            property: "spread"
            from: 0.8
            to: 0
            duration: 200
        }
    }
}
