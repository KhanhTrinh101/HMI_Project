#ifndef XMLWRITER_H
#define XMLWRITER_H

#include <QObject>
#include "applicationsmodel.h"
#include <QFile>
#include <QDomDocument>

class Xmlwriter : public QObject
{
    Q_OBJECT
public:
    explicit Xmlwriter(QString parth, ApplicationsModel* model, QObject *parent = nullptr);

public slots:
    void writer();

private:
    QString m_parth;
    ApplicationsModel* m_model;
};

#endif // XMLWRITER_H
