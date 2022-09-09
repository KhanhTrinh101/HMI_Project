import QtQuick 2.0

MouseArea {
    id: root
    implicitWidth: 316
    implicitHeight: 506
    property string icon
    property string title

    property bool is_remove: false


    Image {
        id: idBackgroud
        width: root.width
        height: root.height
        source: icon + "_n.png"
    }
    Text {
        id: appTitle
        anchors.horizontalCenter: parent.horizontalCenter
        y: 275
        text: title
        font.pixelSize: 36
        color: "white"
    }

    states: [
        State {
            name: "Focus"
            PropertyChanges {
                target: idBackgroud
                source: icon + "_f.png"
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: idBackgroud
                source: icon + "_p.png"
            }
        },
        State {
            name: "Normal"
            PropertyChanges {
                target: idBackgroud
                source: icon + "_n.png"
            }
        }
    ]
    onPressed: root.state = "Pressed"
    onReleased: {
        //console.log("onReleased    " + root.focus)
        if (root.focus == true )
            root.state = "Focus"
        else
            root.state = "Normal"
    }
    onCanceled: {
        //console.log("onCanceled    " + root.focus)
        if (root.focus == true )
            root.state = "Focus"
        else
            root.state = "Normal"
    }

    onFocusChanged: {

        if (root.focus == true )
            root.state = "Focus"
        else
            root.state = "Normal"
    }
}
