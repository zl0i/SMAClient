#include "carworker.h"

CarWorker::CarWorker(QObject *parent) : QObject(parent)
{
    QHash<int, QByteArray> hash;
    hash.insert(CarWorker::idRole, "car_id");
    hash.insert(CarWorker::NameRole, "nameData");
    hash.insert(CarWorker::LatitudeRole, "latitudeData");
    hash.insert(CarWorker::LongitudeRole, "longitudeData");
    hash.insert(CarWorker::SpeedRole, "speedData");
    hash.insert(CarWorker::PathRole, "path");
    carsModel->setItemRoleNames(hash);
}


void CarWorker::fillTestData() {
    carsModel->insertColumn(0);
    carsModel->insertRows(0, 3);
    QModelIndex index = carsModel->index(0, 0);
    carsModel->setData(index, 0, CarWorker::idRole);
    carsModel->setData(index, "Машина 1", CarWorker::NameRole);
    carsModel->setData(index, 51.511226, CarWorker::LatitudeRole);
    carsModel->setData(index, 39.286618, CarWorker::LongitudeRole);
    carsModel->setData(index, 0, CarWorker::SpeedRole);

    index = carsModel->index(1, 0);
    carsModel->setData(index, 1, CarWorker::idRole);
    carsModel->setData(index, "Машина 2", CarWorker::NameRole);
    carsModel->setData(index, 51.511039, CarWorker::LatitudeRole);
    carsModel->setData(index, 39.286660, CarWorker::LongitudeRole);
    carsModel->setData(index, 0, CarWorker::SpeedRole);

    index = carsModel->index(2, 0);
    carsModel->setData(index, 2, CarWorker::idRole);
    carsModel->setData(index, "Машина 3", CarWorker::NameRole);
    carsModel->setData(index, 51.510959, CarWorker::LatitudeRole);
    carsModel->setData(index, 39.276959, CarWorker::LongitudeRole);
    carsModel->setData(index, 10, CarWorker::SpeedRole);
    emit carsModelChanged();
}

void CarWorker::parseDate(ServerWorker::Request type, QJsonObject mainObj) {
    if(type == ServerWorker::UpdateCars) {
        QJsonArray array = mainObj.value("cars").toArray();
        carsModel->clear();
        carsModel->insertColumn(0);
        carsModel->insertRows(0, array.count());
        for(int i = 0; i < array.count(); ++i) {
            QJsonObject obj = array.at(i).toObject();
            QModelIndex index = carsModel->index(i, 0);
            carsModel->setData(index, obj.value("id").toInt(), CarWorker::idRole);
            carsModel->setData(index, obj.value("latitude").toDouble(), CarWorker::LatitudeRole);
            carsModel->setData(index, obj.value("longitude").toDouble(), CarWorker::LongitudeRole);
            carsModel->setData(index, obj.value("speed").toInt(), CarWorker::SpeedRole);
            //carsModel->setData(index, obj.value("path").toVariant(), CarWorker::PathRole);
        }
        emit carsModelChanged();
    }
}

void CarWorker::updateCars() {
    emit updateCarsFromServer();
}
