import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.1
import QtMultimedia 5.9
import "../../Qml/Common"

Item {
    property alias shuffer_status: shuffer.status
    property alias repeater_status: repeater.status
    property alias count_playlist: album_art_view.count

    property alias play_Source: play.source
    property alias next_Source: next.source
    property alias prev_Source: prev.source

    Text {
        id: audioTitle
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        text: album_art_view.currentItem.myData.title
        color: "white"
        font.pixelSize: 36
        onTextChanged: {
            textChangeAni.targets = [audioTitle,audioSinger]
            textChangeAni.restart()
        }
    }
    Text {
        id: audioSinger
        anchors.top: audioTitle.bottom
        anchors.left: audioTitle.left
        text: album_art_view.currentItem.myData.singer
        color: "white"
        font.pixelSize: 32
    }

    NumberAnimation {
        id: textChangeAni
        property: "opacity"
        from: 0
        to: 1
        duration: 400
        easing.type: Easing.InOutQuad
    }
    Text {
        id: audioCount
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        text: album_art_view.count
        color: "white"
        font.pixelSize: 36
    }
    Image {
        anchors.top: parent.top
        anchors.topMargin: 23
        anchors.right: audioCount.left
        anchors.rightMargin: 10
        source: "qrc:/Img/App/Media/music.png"
    }

    Component {
        id: appDelegate
        Item {
            property variant myData: model
            width: 400; height: 400
            scale: PathView.iconScale
            Image {
                id: myIcon
                width: parent.width
                height: parent.height
                y: 20
                anchors.horizontalCenter: parent.horizontalCenter
                source: album_art
            }

            MouseArea {
                anchors.fill: parent
                onClicked: player.playlist.setCurrentIndex(index)
            }
        }
    }

    PathView {
        id: album_art_view
        anchors.left: parent.left
        anchors.leftMargin: (parent.width - 1100)/2
        anchors.top: parent.top
        anchors.topMargin: 250
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        focus: true
        model: myModel
        delegate: appDelegate
        pathItemCount: 3
        path: Path {
            startX: 10
            startY: 50
            PathAttribute { name: "iconScale"; value: 0.5 }
            PathLine { x: 550; y: 50 }
            PathAttribute { name: "iconScale"; value: 1.0 }
            PathLine { x: 1100; y: 50 }
            PathAttribute { name: "iconScale"; value: 0.5 }
        }

        currentIndex: player.playlist.currentIndex
    }

        Connections{
            target: player.playlist
            onCurrentIndexChanged: {
                album_art_view.currentIndex = index;
            }
        }

    //Progress
    Text {
        id: currentTime
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 230
        anchors.right: progressBar.left
        anchors.rightMargin: 20
        text: utility.getTimeInfo(player.position)
        color: "white"
        font.pixelSize: 24
    }
    Slider{
        id: progressBar
        width: 1491 - 675*playlist.position
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 235
        anchors.horizontalCenter: parent.horizontalCenter
        from: 0
        to: player.duration
        value: player.position
        background: Rectangle {
            x: progressBar.leftPadding
            y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
            implicitWidth: 200
            implicitHeight: 4
            width: progressBar.availableWidth
            height: implicitHeight
            radius: 2
            color: "gray"

            Rectangle {
                width: progressBar.visualPosition * parent.width
                height: parent.height
                color: "white"
                radius: 2
            }
        }
        handle: Image {
            anchors.verticalCenter: parent.verticalCenter
            x: progressBar.leftPadding + progressBar.visualPosition * (progressBar.availableWidth - width)
            y: progressBar.topPadding + progressBar.availableHeight / 2 - height / 2
            source: "qrc:/Img/App/Media/point.png"
            Image {
                anchors.centerIn: parent
                source: "qrc:/Img/App/Media/center_point.png"
            }
        }
        onMoved: {
            if (player.seekable){
                player.setPosition(Math.floor(position*player.duration))
            }
        }
    }
    Text {
        id: totalTime
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 230
        anchors.left: progressBar.right
        anchors.leftMargin: 20
        text: utility.getTimeInfo(player.duration)
        color: "white"
        font.pixelSize: 24
    }
    //Media control
    SwitchButton {
        id: shuffer
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        anchors.left: currentTime.left
        icon_off: "qrc:/Img/App/Media/shuffle.png"
        icon_on: "qrc:/Img/App/Media/shuffle-1.png"

        onStatusChanged: {
            if(shuffer.status === 1)
            {
                if(repeater.status === 1) {
                    console.log("Playlist.CurrentItemInLoop ON")
                    utility.playBackModeList(Playlist.CurrentItemInLoop)
                }else {
                    console.log("Playlist.Random ON")
                    utility.playBackModeList(Playlist.Random)
                }
            }else{
                if(repeater.status === 1) {
                    console.log("Playlist.CurrentItemInLoop ON")
                    utility.playBackModeList(Playlist.CurrentItemInLoop)
                }else {
                    console.log("Playlist.Sequential ON")
                    utility.playBackModeList(Playlist.Sequential)
                }
            }
        }
    }
    ButtonControl {
        id: prev
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        anchors.right: play.left
        icon_default: "qrc:/Img/App/Media/prev.png"
        icon_pressed: "qrc:/Img/App/Media/hold-prev.png"
        icon_released: "qrc:/Img/App/Media/prev.png"

        onClicked: {
            if(shuffer.status === 1){
                var newindex = Math.floor(Math.random() * album_art_view.count)
                while(newindex === player.playlist.currentIndex){
                    newindex = Math.floor(Math.random() * album_art_view.count)
                }
                player.playlist.setCurrentIndex(newindex)
            }else {
                if (player.playlist.currentIndex > 0)
                    player.playlist.setCurrentIndex(player.playlist.currentIndex - 1)
                else player.playlist.setCurrentIndex(album_art_view.count-1)
            }
        }

    }
    ButtonControl {
        id: play
        anchors.verticalCenter: prev.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        icon_default: player.state === MediaPlayer.PlayingState ?  "qrc:/Img/App/Media/pause.png" : "qrc:/Img/App/Media/play.png"
        icon_pressed: player.state === MediaPlayer.PlayingState ?  "qrc:/Img/App/Media/hold-pause.png" : "qrc:/Img/App/Media/hold-play.png"
        icon_released: player.state=== MediaPlayer.PlayingState ?  "qrc:/Img/App/Media/pause.png" : "qrc:/Img/App/Media/play.png"
        onClicked: {
            if (player.state != MediaPlayer.PlayingState){//@disable-check M126
                player.play()
            } else {
                player.pause()
            }
        }
        Connections {
            target: player
            onStateChanged:{
                play.source = player.state === MediaPlayer.PlayingState ?  "qrc:/Img/App/Media/pause.png" : "qrc:/Img/App/Media/play.png"
            }
        }
    }
    ButtonControl {
        id: next
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        anchors.left: play.right
        icon_default: "qrc:/Img/App/Media/next.png"
        icon_pressed: "qrc:/Img/App/Media/hold-next.png"
        icon_released: "qrc:/Img/App/Media/next.png"

        onClicked: {
            if(shuffer.status === 1){
                var newindex = Math.floor(Math.random() * album_art_view.count)
                while(newindex === player.playlist.currentIndex){
                    newindex = Math.floor(Math.random() * album_art_view.count)
                }
                player.playlist.setCurrentIndex(newindex)
            }else {
                if (player.playlist.currentIndex < album_art_view.count -1)
                    player.playlist.setCurrentIndex(player.playlist.currentIndex + 1)
                else player.playlist.setCurrentIndex(0)
            }
        }
    }
    SwitchButton {
        id: repeater
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        anchors.right: totalTime.right
        icon_on: "qrc:/Img/App/Media/repeat1_hold.png"
        icon_off: "qrc:/Img/App/Media/repeat.png"

        onStatusChanged: {
            if(repeater.status === 1) {
                console.log("Playlist.CurrentItemInLoop ON")
                utility.playBackModeList(Playlist.CurrentItemInLoop)
            }
            else {
                if(shuffer.status === 1){
                    console.log("Playlist.Random ON")
                    utility.playBackModeList(Playlist.Random)
                }else {
                    console.log("Playlist.Sequential ON")
                    utility.playBackModeList(Playlist.Sequential)
                }
            }
        }
    }

//    Connections{
//        target: player.playlist
//        onCurrentIndexChanged: {
//            album_art_view.currentIndex = index;
//        }
//    }
}
