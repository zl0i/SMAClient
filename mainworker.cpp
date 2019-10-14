#include "mainworker.h"

MainWorker::MainWorker(QObject *parent) : QObject(parent)
{    
    connect(sensorWorker, &SensorWorker::updateSensorsFromServer, serverWorker, &ServerWorker::requestUpdateSensors);
    connect(sensorWorker, &SensorWorker::getHistorySensorFromServer, serverWorker, &ServerWorker::requestHistorySensor);
    connect(carWorker, &CarWorker::updateCarsFromServer, serverWorker, &ServerWorker::requestUpdateCars);

    weatherWorker->updateCurrentWeather();
    weatherTimer->setInterval(1000*60*30);
    connect(weatherTimer, &QTimer::timeout, this, &MainWorker::slotUpdateWeatherTimer);

    sensorWorker->fillInTestData();
    carWorker->fillTestData();

}


void MainWorker::slotUpdateWeatherTimer() {
    weatherWorker->updateCurrentWeather();
}
