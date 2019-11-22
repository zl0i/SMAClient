#include "sensorworker.h"

SensorWorker::SensorWorker(QObject *parent) : QObject(parent)
{  
    QHash<int, QByteArray> hash;
    hash.insert(SensorWorker::idRole, "idData");
    hash.insert(SensorWorker::NameRole, "nameData");
    hash.insert(SensorWorker::LatitudeRole, "latitudeData");
    hash.insert(SensorWorker::LongitudeRole, "longitudeData");
    hash.insert(SensorWorker::TemperatureRole, "temperatureData");
    hash.insert(SensorWorker::HumidityRole, "humidityData");
    hash.insert(SensorWorker::PressureRole, "pressureData");
    hash.insert(SensorWorker::BattaryRole, "battaryData");
    hash.insert(SensorWorker::GSMLevelRole, "gsmLevelData");
    hash.insert(SensorWorker::GroundRole, "groundData");
    hash.insert(SensorWorker::LastUpdateRole, "lastUpdateData");

    sensorModel->setItemRoleNames(hash);

    hash.clear();
    hash.insert(SensorWorker::dtRole, "dateTime");
    hash.insert(SensorWorker::valueRole, "value");
    historyModel->setItemRoleNames(hash);
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
            sensorModel->setData(index, obj.value("name").toString(), SensorWorker::NameRole);
            sensorModel->setData(index, obj.value("latitude").toDouble(), SensorWorker::LatitudeRole);
            sensorModel->setData(index, obj.value("longitude").toDouble(), SensorWorker::LongitudeRole);
            sensorModel->setData(index, obj.value("temperature").toDouble(), SensorWorker::TemperatureRole);
            sensorModel->setData(index, obj.value("humidity").toDouble(), SensorWorker::HumidityRole);
            sensorModel->setData(index, obj.value("pressure").toInt(), SensorWorker::PressureRole);
            sensorModel->setData(index, obj.value("battery").toInt(), SensorWorker::BattaryRole);
            sensorModel->setData(index, obj.value("gsmlvl").toDouble(), SensorWorker::GSMLevelRole);
            sensorModel->setData(index, obj.value("ground").toObject(), SensorWorker::GroundRole);
            sensorModel->setData(index, obj.value("lastUpdate").toString(), SensorWorker::LastUpdateRole);
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

QJsonObject SensorWorker::getSensorById(int id)
{
    QModelIndex index;
    bool finded = false;

    for(int i = 0; i < sensorModel->rowCount(); i++) {
        index = sensorModel->index(i, 0);
        if(sensorModel->data(index, SensorWorker::idRole).toInt() == id)  {
            finded = true;
            break;
        }
    }

    if(!finded)
        return QJsonObject {};
    QJsonObject obj;
    obj.insert("id", sensorModel->data(index, SensorWorker::idRole).toJsonValue());
    obj.insert("name", sensorModel->data(index, SensorWorker::NameRole).toJsonValue());

    QJsonArray arr;
    QJsonObject temp;

    temp.insert("type", "Окружающая среда");
    temp.insert("dataName", tr("Температура"));
    temp.insert("value", sensorModel->data(index, SensorWorker::TemperatureRole).toJsonValue());
    arr.append(temp);

    temp.insert("type", "Окружающая среда");
    temp.insert("dataName", tr("Влажность"));
    temp.insert("value", sensorModel->data(index, SensorWorker::HumidityRole).toJsonValue());
    arr.append(temp);

    temp.insert("type", "Окружающая среда");
    temp.insert("dataName", tr("Давление"));
    temp.insert("value", sensorModel->data(index, SensorWorker::PressureRole).toJsonValue());
    arr.append(temp);


    temp.insert("type", "Общие");
    temp.insert("dataName", tr("Долгота"));
    temp.insert("value", sensorModel->data(index, SensorWorker::LatitudeRole).toDouble());
    arr.append(temp);

    temp.insert("type", "Общие");
    temp.insert("dataName", tr("Широта"));
    temp.insert("value", sensorModel->data(index, SensorWorker::LongitudeRole).toDouble());
    arr.append(temp);

    temp.insert("type", "Общие");
    temp.insert("dataName", tr("Батарея"));
    temp.insert("value", sensorModel->data(index, SensorWorker::BattaryRole).toInt());
    arr.append(temp);

    temp.insert("type", "Общие");
    temp.insert("dataName", tr("Сеть"));
    temp.insert("value", sensorModel->data(index, SensorWorker::GSMLevelRole).toInt());
    arr.append(temp);

    temp.insert("type", "Почва");
    temp.insert("dataName", tr("50 см"));
    temp.insert("value", sensorModel->data(index, SensorWorker::GroundRole).toJsonObject().value("1"));
    arr.append(temp);

    temp.insert("type", "Почва");
    temp.insert("dataName", tr("100 см"));
    temp.insert("value", sensorModel->data(index, SensorWorker::GroundRole).toJsonObject().value("2"));
    arr.append(temp);

    temp.insert("type", "Почва");
    temp.insert("dataName", tr("150 см"));
    temp.insert("value", sensorModel->data(index, SensorWorker::GroundRole).toJsonObject().value("3"));
    arr.append(temp);

    temp.insert("type", "Почва");
    temp.insert("dataName", tr("200 см"));
    temp.insert("value", sensorModel->data(index, SensorWorker::GroundRole).toJsonObject().value("4"));
    arr.append(temp);

    obj.insert("info", arr);

    return  obj;
}



