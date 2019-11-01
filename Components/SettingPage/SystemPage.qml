import QtQuick 2.12
import QtQuick.Controls 2.5

import MyStyle 1.0
import Components.SettingPage 1.0

Item {
    Label {
        x:20; y: 20
        font.pixelSize: 32
        color: MyStyle.textColor
        text: qsTr("Система")
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
            RowCheckBox {
                width: parent.width
                text: qsTr("Сохранять логин")
                checked: _main.login.length !== 0
                onClicked: {
                    if(!checked) {
                        _main.login = ""
                    }
                }
            }
            RowCheckBox {
                width: parent.width
                text: qsTr("Сохранять пароль")
                checked: _main.password.length !== 0
                onClicked: {
                    if(!checked) {
                        _main.password = ""
                    }
                }
            }
            RowComboBox {
                width: parent.width
                text: qsTr("Язык")
                model: ["Русский", "English", "Deutsch"]
                onActivated: {

                }
            }

            Button {
                text: qsTr("Удалить все настройки")
                onClicked: {

                }
            }
        }

    }
}
