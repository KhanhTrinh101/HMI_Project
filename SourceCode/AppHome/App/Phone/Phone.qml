import QtQuick 2.12
import QtQuick.Controls 2.0
import "../../Qml/Common"

Item {
    id: root
    width: 1920
    height: 1080 - 104

    property string numbers: ""
    property bool isphone: false

    AppHeader {
        appTitle: qsTr("Phone")+ Translator.updateText
    }

    Image {
        y : 121
        source: "qrc:/Img/App/Phone/ngang.png"
        width: parent.width
        height: 25
    }

    Text {
        id: numberId
        y: 175
        anchors.horizontalCenter: parent.horizontalCenter
        color: "white"
        text: numbers.length > 12 ? "..." + numbers.substring(numbers.length - 12) : numbers
        font.pixelSize: 50
        Image {
            anchors.centerIn: parent
            source: "qrc:/Img/App/Phone/doc.png"
            width: 50
            height: 75
            visible: numberId.text == "" ? true : false
        }
    }

    Image {
        y: 250
        source: "qrc:/Img/App/Phone/ngang.png"
        width: parent.width
        height: 25
    }

    ListModel {
        id: modeId
        ListElement { number : "1"}
        ListElement { number : "2"}
        ListElement { number : "3"}
        ListElement { number : "4"}
        ListElement { number : "5"}
        ListElement { number : "6"}
        ListElement { number : "7"}
        ListElement { number : "8"}
        ListElement { number : "9"}
        ListElement { number : "*"}
        ListElement { number : "0"}
        ListElement { number : "#"}
    }

    GridView {
        id: numbersPhoneId
        y: 300
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 30
        width: 460
        height: 800
        cellHeight: 140
        cellWidth: 140
        interactive: false
        model: modeId
        delegate: ButtonControl {
            setWidth: 120
            setHeight:  120
            icon_default: "qrc:/Img/App/Phone/button_n.png"
            icon_pressed: "qrc:/Img/App/Phone/button_p.png"
            icon_released: "qrc:/Img/App/Phone/button_n.png"

            Text {
                id: textId
                anchors.centerIn: parent
                text: number
                font.pointSize: 30
                color: "black"
                font.bold: true
            }

            onCanceled: {
                icon_default: "qrc:/Img/App/Phone/button_n.png"
            }

            onClicked: {
                if(isphone == false) {
                    numbers += textId.text
                }
            }
        }
    }

    ButtonControl {
        id: phoneButtonId
        setWidth: 110
        setHeight:  110

        anchors.right: numbersPhoneId.left
        anchors.rightMargin: 20
        anchors.top: numbersPhoneId.top
        anchors.topMargin: 10

        icon_default: "qrc:/Img/App/Phone/phone_n.png"
        icon_pressed: "qrc:/Img/App/Phone/phone_p.png"
        icon_released: "qrc:/Img/App/Phone/phone_n.png"

        onCanceled: {
            icon_default: "qrc:/Img/App/Phone/phone_n.png"
        }

        onClicked: {
            console.log("click button phone")
            if(numbers != "") {
                numbers = qsTr("calling ...")
                isphone = true
            }
        }
    }

    ButtonControl {
        id: removeButtonId
        setWidth: 110
        setHeight:  110

        anchors.right: numbersPhoneId.left
        anchors.rightMargin: 20
        anchors.top: phoneButtonId.bottom
        anchors.topMargin: 20

        icon_default: "qrc:/Img/App/Phone/remove_n.png"
        icon_pressed: "qrc:/Img/App/Phone/remove_p.png"
        icon_released: "qrc:/Img/App/Phone/remove_n.png"

        visible: !isphone

        onCanceled: {
            icon_default: "qrc:/Img/App/Phone/remove_n.png"
        }

        onClicked: {
            console.log("click remove phone")
            if(isphone == false) {
                numbers = numbers.substring(0, numbers.length - 1)
            }
        }
    }

    ButtonControl {
        id: cancelId
        setWidth: 110
        setHeight:  110

        anchors.right: numbersPhoneId.left
        anchors.rightMargin: 20
        anchors.top: phoneButtonId.bottom
        anchors.topMargin: 20

        icon_default: "qrc:/Img/App/Phone/cancel_n.png"
        icon_pressed: "qrc:/Img/App/Phone/cancel_p.png"
        icon_released: "qrc:/Img/App/Phone/cancel_n.png"

        visible: isphone

        onCanceled: {
            icon_default: "qrc:/Img/App/Phone/cancel_n.png"
        }

        onClicked: {
            console.log("click remove phone")
            numbers = ""
            isphone = false
        }
    }
}
