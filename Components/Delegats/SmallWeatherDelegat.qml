import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import MyStyle 1.0

BaseWeatherDelegate {
    id: _delegat
    width: 150; height: 200

    property string date   

    Label {
        x: 0; y: 7
        width: parent.width
        verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
        color: MyStyle.textColor
        font.pixelSize: 16
        text: "16 октября"
    }

    Image {
        x: parent.width/2-width/2; y: 26
        width: 30; height: 30
        fillMode: Image.PreserveAspectFit
        source: getIconByWeather(_delegat.typeWeather)
        layer.enabled: true
        layer.effect: ColorOverlay {
            color: MyStyle.textColor
        }
    }
    Column {
        x: 15; y: 65
        spacing: 6
        Row {
            spacing: 10
            Item {
                width: 20; height: 18
                Image {
                    anchors.centerIn: parent
                    width: 8; height: 16
                    source: "qrc:/image/weather/temperature-black.svg"
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
                text: _delegat.temperature + " C"
            }
        }
        Row {
            spacing: 10
            Item {
                width: 20; height: 18
                Image {
                    anchors.centerIn: parent
                    width: 16; height: 16
                    source: "qrc:/image/weather/pressure-black.svg"
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
                width: 20; height: 18
                Image {
                    anchors.centerIn: parent
                    width: 16; height: 20
                    source: "qrc:/image/weather/humidity-black.svg"
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
                width: 20; height: 18
                Image {
                    anchors.centerIn: parent
                    width: 20; height: 13
                    source: "qrc:/image/weather/wind-black.svg"
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
                text: _delegat.windSpeed + " м/с"
            }
        }
    }

}
