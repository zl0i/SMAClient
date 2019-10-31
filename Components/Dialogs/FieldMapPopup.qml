import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import Components.Controls 1.0
import MyStyle 1.0

Popup {
    id: _popup

    width: 120; height: 120
    padding: 9


    property string field_id
    property string name
    property real temperature
    property real pressure
    property real humidity


    signal clickedMore()

    background: Rectangle {
        width: parent.width; height: parent.height; radius: 20
        color: MyStyle.foregroundColor
        layer.enabled: true
        layer.effect: DropShadow {
            radius: 8
            samples: 16
            color: "#80000000"
        }
    }

    contentItem: Item {
        width: parent.width; height: parent.height
        Label {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            color: MyStyle.textColor
            text: _popup.name
        }
        Column {
            y: 25
            anchors.horizontalCenter: parent.horizontalCenter
            Row {
                spacing: 5
                Item {
                    width: 33; height: 18
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
                    text: _popup.temperature + " °C"
                }
            }
            Row {
                spacing: 5
                Item {
                    width: 33; height: 18
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
                    text: _popup.pressure + " мм"
                }
            }
            Row {
                spacing: 5
                Item {
                    width: 33; height: 18
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
                    text: _popup.humidity + " %"
                }
            }
        }

        MouseArea {
            x: parent.width/2 - width/2; y: parent.height-height
            width: 95; height: 15
            onClicked: {
                _popup.clickedMore(_popup.field_id)
            }
            Row {
                spacing: 10
                Label {
                    height: 15
                    verticalAlignment: Text.AlignVCenter
                    color: MyStyle.textColor
                    text: qsTr("Подробнее")
                }
                Rectangle {
                    width: 15; height: 15; radius: 8
                    color: MyStyle.textColor
                    Image {
                        x:7; y: 4
                        width: 4; height: 8
                        source: "qrc:/image/other/arrow-next-black.svg"
                        antialiasing: true
                        layer.enabled: true
                        layer.effect: ColorOverlay {
                            color: MyStyle.foregroundColor
                        }
                    }
                }
            }
        }


    }

}
