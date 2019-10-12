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

    QTcpSocket *socket;
    QString login;
    QString password;
    QString token;

public:
    explicit ServerWorker(QObject *parent = nullptr);
    ~ServerWorker() ;

    typedef enum {
        Authorization = 1,
        UpdateSensors,
        UpdateCars,
        HistorySensors
    }Request;

    void connectToServer(QString addr, uint16_t port, QString login, QString password);
    void connectToTestServer();



private:
    QJsonDocument getFormatedJson(Request);
    QJsonDocument getFormatedJson(Request, QJsonObject);
    void sendServerJsonDocument(QJsonDocument);
    QJsonDocument getServerJsonDocument();

signals:
    void winConnected();
    void errorConnected(QString);

    void comeDataCars(Request type, QJsonObject obj);
    void comeDataSensors(Request type, QJsonObject obj);

public slots:
    void slotConnected();
    void slotReadyRead();
    void slotTcpError(QAbstractSocket::SocketError socketError);
    void slotDisconnected();

    void requestUpdateSensors();
    void requestHistorySensor(int id, QString property, quint64 dt_start, quint64 dt_end);
    void requestUpdateCars();

};

#endif // SERVERWORKER_H
