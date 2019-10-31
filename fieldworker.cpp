#include "fieldworker.h"

FieldWorker::FieldWorker(QObject *parent) : QObject(parent)
{
    QHash<int, QByteArray> hash;
    hash.insert(FieldWorker::idRole, "idData");
    hash.insert(FieldWorker::NameRole, "nameData");
    hash.insert(FieldWorker::LocationRole, "locationData");
    hash.insert(FieldWorker::TemperatureRole, "temperatureData");
    hash.insert(FieldWorker::HumidityRole, "humidityData");
    hash.insert(FieldWorker::PressureRole, "pressureData");
    hash.insert(FieldWorker::CountRole, "countData");
    hash.insert(FieldWorker::CenterRole, "centerData");
    fieldModel->setItemRoleNames(hash);
}

void FieldWorker::updateFields() {
    emit updateFieldsFromServer();
}

void FieldWorker::addField(QJsonObject obj) {
    emit sendNewFieldToServer(obj);
}

void FieldWorker::fillInTestData() {
    fieldModel->insertColumn(0);
    fieldModel->insertRows(0, 2);
    QJsonArray arr;

    QJsonObject obj;
    obj.insert("latitude", 51.513202);
    obj.insert("longitude", 39.242075);
    arr.append(obj);

    obj.insert("latitude", 51.525009);
    obj.insert("longitude", 39.242204);
    arr.append(obj);

    obj.insert("latitude", 51.524045);
    obj.insert("longitude", 39.253491);
    arr.append(obj);

    obj.insert("latitude", 51.512693);
    obj.insert("longitude", 39.252847);
    arr.append(obj);



    QModelIndex index = fieldModel->index(0, 0);
    fieldModel->setData(index, 0, FieldWorker::idRole);
    fieldModel->setData(index, "Поле 1", FieldWorker::NameRole);
    fieldModel->setData(index, 23.3, FieldWorker::TemperatureRole);
    fieldModel->setData(index, 65, FieldWorker::HumidityRole);
    fieldModel->setData(index, 785, FieldWorker::PressureRole);
    fieldModel->setData(index, arr, FieldWorker::LocationRole);
    fieldModel->setData(index, 4, FieldWorker::CountRole);

    const int cnt = arr.count();
    for(int i = 0; i < cnt; ++i) {
        arr.removeLast();
    }

    obj.insert("latitude",  51.511176);
    obj.insert("longitude", 39.267689);
    arr.append(obj);

    obj.insert("latitude", 51.522716);
    obj.insert("longitude", 39.267861);
    arr.append(obj);

    obj.insert("latitude", 51.521672);
    obj.insert("longitude", 39.279963);
    arr.append(obj);

    obj.insert("latitude", 51.510265);
    obj.insert("longitude", 39.279362);
    arr.append(obj);

    index = fieldModel->index(1, 0);
    fieldModel->setData(index, 1, FieldWorker::idRole);
    fieldModel->setData(index, "Поле 2", FieldWorker::NameRole);
    fieldModel->setData(index, 15, FieldWorker::TemperatureRole);
    fieldModel->setData(index, 85, FieldWorker::HumidityRole);
    fieldModel->setData(index, 850, FieldWorker::PressureRole);
    fieldModel->setData(index, arr, FieldWorker::LocationRole);
    fieldModel->setData(index, 1, FieldWorker::CountRole);
    emit fieldModelChanged();
}

void FieldWorker::parseDate(ServerWorker::Request type, QJsonObject mainObj) {
    if(type == ServerWorker::UpdateFields) {
        QJsonArray array = mainObj.value("fields").toArray();
        fieldModel->clear();
        fieldModel->insertColumn(0);
        fieldModel->insertRows(0, array.count());
        for(int i = 0; i < array.count(); ++i) {
            QJsonObject obj = array.at(i).toObject();
            QModelIndex index = fieldModel->index(i, 0);
            fieldModel->setData(index, obj.value("id").toInt(), FieldWorker::idRole);
            fieldModel->setData(index, obj.value("name").toObject(), FieldWorker::NameRole);
            fieldModel->setData(index, obj.value("location").toObject(), FieldWorker::LocationRole);
            fieldModel->setData(index, obj.value("center").toDouble(), FieldWorker::CenterRole);
            fieldModel->setData(index, obj.value("temperature").toDouble(), FieldWorker::TemperatureRole);
            fieldModel->setData(index, obj.value("humidity").toDouble(), FieldWorker::HumidityRole);
            fieldModel->setData(index, obj.value("pressure").toInt(), FieldWorker::PressureRole);
            //fieldModel->setData(index, obj.value("lastUpdate").toString(), FieldWorker::LastUpdateRole);
        }
        emit fieldModelChanged();
    }
}

QJsonObject FieldWorker::getFiledById(int id) {
    QModelIndex index = fieldModel->index(id, 0);
    QJsonObject obj;
    obj.insert("id", fieldModel->data(index, FieldWorker::idRole).toJsonValue());
    obj.insert("name", fieldModel->data(index, FieldWorker::NameRole).toJsonValue());
    obj.insert("location", fieldModel->data(index, FieldWorker::LocationRole).toJsonValue());
    obj.insert("center", fieldModel->data(index, FieldWorker::CenterRole).toJsonValue());
    obj.insert("temperature", fieldModel->data(index, FieldWorker::TemperatureRole).toJsonValue());
    obj.insert("humidity", fieldModel->data(index, FieldWorker::HumidityRole).toJsonValue());
    obj.insert("pressure", fieldModel->data(index, FieldWorker::PressureRole).toJsonValue());
    return  obj;
}
