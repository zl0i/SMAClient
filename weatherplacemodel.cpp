#include "weatherplacemodel.h"

WeatherPlaceModel::WeatherPlaceModel(QObject *parent) : QStandardItemModel(parent)
{
    QHash<int, QByteArray> hash;
    hash.insert(WeatherPlaceModel::City_id, "cityId");
    hash.insert(WeatherPlaceModel::City_name, "cityName");
    hash.insert(WeatherPlaceModel::City_Country, "cityCountry");
    setItemRoleNames(hash);
}

void WeatherPlaceModel::fillModel()
{
    if(isFiil)
        return;

    QFile *cityFile = new QFile("D:/Project/Qt/SMAClient/SMAClient/city.list.json");
    if(cityFile->open(QIODevice::ReadOnly)) {
        QByteArray array = cityFile->readAll();
        QJsonDocument document = QJsonDocument::fromJson(array);
        QJsonArray cityArray = document.array();
       const long size = cityArray.size();
       insertColumn(0);
       insertRows(0, cityArray.size());
       for(long i = 0; i < size; i++) {
           QJsonObject obj = cityArray.at(i).toObject();
           QModelIndex m_index = index(i, 0);
           setData(m_index, obj.value("id"), WeatherPlaceModel::City_id);
           setData(m_index, obj.value("name"), WeatherPlaceModel::City_name);
           setData(m_index, obj.value("country"), WeatherPlaceModel::City_Country);
       }
       isFiil = true;
    } else
        qDebug() << "file not opened";
}


