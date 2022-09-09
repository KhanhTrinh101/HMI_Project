import QtQuick 2.12
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQml.Models 2.1

Item {
    id: root
    width: 1920
    height: 1080
    function openApplication(url){ // ham thuc hien goi vao file qml cua mot app
        parent.push(url)
    }

    // danh sach các widget nằm ngang
    ListView {
        id: lvWidget
        spacing: 10
        orientation: ListView.Horizontal // cai dat danh sach hien thi theo chieu ngang
        width: 1920
        height: 570
        interactive: false // ???

        // hiệu ứng chuyển trang
        displaced: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
        }

        // model các widget
        model: DelegateModel {
            id: visualModelWidget

            // model con chua ten the loai widget
            model: ListModel {
                id: widgetModel
                ListElement { type: "map" }
                ListElement { type: "climate" }
                ListElement { type: "media" }
            }

            delegate: DropArea { // ??? nhin no kha la giong voi MouseArea
                id: delegateRootWidget
                width: 635; height: 570
                keys: ["widget"] // DropArea chi nhan cac thuoc tinh widget

                onEntered: { // khi co chuot trog vung drop
                    visualModelWidget.items.move(drag.source.visualIndex, iconWidget.visualIndex) // ???
                    iconWidget.item.enabled = false // gan gia tri item = false
                }
                property int visualIndex: DelegateModel.itemsIndex // ???
                Binding { target: iconWidget; property: "visualIndex"; value: visualIndex } // ???
                onExited: iconWidget.item.enabled = true // thuc hien tin hieu khi thoat
                onDropped: { // thuc hien tin hieu khi drop(vuot)
                    console.log(drop.source.visualIndex)
                }

                Loader { // ???
                    id: iconWidget
                    property int visualIndex: 0 // vi tri ao == 0
                    width: 635; height: 570
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        verticalCenter: parent.verticalCenter
                    }

                    sourceComponent: { // ???
                        switch(model.type) { // chon type
                        case "map": return mapWidget
                        case "climate": return climateWidget
                        case "media": return mediaWidget
                        }
                    }

                    Drag.active: iconWidget.item.drag.active// keo item
                    Drag.keys: "widget" // ???
                    Drag.hotSpot.x: delegateRootWidget.width/2 // ???
                    Drag.hotSpot.y: delegateRootWidget.height/2 // ???

                    states: [
                        State { // trang thai khi keo
                            when: iconWidget.Drag.active
                            ParentChange {
                                target: iconWidget
                                parent: root
                            }

                            AnchorChanges {
                                target: iconWidget
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    ]
                }
            }
        }

        Component {
            id: mapWidget
            MapWidget{
                onClicked: openApplication("qrc:/App/Map/Map.qml")
            }
        }
        Component {
            id: climateWidget
            ClimateWidget {
            }
        }
        Component {
            id: mediaWidget
            MediaWidget{
                onClicked: openApplication("qrc:/App/Media/Media.qml")
            }
        }
    }

    // danh sach các ung dung nằm ngang
    ListView {
        id: lvapps
        x: 0
        y:570
        width: 1920; height: 406
        orientation: ListView.Horizontal
        interactive: false
        spacing: 5

        displaced: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
        }

        model: DelegateModel {
            id: visualModel
            model: appsModel
            delegate: DropArea {
                id: delegateRoot
                width: 316; height: 400
                keys: "AppButton"

                onEntered: visualModel.items.move(drag.source.visualIndex, icon.visualIndex)
                property int visualIndex: DelegateModel.itemsIndex
                Binding { target: icon; property: "visualIndex"; value: visualIndex }

                Item {
                    id: icon
                    property int visualIndex: 0
                    width: 316; height: 400
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        verticalCenter: parent.verticalCenter
                    }

                    AppButton{
                        id: app
                        anchors.fill: parent
                        title: model.title
                        icon: model.iconPath
                        onClicked: openApplication(model.url)
                        onReleased: {
                            app.focus = true
                            app.state = "Focus"
                            for (var index = 0; index < visualModel.items.count;index++){
                                if (index !== icon.visualIndex)
                                    visualModel.items.get(index).focus = false
                                else
                                    visualModel.items.get(index).focus = true
                            }
                        }
                    }

                    onFocusChanged: app.focus = icon.focus

                    Drag.active: app.drag.active
                    Drag.keys: "AppButton"

                    states: [
                        State {
                            when: icon.Drag.active
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
        ScrollBar.vertical: ScrollBar {

        }
    }
}
