#ifndef MAINVIEW_H
#define MAINVIEW_H
#include <QSqlDatabase>
#include <QQuickItem>

class MainView : public QQuickItem
{
    Q_OBJECT
public:
    MainView();
    ~MainView();
    Q_INVOKABLE bool connectToDatabase();
   // Q_INVOKABLE QString manngerSIM();
    Q_INVOKABLE QList<QVariant> allSIM();
    Q_INVOKABLE bool changeSIM(int id,const QString & name,double rate);
signals:

public slots:

private:
    QSqlDatabase m_db;
};

#endif // MAINVIEW_H
