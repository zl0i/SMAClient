#include "sensorworker.h"

SensorWorker::SensorWorker(QObject *parent) : QObject(parent)
{  
    QHash<int, QByteArray> hash;
    hash.insert(SensorWorker::idRole, "id");
    hash.insert(SensorWorker::LatitudeRole, "latitude");
    hash.insert(SensorWorker::LongitudeRole, "longitude");
    hash.insert(SensorWorker::TemperatureRole, "temperature");
    hash.insert(SensorWorker::HumidityRole, "humidity");
    hash.insert(SensorWorker::PressureRole, "pressure");
    hash.insert(SensorWorker::SoilRole, "soil");
    sensorModel->setItemRoleNames(hash);

    hash.clear();
    hash.insert(SensorWorker::dtRole, "dateTime");
    hash.insert(SensorWorker::valueRole, "value");
    historyModel->setItemRoleNames(hash);
}

void SensorWorker::fillInTestData() {
    sensorModel->insertColumn(0);
    sensorModel->insertRows(0, 4);
    QModelIndex index = sensorModel->index(0, 0);
    sensorModel->setData(index, 0, SensorWorker::idRole);
    sensorModel->setData(index, 51.511281, SensorWorker::LatitudeRole);
    sensorModel->setData(index, 39.267537, SensorWorker::LongitudeRole);
    sensorModel->setData(index, 23.3, SensorWorker::TemperatureRole);
    sensorModel->setData(index, 65, SensorWorker::HumidityRole);
    sensorModel->setData(index, 785, SensorWorker::PressureRole);

    index = sensorModel->index(1, 0);
    sensorModel->setData(index, 1, SensorWorker::idRole);
    sensorModel->setData(index, 51.522671, SensorWorker::LatitudeRole);
    sensorModel->setData(index, 39.267861, SensorWorker::LongitudeRole);
    sensorModel->setData(index, 26, SensorWorker::TemperatureRole);
    sensorModel->setData(index, 82, SensorWorker::HumidityRole);
    sensorModel->setData(index, 767, SensorWorker::PressureRole);

    index = sensorModel->index(2, 0);
    sensorModel->setData(index, 2, SensorWorker::idRole);
    sensorModel->setData(index, 51.521788, SensorWorker::LatitudeRole);
    sensorModel->setData(index, 39.279748, SensorWorker::LongitudeRole);
    sensorModel->setData(index, 24.5, SensorWorker::TemperatureRole);
    sensorModel->setData(index, 75, SensorWorker::HumidityRole);
    sensorModel->setData(index, 780, SensorWorker::PressureRole);

    index = sensorModel->index(3, 0);
    sensorModel->setData(index, 3, SensorWorker::idRole);
    sensorModel->setData(index, 51.510167, SensorWorker::LatitudeRole);
    sensorModel->setData(index, 39.279191, SensorWorker::LongitudeRole);
    sensorModel->setData(index, 20, SensorWorker::TemperatureRole);
    sensorModel->setData(index, 50, SensorWorker::HumidityRole);
    sensorModel->setData(index, 790, SensorWorker::PressureRole);
    emit sensorModelChanged();
}

void SensorWorker::parseDate(ServerWorker::Request type, QJsonObject mainObj) {
    if(type == ServerWorker::UpdateSensors) {
        QJsonArray array = mainObj.value("sensors").toArray();
        sensorModel->clear();
        sensorModel->insertColumn(0);
        sensorModel->insertRows(0, array.count());
        for(int i = 0; i < array.count(); ++i) {
            QJsonObject obj = array.at(i).toObject();
            QModelIndex index = sensorModel->index(i, 0);
            sensorModel->setData(index, obj.value("id").toInt(), SensorWorker::idRole);
            sensorModel->setData(index, obj.value("latitude").toDouble(), SensorWorker::LatitudeRole);
            sensorModel->setData(index, obj.value("longitude").toDouble(), SensorWorker::LongitudeRole);
            sensorModel->setData(index, obj.value("temperature").toDouble(), SensorWorker::TemperatureRole);
            sensorModel->setData(index, obj.value("humidity").toDouble(), SensorWorker::HumidityRole);
            sensorModel->setData(index, obj.value("pressure").toInt(), SensorWorker::PressureRole);
        }
        emit sensorModelChanged();
    }
    if(type == ServerWorker::HistorySensors) {
        this->target_id = mainObj.value("target_id").toInt();
        this->valueName = mainObj.value("property").toString();
        this->dtStart = QDateTime::fromSecsSinceEpoch(mainObj.value("dt_start").toInt());
        this->dtStart = QDateTime::fromSecsSinceEpoch(mainObj.value("dt_end").toInt());

        QJsonArray array = mainObj.value("history").toArray();
        historyModel->clear();
        historyModel->insertColumn(0);
        historyModel->insertRows(0, array.count());
        for(int i = 0; i < array.count(); ++i) {
            QJsonObject obj = array.at(i).toObject();
            QModelIndex index = sensorModel->index(i, 0);
            historyModel->setData(index, obj.value("dt").toInt(), SensorWorker::dtRole);
            historyModel->setData(index, obj.value("value").toDouble(), SensorWorker::valueRole);
        }
        emit sensorModelChanged();
    }
}

void SensorWorker::updateSensors() {
    emit updateSensorsFromServer();
}

void SensorWorker::getHistorySensor(int id, QString property, quint64 dt_start, quint64 dt_end) {
    emit getHistorySensorFromServer(id, property, dt_start, dt_end);
}



