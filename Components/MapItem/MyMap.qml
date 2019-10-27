import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12

import Components.Dialogs 1.0

Map {
    id: _map
    anchors.fill: parent
    plugin: Plugin { name: "osm" } //mapboxgl esri osm
    center: QtPositioning.coordinate(51.516005, 39.273783)
    zoomLevel: 14
    activeMapType: supportedMapTypes["1"]

    property bool visibleFields: true
    property bool visibleBorderFields: true
    property bool visibleSensors: true
    property bool visibleCars: true

    function moveCenter(coordinate) {
        _centerAnimation.to = coordinate
        _moveAnimation.start()
    }

    MapItemView {
        model: _fields.fieldModel
        delegate: FieldMapItem {
            location: locationData
            visibleField:  _map.visibleFields
            visiblePolygon: _map.visibleBorderFields
            onClicked: {
                _filedMapPopup.x = x;
                _filedMapPopup.y = y;
                _filedMapPopup.open()
            }


            FieldMapPopup {
                id: _filedMapPopup
                name: "Поле 1"
                onClickedMore: {
                    _filedInfoDialog.open()
                    close()
                }
            }
        }
    }
    FieldInfoDialog {
        id: _filedInfoDialog
    }

    MapItemView {
        visible: _map.visibleSensors
        model: _sensors.sensorModel
        delegate: SensorMapItem {
            latitude: latitudeData
            longitude: longitudeData
        }
    }
    MapItemView {
        visible: _map.visibleCars
        model: _cars.carsModel
        delegate: CarMapItem {
            latitude: latitudeData
            longitude: longitudeData
        }
    }

    ParallelAnimation {
        id: _moveAnimation

        property var maxZoomLevel: 10
        property var minZoomLevel: 18

        SequentialAnimation {
            NumberAnimation  {
                target: _map
                properties: "zoomLevel"
                from: _map.zoomLevel
                to: _moveAnimation.maxZoomLevel
                duration: 500
                easing.type: Easing.OutCirc
            }
            NumberAnimation  {
                target: _map
                properties: "zoomLevel"
                from: _moveAnimation.maxZoomLevel
                to: _moveAnimation.minZoomLevel
                duration: 500
                easing.type: Easing.InCirc
            }
        }
        PropertyAnimation  {
            id: _centerAnimation
            target: _map
            properties: "center"
            from: center
            to: 0
            duration: 1000
            easing.type: Easing.InOutSine
        }

    }
}
