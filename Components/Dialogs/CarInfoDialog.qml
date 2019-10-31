import QtQuick 2.12
import QtQuick.Controls 2.5

import Components.Controls 1.0
import MyStyle 1.0

Dialog {
    id: _dialog

    parent: Overlay.overlay
    x: parent.width/2 - width/2; y: parent.height/2 - height/2
    width: 500; height: 280
    modal: true; dim: true
    padding: 0
    closePolicy: Popup.NoAutoClose

    property var model


    Overlay.modal: Rectangle {
        color: "#AA000000"
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
            onClicked: {
                _dialog.close()
            }
        }
    }

    contentItem: Item {
        width: parent.width; height: parent.height
        Label {
            x: 20; y: 20
            color: MyStyle.textColor
            text: qsTr(title)
        }
    }

}
