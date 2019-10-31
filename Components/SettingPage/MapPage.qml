import QtQuick 2.12
import QtQuick.Controls 2.5

import MyStyle 1.0
import Components.SettingPage 1.0

Item {
    Label {
        x:20; y: 20
        font.pixelSize: 32
        color: MyStyle.textColor
        text: qsTr("Карта")
    }

    Flickable {
        x: 20; y: 80
        width: parent.width-2*x; height: parent.height-y
        contentHeight: _column.height
        clip: true
        Column {
            id: _column
            width: parent.width
            spacing: 15
            RowComboBox {
                width: parent.width
                text: qsTr("Плагин карты")
            }
            RowComboBox {
                 width: parent.width
                text: qsTr("Тип карты")
            }
        }
    }
}
