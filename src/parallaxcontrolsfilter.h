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
//#define threshold 0.196133f
//         #define threshold 20.0f
//            if (qAbs(xdiff) < threshold && qAbs(ydiff) < threshold && qAbs(zdiff) < threshold) {
//                reading->setX(prevX + xdiff * 0.008f);
//                reading->setY(prevY + ydiff * 0.008f);
//                reading->setZ(prevZ + zdiff * 0.008f);
//            }

           integralX=integralX+xdiff*accelTimeDiff;
           integralY=integralY+ydiff*accelTimeDiff;
           integralZ=integralZ+zdiff*accelTimeDiff;

           qreal derivativeX=(xdiff-prevXdiff)/accelTimeDiff;
           qreal derivativeY=(ydiff-prevYdiff)/accelTimeDiff;
           qreal derivativeZ=(zdiff-prevZdiff)/accelTimeDiff;

            #define Kp 0.005
            #define Ki 0.003
            #define Kd 0.00002

           reading->setX(Kp*xdiff+Ki*integralX+Kd*derivativeX);
           reading->setY(Kp*ydiff+Ki*integralY+Kd*derivativeY);
           reading->setZ(Kp*zdiff+Ki*integralZ+Kd*derivativeZ);


           prevXdiff = xdiff;
           prevYdiff = ydiff;
           prevZdiff = zdiff;

           qDebug() << "IntegralX: " << integralX << " DerivativeX: " << derivativeX << " xdiff: " << xdiff;

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
