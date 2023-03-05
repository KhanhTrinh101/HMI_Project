#ifndef TRANSLATOR_H
#define TRANSLATOR_H

#include <QObject>
#include <QTranslator>
#include <QGuiApplication>

class Translator : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString updateText READ getEmptyString NOTIFY languageChanged)

public:
    Translator(QGuiApplication* app, QObject* parent = nullptr);
    QString getEmptyString();
    Q_INVOKABLE void selectLanguage(QString language);
    Q_INVOKABLE QString getLanguage();
signals:
    void languageChanged();
private:
    QTranslator* translator;
    QGuiApplication *m_app;
    QString m_language;
};

#endif // TRANSLATOR_H
