import QtQuick 2.12
import QtQuick.Controls 2.5

import Components.Controls 1.0
import Components.Delegats 1.0
import Components.Dialogs 1.0

import MyStyle 1.0

Rectangle {
    color: MyStyle.backgroundColor

    Rectangle {
        width: 256; height: parent.height
        color: "#323232"
        Label {
            width: parent.width; height: 94
            leftPadding: 20
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 24
            font.weight: Font.Bold
            color: "#FFFFFF"
            text: qsTr("Список мест")
        }
        Rectangle {
            x: 0; y: 95
            width: parent.width; height: 1
            color: "#6AABF7"
        }
        ListView {
            id: _placeList
            x: 0; y: 96
            width: parent.width; height: parent.height-y-90
            clip: true
            model: 5
            delegate: Item {
                id: _delegat
                width: parent.width; height: 64
                Label {
                    width: parent.width; height: parent.height
                    leftPadding: 20
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 20
                    color: "#FFFFFF"
                    text: modelData
                }
                Rectangle {
                    width: parent.width; height: parent.height
                    visible: _delegat.ListView.isCurrentItem || _mouseArea.hovered
                    opacity: _mouseArea.pressed ? 0.3 : 0.5
                    color: "#C4C4C4"
                }
                MouseArea {
                    id: _mouseArea
                    width: parent.width; height: parent.height
                    hoverEnabled: true
                    property bool hovered: false
                    onEntered: hovered = true
                    onExited: hovered = false
                    onClicked: {
                        _delegat.ListView.view.currentIndex = index
                    }
                }
            }
        }
        RoundButton {
            x: parent.width/2-width/2; y: parent.height-height-20
            size: "big"
            text: qsTr("Добавить место")
            onClicked: {
                _addWeatherPlaceDialog.open()
            }
        }
    }

    AddWeatherPlaceDialog {
        id: _addWeatherPlaceDialog
    }



    Item {
        id: _contentItem
        x: 256; y: 0
        width: parent.width-x; height: parent.height
        clip: true

        Label {
            x: 20; y:20
            font.pixelSize: 32
            color: MyStyle.textColor
            text: "Поле 3"
        }
        WeatherDelegat {
            x:20; y: 68
            temperature: _weather.relevantData ? _weather.currentWeather.temp : 0
            pressure:  _weather.relevantData ? _weather.currentWeather.pressure : 0
            humidity:  _weather.relevantData ? _weather.currentWeather.humidity : 0
            minTemperature:  _weather.relevantData ? _weather.currentWeather.temp_min: 0
            maxTemperature:  _weather.relevantData ? _weather.currentWeather.temp_max : 0
            windSpeed:  _weather.relevantData ? _weather.currentWeather.speedWind : 0
            windDeg:  _weather.relevantData ? _weather.currentWeather.degWind : 0
            date:  _weather.relevantData ? _weather.currentWeather.dt : 0
            sunrise:  _weather.relevantData ? _weather.currentWeather.sunrise : 0
            sunset: _weather.relevantData ? _weather.currentWeather.sunset : 0
            typeWeather: _weather.relevantData?  _weather.currentWeather.type : ""
            descriptionWeather: _weather.relevantData ? _weather.currentWeather.description : ""
            dailyForecast: _weather.relevantData ? _weather.currentWeather.forecast : 0
        }
        Label {
            x:20; y:283
            color: MyStyle.textColor
            font.pixelSize: 32
            text: qsTr("Прогноз на 5 дней")
        }
        ListView {
            x: 20; y: 331
            width: parent.width-x; height: 200
            orientation: ListView.Horizontal
            spacing: 20
            model: _weather.dailyForecast
            delegate: WeatherDelegat {
                date: modelData.dt
                sunrise:  modelData.sunrise
                sunset:  modelData.sunset
                temperature:  modelData.temp
                pressure: modelData.pressure
                humidity: modelData.humidity
                minTemperature: modelData.temp_min
                maxTemperature: modelData.temp_max
                windSpeed:  modelData.speedWind
                windDeg: modelData.degWind
                typeWeather: modelData.type
                descriptionWeather: modelData.description
                dailyForecast: modelData.forecast
                visibleSun: false
            }
        }
        Label {
            x: 21; y: 546
            font.pixelSize: 32
            color: MyStyle.textColor
            text: qsTr("Прогноз на 14 дней")
        }

        ListView {
            x: 20; y: 596//parent.height-height-20
            width: parent.width-x; height: 160
            orientation: ListView.Horizontal
            spacing: 20
            model: _weather.twoDailyForecast
            delegate: SmallWeatherDelegat {
                temperature: modelData.temp
                pressure: modelData.pressure
                humidity: modelData.humidity
                windSpeed:  modelData.speedWind
                sunrise: modelData.sunrise
                sunset: modelData.sunset
                date: modelData.dt
                typeWeather: modelData.type
                descriptionWeather: modelData.description
            }
        }
    }

}
