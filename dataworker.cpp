#include "dataworker.h"

DataWorker::DataWorker(QObject *parent) : QObject(parent)
{  
    QHash<int, QByteArray> hash;
    hash.insert(DataWorker::idSensorRole, "id");
    hash.insert(DataWorker::LatitudeSensorRole, "latitude");
    hash.insert(DataWorker::LongitudeSensorRole, "longitude");
    hash.insert(DataWorker::TemperatureRole, "temperature");
    hash.insert(DataWorker::HumidityRole, "humidity");
    hash.insert(DataWorker::PressureRole, "pressure");
    hash.insert(DataWorker::SoilRole, "soil");
    sensorModel->setItemRoleNames(hash);

    hash.clear();
    hash.insert(DataWorker::idCarRole, "id");
    hash.insert(DataWorker::LatitudeCarRole, "latitude");
    hash.insert(DataWorker::LongitudeCarRole, "longitude");
    hash.insert(DataWorker::SpeedRole, "speed");
    hash.insert(DataWorker::PathRole, "path");
    carsModel->setItemRoleNames(hash);
}

void DataWorker::addSensorData(QJsonObject obj) {
    Q_UNUSED(obj)
}

void DataWorker::addCarsData(QJsonObject obj) {
    Q_UNUSED(obj)
}


void DataWorker::fillInTestData() {
    sensorModel->insertColumn(0);
    sensorModel->insertRows(0, 4);
    QModelIndex index = sensorModel->index(0, 0);
    sensorModel->setData(index, 0, DataWorker::idSensorRole);
    sensorModel->setData(index, 51.511281, DataWorker::LatitudeSensorRole);
    sensorModel->setData(index, 39.267537, DataWorker::LongitudeSensorRole);
    sensorModel->setData(index, 23.3, DataWorker::TemperatureRole);
    sensorModel->setData(index, 65, DataWorker::HumidityRole);
    sensorModel->setData(index, 785, DataWorker::PressureRole);

    index = sensorModel->index(1, 0);
    sensorModel->setData(index, 1, DataWorker::idSensorRole);
    sensorModel->setData(index, 51.522671, DataWorker::LatitudeSensorRole);
    sensorModel->setData(index, 39.267861, DataWorker::LongitudeSensorRole);
    sensorModel->setData(index, 26, DataWorker::TemperatureRole);
    sensorModel->setData(index, 82, DataWorker::HumidityRole);
    sensorModel->setData(index, 767, DataWorker::PressureRole);

    index = sensorModel->index(2, 0);
    sensorModel->setData(index, 2, DataWorker::idSensorRole);
    sensorModel->setData(index, 51.521788, DataWorker::LatitudeSensorRole);
    sensorModel->setData(index, 39.279748, DataWorker::LongitudeSensorRole);
    sensorModel->setData(index, 24.5, DataWorker::TemperatureRole);
    sensorModel->setData(index, 75, DataWorker::HumidityRole);
    sensorModel->setData(index, 780, DataWorker::PressureRole);

    index = sensorModel->index(3, 0);
    sensorModel->setData(index, 3, DataWorker::idSensorRole);
    sensorModel->setData(index, 51.510167, DataWorker::LatitudeSensorRole);
    sensorModel->setData(index, 39.279191, DataWorker::LongitudeSensorRole);
    sensorModel->setData(index, 20, DataWorker::TemperatureRole);
    sensorModel->setData(index, 50, DataWorker::HumidityRole);
    sensorModel->setData(index, 790, DataWorker::PressureRole);
    emit sensorModelChanged();

    carsModel->insertColumn(0);
    carsModel->insertRows(0, 3);
    index = carsModel->index(0, 0);
    carsModel->setData(index, 0, DataWorker::idCarRole);
    carsModel->setData(index, 51.511226, DataWorker::LatitudeCarRole);
    carsModel->setData(index, 39.286618, DataWorker::LongitudeCarRole);
    carsModel->setData(index, 0, DataWorker::SpeedRole);

    index = carsModel->index(1, 0);
    carsModel->setData(index, 1, DataWorker::idCarRole);
    carsModel->setData(index, 51.511039, DataWorker::LatitudeCarRole);
    carsModel->setData(index, 39.286660, DataWorker::LongitudeCarRole);
    carsModel->setData(index, 0, DataWorker::SpeedRole);

    index = carsModel->index(2, 0);
    carsModel->setData(index, 2, DataWorker::idCarRole);
    carsModel->setData(index, 51.510959, DataWorker::LatitudeCarRole);
    carsModel->setData(index, 39.276959, DataWorker::LongitudeCarRole);
    carsModel->setData(index, 10, DataWorker::SpeedRole);
    emit carsModelChanged();
}



