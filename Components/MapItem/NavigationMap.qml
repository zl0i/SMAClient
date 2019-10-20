import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQml.Models 2.3

import Components.Controls 1.0
import Components.Delegats 1.0

Item {
    id: _root
    width: 279; height: parent.height

    property bool opened: state === "opened" ? true : false

    signal selectFields()
    signal selectSensors()
    signal selectCar()

    signal moveMap(var coordinate)

    states: [
        State {
            name: "opened"
        },
        State {
            name: "closed"
        }
    ]
    state: "opened"

    transitions: [
        Transition {
            from: "opened"; to: "closed"
            NumberAnimation {
                 target: _root
                 property: "x"
                 from: 0; to: -280
                 duration: 250

            }
        },
        Transition {
            from: "closed"; to: "opened"
            NumberAnimation {
                 target: _root
                 property: "x"
                 from: -280; to: 0
                 duration: 250
            }
        }
    ]

    function open() {
        if(opened) return
        state = "opened"
    }

    function close() {
        if(!opened) return
        state = "closed"
    }

    Rectangle {
        width: parent.width; height: parent.height
        opacity: 0.5
        color: "#000000"
    }

    Rectangle {
        x:parent.width; y: 0
        width: 11; height: 25
        color: "#487690"
        Image {
            anchors.centerIn: parent
            source: _root.opened ? "qrc:/image/other/arrow-back-white.svg" : "qrc:/image/other/arrow-next-white.svg"
        }
        MouseArea {
            width: parent.width; height: parent.height
            onClicked: {
                if(_root.opened) close()
                else open()

            }
        }
    }

    MouseArea {
        anchors.fill: parent
    }
    TabBar {
        width: parent.width; height: 25
        contentHeight: 25
        spacing: 0
        background: Rectangle {
            width:parent.width; height: parent.height
            opacity: 0
        }
        CustomTabButton2 {
            width: 93; height: parent.height
            text: qsTr("Поля")
            onClicked: {
                _root.selectFields()
                _list.model = _filedModel
            }
        }
        Rectangle {
            width: 1; height:25
            color: "#FFFFFF"
        }
        CustomTabButton2 {
            width: 93; height: parent.height
            text: qsTr("Датчики")
            onClicked: {
                _root.selectSensors()
                _list.model = _sensorModel
            }
        }
        Rectangle {
            width: 1; height: 25
            color: "#FFFFFF"
        }
        CustomTabButton2 {
            width: 93; height: parent.height
            text: qsTr("Машины")
            onClicked: {
                _root.selectCar()
                _list.model = _carsModel
            }
        }
    }

    FindField {
        x: 14; y: 35
        width: parent.width-28
        emitIfTextChanged: true
    }
    ListView {
        id: _list
        x: 13; y: 89
        width: 233; height: parent.height-y-20
        clip: true
        model: _filedModel
    }


    DelegateModel {
        id: _filedModel
        model: _cars.carsModel
        delegate: FieldDelegat {
            nameField: "Поле " + index
            isFavorite: true
            isLast: ListView.view.count -1 === index
        }
    }

    DelegateModel {
        id: _sensorModel
        model: _sensors.sensorModel
        delegate: SensorDelegat {
            nameSensor: "id"
            temperature: temperature
            pressure: pressure
            humidity: humidity
            isLast: ListView.view.count -1 === index
        }
    }

    DelegateModel {
        id: _carsModel
        model: _cars.carsModel
        delegate: CarDelegat {
            nameCar: "name"
            speed: speed
            isLast: ListView.view.count -1 === index

        }
    }
}
