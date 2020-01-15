#ifndef WEATHERWORKER_H
#define WEATHERWORKER_H

#include <QObject>
#include <QJsonObject>
#include <QtNetwork>
#include <QDateTime>
#include <QDebug>

#include "weatherplacemodel.h"

class WeatherWorker : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QJsonObject currentWeather READ wether NOTIFY currentWetherChanged)
    Q_PROPERTY(QJsonArray dailyForecast READ dailyForecast NOTIFY dailyForecastChanged)
    Q_PROPERTY(QJsonArray twoDailyForecast READ twoDailyForecast NOTIFY twoDailyForecastChanged)
    Q_PROPERTY(bool relevantData READ relevantData NOTIFY currentWetherChanged)

    Q_PROPERTY(WeatherPlaceModel *placeModel READ placeModel NOTIFY placeModelChanged)


public:
    explicit WeatherWorker(QObject *parent = nullptr);
    ~WeatherWorker();

    QJsonObject wether() { return  m_currentWeather; }
    QJsonArray dailyForecast() { return  m_dailyForecast; }
    QJsonArray twoDailyForecast() { return  m_twoDailyForecast; }
    bool relevantData() { return  m_relevantData; }


    WeatherPlaceModel *placeModel() { return  weatherModel; }

    Q_INVOKABLE void updateCurrentWeather();
    Q_INVOKABLE void updateDailyForecastWeather();
    Q_INVOKABLE void updateTwoDailyForecastWeather();

    Q_INVOKABLE void updateAll();


    Q_INVOKABLE QStringList getSytiList();

private:

    QNetworkAccessManager *networkManager;

    QJsonObject m_currentWeather;
    QJsonArray m_dailyForecast;
    QJsonArray m_twoDailyForecast;

    bool m_relevantData = false;

    void parseCurrentWeather(QJsonObject);
    void parseDailyForecast(QJsonObject);
    void parseTwoDailyForecast(QJsonObject);


    QString getStringDateFromUTS(int);

    WeatherPlaceModel *weatherModel;



signals:
    void currentWetherChanged();
    void dailyForecastChanged();
    void twoDailyForecastChanged();
    void placeModelChanged();

public slots:   

    void handlerCurrentWeather();
    void handlerDailyForecast();
    void handlerTwoDailyForecast();


};

#endif // WEATHERWORKER_H
