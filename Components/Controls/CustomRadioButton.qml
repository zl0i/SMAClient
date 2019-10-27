import QtQuick 2.12
import QtQuick.Controls 2.5

import MyStyle 1.0

RadioButton {
    id: _control
    height: 16

    indicator: Rectangle {
        x: _control.leftPadding
        y: parent.height / 2 - height / 2
        implicitWidth: 16
        implicitHeight: 16
        radius: 8
        color: "transparent"
        border.color:  "#6AABF7"

        Rectangle {
            x: 4; y: 4
            width: 8; height: 8
            radius: 5
            color: "#6AABF7"
            visible: _control.checked
        }
    }

    contentItem: Label {
        leftPadding: _control.indicator.width + _control.spacing
        height: _control.height
        verticalAlignment: Text.AlignVCenter
        color: MyStyle.textColor
        text: _control.text
    }
}
