#include "parallaxweapon.h"
#include "parallaxcontrols.h"

ParallaxWeapon::ParallaxWeapon(QObject *parent) :
    QObject(parent),valProxim(false)
{
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
    //qDebug() << "C++ Proxim Signal working..." << valProxim;
    emit finished();
    return valProxim;
}


void ParallaxWeapon::stopProximitySensor(){
    proxim->stop();
}

void ParallaxWeapon::startProximitySensor(){
    proxim->start();
    qDebug() << "proxim data rate: " << proxim->dataRate();
}

void ParallaxWeapon::getAppState(bool appState){
    //qDebug() << "C++: Application is active? " << appState;

    if(appState == true){
        startProximitySensor();
    }
    else{
       stopProximitySensor();
    }
}
