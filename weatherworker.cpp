#include "weatherworker.h"

WeatherWorker::WeatherWorker(QObject *parent) : QObject(parent)
{

    networkManager = new QNetworkAccessManager(this);
    m_addedModel = new QStandardItemModel(this);

    QHash<int, QByteArray> hash;
    hash.insert(WeatherPlaceModel::City_id, "addedCityId");
    hash.insert(WeatherPlaceModel::City_name, "addedCityName");
    m_addedModel->setItemRoleNames(hash);
    m_addedModel->insertColumn(0);

    weatherModel = new WeatherPlaceModel();
    weatherModel->fillModel();

    filledPlaceFromSettings();

    currentId = 472045;
    updateWeatherById(currentId);

}


WeatherWorker::~WeatherWorker() {
    delete  networkManager;
}

void WeatherWorker::updateCurrentWeather()
{
    //https://api.openweathermap.org/data/2.5/weather?id=472045&appid=10a1eeb233d35e9780031ad22d567cd4
    QNetworkRequest req(QUrl("http://api.openweathermap.org/data/2.5/weather?id="+ QString::number(currentId) + "&appid=10a1eeb233d35e9780031ad22d567cd4"));
    QNetworkReply *reply;
    reply = networkManager->get(req);
    connect(reply, &QNetworkReply::finished, this, &WeatherWorker::handlerCurrentWeather);

}

void WeatherWorker::updateDailyForecastWeather()
{
    //http://api.openweathermap.org/data/2.5/forecast?id=472045&appid=10a1eeb233d35e9780031ad22d567cd4
    QNetworkReply *reply;
    reply = networkManager->get(QNetworkRequest(QUrl("http://api.openweathermap.org/data/2.5/forecast?id="+ QString::number(currentId) + "&appid=10a1eeb233d35e9780031ad22d567cd4")));
    connect(reply, &QNetworkReply::finished, this, &WeatherWorker::handlerDailyForecast);

}

void WeatherWorker::updateTwoDailyForecastWeather()
{
    //http://api.openweathermap.org/data/2.5/forecast/daily?id=472045&cnt=14&appid=10a1eeb233d35e9780031ad22d567cd4
    QNetworkReply *reply;
    reply = networkManager->get(QNetworkRequest(QUrl("http://api.openweathermap.org/data/2.5/forecast/daily?id="+ QString::number(currentId) + "&cnt=14&appid=10a1eeb233d35e9780031ad22d567cd4")));
    connect(reply, &QNetworkReply::finished, this, &WeatherWorker::handlerTwoDailyForecast);

}

void WeatherWorker::updateWeatherById(int id)
{
    currentId = id;
    m_relevantData = false;
    updateCurrentWeather();
    updateDailyForecastWeather();
    updateTwoDailyForecastWeather();

}

void WeatherWorker::addPlaceWeather(int id, QString name)
{
    m_addedModel->insertRow(m_addedModel->rowCount());
    QModelIndex index = m_addedModel->index(m_addedModel->rowCount()-1, 0);
    m_addedModel->setData(index, id, WeatherPlaceModel::City_id);
    m_addedModel->setData(index, name, WeatherPlaceModel::City_name);
    emit addedPlaceChanged();
    settingsPlace();
}


QStringList WeatherWorker::getSytiList()
{
    return QStringList {};
}

