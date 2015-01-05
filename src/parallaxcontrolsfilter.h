#ifndef PARALLAXCONTROLSFILTER_H
#define PARALLAXCONTROLSFILTER_H

#include <QObject>
#include <QAccelerometerReading>
#include <QAccelerometerFilter>


class ParallaxControlsFilter : public QObject, public QAccelerometerFilter
{
    Q_OBJECT
    qreal prevX;
    qreal prevY;
    qreal prevZ;
    bool havePrev;

public:

    explicit ParallaxControlsFilter(QObject *parent = 0);

    bool filter(QAccelerometerReading *reading)
    {
        // Smooth out the reported values.  Large changes are applied as-is,
        // and small jitters smooth to the rest position.
        if (havePrev) {
            qreal xdiff = reading->x() - prevX;
            qreal ydiff = reading->y() - prevY;
            qreal zdiff = reading->z() - prevZ;
//#define threshold 0.196133f
         #define threshold 1000.0f
            if (qAbs(xdiff) < threshold && qAbs(ydiff) < threshold && qAbs(zdiff) < threshold) {
                reading->setX(prevX + xdiff * 0.008f);
                reading->setY(prevY + ydiff * 0.008f);
                reading->setZ(prevZ + zdiff * 0.008f);
            }
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
