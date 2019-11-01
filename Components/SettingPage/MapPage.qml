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
        interactive: contentHeight > height
        clip: true
        Column {
            id: _column
            width: parent.width
            spacing: 15
            RowComboBox {
                 width: parent.width
                 text: qsTr("Тип карты")
                 model: ["Street Map", "Satellite Map",
                        "Cycle Map", "Transit Map", "Night Transit Map",
                        "Terrain Map", "Hiking Map", ]
                 onActivated: {
                     _main.mapType = String(index)
                 }
            }
        }
    }
}
