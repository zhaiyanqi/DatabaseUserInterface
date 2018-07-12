#include "databasework.h"
#include <QSqlQuery>
#include <QDebug>

DatabaseWork::DatabaseWork():
    m_db(QSqlDatabase::addDatabase("QOCI"))
{
    m_db.setPort(1521);
    m_db.setHostName("127.0.0.1");
    m_db.setDatabaseName("XE");
    m_db.setUserName("dbmarket");
    m_db.setPassword("a1234");
}

bool DatabaseWork::connectToDatabase()
{
    if(m_db.open())
    {
        m_db.close();
        return true;
    }
    return false;
}

QList<QVariant> DatabaseWork::allSIM()
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

QList<QVariant> DatabaseWork::allShopper()
{
    m_db.open();
    QList<QVariant> list;
    QSqlQuery query("select * from shopper_table");
    if(!query.exec()) return list;
    while(query.next()){
        list.push_back(query.value(0));
        list.push_back(query.value(1));
        list.push_back(query.value(2));
    }
    m_db.close();
    return list;
}

bool DatabaseWork::changeSIM(int id, const QString &name, double rate)
{
    QString execstring = QString("call change_sim_info(%1,%2,%3)").arg(id).arg(name).arg(rate);
    qDebug()<<execstring;
    //QSqlQuery query();
    //if(query.exec()) return true;
    return false;
}

bool DatabaseWork::exec(const QString &string)
{
    m_db.open();
    QSqlQuery query(string);
    bool result = query.exec();
    m_db.close();
    if(!result){
        return false;
    }
    return true;
}

