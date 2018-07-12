#ifndef DATABASEWORK_H
#define DATABASEWORK_H

#include <QObject>
#include <QSqlDatabase>
#include <QVariant>

class DatabaseWork: public QObject
{
    Q_OBJECT
public:
    DatabaseWork();
    Q_INVOKABLE bool connectToDatabase();
    Q_INVOKABLE QList<QVariant > allSIM();
    Q_INVOKABLE QList<QVariant > allShopper();

    Q_INVOKABLE bool changeSIM(int id,const QString & name,double rate);
    Q_INVOKABLE bool exec(const QString & string);

private:
    QSqlDatabase m_db;
};

#endif // DATABASEWORK_H
