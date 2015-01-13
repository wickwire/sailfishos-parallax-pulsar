#ifndef PARALLAXCONTROLS_H
#define PARALLAXCONTROLS_H

#include <QObject>
#include <QTimer>
#include <QDebug>
#include <QAccelerometer>
#include <QAccelerometerReading>
#include "parallaxcontrolsfilter.h"

class ParallaxControls : public QObject
{
    Q_PROPERTY(qreal valAccelX READ getValAccelX NOTIFY valAccelXChanged)
    Q_PROPERTY(qreal valAccelY READ getValAccelY NOTIFY valAccelYChanged)
    Q_PROPERTY(qreal valAccelZ READ getValAccelZ NOTIFY valAccelZChanged)
    Q_OBJECT
public:
    explicit ParallaxControls(QObject *parent = 0);
    QAccelerometer *accel;
    qreal valAccelX;
    qreal valAccelY;
    qreal valAccelZ;
    int screenWidth;
    int screenHeight;

signals:
    qreal valAccelXChanged(qreal valAccelX);
    qreal valAccelYChanged(qreal valAccelY);
    qreal valAccelZChanged(qreal valAccelZ);
    void finished();

public slots:
    void UpdateAccelerometer();
    void startAccelerometer();
    void stopAccelerometer();
    void getAppState(bool appState);

    qreal getValAccelX();
    qreal getValAccelY();
    qreal getValAccelZ();
};

#endif // PARALLAXCONTROLS_H
