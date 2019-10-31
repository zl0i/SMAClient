import QtQuick 2.12
import QtQuick.Controls 2.5
import QtLocation 5.12
import QtPositioning 5.12

import Components.Dialogs 1.0

MapItemGroup {
    id: _root

    property alias filed_id: _filedMapPopup.field_id
    property alias name: _filedMapPopup.name
    property var location
    property var center
    property alias temperature: _filedMapPopup.temperature
    property alias pressure: _filedMapPopup.pressure
    property alias humidity: _filedMapPopup.humidity

    property bool visiblePolygon: true
    property bool visibleField: true


    signal moreClicked(var filed_id)

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
                    _filedMapPopup.open()
                }
            }
            FieldMapPopup {
                id: _filedMapPopup
                x: parent.width/2; y: parent.height/2
                onClickedMore: {
                    close()
                   _root.moreClicked(_root.filed_id)
                }
            }
        }

    }


}
