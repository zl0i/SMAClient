#ifndef WEATHERWORKER_H
#define WEATHERWORKER_H

#include <QObject>
#include <QJsonObject>
#include <QtNetwork>
#include <QDateTime>

class WeatherWorker : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QJsonObject currentWether READ wether NOTIFY wetherChanged)
    //Q_PROPERTY(QJsonObject weekForecast READ weekForecast NOTIFY weekForecastChanged)
    //Q_PROPERTY(QJsonObject twoWeekForecast READ twoWeekForecast NOTIFY twoWeekForecastChanged)

public:
    explicit WeatherWorker(QObject *parent = nullptr);
    ~WeatherWorker();

    QJsonObject wether() { return  m_currentWether; }


    Q_INVOKABLE void updateCurrentWeather();
    Q_INVOKABLE void updateForecastWeather(int countDay = 7);


    Q_INVOKABLE QStringList getSytiList();

private:

    typedef enum {
        Idle,
        currentWeather,
        dailyForecast,
        twoDaylyForecast
    }TypeRequest;

    QNetworkAccessManager *networkManager;

    QJsonObject m_currentWether;


    qreal latitude;
    qreal longitude;

    QString add_id;
    QString cyti_id;

    void requestCurrentWeather();
    void requestWeekForecast();
    void requestTwoWeekForecast();

signals:
    void wetherChanged();
    void weekForecastChanged();
    void twoWeekForecastChanged();

public slots:
    void readReady(QNetworkReply *reply);
};

#endif // WEATHERWORKER_H
