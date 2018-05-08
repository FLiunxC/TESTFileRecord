#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <NetworkRequest.h>
#include <MessageHandler.h>
#include <QDebug>
#include <QFontDatabase>
#include "Singleton.h"


int main(int argc, char *argv[])
{
//#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
//#endif

    QGuiApplication app(argc, argv);

#if defined(Q_OS_ANDROID)
    int fontId = QFontDatabase::addApplicationFont(":/Language/DroidSansFallback.ttf");
    //将字体Id传给applicationFontFamilies,得到一个QStringList,其中的第一个元素为新添加字体的family
    QString androidFont = QFontDatabase::applicationFontFamilies(fontId).at(0);
    QFont font(androidFont);
    QGuiApplication::setFont(font);
#endif

#ifndef QT_NO_DEBUG
    //注册日志系统
    Singleton<MessageHandler>::Instance(nullptr);
#endif

    QQmlApplicationEngine engine;

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
    {
        return -1;
    }
    //测试日志
//    qDebug("This is a debug message");
//    qWarning("This is a warning message");
//    qCritical("This is a critical message");
  //  qFatal()
    return app.exec();
}
