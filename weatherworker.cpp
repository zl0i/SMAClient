#include "weatherworker.h"

WeatherWorker::WeatherWorker(QObject *parent) : QObject(parent)
{
    //networkManager = new QNetworkAccessManager();
    connect(&networkManager, &QNetworkAccessManager::finished, this, &WeatherWorker::onResult);
    type = Idle;

    //updateCurrentWeather();
    //updateDailyForecastWeather();
    //updateTwoDailyForecastWeather();

    //updateAll();

    //https://api.openweathermap.org/data/2.5/uvi?lat=51.67&lon=39.17&appid=10a1eeb233d35e9780031ad22d567cd4 // ультрафиолет
    //https://api.openweathermap.org/data/2.5/forecast?id=472045&appid=10a1eeb233d35e9780031ad22d567cd4 // прогноз на 5 дней
    //https://api.openweathermap.org/data/2.5/forecast/daily?id=472045&appid=10a1eeb233d35e9780031ad22d567cd4 // прогноз на 16 дней
    //https://tile.openweathermap.org/map/temp_new/6/53.0561/37.8864.png?appid=10a1eeb233d35e9780031ad22d567cd4 тайл на карту
}


WeatherWorker::~WeatherWorker() {
    //delete  networkManager;
}

void WeatherWorker::updateCurrentWeather()
{
    //https://api.openweathermap.org/data/2.5/weather?id=472045&appid=10a1eeb233d35e9780031ad22d567cd4
    if(type == Idle) {
        networkManager.get(QNetworkRequest(QUrl("https://api.openweathermap.org/data/2.5/weather?id=472045&appid=10a1eeb233d35e9780031ad22d567cd4")));
        type = CurrentWeather;
    }
}

void WeatherWorker::updateDailyForecastWeather()
{
    //http://api.openweathermap.org/data/2.5/forecast?id=472045&appid=10a1eeb233d35e9780031ad22d567cd4
    if(type == Idle) {
        networkManager.get(QNetworkRequest(QUrl("http://api.openweathermap.org/data/2.5/forecast?id=472045&appid=10a1eeb233d35e9780031ad22d567cd4")));
        type = DailyForecast;
    }
}

void WeatherWorker::updateTwoDailyForecastWeather()
{
    //http://api.openweathermap.org/data/2.5/forecast/daily?id=472045&cnt=14&appid=10a1eeb233d35e9780031ad22d567cd4
    if(type == Idle) {
        networkManager.get(QNetworkRequest(QUrl("http://api.openweathermap.org/data/2.5/forecast/daily?id=472045&cnt=14&appid=10a1eeb233d35e9780031ad22d567cd4")));
        type = TwoDailyForecast;
    }
}

void WeatherWorker::updateAll() {
    updateCurrentWeather();
    m_allUpdate = true;
}

QStringList WeatherWorker::getSytiList()
{
    return QStringList {};
}

void WeatherWorker::onResult(QNetworkReply *reply) {
    switch (type) {
    case CurrentWeather: {
        parseCurrentWeather(reply);
        emit currentWetherChanged();       
        break;
    }
    case DailyForecast: {
        parseDailyForecast(reply);
        emit dailyForecastChanged();
        break;
    }
    case TwoDailyForecast: {
        parseTwoDailyForecast(reply);
        emit twoDailyForecastChanged();
        break;
    }
    default: {

    }
    }
    if(m_allUpdate) {
       if(type == TwoDailyForecast) {
           type = Idle;
           m_allUpdate = false;
       }
       if(type == DailyForecast) {
           type = Idle;
           updateTwoDailyForecastWeather();
       }
       if(type == CurrentWeather) {
           type = Idle;
           updateDailyForecastWeather();
       }
    } else {
        type = Idle;
    }
    delete reply;
}

