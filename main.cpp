#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include "SerialPort.h"
#include "DataSource.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<SerialPort>("com.ar", 1, 0, "SerialPort");
    qmlRegisterType<DataSource>("com.ar", 1, 0, "DataSource");
    SerialPort serial;
    DataSource dataSource;
    QQmlContext *classContext = engine.rootContext();
    classContext->setContextProperty("Port", &serial);
    classContext->setContextProperty("DataStream", &dataSource);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    QQuickStyle::setStyle("Material");
    engine.load(url);

    return app.exec();
}
