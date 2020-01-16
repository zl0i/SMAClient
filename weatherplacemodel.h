#ifndef WEATHERPLACEMODEL_H
#define WEATHERPLACEMODEL_H

#include <QObject>
#include <QStandardItemModel>
#include <QSortFilterProxyModel>
#include <QModelIndex>
#include <QFile>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QDebug>

class WeatherPlaceModel : public QSortFilterProxyModel
{
    Q_OBJECT
public:
    explicit WeatherPlaceModel(QObject *parent = nullptr);

    void fillModel();

    typedef enum {
        City_id = Qt::UserRole + 1,
        City_name,
        City_Country,
    }WeatherPlaceRole;

    Q_INVOKABLE void cityFilter(QString reg);

private:

    QStandardItemModel model;


    bool isFiil = false;


signals:

};

#endif // WEATHERPLACEMODEL_H
