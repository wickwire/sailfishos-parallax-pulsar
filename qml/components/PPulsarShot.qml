import QtQuick 2.0
import QtQuick.Particles 2.0

//Rectangle{

//    id: shot
//    width: 18
//    height: 6
//    color: "red"
//    visible: false
//    property double squareInitX
//    property double squareInitY
//    property double squareY
//    y: shot.squareInitY
//    Connections {
//        target: qmlWeaponTrigger
//        onValProximChanged: {
//            if(qmlWeaponTrigger.valProxim == true){
//                shot.squareInitY = squareY
//                shot.visible = true;
//                shotFired.running = true;
//            }else{
//                shotFired.running = false;
//            }
//            //console.log(qmlWeaponTrigger.valProxim + ":" + shot.squareInitX + shot.squareInitY);
//        }
//    }

//    PropertyAnimation on x{
//        id: shotFired
//        from: shot.squareInitX
//        to: 0-shot.width
//        duration: (Math.abs(((shot.width)-shot.squareInitX))/page.width*300)
//        running: false
//    }
//}

ParticleSystem {

        property double squareInitX
        property double squareInitY
        property double squareY

    id: root
    width: page.width
    height: page.height

    Rectangle {
        z: -1
        anchors.fill: parent
        color: "transparent"
        Text {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 14
            color: "white"
            text: "It's all in the fragment shader."
        }
    }

    Emitter {

        PointDirection{
            id: velocityStop
            x: 0
            y: 0
        }

        PointDirection{
            id: velocityStart
            x: root.width/10
            y: root.height/10
        }

        PointDirection {
            id: accelStop
            x: 0
            y: 0
            xVariation: 0
            yVariation: 0
        }

        PointDirection {
            id: accelStart
            x: -root.width/40
            y: -root.height/40
            xVariation: -root.width/20
            yVariation: -root.width/20
        }

        id: partEmitter
        emitRate: 400
        lifeSpan: 8000
        size: 24
        sizeVariation: 16
        velocity: velocityStop
        acceleration: accelStop

            Connections {
                target: qmlWeaponTrigger
                onValProximChanged: {
                    if(qmlWeaponTrigger.valProxim == true){
                        partEmitter.velocity = velocityStart;
                        partEmitter.acceleration = accelStart;
                        console.log("start shooting");
                    }else{
                        partEmitter.velocity = velocityStop;
                        partEmitter.acceleration = accelStop;
                        console.log("stop shooting");
                    }
                    //console.log(qmlWeaponTrigger.valProxim + ":" + shot.squareInitX + shot.squareInitY);
                }
            }


        //velocity: PointDirection {x: root.width/10; y: root.height/10;}
        //velocity: pointDirStart
        //acceleration: PointDirection {x: -root.width/40; y: -root.height/40; xVariation: -root.width/20; yVariation: -root.width/20}
    }

    CustomParticle {
        vertexShader:"
            uniform lowp float qt_Opacity;
            varying lowp float fFade;
            varying highp vec2 fPos;

            void main() {
                qt_TexCoord0 = qt_ParticleTex;
                highp float size = qt_ParticleData.z;
                highp float endSize = qt_ParticleData.w;

                highp float t = (qt_Timestamp - qt_ParticleData.x) / qt_ParticleData.y;

                highp float currentSize = mix(size, endSize, t * t);

                if (t < 0. || t > 1.)
                currentSize = 0.;

                highp vec2 pos = qt_ParticlePos
                - currentSize / 2. + currentSize * qt_ParticleTex          // adjust size
                + qt_ParticleVec.xy * t * qt_ParticleData.y         // apply velocity vector..
                + 0.5 * qt_ParticleVec.zw * pow(t * qt_ParticleData.y, 2.);

                gl_Position = qt_Matrix * vec4(pos.x, pos.y, 0, 1);

                highp float fadeIn = min(t * 20., 1.);
                highp float fadeOut = 1. - max(0., min((t - 0.75) * 4., 1.));

                fFade = fadeIn * fadeOut * qt_Opacity;
                fPos = vec2(pos.x/320., pos.y/480.);
            }
        "
        //! [0]
        fragmentShader: "
            varying highp vec2 fPos;
            varying lowp float fFade;
            varying highp vec2 qt_TexCoord0;
            void main() {//*2 because this generates dark colors mostly
                highp vec2 circlePos = qt_TexCoord0*2.0 - vec2(1.0,1.0);
                highp float dist = length(circlePos);
                highp float circleFactor = max(min(1.0 - dist, 1.0), 0.0);
                gl_FragColor = vec4(fPos.x*2.0 - fPos.y, fPos.y*2.0 - fPos.x, fPos.x*fPos.y*2.0, 0.0) * circleFactor * fFade;
            }"
        //! [0]

    }
}
