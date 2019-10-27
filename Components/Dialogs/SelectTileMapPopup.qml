import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import Components.Controls 1.0
import MyStyle 1.0

Popup {
    id: _popup

    width: 140; height: 170
    padding: 0


    background: Rectangle {
        width: parent.width; height: parent.height
        radius: 10
        color: MyStyle.foregroundColor
        Rectangle {
            x: parent.width-width; y:0
            width: 10; height: 10
            color: parent.color
        }
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
            y:5
            width: parent.width; height: 20
            horizontalAlignment: Text.AlignHCenter
            color: MyStyle.textColor
            text: qsTr("Карта погоды")
        }

        Column {
            y: 20
            padding: 10
            spacing: 10
            CustomRadioButton {
                checked: true
                text: qsTr("Выключить")
            }
            CustomRadioButton {
                text: qsTr("Облака")
            }
            CustomRadioButton {
                text: qsTr("Осадки")
            }
            CustomRadioButton {
                text: qsTr("Давление")
            }
            CustomRadioButton {
                text: qsTr("Ветер")
            }
        }
    }
}
