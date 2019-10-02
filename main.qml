import QtQuick 2.13
import QtQuick.Controls 2.5
import QtLocation 5.13
import QtPositioning 5.6
import QtGraphicalEffects 1.0
import QtQml.Models 2.3

ApplicationWindow {
    id: _window
    visible: true
    width: 920
    height: 620
    title: qsTr("SMA Client")

    property var sensorsArray: []
    property var carsArray: []
    property var map


    Component.onCompleted: {
        var component = Qt.createComponent("MapView.qml", Component.Asynchronous, _root)
        component.statusChanged.connect(function(status) {
            if(status === Component.Ready) {
                _window.map = component.incubateObject(_root, {"z":0}, Qt.Asynchronous)
                map.onStatusChanged = function(status) {
                    if (status === Component.Ready) {
                        console.log("win!")

                    }
                }
            }
        })
    }

    /*Connections {
        target: _models
        onSensorModelChanged: {
            var sensors = Qt.createComponent("SensorMapItem.qml")
            for(var i = 0; i < _models.sensorModel.rowCount(); i++) {
                var index = _models.sensorModel.index(i, 0);
                var item = sensors.createObject(_window.map, {
                                                    "center.latitude": _models.sensorModel.data(index, 258),
                                                    "center.longitude": _models.sensorModel.data(index, 259)
                                                })
                _window.map.addMapItem(item)
                sensorsArray[i] = item
            }

            console.log("sensor")
        }
        onCarsModelChanged: {
            var sensors = Qt.createComponent("CarMapItem.qml")
            for(var i = 0; i < _models.carsModel.rowCount(); i++) {
                var index = _models.carsModel.index(i, 0);
                var item = sensors.createObject(_window.map, {
                                                    "center.latitude": _models.carsModel.data(index, 265),
                                                    "center.longitude": _models.carsModel.data(index, 266)
                                                })
                _window.map.addMapItem(item)
                carsArray[i] = item
            }
            console.log("cars")
        }
    }*/


    Item {
        id: _root
        anchors.fill: parent
        Image {
            id: _img
            anchors.fill: parent
            source: "qrc:/image/map.png"
            layer.enabled: true
            layer.effect: FastBlur {
                radius: 16
            }
        }

        Rectangle {
            visible: true
            x: parent.width-width-20; y:20; z:1
            width: 240; height: parent.height-40
            radius: 20
            color: "#FFFFFF"
            layer.enabled: true
            layer.effect: DropShadow {
                samples: 16
                radius: 8
            }
            ListView {
                id: _listView
                x:10; y:10
                width: parent.width-20; height: parent.height-20
                spacing: 10
                clip: true
                model: _objectModel
                populate: Transition {
                    id: dispTrans

                    SequentialAnimation {
                        PauseAnimation {
                            duration: (dispTrans.ViewTransition.index -
                                      dispTrans.ViewTransition.targetIndexes[0]) * 200
                        }
                        NumberAnimation {
                            properties: "y";
                            from: _listView.height
                            duration: 400;
                            easing.type: Easing.OutCubic
                        }
                    }
                }
            }
        }
    }
    ObjectModel {
        id: _objectModel
        QuickInfoDelegate {
            width: _listView.width
            height: 50
            color: "black"
        }
        SensorDelegate {
            width: _listView.width
            height: 50
            color: "green"
        }
        CarsDelegate {
            width: _listView.width
            height: 50
            color: "blue"
        }
        WeatherDelegate {
            width: _listView.width
            height: 50
            color: "red"
        }
    }
}
