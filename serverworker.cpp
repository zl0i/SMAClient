#include "serverworker.h"

ServerWorker::ServerWorker(QObject *parent) : QObject(parent)
{
    socket = new QTcpSocket(this);
}

ServerWorker::~ServerWorker() {
    socket->close();
}

void ServerWorker::connectToServer(QString addr, uint16_t port, QString login, QString password) {
    this->login = login;
    this->password = password;
    socket->connectToHost(QHostAddress(addr), port, QIODevice::ReadWrite);
    connect(socket, &QTcpSocket::connected, this, &ServerWorker::slotConnected);
    connect(socket, &QTcpSocket::readyRead, this, &ServerWorker::slotReadyRead);
    //connect(soc, &QTcpSocket::error, this, &ServerWorker::slotTcpError);
    connect(socket, &QTcpSocket::disconnected, this, &ServerWorker::slotDisconnected);
    connect(socket, SIGNAL(error(QAbstractSocket::SocketError)),
            this, SLOT(slotTcpError(QAbstractSocket::SocketError)));
}

void ServerWorker::connectToTestServer() {
    socket->connectToHost(QHostAddress("46.72.206.93"), static_cast<uint16_t>(6666), QIODevice::ReadWrite);
    connect(socket, &QTcpSocket::connected, this, &ServerWorker::slotConnected);
    connect(socket, &QTcpSocket::readyRead, this, &ServerWorker::slotReadyRead);
    //connect(soc, &QTcpSocket::error, this, &ServerWorker::slotTcpError);
    connect(socket, &QTcpSocket::disconnected, this, &ServerWorker::slotDisconnected);
    connect(socket, SIGNAL(error(QAbstractSocket::SocketError)),
            this, SLOT(slotTcpError(QAbstractSocket::SocketError)));
}

void ServerWorker::slotConnected() {
    /*qDebug() << "connect";
    QJsonObject obj;
    obj.insert("name", "Sisoev Dmitry");
    QJsonObject obj1;
    obj1.insert("name", "Popov Dmitry");
    QJsonObject obj2;
    obj2.insert("name", "Sisoev2 Dmitry2");
    QJsonArray arr;
    arr.append(obj);
    arr.append(obj1);
    arr.append(obj2);
    QJsonObject obj3;
    obj3.insert("dayni", arr);
    QJsonDocument doc(obj3);
    QString strJson(doc.toJson(QJsonDocument::Compact));
    socket->write(strJson.toUtf8());*/

    QJsonObject obj;
    obj.insert("login", this->login);
    obj.insert("password", this->password);
    sendServerJsonDocument(getFormatedJson(Authorization, obj));

}

void ServerWorker::slotReadyRead()  {
    QJsonDocument doc = getServerJsonDocument();
    QJsonObject obj = doc.object();
    Request type = static_cast<Request>(obj.value("type").toInt());

    switch (type) {
    case Authorization: {
        QJsonObject mainObj = obj.value("main").toObject();
        if(mainObj.value("answer").toBool()) {
            this->token = mainObj.value("token").toString();
            emit winConnected();
        }
        else {
            emit errorConnected(socket->errorString());
        }
        break;
    }
    case UpdateSensors: {
        emit comeDataSensors(type, obj.value("main").toObject());
        break;
    }
    case UpdateCars: {
        emit comeDataCars(type, obj.value("main").toObject());
        break;
    }
    case HistorySensors: {
        emit comeDataSensors(type, obj.value("main").toObject());
        break;
    }
    }

}

void ServerWorker::slotTcpError(QAbstractSocket::SocketError socketError) {
    socket->close();
    Q_UNUSED(socketError)
    emit errorConnected(socket->errorString());
    qDebug() << "Error: " << socket->errorString();
}

void ServerWorker::slotDisconnected() {
    socket->close();
    qDebug() << "disconnect";
    disconnect(socket, &QTcpSocket::connected, this, &ServerWorker::slotConnected);
    disconnect(socket, &QTcpSocket::readyRead, this, &ServerWorker::slotReadyRead);
    disconnect(socket, &QTcpSocket::connected, this, &ServerWorker::slotConnected);
    disconnect(socket, SIGNAL(error(QAbstractSocket::SocketError)),
               this, SLOT(slotTcpError(QAbstractSocket::SocketError)));
}

QJsonDocument ServerWorker::getFormatedJson(Request type) {
    QJsonObject systemObj;
    systemObj.insert("dt", QDateTime::currentSecsSinceEpoch());
    QJsonObject mainObj;
    mainObj.insert("type", type);
    mainObj.insert("token", token);
    mainObj.insert("system", systemObj);
    QJsonDocument doc;
    doc.setObject(mainObj);
    return doc;
}

QJsonDocument ServerWorker::getFormatedJson(Request type, QJsonObject obj) {
    QJsonObject systemObj;
    systemObj.insert("dt", QDateTime::currentSecsSinceEpoch());
    QJsonObject mainObj;
    mainObj.insert("type", type);
    mainObj.insert("token", token);
    mainObj.insert("system", systemObj);
    mainObj.insert("main", obj);
    QJsonDocument doc;
    doc.setObject(mainObj);
    return doc;
}

void ServerWorker::sendServerJsonDocument(QJsonDocument doc) {
    QString strJson(doc.toJson(QJsonDocument::Compact));
    socket->write(strJson.toUtf8());
    socket->write(strJson.toUtf8());
}

QJsonDocument ServerWorker::getServerJsonDocument() {
    QJsonDocument doc;
    doc.fromJson(socket->readAll());
    return doc;
}

void ServerWorker::requestUpdateSensors() {
    QJsonDocument doc = getFormatedJson(UpdateSensors);
    sendServerJsonDocument(doc);
}

void ServerWorker::requestHistorySensor(int id, QString property, quint64 dt_start, quint64 dt_end) {
    QJsonObject obj;
    obj.insert("target_id", id);
    obj.insert("dt_start", static_cast<int>(dt_start));
    obj.insert("dt_end", static_cast<int>(dt_end));
    obj.insert("property", property);
    QJsonDocument doc = getFormatedJson(HistorySensors, obj);
    sendServerJsonDocument(doc);
}

void ServerWorker::requestUpdateCars() {
    QJsonDocument doc = getFormatedJson(UpdateCars);
    sendServerJsonDocument(doc);
}
