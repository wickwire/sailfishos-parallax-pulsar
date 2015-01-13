#ifndef PARALLAXWEAPON_H
#define PARALLAXWEAPON_H

#include <QObject>
#include <QDebug>
#include <QProximitySensor>
#include <QProximityReading>

class ParallaxWeapon : public QObject
{
    Q_PROPERTY(bool valProxim READ getValProxim NOTIFY valProximChanged)
    Q_OBJECT
public:
    explicit ParallaxWeapon(QObject *parent = 0);
    QProximitySensor *proxim;
    bool valProxim;
signals:
    bool valProximChanged(bool valProxim);
    void finished();

public slots:
    void UpdateProximitySensor();
    bool getValProxim();
};

#endif // PARALLAXWEAPON_H
