#include "mainview.h"
#include <QSql>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QSqlResult>

MainView::MainView():
    m_db(QSqlDatabase::contains("qt_sql_default_connection") ?
           QSqlDatabase::database("qt_sql_default_connection")
           :QSqlDatabase::addDatabase("QOCI"))
{
    m_db.setPort(1521);
    m_db.setHostName("127.0.0.1");
    m_db.setDatabaseName("XE");
    m_db.setUserName("dbmarket");
    m_db.setPassword("a1234");

}

MainView::~MainView()
{
    m_db.close();
    m_db.removeDatabase("QOCI");
}

bool MainView::connectToDatabase()
{
    //if(!db.isValid()) return false;
    if(m_db.open())
    {
        m_db.close();
        return true;
    }
    return false;
}

QList<QVariant> MainView::allSIM()
{
    m_db.open();
    QList<QVariant> list;
    QSqlQuery query("select * from sim_table");
    if(!query.exec()) return list;
    while(query.next()){
        list.push_back(query.value(0));
        list.push_back(query.value(1));
        list.push_back(query.value(2));
    }
    m_db.close();
    return list;
}

bool MainView::changeSIM(int id, const QString &name, double rate)
{
    QString execstring = QString("call change_sim_info(%1,%2,%3)").arg(id).arg(name).arg(rate);
    qDebug()<<execstring;
    //QSqlQuery query();
    //if(query.exec()) return true;
    return false;
}

