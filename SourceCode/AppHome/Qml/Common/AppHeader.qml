import QtQuick 2.0

Item {
    property alias playlistButtonStatus: playlist_button.status
    signal clickPlaylistButton
    property string appTitle: ""
    property bool isMedia: false

    Image {
        id: headerItem
        source: "qrc:/Img/App/Media/title.png"
        SwitchButton {
            id: playlist_button
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            icon_off: "qrc:/Img/App/Media/drawer.png"
            icon_on: "qrc:/Img/App/Media/back.png"
            visible: isMedia
            onClicked: {
                clickPlaylistButton()
            }
        }
        Text {
            anchors.left: playlist_button.right
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("STR_PLAYLIST") + Translator.updateText
            color: "white"
            font.pixelSize: 32
            visible: isMedia
        }
        Text {
            id: headerTitleText
            text: appTitle
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 46
        }
    }
}
