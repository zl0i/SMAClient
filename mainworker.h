#ifndef MAINWORKER_H
#define MAINWORKER_H

#include <QObject>
#include "serverworker.h"
#include "weatherworker.h"
#include "dataworker.h"

class MainWorker : public QObject
{
    Q_OBJECT
public:
    explicit MainWorker(QObject *parent = nullptr);

    ServerWorker *serverWorker = new ServerWorker();
    DataWorker *dataWorker = new DataWorker();
    WeatherWorker *weatherWorker = new WeatherWorker();

signals:

public slots:
};

#endif // MAINWORKER_H
