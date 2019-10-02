#ifndef MAINWORKER_H
#define MAINWORKER_H

#include <QObject>
#include "serverworker.h"
#include "weatherworker.h"
#include "sensorworker.h"
#include "carworker.h"

class MainWorker : public QObject
{
    Q_OBJECT
public:
    explicit MainWorker(QObject *parent = nullptr);

    ServerWorker *serverWorker = new ServerWorker(this);
    SensorWorker *sensorWorker = new SensorWorker(this);
    CarWorker *carWorker = new CarWorker(this);
    WeatherWorker *weatherWorker = new WeatherWorker(this);

signals:

public slots:
};

#endif // MAINWORKER_H
