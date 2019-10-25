import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12

MapQuickItem {
    id: _item

    property var latitude
    property var longitude

    signal clickedItem(var id)
    signal clickedMore()

    anchorPoint.x: _img.width/2
    anchorPoint.y: _img.height/2
    coordinate: QtPositioning.coordinate(latitude, longitude)
    sourceItem: Image {
        id: _img
        width: 57; height: 40
        source: "qrc:/image/map/car.png"
        MouseArea {
            width: parent.width; height: parent.height
            onClicked: {
                _item.clickedItem(0)
            }
        }
    }
}
