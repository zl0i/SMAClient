#ifndef CARWORKER_H
#define CARWORKER_H

#include <QObject>
#include <QStandardItemModel>
#include <QModelIndex>
#include <serverworker.h>

class CarWorker : public QObject
{
    Q_OBJECT
     Q_PROPERTY(QStandardItemModel *carsModel READ getCarsModel RESET resetCarsModel NOTIFY carsModelChanged)
public:
    explicit CarWorker(QObject *parent = nullptr);

    typedef enum {
        idRole = Qt::UserRole+8,
        LatitudeRole,
        LongitudeRole,
        SpeedRole,
        PathRole,
    }CarsRole;
    Q_ENUM(CarsRole)

    QStandardItemModel *carsModel = new QStandardItemModel();
    QStandardItemModel *getCarsModel() { return  carsModel; }
    void resetCarsModel() { carsModel->clear(); }

    void fillTestData();

signals:
    void carsModelChanged();

public slots:
    void parseDate(ServerWorker::Request, QJsonObject);
};

#endif // CARWORKER_H
