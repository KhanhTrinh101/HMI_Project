import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import "../../Qml/Common"


Drawer {
    id: drawer
    property alias mediaPlaylist: mediaPlaylist
    interactive: false
    modal: false
    background: Rectangle {
        id: playList_bg
        anchors.fill: parent
        color: "transparent"
    }
    ListView {
        id: mediaPlaylist
        anchors.fill: parent
        model: myModel
        clip: true
        spacing: 2
        currentIndex: player.playlist.currentIndex
        delegate: MouseArea {
            property variant myData: model
            implicitWidth: playlistItem.width
            implicitHeight: playlistItem.height
            Image {
                id: playlistItem
                width: 675
                height: 193
                source: "qrc:/Img/App/Media/playlist.png"
                opacity: 0.5
            }
            Text {
                text: title
                anchors.fill: parent
                anchors.leftMargin: 70
                verticalAlignment: Text.AlignVCenter
                color: "white"
                font.pixelSize: 32
            }
            onClicked: {
                player.playlist.setCurrentIndex(index)
            }

            onPressed: {
                playlistItem.source = "qrc:/Img/App/Media/hold.png"
            }
            onReleased: {
                playlistItem.source = "qrc:/Img/App/Media/playlist.png"
            }

            onCanceled: {
                playlistItem.source = "qrc:/Img/App/Media/playlist.png"
            }
        }
        highlight: Image {
            source: "qrc:/Img/App/Media/playlist_item.png"
            Image {
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/Img/App/Media/playing.png"
            }
        }
        ScrollBar.vertical: ScrollBar {
            parent: mediaPlaylist.parent
            anchors.top: mediaPlaylist.top
            anchors.left: mediaPlaylist.right
            anchors.bottom: mediaPlaylist.bottom
        }
    }

    Connections{
        target: player.playlist
        onCurrentIndexChanged: {
            mediaPlaylist.currentIndex = index;
        }
    }
}
