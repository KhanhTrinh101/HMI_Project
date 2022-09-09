#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QMediaPlaylist>
#include <QQmlContext>
#include "App/Media/player.h"
#include "App/Media/playlistmodel.h"
#include "App/Climate/climatemodel.h"
#include "applicationsmodel.h"
#include "xmlreader.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    qRegisterMetaType<QMediaPlaylist*>("QMediaPlaylist*");
    qRegisterMetaType<QMediaPlaylist::PlaybackMode>("QMediaPlaylist::PlaybackMode");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    ApplicationsModel appsModel;
    // de doc data in file.xml thi ta dung cau lenh sau
    QString xmlfile = "/application.xml";
    QString Part = QString(PROJECT_PATH) + xmlfile;
    XmlReader xmlReader("applications.xml", appsModel);
    engine.rootContext()->setContextProperty("appsModel", &appsModel);

    Player player;
    engine.rootContext()->setContextProperty("myModel",player.getPlaylistModel());
    engine.rootContext()->setContextProperty("player",player.getPlayer());
    engine.rootContext()->setContextProperty("utility",&player);

    ClimateModel climate;
    engine.rootContext()->setContextProperty("climateModel",&climate);

    const QUrl url(QStringLiteral("qrc:/Qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    //notify signal to QML read data from dbus
    emit climate.dataChanged();

    return app.exec();
}
