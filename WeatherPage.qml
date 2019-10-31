import QtQuick 2.12
import QtQuick.Controls 2.5

import Components.Controls 1.0
import Components.Delegats 1.0

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

            }
        }
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
            temperature: _weather.currentWeather.temp
            pressure: _weather.currentWeather.pressure
            humidity: _weather.currentWeather.humidity
            minTemperature: _weather.currentWeather.min_temp
            maxTemperature: _weather.currentWeather.max_temp
            windSpeed: _weather.currentWeather.speedWind
            windDeg: _weather.currentWeather.degWind
            date: _weather.currentWeather.dt
            sunrise: _weather.currentWeather.sunrise
            sunset: _weather.currentWeather.sunset
            typeWeather: _weather.currentWeather.type
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
            }

        }
    }

}
