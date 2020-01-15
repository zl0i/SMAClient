#ifndef MAINWORKER_H
#define MAINWORKER_H

#include <QObject>
#include <QSettings>
#include "serverworker.h"
#include "weatherworker.h"
#include "sensorworker.h"
#include "carworker.h"
#include "fieldworker.h"

class MainWorker : public QObject
{
    Q_OBJECT   
    Q_PROPERTY(QString mapType READ mapType WRITE setMapType NOTIFY mapTypeChanged)
    Q_PROPERTY(int style READ style WRITE setStyle NOTIFY styleChanged)
    Q_PROPERTY(QString login READ login WRITE setLogin NOTIFY loginChanged)
    Q_PROPERTY(QString password READ password WRITE setPassword NOTIFY passwordChanged)
    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY urlChanged)

    Q_PROPERTY(QString language READ language WRITE setLanguage NOTIFY languageChanged)

public:
    explicit MainWorker(QObject *parent = nullptr);

    ServerWorker *serverWorker = new ServerWorker(this);
    SensorWorker *sensorWorker = new SensorWorker(this);
    CarWorker *carWorker = new CarWorker(this);
    FieldWorker *fieldWorker = new FieldWorker(this);
    WeatherWorker *weatherWorker = new WeatherWorker(this);

    Q_INVOKABLE void removeAllSettings();


    QString mapType() { return m_mapType; }
    void setMapType(QString);

    int style() { return  m_style; }
    void setStyle(int);

    QString login() { return m_login; }
    void setLogin(QString);

    QString password() { return m_password; }
    void setPassword(QString);

    QString url() { return  m_url; }
    void setUrl(QString);

    QString language() { return  m_language; }
    void setLanguage(QString);

private:
    QTimer *weatherTimer = new QTimer;

    QSettings *settings = new QSettings;

    QString m_mapType;
    int m_style;
    QString m_login;
    QString m_password;
    QString m_url;
    QString m_language;

signals:   
    void mapTypeChanged();
    void styleChanged();
    void loginChanged();
    void passwordChanged();
    void urlChanged();
    void languageChanged();

public slots:
    void slotUpdateWeatherTimer();
};

#endif // MAINWORKER_H
