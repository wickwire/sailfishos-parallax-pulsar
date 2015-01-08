#ifndef PARALLAXCONTROLSFILTER_H
#define PARALLAXCONTROLSFILTER_H

#include <QObject>
#include <QAccelerometerReading>
#include <QAccelerometerFilter>
#include <QTime>
#include <QDebug>


class ParallaxControlsFilter : public QObject, public QAccelerometerFilter
{
    Q_OBJECT
    qreal prevX;
    qreal prevY;
    qreal prevZ;
    bool havePrev;
    QTime accelTime;
    int accelTimeDiff;
    qreal integralX;
    qreal integralY;
    qreal integralZ;

    qreal prevXdiff;
    qreal prevYdiff;
    qreal prevZdiff;

public:

    explicit ParallaxControlsFilter(QObject *parent = 0);

    bool filter(QAccelerometerReading *reading)
    {
        accelTimeDiff = accelTime.restart();

        if(accelTimeDiff == 0){
            accelTimeDiff = 20;
        }
        //qDebug() << "accelTimeDiff: " << accelTimeDiff;

        // Smooth out the reported values.  Large changes are applied as-is,
        // and small jitters smooth to the rest position.
        if (havePrev) {
            qreal xdiff = reading->x() - prevX;
            qreal ydiff = reading->y() - prevY;
            qreal zdiff = reading->z() - prevZ;



////#define threshold 0.196133f
//#define threshold 0.8f
//            if (qAbs(xdiff) < threshold && qAbs(ydiff) < threshold && qAbs(zdiff) < threshold) {
//                //reading->setX(prevX + xdiff * 0.1f);
//                xdiff = xdiff * 0.1f;
//                ydiff = ydiff * 0.1f;
//                zdiff = zdiff * 0.1f;
//                //reading->setY(prevY + ydiff * 0.1f);
//                //reading->setZ(prevZ + zdiff * 0.1f);
//            }

           integralX=integralX+xdiff*accelTimeDiff;
           integralY=integralY+ydiff*accelTimeDiff;
           integralZ=integralZ+zdiff*accelTimeDiff;

           qreal derivativeX=(xdiff-prevXdiff)/accelTimeDiff;
           qreal derivativeY=(ydiff-prevYdiff)/accelTimeDiff;
           qreal derivativeZ=(zdiff-prevZdiff)/accelTimeDiff;

            #define Kp 0.005
            #define Ki 0.002
            #define Kd 0.00002

           reading->setX(Kp*xdiff+Ki*integralX+Kd*derivativeX);
           reading->setY(Kp*ydiff+Ki*integralY+Kd*derivativeY);
           reading->setZ(Kp*zdiff+Ki*integralZ+Kd*derivativeZ);


           prevXdiff = xdiff;
           prevYdiff = ydiff;
           prevZdiff = zdiff;

           //qDebug() << "IntegralX: " << integralX << " DerivativeX: " << derivativeX << " xdiff: " << xdiff;

        }
        prevX = reading->x();
        prevY = reading->y();
        prevZ = reading->z();
        havePrev = true;
        return true;
    }

signals:

public slots:

};

#endif // PARALLAXCONTROLSFILTER_H
