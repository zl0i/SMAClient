import QtQuick 2.0
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import MyStyle 1.0

Rectangle {
    id: _delegat
    width: 200; height: 200; radius: 20
    color: MyStyle.foregroundColor


    property string name
    property real temperature
    property real pressure
    property real humidity

    layer.enabled: true
    layer.effect: DropShadow {
        radius: 8
        samples: 16
        color: "#80000000"
    }
    Label {
        y: 10
        width: parent.width
        horizontalAlignment: Text.AlignHCenter
        color: MyStyle.textColor
        font.pixelSize: 14
        text: _delegat.name
    }
    Column {
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 10
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 15
        Row {
            spacing: 5
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
                text: _delegat.temperature + " °C"
            }
        }
        Row {
            spacing: 5
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
            spacing: 5
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
    }
}
