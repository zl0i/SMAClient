import QtQuick 2.12
import QtQuick.Controls 2.5


import Components.Controls 1.0
import Components.Delegats 1.0

Item {

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
            x: 20; y:17
            font.pixelSize: 32
            color: "#000000"
            text: "Поле 3"
        }
        WeatherDelegat {
            x:20; y: 68
            temperature: +25
            pressure: 755
            humidity: 85
            minTemperature: -9
            maxTemperature: -5
            windSpeed: 5
            windDirection: "с-в"
            date: new Date()
            sunrise: new Date()
            sunset: new Date()
        }
        Label {
            x:20; y:310
            color: "#000000"
            font.pixelSize: 32
            text: qsTr("Прогноз на 5 дней")
        }
        ListView {
            x: 20; y: 363
            width: parent.width-x; height: 200
            orientation: ListView.Horizontal
            spacing: 20
            model: 6
            delegate: WeatherDelegat {
                date: new Date()
                sunrise: new Date()
                sunset: new Date()
                temperature: -7
                pressure: 755
                humidity: 85
                minTemperature: -9
                maxTemperature: -5
                windSpeed: 5
                windDirection: "с-в"

            }
        }
        Label {
            x: 21; y: 585
            font.pixelSize: 32
            color: "#000000"
            text: qsTr("Прогноз на 14 дней")
        }

        ListView {
            x: 20; y: parent.height-height-20
            width: parent.width-x; height: 160
            orientation: ListView.Horizontal
            spacing: 20
            model: 6
            delegate: SmallWeatherDelegat {
                temperature: 20
                pressure: 755

            }

        }
    }

}
