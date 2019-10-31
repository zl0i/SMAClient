#ifndef WEATHERWORKER_H
#define WEATHERWORKER_H

#include <QObject>
#include <QJsonObject>
#include <QtNetwork>
#include <QDateTime>
#include <QDebug>

class WeatherWorker : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QJsonObject currentWeather READ wether NOTIFY currentWetherChanged)
    Q_PROPERTY(QJsonArray dailyForecast READ dailyForecast NOTIFY dailyForecastChanged)
    Q_PROPERTY(QJsonArray twoDailyForecast READ twoDailyForecast NOTIFY twoDailyForecastChanged)

public:
    explicit WeatherWorker(QObject *parent = nullptr);
    ~WeatherWorker();

    QJsonObject wether() { return  m_currentWeather; }
    QJsonArray dailyForecast() { return  m_dailyForecast; }
    QJsonArray twoDailyForecast() { return  m_twoDailyForecast; }


    Q_INVOKABLE void updateCurrentWeather();
    Q_INVOKABLE void updateDailyForecastWeather();
    Q_INVOKABLE void updateTwoDailyForecastWeather();

    Q_INVOKABLE void updateAll();


    Q_INVOKABLE QStringList getSytiList();

private:

    typedef enum {
        Idle,
        CurrentWeather,
        DailyForecast,
        TwoDailyForecast
    }TypeRequest;

    TypeRequest type = Idle;

    QNetworkAccessManager networkManager;

    QJsonObject m_currentWeather;
    QJsonArray m_dailyForecast;
    QJsonArray m_twoDailyForecast;

    void parseCurrentWeather(QNetworkReply *reply);
    void parseDailyForecast(QNetworkReply *reply);
    void parseTwoDailyForecast(QNetworkReply *reply);

    QString getStringDateFromUTS(int);

    bool m_allUpdate = false;






signals:
    void currentWetherChanged();
    void dailyForecastChanged();
    void twoDailyForecastChanged();

public slots:
    void onResult(QNetworkReply *reply);
};

#endif // WEATHERWORKER_H
