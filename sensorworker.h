#ifndef WORKER_H
#define WORKER_H

#include <QObject>
#include <QStandardItemModel>
#include <QJsonObject>
#include <QDebug>
#include <serverworker.h>
#include <QDateTime>
#include <QChart>
#include <QtCharts/QXYSeries>
#include <QtCharts/QLineSeries>
#include <QtCharts/QAreaSeries>
#include <QVector>
#include <QPointF>

QT_BEGIN_NAMESPACE
class QQuickView;
QT_END_NAMESPACE

QT_CHARTS_USE_NAMESPACE

class SensorWorker : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStandardItemModel *sensorModel READ getSensorModel RESET resetSensorModel NOTIFY sensorModelChanged)

    Q_PROPERTY(QStandardItemModel *historyModel READ getHistoryModel RESET resetHistoryModel NOTIFY historyModelChanged)

    Q_PROPERTY(int target_id READ getTargetId NOTIFY historyModelChanged)
    Q_PROPERTY(QString valueName READ getValueName NOTIFY historyModelChanged)
    Q_PROPERTY(QString unitsName READ getUnitsName NOTIFY historyModelChanged)
    Q_PROPERTY(qint64 dtStart READ getDtStart NOTIFY historyModelChanged)
    Q_PROPERTY(qint64 dtEnd READ getDtEnd NOTIFY historyModelChanged)


public:
    explicit SensorWorker(QObject *parent = nullptr);

    typedef enum {
        idRole = Qt::UserRole+1,
        NameRole,
        LatitudeRole,
        LongitudeRole,
        TemperatureRole,
        HumidityRole,
        PressureRole,
        WindSpeedRole,
        WindDirectionRole,
        BattaryRole,
        GSMLevelRole,
        GroundRole,
        LastUpdateRole
    }SensorRole;
    Q_ENUM(SensorRole)   

    typedef enum {
        dtRole = Qt::UserRole+1,
        valueRole
    }HistoryRole;
    Q_ENUM(HistoryRole)


    Q_INVOKABLE void updateSensors();
    Q_INVOKABLE void getHistorySensor(int id, QString property, quint64 dt_start, quint64 dt_end);

    Q_INVOKABLE void updateChart(QAbstractSeries *series);

    QStandardItemModel *getHistoryModel() { return  historyModel; }
    void resetHistoryModel() { historyModel->clear(); }

    QStandardItemModel *getSensorModel() { return  sensorModel; }
    void resetSensorModel() { sensorModel->clear(); }
    int getTargetId() { return  target_id;}
    QString getValueName() { return  valueName; }
    QString getUnitsName() { return  unitsName; }
    qint64 getDtStart() { return dtStart.toSecsSinceEpoch(); }
    qint64 getDtEnd() { return dtEnd.toSecsSinceEpoch(); }

    Q_INVOKABLE QJsonObject getSensorById(int id);

private:

    QPair<qreal, qreal> getMinMaxDt();
    QPair<qreal, qreal>getMinMaxValue();

    QStandardItemModel *sensorModel = new QStandardItemModel(this);

    QStandardItemModel *historyModel = new QStandardItemModel(this);   
    int target_id;
    QString valueName;
    QString unitsName;
    QDateTime dtStart;
    QDateTime dtEnd;

signals:
    void sensorModelChanged();
    void historyModelChanged();

    void updateSensorsFromServer();
    void getHistorySensorFromServer(int id, QString property, quint64 dt_start, quint64 dt_end);

    void minMaxDtChanged(qreal min, qreal max);
    void minMaxValueChanged(qreal min, qreal max);

public slots:
    void parseDate(ServerWorker::Request, QJsonObject);
};

#endif // WORKER_H
