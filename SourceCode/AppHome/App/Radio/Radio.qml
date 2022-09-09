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
        width: parent.width
        height: parent.height
        y: 40

        source: "qrc:/Img/App/Radio/radio.jpg"
    }

    AppHeader{
        id: title
        appTitle: qsTr("RADIO")+ Translator.updateText
    }


}
