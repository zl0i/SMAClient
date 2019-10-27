import QtQuick 2.12
import QtQuick.Controls 2.5

import MyStyle 1.0

CheckBox {
    id: _control
    height: 26

    indicator: Rectangle {
        x: _control.leftPadding
        y: parent.height / 2 - height / 2
        implicitWidth: 26
        implicitHeight: 26
        color: MyStyle.foregroundColor
        border.color: MyStyle.textColor

        Rectangle {
            x: 6; y: 6
            width: 14; height: 14
            color: MyStyle.textColor
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
