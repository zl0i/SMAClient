#ifndef MAINWORKER_H
#define MAINWORKER_H

#include <QObject>
#include "serverworker.h"
#include "weatherworker.h"
#include "sensorworker.h"
#include "carworker.h"
#include "fieldworker.h"

class MainWorker : public QObject
{
    Q_OBJECT
public:
    explicit MainWorker(QObject *parent = nullptr);

    ServerWorker *serverWorker = new ServerWorker(this);
    SensorWorker *sensorWorker = new SensorWorker(this);
    CarWorker *carWorker = new CarWorker(this);
    FieldWorker *fieldWorker = new FieldWorker(this);
    WeatherWorker *weatherWorker = new WeatherWorker(this);

private:
    QTimer *weatherTimer = new QTimer;
signals:

public slots:
    void slotUpdateWeatherTimer();
};

#endif // MAINWORKER_H
