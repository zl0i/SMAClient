import QtQuick 2.12
import QtQuick.Controls 2.5

import Components.Controls 1.0
import MyStyle 1.0

Dialog {
    id: _dialog

    parent: Overlay.overlay
    x: parent.width/2 - width/2; y: parent.height/2 - height/2
    width: 400; height: 350
    modal: true; dim: true
    padding: 0
    closePolicy: Popup.NoAutoClose

    property alias nameField: _nameField.text
    property var pathField: []

    signal editField()
    signal newFiled()
    signal earlierClosed()

    Overlay.modal: Rectangle {
        color: "#AA000000"
    }

    function reset() {
        nameField = ""
        pathField = []
    }

    background: Rectangle {
        width: parent.width; height: parent.height; radius: 20
        color: MyStyle.foregroundColor
        CircleImageButton {
            x: parent.width-width-20; y: 20
            width:20; height: 20
            iconWidth: 20; iconHeight: 20
            style: "transparent"
            source: "qrc:/image/other/exit-black.svg"
            isOverlayColor: true
            pressedIconColor: "#487690"
            releasedIconColor: MyStyle.textColor
            onClicked: _dialog.earlierClosed()
        }
    }
    contentItem: Item {
        width: parent.width; height: parent.height
        Label {
            x: 20; y: 20
            font.pixelSize: 24
            color: MyStyle.textColor
            text: qsTr("Добавить поле")
        }
        Row {
            x:20; y: 75
            Label {
                width: 100; height: 35
                verticalAlignment: Text.AlignVCenter
                color: MyStyle.textColor
                text: qsTr("Имя поля")
            }
            InputText {
                id: _nameField
                width: 250
            }
        }
        Label {
            x: 20; y: 127
            width: 100; height: 45
            verticalAlignment: Text.AlignVCenter
            color: MyStyle.textColor
            text: qsTr("Расположение")
        }
        RoundButton {
            x:parent.width-width-20; y: 127
            width: 120; height: 45
            size: "custom"
            text: qsTr("Указать\nна карте")
            onClicked: {
                _dialog.editField()
            }
        }
        InputTextArea {
            id: _coordArea
            x: 20; y: 180
            width: 350; height: 90
            wrapMode: Text.WrapAnywhere
            text: JSON.stringify(pathField).toString()
        }

        RoundButton {
            x: 20; y: parent.height-height-20
            text: qsTr("Добавить")
            onClicked: _dialog.newFiled()
        }
        RoundButton {
            x: parent.width-width-20; y: parent.height-height-20
            style: "transparent"
            text: qsTr("Отмена")
            onClicked: _dialog.earlierClosed()
        }
    }

}