void WeatherWorker::parseCurrentWeather(QJsonObject obj) {

    QJsonObject rootObj = obj;
    m_currentWeather.insert("dt", getStringDateFromUTS(rootObj.value("dt").toInt()));
    QJsonObject temp = rootObj.value("weather").toArray().at(0).toObject();
    m_currentWeather.insert("type", temp.value("main").toString());
    m_currentWeather.insert("description", temp.value("description").toString());

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

void WeatherWorker::parseDailyForecast(QJsonObject obj)
{
    QJsonArray listObj = obj.value("list").toArray();
    QJsonArray model;
    QDateTime today = QDateTime::currentDateTime();

    QDate currentDate = QDate::currentDate();
    currentDate = currentDate.addDays(1);

    int cnt = 0;
    for(cnt = 0; cnt < listObj.size(); ++cnt) {
        QJsonObject element = listObj.at(cnt).toObject();
        QJsonObject item;

        QDateTime dt;
        dt.setSecsSinceEpoch(element.value("dt").toInt());

        if(dt.date().day() == today.date().day()) {
            QJsonObject tmp {
                {"dt",  getStringDateFromUTS(element.value("dt").toInt())},
                {"temp", element.value("main").toObject().value("temp").toDouble()-273.00}
            };
            model.append(tmp);
        } else {
            break;
        }
    }

    m_currentWeather.insert("forecast", model);    

    for(; cnt < listObj.size(); cnt+=8) {
        QJsonObject startElement = listObj.at(cnt).toObject();
         QJsonObject midElement;
        if(cnt + 4 < listObj.size())
            midElement = listObj.at(cnt+4).toObject();
        else
            midElement = listObj.last().toObject();

        QJsonObject item;

        QDateTime dt;
        dt.setSecsSinceEpoch(midElement.value("dt").toInt());
        item.insert("dt", getStringDateFromUTS(midElement.value("dt").toInt()));

        QJsonObject temp = midElement.value("weather").toArray().at(0).toObject();
        item.insert("type", temp.value("main"));
        item.insert("description", temp.value("description"));

        temp =  midElement.value("main").toObject();
        item.insert("temp", temp.value("temp").toDouble()-273.00);
        item.insert("temp_min", temp.value("temp_min").toDouble()-273.00);
        item.insert("temp_max", temp.value("temp_max").toDouble()-273.00);
        item.insert("pressure", temp.value("pressure"));
        item.insert("humidity", temp.value("humidity"));

        temp =  midElement.value("wind").toObject();
        item.insert("speedWind", temp.value("speed"));
        item.insert("degWind", temp.value("deg"));

        QJsonArray forecastDay;

        for(int i = cnt; i < listObj.size() && (i < cnt + 8); ++i) {
            QJsonObject element2 = listObj.at(i).toObject();

            QDateTime dt2;
            dt2.setSecsSinceEpoch(element2.value("dt").toInt());

            if(dt.date().day() == dt2.date().day()) {
                QJsonObject item2 {
                    {"dt",  getStringDateFromUTS(element2.value("dt").toInt())},
                    {"temp", element2.value("main").toObject().value("temp").toDouble()-273.00}
                };
                forecastDay.append(item2);
            }
        }
        item.insert("forecast", forecastDay);       
        m_dailyForecast.append(item);
    }    
}

void WeatherWorker::parseTwoDailyForecast(QJsonObject obj) {

    QJsonArray listObj = obj.value("list").toArray();

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

        QJsonObject temp = element.value("weather").toArray().at(0).toObject();
        item.insert("type", temp.value("main"));
        item.insert("description", temp.value("description"));

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

void WeatherWorker::filledPlaceFromSettings()
{
    QJsonArray arr = settings.value("settings/placeWeather", QJsonArray {}).toJsonArray();
    for(int i = 0; i < arr.size(); i++) {
        QJsonObject obj = arr.at(i).toObject();
        m_addedModel->insertRow(i);
        QModelIndex index = m_addedModel->index(i, 0);
        m_addedModel->setData(index, obj.value("id").toInt() ,WeatherPlaceModel::City_id);
        m_addedModel->setData(index, obj.value("name").toString(), WeatherPlaceModel::City_name);
    }

    emit addedPlaceChanged();
}

void WeatherWorker::settingsPlace()
{
    QJsonArray arr;
    for(int i = 0; i < m_addedModel->rowCount(); i++) {
        QJsonObject obj;
        QModelIndex index = m_addedModel->index(i, 0);
        obj.insert("id", m_addedModel->data(index, WeatherPlaceModel::City_id).toJsonValue());
        obj.insert("name", m_addedModel->data(index, WeatherPlaceModel::City_name).toJsonValue());
        arr.append(obj);
    }
    settings.setValue("settings/placeWeather", arr);
}

void WeatherWorker::handlerCurrentWeather() {
    QNetworkReply *reply = static_cast<QNetworkReply*>(sender());
    QJsonDocument document = QJsonDocument::fromJson(reply->readAll());

    parseCurrentWeather(document.object());
    m_relevantData = true;
    emit currentWetherChanged();
    reply->deleteLater();
}

void WeatherWorker::handlerDailyForecast() {
    QNetworkReply *reply = static_cast<QNetworkReply*>(sender());
    QJsonDocument document = QJsonDocument::fromJson(reply->readAll());

    parseDailyForecast(document.object());
    emit currentWetherChanged();
    emit dailyForecastChanged();
    reply->deleteLater();
}

void WeatherWorker::handlerTwoDailyForecast() {
    QNetworkReply *reply = static_cast<QNetworkReply*>(sender());
    QJsonDocument document = QJsonDocument::fromJson(reply->readAll());

    parseTwoDailyForecast(document.object());
    emit twoDailyForecastChanged();
    reply->deleteLater();
}
