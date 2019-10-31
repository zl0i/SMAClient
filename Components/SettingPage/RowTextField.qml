import QtQuick 2.12
import QtQuick.Controls 2.5

import MyStyle 1.0

Item {
    id: _root
    height: 35
    property string text

    property alias model: _comboBox.model

    signal activated(var index)

    Label {
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 18
        color: MyStyle.textColor
        text: _root.text
    }
    TextField {
        id: _comboBox
        x: parent.width-width
        background: Rectangle {
            width: parent.width; height: parent.height
            color: MyStyle.foregroundColor
            border { width: 1; color: MyStyle.textColor }
        }

    }
}
