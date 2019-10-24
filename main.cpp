#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>
#include "mainworker.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.addImportPath(":/");
    engine.addImportPath("D:/Project/Qt/ModuleQML");

    MainWorker *mainWorker = new MainWorker();    
    engine.rootContext()->setContextProperty("_server", mainWorker->serverWorker);
    engine.rootContext()->setContextProperty("_weather", mainWorker->weatherWorker);
    engine.rootContext()->setContextProperty("_sensors", mainWorker->sensorWorker);
    engine.rootContext()->setContextProperty("_cars", mainWorker->carWorker);

    mainWorker->sensorWorker->fillInTestData();
    mainWorker->carWorker->fillTestData();


    qmlRegisterSingletonType(QUrl("qrc:/MyStyle.qml"), "MyStyle", 1, 0, "MyStyle");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
