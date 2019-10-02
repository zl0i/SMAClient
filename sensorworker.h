#ifndef WORKER_H
#define WORKER_H

#include <QObject>
#include <QStandardItemModel>
#include <QJsonObject>
#include <QDebug>
#include <serverworker.h>

class SensorWorker : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStandardItemModel *sensorModel READ getSensorModel RESET resetSensorModel NOTIFY sensorModelChanged)
    Q_PROPERTY(QStandardItemModel *historyModel READ getHistoryModel RESET resetHistoryModel NOTIFY historyModelChanged)

public:
    explicit SensorWorker(QObject *parent = nullptr);

    typedef enum {
        idRole = Qt::UserRole+1,
        LatitudeRole,
        LongitudeRole,
        TemperatureRole,
        HumidityRole,
        PressureRole,
        SoilRole
    }SensorRole;
    Q_ENUM(SensorRole)   

    void addSensorData(QJsonObject obj);
    void addCarsData(QJsonObject obj);

    Q_INVOKABLE void fillInTestData();




private:
    QStandardItemModel *sensorModel = new QStandardItemModel(this);
    QStandardItemModel *getSensorModel() { return  sensorModel; }
    void resetSensorModel() { sensorModel->clear(); }

    QStandardItemModel *historyModel = new QStandardItemModel(this);
    QStandardItemModel *getHistoryModel() { return  historyModel; }
    void resetHistoryModel() { historyModel->clear(); }

signals:
    void sensorModelChanged();
    void historyModelChanged();


public slots:
    void parseDate(ServerWorker::Request, QJsonObject);
};

#endif // WORKER_H
