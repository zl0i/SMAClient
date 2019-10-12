#include "weatherworker.h"

WeatherWorker::WeatherWorker(QObject *parent) : QObject(parent)
{
    networkManager = new QNetworkAccessManager();
    connect(networkManager, &QNetworkAccessManager::finished, this, &WeatherWorker::readReady);

    //networkManager->get(QNetworkRequest(QUrl("https://api.openweathermap.org/data/2.5/weather?id=472045&appid=10a1eeb233d35e9780031ad22d567cd4")));

    //networkManager->get(QNetworkRequest(QUrl("https://api.openweathermap.org/data/2.5/uvi?lat=51.67&lon=39.17&appid=10a1eeb233d35e9780031ad22d567cd4")));

    //https://api.openweathermap.org/data/2.5/uvi?lat=51.67&lon=39.17&appid=10a1eeb233d35e9780031ad22d567cd4 // ультрафиолет
    //https://api.openweathermap.org/data/2.5/forecast?id=472045&appid=10a1eeb233d35e9780031ad22d567cd4 // прогноз на 5 дней
    //https://api.openweathermap.org/data/2.5/forecast/daily?id=472045&appid=10a1eeb233d35e9780031ad22d567cd4 // прогноз на 16 дней
    //https://tile.openweathermap.org/map/temp_new/6/53.0561/37.8864.png?appid=10a1eeb233d35e9780031ad22d567cd4 тайл на карту
}


WeatherWorker::~WeatherWorker() {
    delete  networkManager;
}

void WeatherWorker::updateCurrentWeather()
{

}

void WeatherWorker::updateForecastWeather(int countDay)
{

}

QStringList WeatherWorker::getSytiList()
{
    return QStringList {};
}

void WeatherWorker::readReady(QNetworkReply *reply) {

    delete reply;
}

