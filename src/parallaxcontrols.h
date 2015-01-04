#ifndef PARALLAXCONTROLS_H
#define PARALLAXCONTROLS_H

#include <QObject>
#include <QTimer>
#include <QDebug>
#include <QAccelerometer>
#include <QAccelerometerReading>

class ParallaxControls : public QObject
{
    Q_PROPERTY(qreal valAccelX READ getValAccelX NOTIFY valAccelXUpdated)
    Q_PROPERTY(qreal valAccelY READ getValAccelY NOTIFY valAccelYUpdated)
    Q_PROPERTY(qreal valAccelZ READ getValAccelZ NOTIFY valAccelZUpdated)
    Q_OBJECT
public:
    explicit ParallaxControls(QObject *parent = 0);
    //QTimer *timer;
    QAccelerometer *accel;
    qreal valAccelX;
    qreal valAccelY;
    qreal valAccelZ;

signals:
    qreal valAccelXUpdated(qreal valAccelX);
    qreal valAccelYUpdated(qreal valAccelY);
    qreal valAccelZUpdated(qreal valAccelZ);
    void finished();

public slots:
    //void MyTimerSlot();
    void UpdateAccelerometer();

    qreal getValAccelX();
    qreal getValAccelY();
    qreal getValAccelZ();
};

#endif // PARALLAXCONTROLS_H
