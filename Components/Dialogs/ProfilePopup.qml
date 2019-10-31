import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import Components.Controls 1.0
import MyStyle 1.0

Popup {
    id: _popup
    parent: Overlay.overlay
    width: 317; height: 166
    padding: 10

    property string fullName: ""
    property string companyName: ""
    property string role: ""

    signal exit()

    background: Rectangle {
        width: parent.width; height: parent.height
        radius: 20
        color: MyStyle.foregroundColor
        Rectangle {
            x: -5; y: 21
            width: 13; height: 13
            rotation: 45
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
        Label {
            x:13; y:5
            font.pixelSize: 18
            color: MyStyle.textColor
            text: _popup.companyName
        }
        Label {
            x:13; y:38
            font.pixelSize: 18
            color: MyStyle.textColor
            text: _popup.fullName
        }
        Label {
            x:13; y:70
            font.pixelSize: 18
            color: MyStyle.textColor
            text: qsTr("Статус: %1").arg(_popup.role)
        }

        RoundButton {
            x: parent.width-width; y: parent.height-height
            width: 115; height: 40
            size: "custom"
            style: "dark blue"
            text: qsTr("Выйти")
            onClicked:  {
                _popup.close()
                _popup.exit()
            }
        }




    }

}
