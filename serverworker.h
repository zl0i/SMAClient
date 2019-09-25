#ifndef SERVERWORKER_H
#define SERVERWORKER_H

#include <QObject>
#include <QTcpSocket>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QDataStream>

class ServerWorker : public QObject
{
    Q_OBJECT

    QTcpSocket *soc;
    QDataStream out;
    QDataStream in;

public:
    explicit ServerWorker(QObject *parent = nullptr);

    typedef enum {
        Authorization = 1,
        UpdateSensorData,
        UpdateCarsData
    }Request;

    void connectToServer();
signals:
    void winConnected();
    void errorConnected(QString error);

public slots:
    void slotConnected();
    void slotReadyRead();
    void slotTcpError(QAbstractSocket::SocketError socketError);
    void slotDisconnected();
};

#endif // SERVERWORKER_H
