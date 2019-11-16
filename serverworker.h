#ifndef SERVERWORKER_H
#define SERVERWORKER_H

#include <QObject>
#include <QTcpSocket>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QHostAddress>
#include <QDateTime>
#include <QAbstractSocket>

class ServerWorker : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString login READ login NOTIFY inputChanged)
    Q_PROPERTY(QString password READ password NOTIFY inputChanged)

    Q_PROPERTY(QString fullName READ fullName NOTIFY clientChanged)
    Q_PROPERTY(QString companyName READ companyName NOTIFY clientChanged)
    Q_PROPERTY(QString role READ role NOTIFY clientChanged)


public:
    explicit ServerWorker(QObject *parent = nullptr);
    ~ServerWorker() ;

    typedef enum {
        Authorization = 1,
        UpdateFields,
        UpdateSensors,
        UpdateCars,
        HistorySensors
    }Request;

    typedef enum {

    }ErrorServer;
    Q_ENUM(ErrorServer)


    Q_INVOKABLE void connectToServer(QString addr, int port, QString login, QString password);
    void connectToTestServer();


    QString login() { return  m_login; }
    QString password() { return  m_password; }
    QString fullName() { return  m_fullName; }
    QString companyName() { return  m_companyName; }
    QString role() { return m_role; }

private:
    QTcpSocket *socket;
    QString m_login;
    QString m_password;

    QString m_fullName;
    QString m_companyName;
    QString m_role;

    bool testMod = false;

    QJsonDocument getFormatedJson(Request);
    QJsonDocument getFormatedJson(Request, QJsonObject);
    void sendServerJsonDocument(QJsonDocument);
    QJsonDocument getServerJsonDocument();

signals:
    void winConnected();
    void errorConnected(int code, QString text);

    void comeDataFields(Request type, QJsonObject obj);
    void comeDataSensors(Request type, QJsonObject obj);
    void comeDataCars(Request type, QJsonObject obj);

    void inputChanged();
    void clientChanged();

public slots:
    void slotConnected();
    void slotReadyRead();
    void slotTcpError(QAbstractSocket::SocketError socketError);
    void slotDisconnected();

    void requestUpdateFields();
    void requestNewFields(QJsonObject);

    void requestUpdateSensors();
    void requestHistorySensor(int id, QString property, quint64 dt_start, quint64 dt_end);

    void requestUpdateCars();
};

#endif // SERVERWORKER_H
