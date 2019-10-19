import QtQuick 2.12
import QtQuick.Controls 2.5

import Components.Controls 1.0

import "Controls"

Rectangle {
    id: _root
    color: "#1D1D1D"

    signal profileClicked()
    signal selectMainPage()
    signal selectMapPage()
    signal selectWeatherPage()
    signal selectSettingsPage()

    property var selectButton: _mainButton

    Image {
        x: 5; y: 20
        width: 80; height: 80
        source: "qrc:/image/other/profile.png"
        MouseArea {
            width: parent.width; height: parent.height
            onClicked:  {
                _root.profileClicked()
            }
        }
    }


    Column {
        id: _column
        y: 107
        width: parent.width
        spacing: 10
        CustomTabButton {
            id: _mainButton
            width: parent.width; height: 60
             checked: selectButton === this
            backgroundColor: _root.color
            checkedColor: "#C4C4C4"
            lineColor: "#6AABF7"
            text: qsTr("Главная")           
            onClicked: {
                if(selectButton !== _mainButton) selectButton = _mainButton
                _root.selectMainPage()
            }
        }
        CustomTabButton {
            id: _mapButton
            width: parent.width; height: 60
             checked: selectButton === this
            backgroundColor: _root.color
            checkedColor: "#C4C4C4"
            lineColor: "#6AABF7"
            text: qsTr("Карта")
            onClicked: {
                if(selectButton !== _mapButton) selectButton = _mapButton
                _root.selectMapPage()
            }
        }
        CustomTabButton {
            id: _weatherBuuton
            width: parent.width; height: 60
            checked: selectButton === this
            backgroundColor: _root.color
            checkedColor: "#C4C4C4"
            lineColor: "#6AABF7"
            text: qsTr("Погода")
            onClicked: {
                if(selectButton !== _weatherBuuton) selectButton = _weatherBuuton
                _root.selectWeatherPage()
            }

        }
        CustomTabButton {
            id: _settingsButton
            width: parent.width; height: 60
            backgroundColor: _root.color
            checkedColor: "#C4C4C4"
            lineColor: "#6AABF7"
            text: qsTr("Настройки")
            checked: selectButton === this
            onClicked: {
                 if(selectButton !== _settingsButton) selectButton = _settingsButton
                _root.selectSettingsPage()
            }

        }
    }



}
