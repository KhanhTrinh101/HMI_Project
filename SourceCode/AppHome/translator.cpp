#include "translator.h"
#include <QDebug>
#include <QTranslator>

Translator::Translator(QGuiApplication* app, QObject* parent)
    : QObject(parent)
{
    translator = new QTranslator();
    m_app = app;
    translator->load(":/Translator/translate_us.qm");
    m_app->installTranslator(translator);
    m_language = "english";
}

QString Translator::getEmptyString()
{
    return "";
}

// cài đặt ngôn ngữ
void Translator::selectLanguage(QString language)
{
    m_language = language;
    // ngôn ngữ tiếng việt
    if(language.compare("vietnamese") == 0) {
        qDebug() << "goi vao languge vietnamese";
        translator->load(":/Translator/translate_vn.qm");
    }

    // ngôn ngữ tiếng anh
    else if(language.compare("english") == 0) {
        qDebug() << "goi vao languge english";
        translator->load(":/Translator/translate_us.qm");
    }

    // ngôn ngữ tiếng nhat
    else if(language.compare("japanese") == 0) {
        qDebug() << "goi vao languge japanese";
        translator->load(":/Translator/translate_jp.qm");
    }
    m_app->installTranslator(translator);
    emit languageChanged();

}

QString Translator::getLanguage()
{
    return m_language;
}
