#include "serverworker.h"

ServerWorker::ServerWorker(QObject *parent) : QObject(parent)
{
    socket = new QTcpSocket(this);
    m_login = "test";
    m_password = "test";
}

ServerWorker::~ServerWorker() {
    socket->close();
}

void ServerWorker::connectToServer(QString addr, int port, QString login, QString password) {
    if(addr.isEmpty() || port == 0 || login.isEmpty() || password.isEmpty()) {
        emit  errorConnected(401, "");
        return;
    }
    this->m_login = login;
    this->m_password = password;
    emit inputChanged();
    if(login == "test" && password == "test") {
        testMod = true;
        m_fullName = "Сукачев Александр Игоревич";
        m_companyName = "ИП Сукачев";
        m_role = "Директор";
        emit clientChanged();
        emit winConnected();
        return;
    }
    if(!socket->isOpen()) {
        socket->connectToHost(QHostAddress(addr), static_cast<uint16_t>(port), QIODevice::ReadWrite);
        connect(socket, &QTcpSocket::connected, this, &ServerWorker::slotConnected);
        connect(socket, &QTcpSocket::readyRead, this, &ServerWorker::slotReadyRead);
        connect(socket, &QTcpSocket::disconnected, this, &ServerWorker::slotDisconnected);
        connect(socket, SIGNAL(error(QAbstractSocket::SocketError)),
                this, SLOT(slotTcpError(QAbstractSocket::SocketError)));
    }
    else {
        slotConnected();
    }
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
    QJsonObject obj;
    obj.insert("login", this->m_login);
    obj.insert("password", this->m_password);
    sendServerJsonDocument(getFormatedJson(Authorization, obj));

}

void ServerWorker::slotReadyRead()  {
    QJsonDocument doc = getServerJsonDocument();
    QJsonObject obj = doc.object();
    Request type = static_cast<Request>(obj.value("type").toInt());
    qDebug() << doc;
    switch (type) {
    case Authorization: {
        QJsonObject mainObj = obj.value("main").toObject();
        if(mainObj.value("answer").toBool()) {
            m_fullName = mainObj.value("fullName").toString();
            m_companyName = mainObj.value("companyName").toString();
            emit clientChanged();
            emit winConnected();
        }
        else {
            emit errorConnected(401, socket->errorString());
        }
        break;
    }
    case UpdateFields: {
        emit comeDataFields(type, obj.value("main").toObject());
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
    default: {
        emit errorConnected(400, socket->errorString());
    }
    }

}

void ServerWorker::slotTcpError(QAbstractSocket::SocketError socketError) {
    socket->close();
    Q_UNUSED(socketError)
    emit errorConnected(404, socket->errorString());
}

void ServerWorker::slotDisconnected() {
    socket->close();
    qDebug() << "disconnect";
    testMod= false;
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
    mainObj.insert("system", systemObj);
    mainObj.insert("main", obj);
    QJsonDocument doc;
    doc.setObject(mainObj);
    return doc;
}

void ServerWorker::sendServerJsonDocument(QJsonDocument doc) {
    QString strJson(doc.toJson(QJsonDocument::Compact));
    socket->write(strJson.toUtf8());
    socket->write("\n");
}

QJsonDocument ServerWorker::getServerJsonDocument() {       
    return QJsonDocument::fromJson(socket->readAll());
}

void ServerWorker::requestUpdateFields() {
    if(testMod) {
        QJsonObject obj;
        obj.insert("name", "filed1");
        obj.insert("pressure", 783.5);
        obj.insert("temperature", 23.85);
        obj.insert("humidity", 73.5);
        obj.insert("id", 1);
        obj.insert("lastUpdate", "2019-11-04 13:43:14.0");

        QJsonObject point;
        point.insert("latitude", 51.757726);
        point.insert("longitude", 39.178850);
        obj.insert("center", point);

        QJsonArray location;

        point.insert("latitude", 51.758113);
        point.insert("longitude", 39.177992);
        location.append(point);

        point.insert("latitude", 51.757883);
        point.insert("longitude", 39.179853);
        location.append(point);

        point.insert("latitude", 51.757364);
        point.insert("longitude", 39.179730);
        location.append(point);

        point.insert("latitude", 51.757613);
        point.insert("longitude", 39.177997);
        location.append(point);

        obj.insert("location", location);
        QJsonArray fields;
        fields.append(obj);
        QJsonObject mainObj;
        mainObj.insert("fields", fields);

        emit comeDataFields(ServerWorker::UpdateFields, mainObj);
    } else {
        QJsonDocument doc = getFormatedJson(UpdateFields);
        sendServerJsonDocument(doc);
    }
}

void ServerWorker::requestNewFields(QJsonObject obj) {
    Q_UNUSED(obj)
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
