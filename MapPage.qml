import QtQuick 2.12
import QtQuick.Controls 2.5
import QtLocation 5.13
import QtPositioning 5.6
import QtQml.Models 2.12

import Components 1.0

Item {
    id: _root
    property alias map: _mapLoader.item

    /*Component.onCompleted: {
        if(map) return
        var component = Qt.createComponent("MyMap.qml", Component.Asynchronous, _root)
        component.statusChanged.connect(function(status) {
            if(status === Component.Ready) {
                _mapLoader.sourceComponent = component
                _root.map = component.incubateObject(_root, {"z":0}, Qt.Asynchronous)
                map.onStatusChanged = function(status) {
                    if (status === Component.Ready) {
                        console.log("win!")

                    }
                }
            }
        })
    }*/

    Loader {
        id: _mapLoader
        anchors.fill: parent
        source: "qrc:/Components/MapItem/MyMap.qml"
        asynchronous: true
    }

    Item {
        width: 300; height: parent.height
        Rectangle {
            width: parent.width; height: parent.height
            opacity: 0.5
            color: "#000000"
        }
        MouseArea {
            anchors.fill: parent
        }
        /*Row {
            width: parent.width
            CheckBox {
                text: qsTr("Поля")
            }
            CheckBox {
                text: qsTr("Датчики")
            }

            CheckBox {
                text: qsTr("Машины")
            }
        }*/
        TabBar {
            //y: 50
            width: parent.width-25; height: 25
            contentHeight: 25
            spacing: 0
            background: Rectangle {
                width:parent.width; height: parent.height
                opacity: 0
            }

            TabButton {
                width: 92; height: parent.height
                text: qsTr("Поля")
                onClicked: {
                    _list.model = _filedModel
                }
            }
            TabButton {
                width:  92; height: parent.height
                text: qsTr("Датчики")
                onClicked: {
                    _list.model = _sensorModel
                }
            }
            TabButton {
                width: 92; height: parent.height
                text: qsTr("Машины")
                onClicked: {
                    _list.model = _carsModel
                }
            }
        }
        TextField {
            x: 20; y: 35
            width: parent.width-40; height: 30
            leftPadding:30;rightPadding: 30
            selectByMouse: true
            selectionColor: "#ADD8E6"
            background:  Rectangle {
                width: parent.width; height: parent.height
                radius: height/2
                color: "#FFFFFF"
            }
        }
        ListView {
            id: _list
            y: 80
            width: parent.width;  height: parent.height-y
            clip: true
            model: _filedModel

        }

        DelegateModel {
            id: _filedModel
            model: _cars.carsModel
            delegate: Label {
                width: _list.width; height: 40
                text: "field"
            }
        }

        DelegateModel {
            id: _sensorModel
            model: _sensors.sensorModel
            delegate: Label {
                width: _list.width; height: 40
                text: "sensor"
            }
        }

        DelegateModel {
            id: _carsModel
            model: _cars.carsModel
            delegate: Label {
                width: _list.width; height: 40
                text: "caaar"
            }
        }




    }

}
