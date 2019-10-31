import QtQuick 2.12
import QtQuick.Controls 2.5

import MyStyle 1.0

Item {
    Label {
        x:20; y: 20
        font.pixelSize: 32
        color: MyStyle.textColor
        text: qsTr("Система")
    }
}
