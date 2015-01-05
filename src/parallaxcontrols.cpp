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

    valProxim = false;
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

    accel->start();

    proxim = new QProximitySensor(this);
    connect(proxim, SIGNAL(readingChanged()),
            this, SLOT(UpdateProximitySensor()));

    proxim->start();

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
    return valAccelX;
    emit finished();
}

qreal ParallaxControls::getValAccelY(){
    //qDebug() << "C++ Y Signal working..." << valAccelY;
    return valAccelY;
    emit finished();
}

qreal ParallaxControls::getValAccelZ(){
    //qDebug() << "C++ Z Signal working..." << valAccelZ;
    return valAccelZ;
    emit finished();
}


void ParallaxControls::UpdateProximitySensor()
{
    QProximityReading *reading = proxim->reading();
    valProxim = reading->property("close").value<bool>();
    qDebug() << "Near..." << valProxim;
    emit valProximChanged(valProxim);
}

bool ParallaxControls::getValProxim(){
    qDebug() << "C++ Proxim Signal working..." << valProxim;
    return valProxim;
    emit finished();
}

void ParallaxControls::CloseSensors(){
    accel->stop();
    proxim->stop();
}
