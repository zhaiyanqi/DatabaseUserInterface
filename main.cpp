#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSqlDatabase>
#include <QDebug>
#include <QSqlError>
#include <QtSql>
#include <QQuickView>
#include <QQmlEngine>
#include <QQmlContext>
#include "databasework.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    //qmlRegisterType<MainView>("Databasework.MainView",1,0,"MainView");

    QQuickView view;
    view.rootContext()->setContextProperty("Database", new DatabaseWork);
    view.setSource(QUrl(QStringLiteral("qrc:/main.qml")));
    view.connect(view.engine(), &QQmlEngine::quit, &app, &QCoreApplication::quit);
    view.show();

    return app.exec();
}
