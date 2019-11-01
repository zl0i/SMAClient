import QtQuick 2.12
import QtQuick.Controls 2.5

import Components.SettingPage 1.0
import MyStyle 1.0

Item {

    Label {
        x:20; y: 20
        font.pixelSize: 32
        color: MyStyle.textColor
        text: qsTr("Интерфейс")
    }

    Flickable {
        x: 20; y: 80
        width: parent.width-40; height: parent.height-80
        contentHeight: _column.height
        interactive: contentHeight > height
        clip: true
        Column {
            id: _column
            width: parent.width
            spacing: 20
            RowCheckBox {
                width: parent.width
                text: qsTr("Темная тема")
                checked: _main.style === 1
                onClicked:  {
                    if(checked) {
                        _main.style = 1
                    }
                    else {
                        _main.style = 0
                    }
                }
            }
        }
    }
}
