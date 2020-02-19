#include "weatherplacemodel.h"

WeatherPlaceModel::WeatherPlaceModel(QObject *parent) : QSortFilterProxyModel (parent)
{
    QHash<int, QByteArray> hash;
    hash.insert(WeatherPlaceModel::City_id, "cityId");
    hash.insert(WeatherPlaceModel::City_name, "cityName");
    hash.insert(WeatherPlaceModel::City_Country, "cityCountry");
    model.setItemRoleNames(hash);
}

void WeatherPlaceModel::fillModel()
{
    if(isFiil)
        return;

    QFile *cityFile = new QFile("city.list.json");
    if(cityFile->open(QIODevice::ReadOnly)) {
        QByteArray array = cityFile->readAll();
        QJsonDocument document = QJsonDocument::fromJson(array);
        QJsonArray cityArray = document.array();
        const long size = cityArray.size();
        model.insertColumn(0);
        model.insertRows(0, cityArray.size());
        for(long i = 0; i < size; i++) {
            QJsonObject obj = cityArray.at(i).toObject();
            QModelIndex m_index = model.index(i, 0);
            model.setData(m_index, obj.value("id"), WeatherPlaceModel::City_id);
            model.setData(m_index, obj.value("name"), WeatherPlaceModel::City_name);
            model.setData(m_index, obj.value("country"), WeatherPlaceModel::City_Country);
        }
        setSourceModel(&model);
        isFiil = true;
    } else
        qDebug() << "file not opened";
}

void WeatherPlaceModel::cityFilter(QString reg)
{
   setFilterRole(WeatherPlaceModel::City_name);
   QRegExp regExp(reg, Qt::CaseInsensitive);
   setFilterRegExp(regExp);
}


