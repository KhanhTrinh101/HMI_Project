import QtQuick 2.11
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "../../Qml/Common"



Item {
    id: root
    implicitWidth: 1920
    implicitHeight: 1080 - 104

    AppHeader{
        appTitle: qsTr("SETTINGS") + Translator.updateText
    }

    ListModel {
        id: modelId
        ListElement {
            title: qsTr("Language")
            icon_n: "qrc:/Img/App/Settings/general_n.png"
            icon_p: "qrc:/Img/App/Settings/general_p.png"
        }
        ListElement {
            title: qsTr("Display")
            icon_n: "qrc:/Img/App/Settings/display_n.png"
            icon_p: "qrc:/Img/App/Settings/display_p.png"
        }
        ListElement {
            title: qsTr("Conection")
            icon_n: "qrc:/Img/App/Settings/connection_n.png"
            icon_p: "qrc:/Img/App/Settings/connection_p.png"
        }
        ListElement {
            title: qsTr("Navigation")
            icon_n: "qrc:/Img/App/Settings/navigation_n.png"
            icon_p: "qrc:/Img/App/Settings/navigation_p.png"
        }
        ListElement {
            title: qsTr("Profile")
            icon_n: "qrc:/Img/App/Settings/profile_n.png"
            icon_p: "qrc:/Img/App/Settings/profile_p.png"
        }
        ListElement {
            title: qsTr("Sound")
            icon_n: "qrc:/Img/App/Settings/sound_n.png"
            icon_p: "qrc:/Img/App/Settings/sound_p.png"
        }
        ListElement {
            title: qsTr("Vehicle")
            icon_n: "qrc:/Img/App/Settings/vehicle_n.png"
            icon_p: "qrc:/Img/App/Settings/vehicle_p.png"
        }
        ListElement {
            title: qsTr("Voice")
            icon_n: "qrc:/Img/App/Settings/voice_n.png"
            icon_p: "qrc:/Img/App/Settings/voice_p.png"
        }
    }

    GridView {
        id: listSettings
        x: 300
        y: 200

        width: 1500
        height: 700
        cellHeight: 350
        cellWidth: 350

        interactive: false
        model: modelId
        delegate: Item {
            width: recId.implicitWidth
            height: recId.implicitHeight
            Rectangle {
                id: recId
                width: connectionId.implicitWidth + 50
                height: connectionId.implicitHeight + 50
                radius: 20
                color: "white"

                ButtonControl {
                    id: connectionId
                    anchors.centerIn: parent

                    setHeight: 200
                    setWidth: 200

                    icon_default: icon_n
                    icon_pressed: icon_p
                    icon_released: icon_n

                    onClicked: {
                        if(title === "Language" || title === "言語" || title === "Ngôn Ngữ") {
                            settingsDialog.open()
                        }
                    }

                    onCanceled: {
                        connectionId.icon_default = icon_n
                    }

                    onPressed: {
                        recId.color = "gray"
                    }

                    onReleased: {
                        recId.color = "white"
                    }
                }
            }
            Text {
                anchors.top: recId.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: recId.horizontalCenter
                text: title + Translator.updateText
                font.pointSize: 30
                color: "white"
            }
        }
    }

    Dialog {
        id: settingsDialog
        x: 1920/2 - 150
        y: (1080 - 104)/2 - 150

        width: 300
        height: 300
        modal: true
        focus: true
        title: qsTr("Select language")+ Translator.updateText

        standardButtons: Dialog.Ok | Dialog.Cancel
        onAccepted: {
            console.log("language:   " + styleBox.currentValue)
            Translator.selectLanguage(styleBox.currentValue)
            settingsDialog.close()
        }
        onRejected: {
            settingsDialog.close()
        }


        contentItem: ColumnLayout {
            id: settingsColumn
            RowLayout {
                spacing: 10
                Label {
                    text: qsTr("language:")+ Translator.updateText
                }

                ComboBox {
                    id: styleBox
                    Component.onCompleted: currentIndex = indexOfValue(Translator.getLanguage())
                    model: ListModel {
                        ListElement {language: "vietnamese"}
                        ListElement {language: "english"}
                        ListElement {language: "japanese"}
                    }
                    Layout.fillWidth: true
                }
            }
        }
    }
}
