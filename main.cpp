#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>
#include "mainworker.h"
#include <QDateTime>
#include <QSslSocket>

int main(int argc, char *argv[])
{

    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    QApplication::setApplicationName("SMAClient");
    QApplication::setOrganizationName("zloi");

    //qDebug() << QSslSocket::supportsSsl() << QSslSocket::sslLibraryBuildVersionString();

    QQmlApplicationEngine engine;
    engine.addImportPath(":/");
    engine.addImportPath("D:/Project/Qt/ModuleQML");

    MainWorker *mainWorker = new MainWorker();
    engine.rootContext()->setContextProperty("_main", mainWorker);
    engine.rootContext()->setContextProperty("_server", mainWorker->serverWorker);
    engine.rootContext()->setContextProperty("_weather", mainWorker->weatherWorker);
    engine.rootContext()->setContextProperty("_fields", mainWorker->fieldWorker);
    engine.rootContext()->setContextProperty("_sensors", mainWorker->sensorWorker);
    engine.rootContext()->setContextProperty("_cars", mainWorker->carWorker);


    qmlRegisterSingletonType(QUrl("qrc:/MyStyle.qml"), "MyStyle", 1, 0, "MyStyle");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
