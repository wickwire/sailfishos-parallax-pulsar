#ifndef PARALLAXCONTROLS_H
#define PARALLAXCONTROLS_H

#include <QObject>
#include <QTimer>
#include <QDebug>
#include <QAccelerometer>
#include <QAccelerometerReading>

class ParallaxControls : public QObject
{
    Q_OBJECT
public:
    explicit ParallaxControls(QObject *parent = 0);
    //QTimer *timer;
    QAccelerometer *accel;

signals:

public slots:
    //void MyTimerSlot();
    void UpdateAccelerometer();
};

#endif // PARALLAXCONTROLS_H
