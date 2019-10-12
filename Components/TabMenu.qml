import QtQuick 2.12
import QtQuick.Controls 2.5

import Components.Controls 1.0

import "Controls"

Rectangle {
    id: _root
    color: "#1A1A1A"

    signal selectStartPage()
    signal selectMapPage()
    signal selectSettingsPage()



    Column {
        id: _column
        y: 50
        width: parent.width
        spacing: 10
        CustomTabButton {
            width: parent.width; height: 50
            backgroundColor: _root.color
            checkedColor: "#404040"
            lineColor: "#87CEFA"
            text: qsTr("Главная")
            checked: true
            onClicked: {
                _root.selectStartPage()
            }
        }
        CustomTabButton {
            width: parent.width; height: 50
            backgroundColor: _root.color
            checkedColor: "#404040"
            lineColor: "#87CEFA"
            text: qsTr("Карта")
            onClicked: {
                _root.selectMapPage()
            }

        }
        CustomTabButton {
            width: parent.width; height: 50
            backgroundColor: _root.color
            checkedColor: "#404040"
            lineColor: "#87CEFA"
            text: qsTr("Настройки")
            onClicked: {
                _root.selectSettingsPage()
            }

        }
    }



}
