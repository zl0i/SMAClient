#include "serverworker.h"

ServerWorker::ServerWorker(QObject *parent) : QObject(parent)
{
    soc = new QTcpSocket(this);
    out.setDevice(soc);
   // out.setVersion(QDataStream::Qt_5_9);
    in.setDevice(soc);
    //in.setVersion(QDataStream::Qt_5_9);

}
#include <QHostAddress>

void ServerWorker::connectToServer() {
    QHostAddress adr;
    adr.setAddress("46.72.206.93");
    soc->connectToHost(adr, static_cast<uint16_t>(6666), QIODevice::ReadWrite);
    connect(soc, &QTcpSocket::connected, this, &ServerWorker::slotConnected);
    connect(soc, &QTcpSocket::readyRead, this, &ServerWorker::slotReadyRead);
    //connect(soc, &QTcpSocket::error, this, &ServerWorker::slotTcpError);
    connect(soc, &QTcpSocket::disconnected, this, &ServerWorker::slotDisconnected);
    connect(soc, SIGNAL(error(QAbstractSocket::SocketError)),
            this, SLOT(slotTcpError(QAbstractSocket::SocketError)));
}

void ServerWorker::slotConnected() {
    qDebug() << "connect";

   QJsonArray arr;
   arr.append("Сысоев Дмитрий");
   arr.append("Попов Дмитрий");
   arr.append("Ефремов Иван");
   QJsonObject obj;
   obj.insert("dayni", arr);
   QJsonDocument doc;
   doc.setObject(obj);
   //soc->write(doc.toBinaryData());
   out << doc.toBinaryData();

    //QByteArray arr("asdasd\n");
    //out << arr;
    //soc->write(arr);
    //soc->flush();

}

void ServerWorker::slotReadyRead()  {    
    qDebug() << "data read";
    //soc->flush();
    //QByteArray str = soc->readAll();
    QByteArray str;
    in >> str;
    qDebug() << str;
}

void ServerWorker::slotTcpError(QAbstractSocket::SocketError socketError) {
    soc->close();
    emit errorConnected("error url");
    qDebug() << "Error: " << socketError;
}

void ServerWorker::slotDisconnected() {
    soc->close();
    qDebug() << "disconnect";
    disconnect(soc, &QTcpSocket::connected, this, &ServerWorker::slotConnected);
    disconnect(soc, &QTcpSocket::readyRead, this, &ServerWorker::slotReadyRead);
    disconnect(soc, &QTcpSocket::connected, this, &ServerWorker::slotConnected);
    disconnect(soc, SIGNAL(error(QAbstractSocket::SocketError)),
               this, SLOT(slotTcpError(QAbstractSocket::SocketError)));
}
