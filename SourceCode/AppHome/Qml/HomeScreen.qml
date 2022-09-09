import QtQuick 2.12
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQml.Models 2.1
import "Common"

Item {
    id: root
    width: 1920
    height: 1080
    function openApplication(url) {
        parent.push(url)
    }

    property int focusArea: 0 // 0 - listWidget; 1 - listapps
    property int focusIndexOfWidget: 0 // 0 - map widget; 1 - climate widget, 2 - media widget
    property int focusIndexOfApps: 0 // 0 -> listapps.count - 1
    
    onFocusAreaChanged: {
        if(focusArea === 0)
            lvWidget.forceActiveFocus()
        else
            lvapps.forceActiveFocus()
    }

    Keys.onReleased: {
        switch(event.key){
            // phim mui ten phai
        case Qt.Key_Right:
            if(focusArea == 0){
                if(focusIndexOfWidget < 2)
                    focusIndexOfWidget++
                else
                    focusIndexOfWidget = 0
            }else{
                if(focusIndexOfApps < lvapps.count - 1)
                    focusIndexOfApps++  
                else
                    focusIndexOfApps = 0
            }
            break
            // phim mui ten phai
        case Qt.Key_Left:
            if(focusArea == 0){
                if(focusIndexOfWidget > 0)
                    focusIndexOfWidget--
                else
                    focusIndexOfWidget = 2
            }else{
                if(focusIndexOfApps > 0)
                    focusIndexOfApps--
                else
                    focusIndexOfApps = lvapps.count - 1
            }
            break
            // phim mui ten len
        case Qt.Key_Up:
            focusArea = 0
            focusIndexOfWidget = 0
            break
            // phim mui ten xuong
        case Qt.Key_Down:
            focusArea = 1
            focusIndexOfApps = 0
            break
            // phim enter phai
        case Qt.Key_Enter:
            // phim enter trai
        case Qt.Key_Return:
            if(focusArea == 0){
                switch (focusIndexOfWidget) {
                case 0:
                    openApplication("qrc:/App/Map/Map.qml")
                    break;
                case 1:
                    openApplication("qrc:/App/Climate/Climate.qml")
                    break;
                case 2:
                    openApplication("qrc:/App/Media/Media.qml")
                    break;
                }
            } else {
                openApplication(lvapps.currentItem.modelApps.url)
            }
            break
        }
    }

    // danh sach các widget nằm ngang
    ListView {
        id: lvWidget
        spacing: 10
        orientation: ListView.Horizontal
        width: 1920
        height: 570
        interactive: false

        model: ListModel {
            ListElement { type: "map" }
            ListElement { type: "climate" }
            ListElement { type: "media" }
        }

        delegate: Item {
            width: iconWidget.implicitWidth
            height: iconWidget.implicitHeight
            Loader {
                id: iconWidget
                width: 635
                height: 570
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                sourceComponent: {
                    switch(model.type) {
                    case "map": return mapWidget
                    case "climate": return climateWidget
                    case "media": return mediaWidget
                    }
                }
            }
        }

        Component {
            id: mapWidget
            MapWidget{
                focus: focusArea == 0 && focusIndexOfWidget == 0
                onClicked: {
                    openApplication("qrc:/App/Map/Map.qml")
                    focusIndexOfWidget = 0
                    focusArea = 0
                }
            }
        }
        Component {
            id: climateWidget
            ClimateWidget {
                focus: focusArea == 0 && focusIndexOfWidget == 1
                onClicked: {
                    openApplication("qrc:/App/Climate/Climate.qml")
                    focusIndexOfWidget = 1
                    focusArea = 0
                }
            }
        }
        Component {
            id: mediaWidget
            MediaWidget{
                focus: focusArea == 0 && focusIndexOfWidget == 2
                onClicked: {
                    openApplication("qrc:/App/Media/Media.qml")
                    focusIndexOfWidget = 2
                    focusArea = 0
                }
            }
        }
    }

    onFocusIndexOfAppsChanged: {
        lvapps.currentIndex = focusIndexOfApps
    }

    // danh sach các ung dung nằm ngang
    ListView {
        id: lvapps
        x: 0
        y: 570
        width: 1920; height: 456
        orientation: ListView.Horizontal
        interactive: lvapps.count > 6
        spacing: 5

        displaced: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad}
        }

        model: DelegateModel {
            id: visualModel
            model: appsModel
            delegate: DropArea {
                property var modelApps: model
                id: delegateRoot
                width: 316; height: 456
                keys: "AppButton"
                property int visualIndex: DelegateModel.itemsIndex

                onEntered: {
                    console.log("onEntered")
                    let _from = drag.source.visualIndex
                    let _to = icon.visualIndex
                    visualModel.items.move(_from, _to)
                    appsModel.preorder(_from, _to)
                    Writer.writer()
                }

                onExited: {
                    console.log("onExited")
                    focusArea = 1
                    focusIndexOfApps = icon.visualIndex
                    lvapps.forceActiveFocus()
//                    console.log("=============== begin ==================")
//                    console.log("current index of list view       " + lvapps.currentIndex)
//                    console.log("index of focus app               " + focusIndexOfApps)
//                    console.log("visual index                     " + icon.visualIndex )
//                    console.log("model index                      " + model.index)
//                    console.log("focus on app                     " + app.focus)
//                    console.log("================ end ===================")
                }

                Binding {
                    target: icon
                    property: "visualIndex"
                    value: visualIndex
                }

                Item {
                    id: icon
                    property int visualIndex: 0

                    width: 316; height: 456
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }

                    AppButton {
                        id: app
                        anchors.fill: parent
                        title: qsTr(model.title) + Translator.updateText
                        icon: model.iconPath
                        focus: focusArea == 1 && (icon.visualIndex === focusIndexOfApps)
                        property bool isPreorder: false

                        onReleased: {
                            console.log("onReleased")
                            if(app.isPreorder == false) {
                                for (var index = 0; index < visualModel.items.count;index++) {
                                    if (index !== icon.visualIndex)
                                        visualModel.items.get(index).focus = false
                                    else
                                        visualModel.items.get(index).focus = true
                                }
                                focusIndexOfApps = icon.visualIndex
                                focusArea = 1
                                openApplication(model.url)
                            }

                            app.isPreorder = false
                            focusIndexOfApps++
                            focusIndexOfApps--
                        }

                        onPressAndHold: app.isPreorder = true
                        
                        drag.axis: Drag.XAxis
                        drag.smoothed: true
                        drag.target: app.isPreorder? parent : undefined
                    }

                    Drag.active: app.isPreorder
                    Drag.keys: "AppButton"
                    Drag.hotSpot.x: width / 2
                    Drag.hotSpot.y: height / 2

                    states: [
                        State {
                            when: app.isPreorder
                            ParentChange {
                                target: icon
                                parent: root
                            }
                            AnchorChanges {
                                target: icon
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    ]
                }
            }
        }

        ScrollBar.horizontal: ScrollBar {
            parent: lvapps.parent
            anchors.top: lvapps.top
            anchors.left: lvapps.left
            anchors.right: lvapps.right
        }
    }

//    Component.onCompleted: {
//        focusArea = 1
//        focusIndexOfApps = 0
//    }

}
