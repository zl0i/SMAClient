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
        anchors { bottom: parent.bottom; right: parent.right; bottomMargin: -200; rightMargin: -200}
        width: 400; height: 400
        visible: _flick.isEdit
        RadialGradient {
            anchors.fill: parent
            verticalRadius: 200
            horizontalRadius: 200
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
        Image {
            x: 150; y: 150
            width: 40; height: 40
            source: "qrc:/image/other/trashBin-black.svg"
        }

        DropArea {
            id: _dropArea
            anchors.fill: parent
            property bool hovered: false
            onEntered: hovered = true
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
        interactive: contentHeight > height
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

                            function setPropertyComponent(obj, model) {
                                for(var key in model) {
                                    if(key === "component") continue
                                    obj[key] = model[key]
                                }
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



    property var favoritModel: [
        {
            "component": "WeatherDelegat.qml",
            "date":  _weather.relevantData ? _weather.currentWeather.dt : 0,
            "temperature": _weather.relevantData ? _weather.currentWeather.temp : 0,
            "pressure":  _weather.relevantData ? _weather.currentWeather.pressure : 0,
            "humidity":  _weather.relevantData ? _weather.currentWeather.humidity : 0,
            "minTemperature":  _weather.relevantData ? _weather.currentWeather.temp_min: 0,
            "maxTemperature":  _weather.relevantData ? _weather.currentWeather.temp_max : 0,
            "windSpeed":  _weather.relevantData ? _weather.currentWeather.speedWind : 0,
            "windDeg":  _weather.relevantData ? _weather.currentWeather.degWind : 0,
            "date":  _weather.relevantData ? _weather.currentWeather.dt : 0,
            "sunrise":  _weather.relevantData ? _weather.currentWeather.sunrise : 0,
            "sunset": _weather.relevantData ? _weather.currentWeather.sunset : 0,
            "typeWeather": _weather.relevantData ?  _weather.currentWeather.type : "",
            "descriptionWeather": _weather.relevantData ? _weather.currentWeather.description : "",
            "dailyForecast": _weather.relevantData ? _weather.currentWeather.forecast : 0
        },
        {
            "component": "WeatherDelegat.qml",
            "temperature": _weather.dailyForecast[0].temp,
            "pressure": _weather.dailyForecast[0].pressure,
            "humidity": _weather.dailyForecast[0].humidity,
            "typeWeather":  _weather.dailyForecast[0].type,
            "descriptionWeather": _weather.dailyForecast[0].description,
            "date": _weather.dailyForecast[0].dt,
            "sunrise": _weather.dailyForecast[0].sunrise,
            "sunset": _weather.dailyForecast[0].sunset,
            "windSpeed":  _weather.dailyForecast[0].speedWind,
            "minTemperature": _weather.dailyForecast[0].temp_min,
            "maxTemperature": _weather.dailyForecast[0].temp_max,
            "dailyForecast": _weather.dailyForecast[0].forecast,
            "visibleSun": false
        },
        {
            "component": "SmallWeatherDelegat.qml",
            "temperature": _weather.dailyForecast[1].temp,
            "pressure": _weather.dailyForecast[1].pressure,
            "humidity": _weather.dailyForecast[1].humidity,
            "width": 200,
            "typeWeather":  _weather.dailyForecast[1].type,
            "descriptionWeather": _weather.dailyForecast[1].description,
            "date": _weather.dailyForecast[1].dt,
            "sunrise": _weather.dailyForecast[1].sunrise,
            "sunset": _weather.dailyForecast[1].sunset,
            "windSpeed":  _weather.dailyForecast[1].speedWind,
            "visibleSun": false
        },
        {
            "component": "SmallWeatherDelegat.qml",
            "temperature": _weather.dailyForecast[2].temp,
            "pressure": _weather.dailyForecast[2].pressure,
            "humidity": _weather.dailyForecast[2].humidity,
            "width": 200,
            "typeWeather":  _weather.dailyForecast[2].type,
            "descriptionWeather": _weather.dailyForecast[2].description,
            "date": _weather.dailyForecast[2].dt,
            "sunrise": _weather.dailyForecast[2].sunrise,
            "sunset": _weather.dailyForecast[2].sunset,
            "windSpeed":  _weather.dailyForecast[2].speedWind,
            "visibleSun": false
        },
        {
            "component": "FieldMapDelegat.qml",
            "name": "Поле 1",
            "temperature": -5,
            "pressure": 750,
            "humidity": 65
        }

    ]


}
