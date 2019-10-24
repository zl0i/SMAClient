import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import MyStyle 1.0

Rectangle {
    id: _delegat
    width: 200; height: 200; radius: 20
    color: MyStyle.foregroundColor
    layer.enabled: true
    layer.effect: DropShadow {
        radius: 8
        samples: 16
        color: _mouseArea.pressed ? "#80FFFFFF": "#80000000"
    }

    signal clicked()

    MouseArea {
        id: _mouseArea
        width: parent.width; height: parent.height
        onClicked: _delegat.clicked()
    }
    Label {
        width: parent.width; height: parent.height-50
        verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
        color: MyStyle.textColor
        font.pixelSize: 96
        font.weight: Font.Black
        text: "+"
    }

    Label {
        y:120
        width: parent.width;
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 18
        color: MyStyle.textColor
        text: qsTr("Добавить")
    }

}
