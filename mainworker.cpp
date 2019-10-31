#include "mainworker.h"

MainWorker::MainWorker(QObject *parent) : QObject(parent)
{    

    connect(fieldWorker, &FieldWorker::updateFieldsFromServer, serverWorker, &ServerWorker::requestUpdateFields);
    connect(fieldWorker, &FieldWorker::sendNewFieldToServer, serverWorker, &ServerWorker::requestNewFields);
    connect(serverWorker, &ServerWorker::comeDataFields, fieldWorker, &FieldWorker::parseDate);

    connect(sensorWorker, &SensorWorker::updateSensorsFromServer, serverWorker, &ServerWorker::requestUpdateSensors);
    connect(sensorWorker, &SensorWorker::getHistorySensorFromServer, serverWorker, &ServerWorker::requestHistorySensor);
    connect(serverWorker, &ServerWorker::comeDataSensors, sensorWorker, &SensorWorker::parseDate);

    connect(carWorker, &CarWorker::updateCarsFromServer, serverWorker, &ServerWorker::requestUpdateCars);
    connect(serverWorker, &ServerWorker::comeDataCars, carWorker, &CarWorker::parseDate);

    weatherTimer->setInterval(1000*60*30);
    connect(weatherTimer, &QTimer::timeout, this, &MainWorker::slotUpdateWeatherTimer);

}


void MainWorker::slotUpdateWeatherTimer() {
    weatherWorker->updateAll();
}
