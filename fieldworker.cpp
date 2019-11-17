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
            fieldModel->setData(index, obj.value("name").toString(), FieldWorker::NameRole);
            fieldModel->setData(index, obj.value("location").toArray(), FieldWorker::LocationRole);
            fieldModel->setData(index, obj.value("center").toObject(), FieldWorker::CenterRole);
            fieldModel->setData(index, obj.value("temperature").toDouble(), FieldWorker::TemperatureRole);
            fieldModel->setData(index, obj.value("humidity").toDouble(), FieldWorker::HumidityRole);
            fieldModel->setData(index, obj.value("pressure").toDouble(), FieldWorker::PressureRole);
            //fieldModel->setData(index, obj.value("lastUpdate").toString(), FieldWorker::LastUpdateRole);
        }
        emit fieldModelChanged();
    }
}

QJsonObject FieldWorker::getFiledById(int id) {

    QModelIndex index;
    bool finded = false;

    for(int i = 0; i < fieldModel->rowCount(); i++) {
        index = fieldModel->index(i, 0);
        if(fieldModel->data(index, FieldWorker::idRole).toInt() == id)  {
            finded = true;
            break;
        }
    }

    if(!finded)
        return QJsonObject {};

    QJsonObject obj;
    obj.insert("id", fieldModel->data(index, FieldWorker::idRole).toJsonValue());
    obj.insert("name", fieldModel->data(index, FieldWorker::NameRole).toJsonValue());

    QJsonArray arr;
    QJsonObject temp;    

    temp.insert("type", "Окружающая среда");
    temp.insert("dataName", tr("Температура"));
    temp.insert("value", fieldModel->data(index, FieldWorker::TemperatureRole).toJsonValue());
    arr.append(temp);

    temp.insert("type", "Окружающая среда");
    temp.insert("dataName", tr("Влажность"));
    temp.insert("value", fieldModel->data(index, FieldWorker::HumidityRole).toJsonValue());
    arr.append(temp);

    temp.insert("type", "Окружающая среда");
    temp.insert("dataName", tr("Давление"));
    temp.insert("value", fieldModel->data(index, FieldWorker::PressureRole).toJsonValue());
    arr.append(temp);


    temp.insert("type", "Общие");
    temp.insert("dataName", tr("Долгота"));
    temp.insert("value", fieldModel->data(index, FieldWorker::CenterRole).toJsonObject().value("latitude"));
    arr.append(temp);

    temp.insert("type", "Общие");
    temp.insert("dataName", tr("Широта"));
    temp.insert("value", fieldModel->data(index, FieldWorker::CenterRole).toJsonObject().value("longitude"));
    arr.append(temp);

    temp.insert("type", "Общие");
    temp.insert("dataName", tr("Количество датчиков"));
    temp.insert("value", fieldModel->data(index, FieldWorker::CountRole).toJsonValue());
    arr.append(temp);

    obj.insert("info", arr);

    return  obj;
}
