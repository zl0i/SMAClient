import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import Components.Controls 1.0
import MyStyle 1.0

Popup {
    id: _popup

    width: 120; height: 120
    padding: 0

    property string name

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
            y: 10
            width: parent.height
            horizontalAlignment: Text.AlignHCenter
            color: MyStyle.textColor
            text: _popup.name
        }
        MouseArea {
            x: parent.width/2 - width/2; y: parent.height-height-10
            width: 95; height: 15
            onClicked: {
                _popup.clickedMore()
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
