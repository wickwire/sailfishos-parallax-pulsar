#include "parallaxcontrols.h"

ParallaxControls::ParallaxControls(QObject *parent) :
    QObject(parent)
{
//    // create a timer
//    timer = new QTimer(this);

//    // setup signal and slot
//    connect(timer, SIGNAL(timeout()),
//          this, SLOT(MyTimerSlot()));

//    // msec
//    timer->start(1000);

    //valProxim = false;
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

//    proxim = new QProximitySensor(this);
//    connect(proxim, SIGNAL(readingChanged()),
//            this, SLOT(UpdateProximitySensor()));

//    proxim->start();

}

//void ParallaxControls::MyTimerSlot()
//{
//    qDebug() << "Timer...";
//}

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
    int parallaxX = -(valAccelX*1000-screenWidth/2+50/2);
    if( parallaxX > screenWidth-50){
        parallaxX = screenWidth-50;
    }
    else if( parallaxX < 0){
        parallaxX = 0;
    }
    valAccelX = parallaxX;
    return valAccelX;
    emit finished();
}

qreal ParallaxControls::getValAccelY(){
    //qDebug() << "C++ Y Signal working..." << valAccelY;
    int parallaxY = (valAccelY*1000+screenHeight/2-50/2);
    if(parallaxY > screenHeight-50){
        parallaxY = screenHeight-50;
    }
    else if(parallaxY < 0){
        parallaxY = 0;
    }
    valAccelY = parallaxY;
    return valAccelY;
    emit finished();
}

qreal ParallaxControls::getValAccelZ(){
    //qDebug() << "C++ Z Signal working..." << valAccelZ;
    int parallaxZ = (valAccelZ*1000-screenWidth/2+50/2);
    if(parallaxZ > screenWidth-50){
        parallaxZ = screenWidth-50;
    }
    else if(parallaxZ < 0){
        parallaxZ = 0;
    }
    valAccelZ = parallaxZ;
    return valAccelZ;
    emit finished();
}


//void ParallaxControls::UpdateProximitySensor()
//{
//    QProximityReading *reading = proxim->reading();
//    valProxim = reading->property("close").value<bool>();
//    qDebug() << "Near..." << valProxim;
//    emit valProximChanged(valProxim);
//}

//bool ParallaxControls::getValProxim(){
//    qDebug() << "C++ Proxim Signal working..." << valProxim;
//    return valProxim;
//    emit finished();
//}

void ParallaxControls::CloseSensors(){
    accel->stop();
    //proxim->stop();
}
