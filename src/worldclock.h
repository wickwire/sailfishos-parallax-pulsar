#ifndef WORLDCLOCK_H
#define WORLDCLOCK_H

#include <QObject>
#include <QTimer>
#include <QDebug>
#include <QThread>

class WorldClock : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString testTimer READ testTimer NOTIFY testTimerChanged)
public:
    explicit WorldClock(QObject *parent = 0);

    QString testTimer() const
    { return m_testTimer; }

private:
    QString m_testTimer;
signals:
    void testTimerChanged();
public slots:
    void fireTimer();
};

#endif // WORLDCLOCK_H
