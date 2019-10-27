import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQml.Models 2.12
import QtGraphicalEffects 1.0
import Qt.labs.settings 1.1

import Components.Controls 1.0
import Components.Delegats 1.0
import Components.Dialogs 1.0
import MyStyle 1.0

import DropView 1.0

Rectangle {
    id: _root
    color: MyStyle.backgroundColor
    Label {
        x: 50; y:25
        font.pixelSize: 32
        font.weight: Font.Bold
        color: MyStyle.textColor
        text: qsTr("Избранные данные")
    }
    MouseArea {
        anchors.fill: parent
        onClicked: _flick.isEdit = false
    }
    Flickable {
        id: _flick
        x: 50; y: 100
        width: parent.width-x; height: parent.height-y
        implicitHeight: 500
        clip: true
        contentHeight: _flow.height+20
        property bool isEdit: false
        Flow {
            id: _flow
            x:10; y:10
            width: parent.width-20;// height: parent.height
            spacing: 20
            Repeater {
                id: _repeter
                model: DelegateModel {
                    id: _visualModel
                    model: favoritModel
                    delegate: DragWrapper {
                        width: _loader.width; height: _loader.height
                        isEdit: _flick.isEdit
                        view: _repeter
                        Loader {
                            id: _loader
                            source: "Components/Delegats/" + modelData.component
                            onStatusChanged: {
                                setPropertyComponen(item, modelData)
                            }
                        }
                        onEditStart: {
                            _flick.isEdit = true
                        }
                        onDropEntered: {
                            _visualModel.items.move(drag.source.DelegateModel.itemsIndex, DelegateModel.itemsIndex)
                        }
                    }
                }
            }
            AddFooter {
                z: -1
                visible: !_flick.isEdit
                onClicked: {
                    _addFavoriteDialog.open()
                }

            }
        }
    }
    Component.onCompleted: {
        var temp = new Date()
        //temp.setSeconds(1570159679)
        //temp.setMilliseconds(1571961600)
        temp.setMilliseconds(1570266000)
        //temp.setUTC(1571961600)
        console.log(temp)
        console.log(new Date().getHours())
    }

    AddFavoriteDialog {
        id: _addFavoriteDialog
    }

    function setPropertyComponen(obj, model) {
        for(var key in model) {
            if(key === "component") continue
            obj[key] = model[key]
        }
    }

    property var favoritModel: [
        {
            "component": "WeatherDelegat.qml",
            "temperature": -10,
            "pressure": 755,
            "humidity": 85,
            "typeWeather": "snow",
            "date": 1570159679,
            "minTemperature": -12,
            "maxTemperature": -5,
            "windSpeed": 10,
            "windDeg": 325,
            "sunrise": 1570159679,
            "sunset": 1570159679
        },
        {
            "component": "SmallWeatherDelegat.qml",
            "temperature": 25,
            "pressure": 755,
            "humidity": 85,
            "width": 200,
            "typeWeather": "rain",
            "date": 1570159679
        },
        {
            "component": "SmallWeatherDelegat.qml",
            "temperature": 25,
            "pressure": 755,
            "humidity": 85,
            "width": 200,
            "typeWeather": "mist",
            "date": 1572019348
        },
        {
            "component": "SmallWeatherDelegat.qml",
            "temperature": 25,
            "pressure": 755,
            "humidity": 85,
            "width": 200,
            "date": 1572019348,
            "typeWeather": "thunderstorm",
        },
        {
            "component": "WeatherDelegat.qml",
            "temperature": 25,
            "pressure": 755,
            "humidity": 85,
            "date": 1572019348,
            "typeWeather": "clear sky",
            "minTemperature": 23,
            "maxTemperature": 27,
            "windSpeed": 3,
            "windDeg": 178,
            "sunrise": 1570159679,
            "sunset": 1570159679
        },
        {
            "component": "SmallWeatherDelegat.qml",
            "temperature": 25,
            "pressure": 755,
            "humidity": 85,
            "width": 200,
            "date": 1572019348,
            "typeWeather": "few clouds",
        },
    ]


}
