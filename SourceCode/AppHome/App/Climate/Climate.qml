import QtQuick 2.0
import "../../Qml/Common"

MouseArea {
    id: root
    implicitWidth: 1920
    implicitHeight: 1080 - 104

    function temp(value) {
        if (value === 16.5) {
            return "LOW"
        } else if (value === 31.5) {
            return "HIGH"
        } else {
            return value + "°C"
        }
    }

    function fanLevel(value) {
        if(value === 10) {
            return "qrc:/Img/HomeScreen/ClimateWidget/widget_climate_wind_level_10.png"
        }else if(climateModel.fan_level < 10) {
            return "qrc:/Img/HomeScreen/ClimateWidget/widget_climate_wind_level_0"+climateModel.fan_level+".png"
        }else if(climateModel.fan_level === 1) {
            return "qrc:/Img/HomeScreen/ClimateWidget/widget_climate_wind_level_01.png"
        }
    }

    AppHeader {
        appTitle: qsTr("STR_CLIMATE") + Translator.updateText
    }

    // title ghe tai xe
    Text {
        id: titleDriverId
        y: 215
        width: 900
        text: qsTr("STR_DRIVER") + Translator.updateText
        color: "white"
        font.pixelSize: 40
        horizontalAlignment: Text.AlignHCenter
    }

    // duong ke
    Image {
        anchors.top: titleDriverId.bottom
        anchors.horizontalCenter: titleDriverId.horizontalCenter
        width: 284
        source: "qrc:/Img/HomeScreen/ClimateWidget/widget_climate_line.png"
    }

    // ghe  tai xe
    Image {
        x: (310 + 35 + 90)
        y: 305
        width: 120
        height: 160
        source: "qrc:/Img/HomeScreen/ClimateWidget/widget_climate_arrow_seat.png"
    }

    // huong gio vao mat
    Image {
        x: (310 + 35)
        y:(305 + 30)
        width: 100
        height: 80
        source: climateModel.driver_wind_mode === 0 || climateModel.driver_wind_mode === 2 ?
                "qrc:/Img/HomeScreen/ClimateWidget/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/ClimateWidget/widget_climate_arrow_01_n.png"

    }

    // huong gio vao chan
    Image {
        x: 310
        y:(305 + 30 + 30)
        width: 100
        height: 80
        source: climateModel.driver_wind_mode === 1 || climateModel.driver_wind_mode === 2 ?
                "qrc:/Img/HomeScreen/ClimateWidget/widget_climate_arrow_02_s_b.png" : "qrc:/Img/HomeScreen/ClimateWidget/widget_climate_arrow_02_n.png"
    }

    // nhiet do ghe hanh khach
    Text {
        id: driver_temp
        y: (365 + 130)
        anchors.horizontalCenter: titleDriverId.horizontalCenter
        width: 284
        text: temp(climateModel.driver_temp)

        color: "white"
        font.pixelSize: 56
        horizontalAlignment: Text.AlignHCenter
    }

    // ghe hanh khach
    Text {
        id: passengerId
        x: 1020
        y: 215
        width: 900
        text: qsTr("STR_PASSENGER") + Translator.updateText
        color: "white"
        font.pixelSize: 40
        horizontalAlignment: Text.AlignHCenter
    }

    // duong ke
    Image {
        anchors.top: passengerId.bottom
        anchors.horizontalCenter: passengerId.horizontalCenter
        width: 284
        source: "qrc:/Img/HomeScreen/ClimateWidget/widget_climate_line.png"
    }

    /// ghe ngoi cua hanh khach
    Image {
        x: (310 + 35 + 90 + 910 + 35 + 90)
        y: 305
        width: 120
        height: 160
        source: "qrc:/Img/HomeScreen/ClimateWidget/widget_climate_arrow_seat.png"
    }

    // huong gio vao mat
    Image {
        x: (310 + 35 + 90 + 910 + 35)
        y: (305 + 30)
        width: 100
        height: 80
        source: climateModel.passenger_wind_mode === 0 || climateModel.passenger_wind_mode === 2 ?
                "qrc:/Img/HomeScreen/ClimateWidget/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/ClimateWidget/widget_climate_arrow_01_n.png"
    }

    // huong gio vao chan
    Image {
        x: (310 + 35 + 90 + 910)
        y: (305 + 30 + 30)
        width: 100
        height: 80
        source: climateModel.passenger_wind_mode === 1 || climateModel.passenger_wind_mode === 2 ?
                "qrc:/Img/HomeScreen/ClimateWidget/widget_climate_arrow_02_s_b.png" : "qrc:/Img/HomeScreen/ClimateWidget/widget_climate_arrow_02_n.png"
    }

    // nhiet do ghe hanh khach
    Text {
        id: passenger_temp
        y: (365 + 130)
        anchors.horizontalCenter: passengerId.horizontalCenter
        width: 284
        text: temp(climateModel.passenger_temp)
        color: "white"
        font.pixelSize: 56
        horizontalAlignment: Text.AlignHCenter
    }

    //hinh nen yoc do gio
    Image {
        //x: 272
        id: windLevelBgId
        y: 300
        anchors.horizontalCenter: parent.horizontalCenter
        width: 500
        height: 300
        source: "qrc:/Img/HomeScreen/ClimateWidget/widget_climate_wind_level_bg.png"
    }

    // toc do gio cap 1
    Image {
        id: fan_level
        y: 300
        anchors.horizontalCenter: parent.horizontalCenter
        width: 500
        height: 300
        source: fanLevel(climateModel.fan_level)
    }

    // khi toc do gio thay doi level
    Connections{
        target: climateModel
        onDataChanged: {
            //set data for fan level
            fanLevel(climateModel.fan_level)
            //set data for driver temp
            driver_temp.text = temp(climateModel.driver_temp)
            //set data for passenger temp
            passenger_temp.text = temp(climateModel.passenger_temp)
        }
    }

    // icon quat gio
    Image {
        anchors.top: windLevelBgId.bottom
        anchors.horizontalCenter: windLevelBgId.horizontalCenter
        width: 100
        height: 100
        source: "qrc:/Img/HomeScreen/ClimateWidget/widget_climate_ico_wind.png"
    }
    // che do tu dong(ghe hanh khach cai dat theo ghe tai xe)
    Text {
        y:(495 + 250)
        anchors.horizontalCenter: titleDriverId.horizontalCenter
        width: 272
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("STR_AUTO") + Translator.updateText
        color: !climateModel.auto_mode ? "white" : "gray"
        font.pixelSize: 56
    }

    // title nhiet do ngoai troi
    Text {
        y:720
        anchors.horizontalCenter: parent.horizontalCenter
        width: 271
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("STR_OUTSIDE") + Translator.updateText
        color: "white"
        font.pixelSize: 36
    }

    // nhiet do ngoai troi
    Text {
        y: (720 + 25 + 25)
        anchors.horizontalCenter: parent.horizontalCenter
        width: 271
        horizontalAlignment: Text.AlignHCenter
        text: "27.5°C"
        color: "white"
        font.pixelSize: 48
    }

    // che do dong bo
    Text {
        y:(720 + 25)
        anchors.horizontalCenter: passengerId.horizontalCenter
        width: 272
        horizontalAlignment: Text.AlignHCenter
        text: qsTr("STR_SYNC") + Translator.updateText
        color: !climateModel.sync_mode ? "white" : "gray"
        font.pixelSize: 56
    }
}

