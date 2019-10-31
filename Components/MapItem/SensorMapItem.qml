import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12

import Components.Dialogs 1.0

MapQuickItem {
    id: _root


    property alias sensor_id: _sensorMapPopup.sensor_id
    property alias name: _sensorMapPopup.name
    property var latitude
    property var longitude
    property alias temperature: _sensorMapPopup.temperature
    property alias pressure: _sensorMapPopup.pressure
    property alias humidity: _sensorMapPopup.humidity



    signal moreClicked()

    anchorPoint.x: _img.width/2
    anchorPoint.y: _img.height/2
    coordinate: QtPositioning.coordinate(latitude, longitude)
    sourceItem: Image {
        id: _img
        width: 20; height: 20
        source: "qrc:/image/map/sensor.png"
        MouseArea {
            width: parent.width; height: parent.height
            onClicked: {
                _sensorMapPopup.open()
            }
        }
        SensorMapPopup {
            id: _sensorMapPopup
            x: parent.width/2; y: parent.height/2
            onClickedMore: {
                close()
               _root.moreClicked(_root.filed_id)
            }
        }
    }
}
