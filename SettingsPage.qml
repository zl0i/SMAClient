import QtQuick 2.12
import QtQuick.Controls 2.12

import Components.Controls 1.0
import MyStyle 1.0

Rectangle {
    color: MyStyle.backgroundColor

    Rectangle {

        width: 256; height: parent.height
        color: "#323232"
        Label {
            width: parent.width; height: 94
            leftPadding: 20
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 24
            font.weight: Font.Bold
            color: "#FFFFFF"
            text: qsTr("Настройки")
        }
        Rectangle {
            x: 0; y: 95
            width: parent.width; height: 1
            color: "#6AABF7"
        }
        ListView {
            id:  _listSettings
            x: 0; y: 96
            width: parent.width; height: parent.height-y-90
            clip: true
            model: modelSettings            

            delegate: Item {
                id: _delegat
                width: parent.width; height: 64
                Label {
                    width: parent.width; height: parent.height
                    leftPadding: 20
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 20
                    color: "#FFFFFF"
                    text: modelData.title
                }
                Rectangle {
                    width: parent.width; height: parent.height
                    visible: _delegat.ListView.isCurrentItem || _mouseArea.hovered
                    opacity: _mouseArea.pressed ? 0.3 : 0.5
                    color: "#C4C4C4"
                }
                MouseArea {
                    id: _mouseArea
                    width: parent.width; height: parent.height
                    hoverEnabled: true
                    property bool hovered: false
                    onEntered: hovered = true
                    onExited: hovered = false
                    onClicked: {
                        _delegat.ListView.view.currentIndex = index
                    }
                }
            }
        }
    }
    Loader {
        x: 256; y: 0
        width: parent.width-x; height: parent.height
        source: "qrc:Components/SettingPage/" + modelSettings[_listSettings.currentIndex].component

    }



    readonly property var modelSettings: [
        {
            "title": "Общее",
            "info": "Общие настройки",
            "component": ""
        },
        {
            "title": "Карта",
            "info": "Настройки карта",
            "component": ""
        },
        {
            "title": "Интрефейс",
            "info": "Настройки интерфейса",
            "component": "GeneralPage.qml"
        },        
        {
            "title": "Система",
            "info": "Настройки системы",
            "component": ""
        }
    ]



}
