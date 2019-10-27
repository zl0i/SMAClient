import QtQuick 2.12
import QtQuick.Controls 2.5
import QtLocation 5.12
import QtPositioning 5.12

MapItemGroup {
    id: _root
    property var location

    property bool visiblePolygon: true
    property bool visibleField: true

    signal clicked(var x, var y)

    MapPolygon {
        visible: visiblePolygon
        color: "#6AABF7"
        opacity: 0.3
        border.width: 1; border.color: "#000000"
        path: location
    }

    MapQuickItem {
        coordinate: QtPositioning.coordinate(location[0].latitude, location[0].longitude)
        anchorPoint.x: sourceItem.width/2
        anchorPoint.y: sourceItem.height/2
        visible: visibleField
        sourceItem: Image {
            width: 80; height: 80
            source: "qrc:/image/map/field.png"
            MouseArea {
                width: parent.width; height: parent.height
                onClicked: {
                    var point = mapToItem(Overlay.overlay, mouseX, mouseY)
                    _root.clicked(point.x-parent.width, point.y)
                }
            }
        }

    }


}
