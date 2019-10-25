#ifndef FIELDWORKER_H
#define FIELDWORKER_H

#include <QObject>
#include <QStandardItemModel>
#include "serverworker.h"

class FieldWorker : public QObject
{
    Q_OBJECT
     Q_PROPERTY(QStandardItemModel *fieldModel READ getFieldModel NOTIFY fieldModelChanged)
public:
    explicit FieldWorker(QObject *parent = nullptr);

    typedef enum {
        idRole = Qt::UserRole+1,
        NameRole,
        LocationRole,
        TemperatureRole,
        HumidityRole,
        PressureRole ,
        CountRole
    }FieldRole;
    Q_ENUM(FieldRole)

    Q_INVOKABLE void fillInTestData();

    QStandardItemModel *getFieldModel() { return fieldModel; }

private:
    QStandardItemModel *fieldModel = new QStandardItemModel();

signals:
    void fieldModelChanged();

public slots:
    void parseDate(ServerWorker::Request, QJsonObject);
};

#endif // FIELDWORKER_H
