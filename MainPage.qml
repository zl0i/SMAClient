import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQml.Models 2.12
import QtGraphicalEffects 1.12
import Qt.labs.settings 1.1
import QtQml 2.13

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
    Item {
        anchors { bottom: parent.bottom; right: parent.right;}
        width: 200; height: 200
        visible: _flick.isEdit
        RadialGradient {
            anchors.fill: parent
            verticalRadius: 100
            horizontalRadius: 100
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#D33131" }
                GradientStop {
                    position: _dropArea.hovered ? 1 : 0.7;
                    color: "transparent"
                    Behavior on position {
                        NumberAnimation { duration: 250 }
                    }
                }
            }

        }
        DropArea {
            id: _dropArea
            anchors.fill: parent
            property bool hovered: false
            onEntered: {
                hovered = true
            }
            onExited: hovered = false
            onDropped: {
                _visualModel.items.remove(drag.source.DelegateModel.itemsIndex, 1)
                console.log("drop")
            }
        }

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
                        view: _flick
                        Loader {
                            id: _loader
                            source: "Components/Delegats/" + modelData.component
                            onStatusChanged: {
                                setPropertyComponent(item, modelData)
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

    AddFavoriteDialog {
        id: _addFavoriteDialog
    }

    function setPropertyComponent(obj, model) {
        for(var key in model) {
            if(key === "component") continue
            obj[key] = model[key]
        }
    }

    property var favoritModel: [
        /*{
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
        },*/
    ]


}
