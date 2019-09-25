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

    MainWorker *mainWorker = new MainWorker();
    engine.rootContext()->setContextProperty("_server", mainWorker->serverWorker);
    engine.rootContext()->setContextProperty("_weather", mainWorker->weatherWorker);
    engine.rootContext()->setContextProperty("_models", mainWorker->dataWorker);

    mainWorker->serverWorker->connectToServer();
    //mainWorker->dataWorker->fillInTestData();

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;



    return app.exec();
}
