#ifndef XMLREADER_H
#define XMLREADER_H
#include <QtXml>
#include <QFile>
#include "applicationsmodel.h"

class XmlReader
{
public:
    XmlReader(QString filePath, ApplicationsModel &model);
private:
    QDomDocument m_xmlDoc; //The QDomDocument class represents an XML document.
    bool ReadXmlFile(QString filePath); // doc file luu vao m_xmlDoc
    void PaserXml(ApplicationsModel &model); //ghi tu m_xmlDoc vao model
};

#endif // XMLREADER_H
