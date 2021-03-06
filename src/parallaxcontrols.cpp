#include "parallaxcontrols.h"

ParallaxControls::ParallaxControls(QObject *parent) :
    QObject(parent)
{
    valAccelX = 0;
    valAccelY = 0;
    valAccelZ = 0;

    accel = new QAccelerometer(this);
    connect(accel, SIGNAL(readingChanged()),
            this, SLOT(UpdateAccelerometer()));

    connect(this, SIGNAL(valAccelXChanged(qreal)),
            this, SLOT(getValAccelX()));

    connect(this, SIGNAL(valAccelYChanged(qreal)),
            this, SLOT(getValAccelY()));

    connect(this, SIGNAL(valAccelZChanged(qreal)),
            this, SLOT(getValAccelZ()));

    accel->addFilter(new ParallaxControlsFilter(this));

    accel->start();
    accel->stop();
    accel->start();
}

void ParallaxControls::UpdateAccelerometer()
{
    QAccelerometerReading *reading = accel->reading();
    valAccelX = reading->property("x").value<qreal>();
    valAccelY = reading->property("y").value<qreal>();
    valAccelZ = reading->property("z").value<qreal>();
    //qreal y = reading->value(1).value<qreal>();

    //qDebug() << "Accel..." << valAccelX << "+" << valAccelY << "+" << valAccelZ;

    emit valAccelXChanged(valAccelX);
    emit valAccelYChanged(valAccelY);
    emit valAccelZChanged(valAccelX);
}

qreal ParallaxControls::getValAccelX(){
    //qDebug() << "C++ X Signal working..." << valAccelX;
    int parallaxX = -(valAccelX*200-screenWidth/2+50/2);
    if( parallaxX > screenWidth-50){
        parallaxX = screenWidth-50;
    }
    else if( parallaxX < 0){
        parallaxX = 0;
    }
    valAccelX = parallaxX;
    emit finished();
    return valAccelX;
}

qreal ParallaxControls::getValAccelY(){
    //qDebug() << "C++ Y Signal working..." << valAccelY;
    int parallaxY = (valAccelY*200+screenHeight/2-50/2);
    if(parallaxY > screenHeight-50){
        parallaxY = screenHeight-50;
    }
    else if(parallaxY < 0){
        parallaxY = 0;
    }
    valAccelY = parallaxY;
    emit finished();
    return valAccelY;
}

qreal ParallaxControls::getValAccelZ(){
    //qDebug() << "C++ Z Signal working..." << valAccelZ;
    int parallaxZ = (valAccelZ*200-screenWidth/2+50/2);
    if(parallaxZ > screenWidth-50){
        parallaxZ = screenWidth-50;
    }
    else if(parallaxZ < 0){
        parallaxZ = 0;
    }
    valAccelZ = parallaxZ;
    emit finished();
    return valAccelZ;
}

void ParallaxControls::stopAccelerometer(){
    accel->stop();
}

void ParallaxControls::startAccelerometer(){
    accel->start();
    qDebug() << "accel data rate: " << accel->dataRate();
}

void ParallaxControls::getAppState(bool appState){
    qDebug() << "C++: Application is active? " << appState;

    if(appState == true){
        startAccelerometer();
    }
    else{
       stopAccelerometer();
    }
}
