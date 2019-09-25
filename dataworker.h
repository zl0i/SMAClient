#ifndef WORKER_H
#define WORKER_H

#include <QObject>
#include <QStandardItemModel>
#include <QJsonObject>
#include <QDebug>

class DataWorker : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStandardItemModel *sensorModel READ getSensorModel RESET resetSensorModel NOTIFY sensorModelChanged)
    Q_PROPERTY(QStandardItemModel *carsModel READ getCarsModel RESET resetCarsModel NOTIFY carsModelChanged)

public:
    explicit DataWorker(QObject *parent = nullptr);

    typedef enum {
        idSensorRole = Qt::UserRole+1,
        LatitudeSensorRole,
        LongitudeSensorRole,
        TemperatureRole,
        HumidityRole,
        PressureRole,
        SoilRole
    }SensorRole;
    Q_ENUM(SensorRole)

    typedef enum {
        idCarRole = Qt::UserRole+8,
        LatitudeCarRole,
        LongitudeCarRole,
        SpeedRole,
        PathRole,
    }CarsRole;
    Q_ENUM(CarsRole)

    void addSensorData(QJsonObject obj);
    void addCarsData(QJsonObject obj);
    Q_INVOKABLE void fillInTestData();

private:
    QStandardItemModel *sensorModel = new QStandardItemModel();
    QStandardItemModel *getSensorModel() { return  sensorModel; }
    void resetSensorModel() { sensorModel->clear(); }


    QStandardItemModel *carsModel = new QStandardItemModel();
    QStandardItemModel *getCarsModel() { return  carsModel; }
    void resetCarsModel() { carsModel->clear(); }


signals:
    void sensorModelChanged();
    void carsModelChanged();

public slots:
};

#endif // WORKER_H
