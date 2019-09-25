#ifndef WEATHERWORKER_H
#define WEATHERWORKER_H

#include <QObject>

class WeatherWorker : public QObject
{
    Q_OBJECT
public:
    explicit WeatherWorker(QObject *parent = nullptr);

signals:

public slots:
};

#endif // WEATHERWORKER_H
