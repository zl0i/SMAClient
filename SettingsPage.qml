import QtQuick 2.12
import QtQuick.Controls 2.12

Item {

    ListView {
        id: _listSettings
        width: 150; height: parent.height
        clip: true
        currentIndex: 0
        model: modelSettings
        delegate: Rectangle {
            id: _delegate
            width: parent.width; height: 75
            color: _listSettings.currentIndex === index ? "#87CEFA" : "#FFFFFF"
            Label {
                x: parent.width/2-width/2; y: parent.height/2 - height/2
                text: modelData.title
            }
            MouseArea {
                anchors.fill: parent
                onClicked: _listSettings.currentIndex = index
            }
        }

    }
    Loader {
        x: _listSettings.width
        width: parent.width-x; height: parent.height
        //source: _listSettings.currentItem.modelData.component
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
            "title": "Профиль",
            "info": "Настройки профиля",
            "component": ""
        },
        {
            "title": "Интрефейс",
            "info": "Настройки интерфейса",
            "component": ""
        },
        {
            "title": "Шрифт",
            "info": "Настройки шрифта",
            "component": ""
        },
        {
            "title": "Система",
            "info": "Настройки системы",
            "component": ""
        },


    ]



}
