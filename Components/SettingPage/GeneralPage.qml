import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

import MyStyle 1.0

Item {
    Label {
        x:20; y: 20
        font.pixelSize: 32
        color: MyStyle.textColor
        text: qsTr("Общие")
    }

    Flickable {
        x: 20; y: 80
        width: parent.width-2*x; height: parent.height-y
        contentHeight: _clolumn.height
        clip: true
        Column {
            id: _clolumn
            width: parent.width
            spacing: 15

        }
    }

}
