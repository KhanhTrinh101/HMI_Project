#include "xmlwriter.h"
#include <QDebug>

Xmlwriter::Xmlwriter(QString parth, ApplicationsModel *model, QObject *parent) : QObject(parent)
{
    m_parth = parth;
    m_model = model;
}

void Xmlwriter::writer()
{
    qDebug() << "goi vao write file";
    QDomDocument document;
    QDomElement root = document.createElement("APPLICATIONS");
    document.appendChild(root);

    for(int i = 1; i <= m_model->rowCount(); i++){
        QDomElement _app = document.createElement("APP");
        _app.setAttribute("ID", "00" + QString::number(i));
        root.appendChild(_app);

        QDomElement _title = document.createElement("TITLE");
        QDomText value_of_title = document.createTextNode(m_model->getData(i - 1).title());
        _title.appendChild(value_of_title);
        _app.appendChild(_title);

        QDomElement _url = document.createElement("URL");
        QDomText value_of_url = document.createTextNode(m_model->getData(i - 1).url());
        _url.appendChild(value_of_url);
        _app.appendChild(_url);

        QDomElement _icon_parth = document.createElement("ICON_PATH");
        QDomText value_of_icon_parth = document.createTextNode(m_model->getData(i - 1).iconPath());
        _icon_parth.appendChild(value_of_icon_parth);
        _app.appendChild(_icon_parth);
    }

    QFile f(m_parth);
    if (!f.open(QIODevice::WriteOnly ))
    {
        // Error while loading file
        qDebug() << "Error while loading file";
        qDebug() << m_parth;
        return;
    } else {
        QTextStream stream(&f);
        stream << document;
        f.close();
    }


}
