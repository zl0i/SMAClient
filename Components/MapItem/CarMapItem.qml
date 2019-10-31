import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12

import Components.Dialogs 1.0

MapQuickItem {
    id: _item

    property alias car_id: _carMapPopup.car_id
    property alias name: _carMapPopup.name
    property alias speed: _carMapPopup.speed
    property var latitude
    property var longitude

    signal moreClicked(var id)

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
                _carMapPopup.open()
            }
        }
        CarMapPopup {
            id: _carMapPopup
            onClickedMore: {
                close()
                _item.moreClicked(car_id)
            }
        }
    }
}
