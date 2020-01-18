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

void ServerWorker::sendServerJsonDocument(QJsonDocument doc)
{
    if(!socket->isOpen())
        return;

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
    if(testMod) {
        qDebug() << "test mode";
    } else {
        QJsonDocument doc = getFormatedJson(AddField, obj);
        sendServerJsonDocument(doc);
    }
}

void ServerWorker::requestUpdateSensors() {
    if(testMod) {
        QJsonArray sensors;

        QJsonObject obj1 {
            {"battery", 47},
            {"ground", QJsonObject {
                    {"1", 58},
                    {"2", 60},
                    {"3", 65},
                    {"4", 70}
                }
            },
            {"gsmlvl", 85},
            {"humidity", 75},
            {"id", 1},
            {"lastUpdate", "2019-11-04 13:43:14.0"},
            {"latitude", 51.757893},
            {"longitude", 39.178092},
            {"name", "sensors1"},
            {"pressure", 785},
            {"temperature", 24.5}
        };
        sensors.append(obj1);

        QJsonObject obj2 {
            {"battery", 46},
            {"ground", QJsonObject {
                    {"1", 57},
                    {"2", 69},
                    {"3", 64},
                    {"4", 69}
                }
            },
            {"gsmlvl", 84},
            {"humidity", 74},
            {"id", 2},
            {"lastUpdate", "2019-11-04 18:50:11.0"},
            {"latitude", 51.75781},
            {"longitude", 39.178548},
            {"name", "sensors2"},
            {"pressure", 784},
            {"temperature", 24.4}
        };
        sensors.append(obj2);


        QJsonObject obj3 {
            {"battery", 45},
            {"ground", QJsonObject {
                    {"1", 56},
                    {"2", 68},
                    {"3", 63},
                    {"4", 68}
                }
            },
            {"gsmlvl", 83},
            {"humidity", 73},
            {"id", 3},
            {"lastUpdate", "2019-11-04 18:52:24.0"},
            {"latitude", 51.757736},
            {"longitude", 39.179084},
            {"name", "sensors3"},
            {"pressure", 783},
            {"temperature", 23.3}
        };
        sensors.append(obj3);

        QJsonObject obj4 {
            {"battery", 44},
            {"ground", QJsonObject {
                    {"1", 55},
                    {"2", 67},
                    {"3", 62},
                    {"4", 67}
                }
            },
            {"gsmlvl", 82},
            {"humidity", 72},
            {"id", 4},
            {"lastUpdate", "2019-11-04 18:53:57.0"},
            {"latitude", 51.757643},
            {"longitude", 39.17961},
            {"name", "sensors4"},
            {"pressure", 782},
            {"temperature", 23.2}
        };

        sensors.append(obj4);

        QJsonObject mainObj;
        mainObj.insert("sensors", sensors);
        emit comeDataSensors(ServerWorker::UpdateSensors, mainObj);
    } else {
        QJsonDocument doc = getFormatedJson(UpdateSensors);
        sendServerJsonDocument(doc);
    }
}

void ServerWorker::requestHistorySensor(int id, QString property, quint64 dt_start, quint64 dt_end) {

    if(testMod) {
        QJsonObject obj {
            {"history",  QJsonArray {
                    QJsonObject {
                        {"dt", "2020-01-16 19:17:53.919"},
                        {"value", 786}
                    },
                    QJsonObject {
                        {"dt", "2020-01-16 19:18:53.919"},
                        {"value", 785}
                    },
                    QJsonObject {
                        {"dt", "2020-01-16 19:19:53.919"},//2020-01-16 19:17:53.919
                        {"value", 758}
                    },
                    QJsonObject {
                        {"dt", "2020-01-16 19:20:53.919"},
                        {"value", 750}
                    },
                    QJsonObject {
                        {"dt", "2020-01-16 19:21:53.919"},
                        {"value", 400}
                    },
                    QJsonObject {
                        {"dt", "2020-01-16 19:22:53.919"},
                        {"value", 525}
                    },
                    QJsonObject {
                        {"dt", "2020-01-16 19:23:53.919"},
                        {"value", 800}
                    },
                    QJsonObject {
                        {"dt", "2020-01-16 19:24:53.919"},
                        {"value", 755}
                    }
                }
            },
            {"property", "pressure"},
            {"target_id", 1}
        };
        emit comeDataSensors(ServerWorker::HistorySensors, obj);
    } else {
        QJsonObject obj;
        obj.insert("target_id", id);
        obj.insert("dt_start", static_cast<int>(dt_start));
        obj.insert("dt_end", static_cast<int>(dt_end));
        obj.insert("property", property);
        QJsonDocument doc = getFormatedJson(HistorySensors, obj);
        sendServerJsonDocument(doc);
    }
}

void ServerWorker::requestUpdateCars() {
    if(testMod) {
        QJsonObject obj {
            {"cars", QJsonArray {
                    QJsonObject {
                        {"id", 1},
                        {"name", "cars1"},
                        {"latitude", 51.511226},
                        {"longitude", 39.286618},
                        {"speed", 0},
                        {"lastUpdate", "16564897415"}
                    },
                    QJsonObject {
                        {"id", 2},
                        {"name", "cars2"},
                        {"latitude", 51.511039},
                        {"longitude", 39.286660},
                        {"speed", 0},
                        {"lastUpdate", "16564897415"}
                    },
                    QJsonObject {
                        {"id", 3},
                        {"name", "cars3"},
                        {"latitude", 51.510959},
                        {"longitude", 39.276959},
                        {"speed", 30},
                        {"lastUpdate", "16564897415"}
                    }
                }
            }
        };
        emit comeDataCars(ServerWorker::UpdateCars, obj);
    } else {
        QJsonDocument doc = getFormatedJson(UpdateCars);
        sendServerJsonDocument(doc);
    }
}
