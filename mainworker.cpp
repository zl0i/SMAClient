#include "mainworker.h"

MainWorker::MainWorker(QObject *parent) : QObject(parent)
{    

    connect(fieldWorker, &FieldWorker::updateFieldsFromServer, serverWorker, &ServerWorker::requestUpdateFields);
    connect(fieldWorker, &FieldWorker::sendNewFieldToServer, serverWorker, &ServerWorker::requestNewFields);
    connect(serverWorker, &ServerWorker::comeDataFields, fieldWorker, &FieldWorker::parseDate);

    connect(sensorWorker, &SensorWorker::updateSensorsFromServer, serverWorker, &ServerWorker::requestUpdateSensors);
    connect(sensorWorker, &SensorWorker::getHistorySensorFromServer, serverWorker, &ServerWorker::requestHistorySensor);
    connect(serverWorker, &ServerWorker::comeDataSensors, sensorWorker, &SensorWorker::parseDate);

    connect(carWorker, &CarWorker::updateCarsFromServer, serverWorker, &ServerWorker::requestUpdateCars);
    connect(serverWorker, &ServerWorker::comeDataCars, carWorker, &CarWorker::parseDate);

    weatherTimer->setInterval(1000*60*30);
    connect(weatherTimer, &QTimer::timeout, this, &MainWorker::slotUpdateWeatherTimer);

    m_mapType = settings->value("settings/map/type", "1").toString();
    m_style = settings->value("settings/interface/style", 0).toInt();
    m_login = settings->value("settings/system/login", "").toString();
    m_password = settings->value("settings/system/password", "").toString();
    m_language = settings->value("", "ru").toString();

}


void MainWorker::slotUpdateWeatherTimer() {
    weatherWorker->updateAll();
}

void MainWorker::removeAllSettings() {
    settings->clear();
}

void MainWorker::setMapType(QString type) {
    m_mapType = type;
    settings->setValue("settings/map/type", m_mapType);
    emit mapTypeChanged();
}

void MainWorker::setStyle(int s) {
    m_style = s;
    settings->setValue("settings/interface/style", m_style);
    emit styleChanged();
}

void MainWorker::setLogin(QString login) {
    m_login = login;
    settings->setValue("settings/system/login", m_login);
    emit loginChanged();
}

void MainWorker::setPassword(QString password) {
    m_password = password;
    settings->setValue("settings/system/password", m_password);
    emit passwordChanged();
}

void MainWorker::setLanguage(QString lang) {
    m_language = lang;
    //QTranslator translator;
    //translator.load(":translation/main_de");
    //app.installTranslator(&translator);
    //engine.retranslate()
    settings->setValue("settings/system/language", m_language);
}
