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
    padding: 20
    closePolicy: Popup.NoAutoClose

    property var model


    Overlay.modal: Rectangle {
        color: "#AA000000"
    }

    background: Rectangle {
        width: 500; height: 280; radius: 20
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
            font { weight: Font.Bold; pixelSize: 24 }
            color: MyStyle.textColor
            text: model.name
        }
        ListView {
           x:0; y: 40
           width: 130; height: parent.height-50
           model: _dialog.model.info
           clip: true
           delegate: Label {
               width: 130; height: 40
               color: MyStyle.textColor
               text: modelData.dataName + ": " + modelData.data + modelData.type
           }
           section.property: "type"
           section.criteria: ViewSection.FullString
           section.delegate: Rectangle {
               width: 130; height: 40
               color: "red"
               Label {
                   text: "asdas"
               }
           }

        }
    }

}
