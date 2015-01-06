#include "parallaxweapon.h"
#include "parallaxcontrols.h"

ParallaxWeapon::ParallaxWeapon(QObject *parent) :
    QObject(parent)
{
    valProxim = false;

    proxim = new QProximitySensor(this);
    connect(proxim, SIGNAL(readingChanged()),
            this, SLOT(UpdateProximitySensor()));

    proxim->start();
}

void ParallaxWeapon::UpdateProximitySensor()
{
    QProximityReading *reading = proxim->reading();
    valProxim = reading->property("close").value<bool>();
    //qDebug() << "Near..." << valProxim;
    emit valProximChanged(valProxim);
}

bool ParallaxWeapon::getValProxim(){
    qDebug() << "C++ Proxim Signal working..." << valProxim;
    emit finished();
    return valProxim;
}
