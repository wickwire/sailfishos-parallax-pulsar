#ifndef PARALLAXCONTROLS_H
#define PARALLAXCONTROLS_H

#include <QObject>
#include <QTimer>
#include <QDebug>
#include <QAccelerometer>
#include <QAccelerometerReading>
//#include <QProximitySensor>
//#include <QProximityReading>
#include "parallaxcontrolsfilter.h"

class ParallaxControls : public QObject
{
    Q_PROPERTY(qreal valAccelX READ getValAccelX NOTIFY valAccelXChanged)
    Q_PROPERTY(qreal valAccelY READ getValAccelY NOTIFY valAccelYChanged)
    Q_PROPERTY(qreal valAccelZ READ getValAccelZ NOTIFY valAccelZChanged)
    //Q_PROPERTY(bool valProxim READ getValProxim NOTIFY valProximChanged)
    Q_OBJECT
public:
    explicit ParallaxControls(QObject *parent = 0);
    //QTimer *timer;
    QAccelerometer *accel;
    qreal valAccelX;
    qreal valAccelY;
    qreal valAccelZ;
    //QProximitySensor *proxim;
    //bool valProxim;
    int screenWidth;
    int screenHeight;

signals:
    qreal valAccelXChanged(qreal valAccelX);
    qreal valAccelYChanged(qreal valAccelY);
    qreal valAccelZChanged(qreal valAccelZ);
    //bool valProximChanged(bool valProxim);
    void finished();

public slots:
    //void MyTimerSlot();
    void UpdateAccelerometer();
    //void UpdateProximitySensor();
    void CloseSensors();
    void getAppState();

    qreal getValAccelX();
    qreal getValAccelY();
    qreal getValAccelZ();

    //bool getValProxim();
};

#endif // PARALLAXCONTROLS_H
