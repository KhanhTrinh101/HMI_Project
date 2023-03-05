import QtQuick 2.11
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../../Qml/Common"

Item {
    id: root
    width: 1920
    height: 1080 - 104

    Image{
        id: sourceApp
        anchors.fill: parent

        source: "qrc:/Img/App/Video/phim.jpg"
    }

    AppHeader{
        id: appTitle
        appTitle: qsTr("VIDEO")+ Translator.updateText
    }


}
