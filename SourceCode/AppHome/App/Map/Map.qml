import QtQuick 2.11
import QtQuick.Controls 2.4
import QtPositioning 5.6
import QtLocation 5.6

Item {
    id: root
    width: 1920
    height: 1080-70

    Item {
        id: startAnimation
        XAnimator{
            target: root
            from: 1920
            to: 0
            duration: 200
            running: true
        }
    }

    Plugin {
        id: mapPlugin
        name: "mapboxgl" //"mapboxgl" //"osm" // , "esri", ...
    }
    MapQuickItem {
        id: marker
        anchorPoint.x: image.width/4
        anchorPoint.y: image.height
        coordinate: QtPositioning.coordinate(10.8851188, 106.7781031)

        sourceItem: Image {
            id: image
            source: "qrc:/Img/App/Map/car_icon.png"
        }
    }
    Map { // @disable-check M129
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(10.8851188, 106.7781031)
        zoomLevel: 14
        copyrightsVisible: false
        Component.onCompleted: {
            map.addMapItem(marker)
        }
    }
}
