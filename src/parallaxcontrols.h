#ifndef PARALLAXCONTROLS_H
#define PARALLAXCONTROLS_H

#include <QObject>
#include <QTimer>
#include <QDebug>
#include <QAccelerometer>
#include <QAccelerometerReading>

class ParallaxControls : public QObject
{
    Q_PROPERTY(qreal valAccelX READ getValAccelX NOTIFY valAccelXChanged)
    Q_PROPERTY(qreal valAccelY READ getValAccelY NOTIFY valAccelYChanged)
    Q_PROPERTY(qreal valAccelZ READ getValAccelZ NOTIFY valAccelZChanged)
    Q_OBJECT
public:
    explicit ParallaxControls(QObject *parent = 0);
    //QTimer *timer;
    QAccelerometer *accel;
    qreal valAccelX;
    qreal valAccelY;
    qreal valAccelZ;

signals:
    qreal valAccelXChanged(qreal valAccelX);
    qreal valAccelYChanged(qreal valAccelY);
    qreal valAccelZChanged(qreal valAccelZ);
    void finished();

public slots:
    //void MyTimerSlot();
    void UpdateAccelerometer();

    qreal getValAccelX();
    qreal getValAccelY();
    qreal getValAccelZ();
};

#endif // PARALLAXCONTROLS_H
