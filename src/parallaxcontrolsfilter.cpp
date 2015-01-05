#include "parallaxcontrolsfilter.h"

ParallaxControlsFilter::ParallaxControlsFilter(QObject *parent) :
    QObject(parent)
  , QAccelerometerFilter()
  , prevX(0)
  , prevY(0)
  , prevZ(0)
  , havePrev(false)
{
}
