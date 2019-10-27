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
        contentHeight: children.height
        Column {
            width: parent.width
            spacing: 15
            RowLayout {
                width: parent.width
                Label {
                    Layout.alignment: Qt.AlignLeft
                    height: 35
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 18
                    color: MyStyle.textColor
                    text: qsTr("Темная тема")
                }
                CheckBox {
                     Layout.alignment: Qt.AlignRight
                    checked: MyStyle.theme === MyStyle.Theme.Black
                    onCheckedChanged: {
                        if(checked) {
                            MyStyle.theme =  MyStyle.Theme.Black
                        }
                        else {
                            MyStyle.theme =  MyStyle.Theme.White
                        }
                    }
                }
            }
        }
    }

}