void WeatherWorker::parseCurrentWeather(QNetworkReply *reply) {

    QJsonDocument document = QJsonDocument::fromJson(reply->readAll());
    QJsonObject rootObj = document.object();
    m_currentWeather.insert("dt", getStringDateFromUTS(rootObj.value("dt").toInt()));

    QJsonObject temp = rootObj.value("weather").toObject();
    m_currentWeather.insert("type", temp.value("main"));

    temp =  rootObj.value("main").toObject();
    m_currentWeather.insert("temp", temp.value("temp").toDouble()-273);
    m_currentWeather.insert("temp_min", temp.value("temp_min").toDouble()-273.00);
    m_currentWeather.insert("temp_max", temp.value("temp_max").toDouble()-273.00);
    m_currentWeather.insert("pressure", temp.value("pressure"));
    m_currentWeather.insert("humidity", temp.value("humidity"));

    temp =  rootObj.value("wind").toObject();
    m_currentWeather.insert("speedWind", temp.value("speed"));
    m_currentWeather.insert("degWind", temp.value("deg"));

    temp =  rootObj.value("sys").toObject();
    m_currentWeather.insert("sunrise", getStringDateFromUTS(temp.value("sunrise").toInt()));
    m_currentWeather.insert("sunset", getStringDateFromUTS(temp.value("sunset").toInt()));

}

void WeatherWorker::parseDailyForecast(QNetworkReply *reply) {
    QJsonDocument document = QJsonDocument::fromJson(reply->readAll());
    QJsonArray listObj = document.object().value("list").toArray();


    for(int i = 0; i < listObj.size(); ++i) {
        QJsonObject item;
        QJsonObject element = listObj.at(i).toObject();
        item.insert("dt", getStringDateFromUTS(element.value("dt").toInt()));

        QJsonObject temp = element.value("weather").toObject();
        item.insert("type", temp.value("main"));

        temp =  element.value("main").toObject();
        item.insert("temp", temp.value("temp").toDouble()-273.00);
        item.insert("temp_min", temp.value("temp_min").toDouble()-273.00);
        item.insert("temp_max", temp.value("temp_max").toDouble()-273.00);
        item.insert("pressure", temp.value("pressure"));
        item.insert("humidity", temp.value("humidity"));

        temp =  element.value("wind").toObject();
        item.insert("speedWind", temp.value("speed"));
        item.insert("degWind", temp.value("deg"));

        /*temp =  element.value("sys").toObject();
        item.insert("sunrise", temp.value("sunrise"));
        item.insert("sunset", temp.value("sunset"));*/


        m_dailyForecast.append(item);
    }
}

void WeatherWorker::parseTwoDailyForecast(QNetworkReply *reply) {
    QJsonDocument document = QJsonDocument::fromJson(reply->readAll());
    QJsonArray listObj = document.object().value("list").toArray();

    for(int i = 0; i < listObj.size(); ++i) {
        QJsonObject item;
        QJsonObject element = listObj.at(i).toObject();
        item.insert("dt", getStringDateFromUTS(element.value("dt").toInt()));
        item.insert("sunrise", getStringDateFromUTS(element.value("sunrise").toInt()));
        item.insert("sunset", getStringDateFromUTS(element.value("sunset").toInt()));
        item.insert("speedWind", element.value("speed"));
        item.insert("degWind", element.value("deg"));
        item.insert("pressure", element.value("pressure"));
        item.insert("humidity", element.value("humidity"));

        QJsonObject temp = element.value("weather").toObject();
        item.insert("type", temp.value("main"));

        temp =  element.value("temp").toObject();
        item.insert("temp", temp.value("day").toDouble()-273.00);
        item.insert("temp_min", temp.value("min").toDouble()-273.00);
        item.insert("temp_max", temp.value("max").toDouble()-273.00);

        m_twoDailyForecast.append(item);
    }
}

QString WeatherWorker::getStringDateFromUTS(int sec) {
    QDateTime dt;
    dt.setSecsSinceEpoch(sec);
    return  dt.toString();
}

