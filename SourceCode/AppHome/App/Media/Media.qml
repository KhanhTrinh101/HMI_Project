import QtQuick 2.6
import QtQuick.Controls 2.4
import QtMultimedia 5.9
import "../../Qml/Common"

Item {
    width: 1920
    height: 1080-104

    //Header
    AppHeader{
        id: headerItem
        width: parent.width
        height: 141
        playlistButtonStatus: playlist.opened ? 1 : 0
        isMedia: true
        appTitle: qsTr("STR_MEDIA") + Translator.updateText
        onClickPlaylistButton: {
            if (!playlist.opened) {
                playlist.open()
            } else {
                playlist.close()
            }
        }
    }

    //Playlist
    PlaylistView{
        id: playlist
        y: 141 + 104
        width: 675
        height: parent.height-headerItem.height
    }

    //Media Info
    MediaInfoControl{
        id: mediaInfoControl
        anchors.top: headerItem.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: playlist.position*playlist.width
        anchors.bottom: parent.bottom
    }



    Keys.onPressed: {
        switch(event.key){
        case Qt.Key_Space:
            mediaInfoControl.play_Source = "qrc:/Img/App/Media/hold-play.png"
            break
        case Qt.Key_Left:
            mediaInfoControl.prev_Source = "qrc:/Img/App/Media/hold-prev.png"
            break
        case Qt.Key_Right:
            mediaInfoControl.next_Source = "qrc:/Img/App/Media/hold-next.png"
            break
        }
    }

    Keys.onReleased: {
        switch(event.key){
        case Qt.Key_Space:

            mediaInfoControl.play_Source = "qrc:/Img/App/Media/play.png"

            if (player.state != MediaPlayer.PlayingState){//@disable-check M126
                player.play()
            } else {
                player.pause()
            }
            break

        case Qt.Key_Right:

            mediaInfoControl.next_Source = "qrc:/Img/App/Media/next.png"

            if(mediaInfoControl.shuffer_status === 1){
                var newindex = Math.floor(Math.random() * mediaInfoControl.count_playlist)
                while(newindex === player.playlist.currentIndex){
                    newindex = Math.floor(Math.random() * mediaInfoControl.count_playlist)
                }
                player.playlist.setCurrentIndex(newindex)
            }else {
                if (player.playlist.currentIndex < mediaInfoControl.count_playlist - 1)
                    player.playlist.setCurrentIndex(player.playlist.currentIndex + 1)
                else player.playlist.setCurrentIndex(0)
            }


            break

        case Qt.Key_Left:

            mediaInfoControl.prev_Source = "qrc:/Img/App/Media/prev.png"

            if(mediaInfoControl.shuffer_status === 1){
                var newindex = Math.floor(Math.random() * mediaInfoControl.count_playlist) //@disable-check M107
                while(newindex === player.playlist.currentIndex){
                    newindex = Math.floor(Math.random() * mediaInfoControl.count_playlist)
                }
                player.playlist.setCurrentIndex(newindex)
            }else {
                if (player.playlist.currentIndex > 0)
                    player.playlist.setCurrentIndex(player.playlist.currentIndex - 1)
                else player.playlist.setCurrentIndex(mediaInfoControl.count_playlist - 1)
            }
            break;

        case Qt.Key_S:
            mediaInfoControl.shuffer_status = !mediaInfoControl.shuffer_status
            break

        case Qt.Key_R:
            mediaInfoControl.repeater_status = !mediaInfoControl.repeater_status
            break
        }
    }


}
