#include "parallaxcontrolsfilter.h"

ParallaxControlsFilter::ParallaxControlsFilter(QObject *parent) :
    QObject(parent)
  , QAccelerometerFilter()
  , prevX(0)
  , prevY(0)
  , prevZ(0)
  , havePrev(false)
{
    accelTime.start();

    integralX = 0;
    integralY = 0;
    integralZ = 0;
}
