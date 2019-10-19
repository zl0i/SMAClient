import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQml.Models 2.3

import Components.Controls 1.0
import Components.Delegats 1.0

Item {
    id: _root
    width: 280; height: parent.height

    signal selectFields()
    signal selectSensors()
    signal selectCar()

    Rectangle {
        width: parent.width; height: parent.height
        opacity: 0.5
        color: "#000000"
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
            width:  93; height: parent.height
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

        }
    }

    DelegateModel {
        id: _sensorModel
        model: _sensors.sensorModel
        delegate: SensorDelegat {

        }
    }

    DelegateModel {
        id: _carsModel
        model: _cars.carsModel
        delegate: CarDelegat {

        }
    }
}
