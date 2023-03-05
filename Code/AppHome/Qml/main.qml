import QtQuick 2.11
import QtQuick.Window 2.0
import QtQuick.Controls 2.4


ApplicationWindow {
    id: window
    visibility: "FullScreen"
    //visible: true
    width: 1920
    height: 1080

    // back ground
    Image {
        id: background
        width: 1920
        height: 1080
        source: "qrc:/Img/HomeScreen/bg_full.png"
    }

    // vung stastus bar
    StatusBar {
        id: statusBar
        onBntBackClicked:{

            while(stackView.depth != 1) {
                stackView.pop()
            }
        }
        isShowBackBtn: stackView.depth == 1 ? false : true
    }

    //vùng widget và vùng danh sách ứng dụng
    StackView {
        id: stackView
        width: 1920
        anchors.top: statusBar.bottom
        initialItem: HomeScreen{}

        onCurrentItemChanged: {
            currentItem.forceActiveFocus()
        }
        pushExit: Transition {
            XAnimator {
                from: 0
                to: -1920
                duration: 200
                easing.type: Easing.OutCubic
            }
        }

        Keys.onReleased: {
            switch(event.key){
            case Qt.Key_Backspace:
                while(stackView.depth != 1) {
                    stackView.pop()
                }
                break
                // phim 1
            case Qt.Key_1:
                stackView.push("qrc:/App/Settings/Settings.qml")
                break
                // phim 3
            case Qt.Key_3:
                stackView.push("qrc:/App/Climate/Climate.qml")
                break
                // phim 2
            case Qt.Key_2:
                stackView.push("qrc:/App/Map/Map.qml")
                break
                // phim 4
            case Qt.Key_4:
                stackView.push("qrc:/App/Media/Media.qml")
                break
            }
        }
    }
}
