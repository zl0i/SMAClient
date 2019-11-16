import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import MyStyle 1.0

BaseWeatherDelegate {
    id: _delegat
    width: 410;
    antialiasing: true
    property int minTemperature
    property int maxTemperature
    property int windDeg
    property var dailyForecast

    property bool visibleSun: true

    Label {
        x:16; y:3
        font.pixelSize: 20
        color: MyStyle.textColor
        text: {
            var temp = new Date(date)
            if(temp.getDate() === new Date().getDate()) {
                return qsTr("Сегодня (%1)").arg(temp.toLocaleString(Qt.locale(), "dd MMMM"))
            }
            return temp.toLocaleString(Qt.locale(), "dd MMMM")
        }
    }
    Label {
        id: _mainTemp
        x:16; y:35
        font.pixelSize: 36
        color: MyStyle.textColor
        text: (_delegat.temperature > 0 ? "+" : "")  + _delegat.temperature + " " + degTemperatureStr + "C"
    }
    Label {
        id: _maxTemp
        x: _mainTemp.x + _mainTemp.contentWidth + 10; y:31
        color: MyStyle.textColor
        text: (_delegat.maxTemperature > 0 ? "+" : "")  + _delegat.maxTemperature
    }
    Label {
        id: _minTemp
        x: _mainTemp.x + _mainTemp.contentWidth + 10; y:68
        color: MyStyle.textColor
        text: (_delegat.minTemperature > 0 ? "+" : "")  + _delegat.minTemperature
    }
    Row {
        x:_maxTemp.x + _maxTemp.contentWidth + 20; y:32
        height: 17
        spacing: 7
        visible: _delegat.visibleSun
        Image {
            width: 33; height: 17
            source: "qrc:/image/weather/value-icons/upsun-black.svg"
            layer.enabled: true
            layer.effect: ColorOverlay {
                color: MyStyle.textColor
            }
        }
        Label {
            height: 17
            verticalAlignment: Text.AlignVCenter
            color: MyStyle.textColor
            text: new Date(sunrise).toLocaleString(Qt.locale(), "hh:mm")
        }
    }
    Row {
        x:_maxTemp.x + _maxTemp.contentWidth + 20; y:68
        height: 11
        spacing: 7
        visible: _delegat.visibleSun
        Image {
            width: 33; height: 11
            source: "qrc:/image/weather/value-icons/downsun-black.svg"
            layer.enabled: true
            layer.effect: ColorOverlay {
                color: MyStyle.textColor
            }
        }
        Label {
            height: 11
            verticalAlignment: Text.AlignVCenter
            color: MyStyle.textColor
            text: new Date(sunset).toLocaleString(Qt.locale(), "hh:mm")
        }
    }


    Row {
        x: 16; y:91
        height: 22
        spacing: 10
        Item {
            width: 20; height: 22
            Image {
                anchors.centerIn: parent
                width: 13; height: 20
                source: "qrc:/image/weather/value-icons/humidity-black.svg"
                layer.enabled: true
                layer.effect: ColorOverlay {
                    color: MyStyle.textColor
                }
            }
        }
        Label {
            height: 22
            verticalAlignment: Text.AlignVCenter
            color: MyStyle.textColor
            text: _delegat.humidity + " %"
        }
        Item {
            width: 26; height: 22
            Image {
                anchors.centerIn: parent
                width: 20; height: 20
                source: "qrc:/image/weather/value-icons/pressure-black.svg"
                layer.enabled: true
                layer.effect: ColorOverlay {
                    color: MyStyle.textColor
                }
            }
        }
        Label {
            height: 22
            verticalAlignment: Text.AlignVCenter
            color: MyStyle.textColor
            text: _delegat.pressure + " мм"
        }
        Item {
            width: 26; height: 22
            Image {
                anchors.centerIn: parent
                width: 26.5; height: 15
                antialiasing: true
                source: "qrc:/image/weather/value-icons/wind-black.svg"
                layer.enabled: true
                layer.effect: ColorOverlay {
                    color: MyStyle.textColor
                }
            }
        }
        Label {
            height: 22
            verticalAlignment: Text.AlignVCenter
            color: MyStyle.textColor
            text: getDirectionByDeg(windDeg)
        }
        Label {
            height: 22
            verticalAlignment: Text.AlignVCenter
            color: MyStyle.textColor
            text: _delegat.windSpeed + qsTr(" м/с")
        }
    }
    Column {
        x: parent.width-width-20; y: 15
        spacing: 10
        Item {
            width: 100; height: 60
            Image {
                anchors.centerIn: parent
                width: 75; height: 60
                fillMode: Image.PreserveAspectFit
                source: getIconByWeather(typeWeather, descriptionWeather)
                layer.enabled: true
                layer.effect: ColorOverlay {
                    color: MyStyle.textColor
                }
            }
        }
        Label {
            width: 100; height: 32
            verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            color: MyStyle.textColor
            text: getNameByWeather(descriptionWeather)
        }
    }

    Rectangle {
        x: 12; y: 122
        width: parent.width-24; height: 1
        color: "#6AABF7"
    }

    ListView {
        x: 16; y:134
        width: parent.width-x-16; height: 40
        orientation: ListView.Horizontal
        spacing: 20
        interactive: false
        model: dailyForecast
        delegate: Column {
            width: 37; height: 20
            spacing: 10
            Label {
                width: 37; height: 20
                verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
                color: MyStyle.textColor
                text: new Date(modelData.dt).toLocaleString(Qt.locale(), "hh:mm")
            }
            Label {
                width: 37; height: 20
                verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
                color: MyStyle.textColor
                text: Math.floor(modelData.temp) + " " + degTemperatureStr + "C"
            }
        }
    }

}
