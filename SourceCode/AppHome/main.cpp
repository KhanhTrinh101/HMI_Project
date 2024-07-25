#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QMediaPlaylist>
#include <QQmlContext>
#include "App/Media/player.h"
#include "App/Media/playlistmodel.h"
#include "App/Climate/climatemodel.h"
#include "applicationsmodel.h"
#include "xmlreader.h"
#include "translator.h"
#include "xmlwriter.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    qRegisterMetaType<QMediaPlaylist*>("QMediaPlaylist*");
    qRegisterMetaType<QMediaPlaylist::PlaybackMode>("QMediaPlaylist::PlaybackMode");

    QGuiApplication app(argc, argv); // giao dien ben tren phan mem
    QQmlApplicationEngine engine; // load cac thanh phan ben duoi phan mem

    // tao mot danh sach luu tru cac ung dung
    ApplicationsModel appsModel;
    engine.rootContext()->setContextProperty("appsModel", &appsModel);

    // doc tat ca thong tin tu file applications.xml vao danh sach ung dung appsModel
    QString xmlfile = "applications.xml";
    QString Part = QString(PROJECT_PATH) + xmlfile;
    XmlReader xmlReader(Part, appsModel);

    // khoi tao du lieu cho model choi nhac
    Player player;
    engine.rootContext()->setContextProperty("myModel",player.getPlaylistModel());
    engine.rootContext()->setContextProperty("player",player.getPlayer());
    engine.rootContext()->setContextProperty("utility",&player);

    // khoi tao du lieu cho model dieu hoa khong khi
    ClimateModel climate;
    engine.rootContext()->setContextProperty("climateModel",&climate);

    // khoi tao tinh nang chuyen doi ngon ngu
    Translator trans(&app);
    engine.rootContext()->setContextProperty("Translator",&trans);

    const QUrl url(QStringLiteral("qrc:/Qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    // notify signal to QML read data from dbus
    //emit climate.dataChanged();

    // ghi tat ca thong tin tu danh sach ung dung appsModel vao file applications.xml
    Xmlwriter writer(Part, &appsModel);
    engine.rootContext()->setContextProperty("Writer", &writer);

    return app.exec();
}
