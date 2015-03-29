#include "worldclock.h"

WorldClock::WorldClock(QObject *parent) :
    QObject(parent)
{
    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(fireTimer()));
    //qDebug() << "Firing QTimer at WorldClock!";
    timer->start(10000);
}

void WorldClock::fireTimer(){
    emit testTimerChanged();
    //qDebug() << "Thread id from fireTimer: " << QThread::currentThreadId();
}
