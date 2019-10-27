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
            temperature: +15
            pressure: 755
            humidity: 85
            minTemperature: 25
            maxTemperature: 25
            windSpeed: 5
            windDeg: 240
            date: 1570266000
            sunrise: 1570266000
            sunset: 1570266000
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
            model: 6
            delegate: WeatherDelegat {
                date: 1570266000
                sunrise: 1570266000
                sunset: 1570266000
                temperature: -7
                pressure: 755
                humidity: 85
                minTemperature: -9
                maxTemperature: -5
                windSpeed: 5
                windDeg: 357
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
            model: 6
            delegate: SmallWeatherDelegat {
                temperature: 20
                pressure: 755
                date: 1570159679
            }

        }
    }

}
