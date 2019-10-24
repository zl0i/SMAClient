import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import MyStyle 1.0

BaseWeatherDelegate {
    id: _delegat
    width: 410; height: 200

    property var date    
    property int minTemperature
    property int maxTemperature   
    property string windDirection


    Label {
        x:16; y:3
        font.pixelSize: 20
        color: MyStyle.textColor
        text: {
            if(date.getDate() === new Date().getDate()) {
                return qsTr("Сегодня (%1)").arg(date.toLocaleString(Qt.locale(), "dd MMMM"))
            }
            return date.toLocaleString(Qt.locale(), "dd MMMM")
        }
    }
    Label {
        id: _mainTemp
        x:16; y:35
        font.pixelSize: 36
        color: MyStyle.textColor
        text: (_delegat.temperature > 0 ? "+" : "")  + _delegat.temperature + " C"
    }
    Label {
        x: _mainTemp.x + _mainTemp.contentWidth + 10; y:31
        color: MyStyle.textColor
        text: _delegat.maxTemperature
    }
    Label {
        x: _mainTemp.x + _mainTemp.contentWidth + 10; y:68
        color: MyStyle.textColor
        text: _delegat.minTemperature
    }
    Row {
        x:146; y:32
        height: 17
        spacing: 7
        Image {
            width: 33; height: 17
            source: "qrc:/image/weather/upsun-black.svg"
            layer.enabled: true
            layer.effect: ColorOverlay {
                color: MyStyle.textColor
            }
        }
        Label {
            height: 17
            verticalAlignment: Text.AlignVCenter
            color: MyStyle.textColor
            text: sunrise.toLocaleString(Qt.locale(), "HH:mm")
        }
    }
    Row {
        x:146; y:68
        height: 11
        spacing: 7
        Image {
            width: 33; height: 11
            source: "qrc:/image/weather/downsun-black.svg"
            layer.enabled: true
            layer.effect: ColorOverlay {
                color: MyStyle.textColor
            }
        }
        Label {
            height: 11
            verticalAlignment: Text.AlignVCenter
            color: MyStyle.textColor
            text: sunrise.toLocaleString(Qt.locale(), "HH:mm")
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
                source: "qrc:/image/weather/humidity-black.svg"
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
                source: "qrc:/image/weather/pressure-black.svg"
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
                source: "qrc:/image/weather/wind-black.svg"
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
            text: _delegat.windDirection
        }
        Label {
            height: 22
            verticalAlignment: Text.AlignVCenter
            color: MyStyle.textColor
            text: _delegat.windSpeed + " м/с"
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
                source: "qrc:/image/weather/snow-black.svg"
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
            text: "Снег"//"Перееменная облачность"
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
        model: 7
        delegate: Column {
            width: 37; height: 20
            spacing: 10
            Label {
                width: 37; height: 20
                verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
                color: MyStyle.textColor
                text: "22:00"
            }
            Label {
                width: 37; height: 20
                verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
                color: MyStyle.textColor
                text: "+8 C"
            }
        }
    }

}
