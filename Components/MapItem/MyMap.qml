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
    activeMapType: supportedMapTypes[_main.mapType]

    property bool visibleFields: true
    property bool visibleBorderFields: true
    property bool visibleSensors: true
    property bool visibleCars: true

    property bool isEditMode: false
    property var newPolygonField: []

    signal endEditMode(var path)

    function moveCenter(coordinate) {
        _centerAnimation.to = coordinate
        _moveAnimation.start()
    }

    function inputEditMode() {
        isEditMode = true
        newPolygonField = []
        _newFieldPolygon.path = []
    }

    function exitEditMode() {
        isEditMode = false
    }

    MouseArea {

        width: parent.width; height: parent.height
        visible: isEditMode
        onClicked: {
            newPolygonField.push(_map.toCoordinate(Qt.point(mouseX, mouseY)))
            _newFieldPolygon.path = newPolygonField
            if(newPolygonField.length == 4) {
                //exitEditMode()
                endEditMode(_newFieldPolygon.path)
            }
        }
    }

    MapPolygon {
        id: _newFieldPolygon
        visible: isEditMode
        color: "#6AABF7"
        opacity: 0.3
        border.width: 1; border.color: "#000000"
    }

    MapItemView {
        model: _fields.fieldModel
        delegate: FieldMapItem {
            filed_id: idData
            name: nameData
            location: locationData
            center: centerData
            temperature: temperatureData
            humidity: humidityData
            pressure: pressureData
            visibleField:  _map.visibleFields
            visiblePolygon: _map.visibleBorderFields
            onMoreClicked: {
                console.log(filed_id)
                var model = _fields.getFiledById(filed_id)
                _filedInfoDialog.show(model)
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
            sensor_id: idData
            name: nameData
            temperature: temperatureData
            humidity: humidityData
            pressure: pressureData
            latitude: latitudeData
            longitude: longitudeData
            onMoreClicked: {
                var model = _sensors.getSensorById(sensor_id)
                _sensorInfoDialog.show(model)
            }

        }
    }
    SensorInfoDialog {
        id: _sensorInfoDialog
    }

    MapItemView {
        visible: _map.visibleCars
        model: _cars.carsModel
        delegate: CarMapItem {
            car_id: idData
            name: nameData
            latitude: latitudeData
            longitude: longitudeData
            onMoreClicked: {
                _carInfoDialog.open()
            }
        }
    }

    CarInfoDialog {
        id: _carInfoDialog
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
