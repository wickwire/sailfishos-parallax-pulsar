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

    accel = new QAccelerometer(this);
    connect(accel, SIGNAL(readingChanged()),
            this, SLOT(UpdateAccelerometer()));

    accel->start();
}

//void ParallaxControls::MyTimerSlot()
//{
//    qDebug() << "Timer...";
//}

void ParallaxControls::UpdateAccelerometer()
{
    QAccelerometerReading *reading = accel->reading();
    qreal x = reading->property("x").value<qreal>();
    qreal y = reading->property("y").value<qreal>();
    qreal z = reading->property("z").value<qreal>();
    //qreal y = reading->value(1).value<qreal>();

    qDebug() << "Accel..." << x << "+" << y << "+" << z;
}
