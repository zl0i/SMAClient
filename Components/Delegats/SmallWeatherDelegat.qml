import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import MyStyle 1.0

BaseWeatherDelegate {
    id: _delegat
    width: 150; height: 200
    antialiasing: true

    property bool visibleSun: true

    Label {
        x: 0; y: 5
        width: parent.width
        verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
        color: MyStyle.textColor
        font.pixelSize: 16
        text: new Date(date).toLocaleString(Qt.locale(), "d MMMM")
    }

    Image {
        x: parent.width/2-width/2; y: 26
        width: 30; height: 30
        fillMode: Image.PreserveAspectFit
        source: getIconByWeather(_delegat.typeWeather, _delegat.descriptionWeather)
        layer.enabled: true
        layer.effect: ColorOverlay {
            color: MyStyle.textColor
        }
    }
    Column {
        x: parent.width/2-width/2; y: parent.height/2-height/2 + 32
        spacing: 5
        Row {
            spacing: 10
            Item {
                width: 33; height: 18
                Image {
                    anchors.centerIn: parent
                    width: 8; height: 16
                    source: "qrc:/image/weather/value-icons/temperature-black.svg"
                    layer.enabled: true
                    layer.effect: ColorOverlay {
                        color: MyStyle.textColor
                    }
                }
            }
            Label {
                width: 53; height: 18
                verticalAlignment: Text.AlignVCenter
                color: MyStyle.textColor
                text: _delegat.temperature + " " + degTemperatureStr + "C"
            }
        }
        Row {
            spacing: 10
            Item {
                width: 33; height: 18
                Image {
                    anchors.centerIn: parent
                    width: 16; height: 16
                    source: "qrc:/image/weather/value-icons/pressure-black.svg"
                    layer.enabled: true
                    layer.effect: ColorOverlay {
                        color: MyStyle.textColor
                    }
                }
            }
            Label {
                width: 53; height: 18
                verticalAlignment: Text.AlignVCenter
                color: MyStyle.textColor
                text: _delegat.pressure + " мм"
            }
        }
        Row {
            spacing: 10
            Item {
                width: 33; height: 18
                Image {
                    anchors.centerIn: parent
                    width: 16; height: 20
                    source: "qrc:/image/weather/value-icons/humidity-black.svg"
                    layer.enabled: true
                    layer.effect: ColorOverlay {
                        color: MyStyle.textColor
                    }
                }
            }
            Label {
                width: 53; height: 18
                verticalAlignment: Text.AlignVCenter
                color: MyStyle.textColor
                text: _delegat.humidity + " %"
            }
        }
        Row {
            spacing: 10
            Item {
                width: 33; height: 18
                Image {
                    anchors.centerIn: parent
                    width: 20; height: 13
                    source: "qrc:/image/weather/value-icons/wind-black.svg"
                    layer.enabled: true
                    layer.effect: ColorOverlay {
                        color: MyStyle.textColor
                    }
                }
            }
            Label {
                width: 53; height: 18
                verticalAlignment: Text.AlignVCenter
                color: MyStyle.textColor
                text: _delegat.windSpeed + qsTr(" м/с")
            }
        }
        Row {
            visible: _delegat.visibleSun
            spacing: 10
            Item {
                width: 33; height: 18
                Image {
                    anchors.centerIn: parent
                    width: 27; height: 16
                    source: "qrc:/image/weather/value-icons/upsun-black.svg"
                    layer.enabled: true
                    layer.effect: ColorOverlay {
                        color: MyStyle.textColor
                    }
                }
            }
            Label {
                width: 53; height: 16
                verticalAlignment: Text.AlignVCenter
                color: MyStyle.textColor
                text:  new Date(sunrise).toLocaleString(Qt.locale(), "hh:mm")
            }
        }
        Row {
            visible: _delegat.visibleSun
            spacing: 10
            Item {
                width: 33; height: 18
                Image {
                    anchors.centerIn: parent
                    width: 33; height: 11
                    source: "qrc:/image/weather/value-icons/downsun-black.svg"
                    layer.enabled: true
                    layer.effect: ColorOverlay {
                        color: MyStyle.textColor
                    }
                }
            }
            Label {
                width: 53; height: 11
                verticalAlignment: Text.AlignVCenter
                color: MyStyle.textColor
                text:  new Date(sunset).toLocaleString(Qt.locale(), "hh:mm")
            }
        }
    }

}
