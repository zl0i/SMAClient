import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import Components.Controls 1.0

Popup {
    id: _popup
    parent: Overlay.overlay
    width: 317; height: 166
    padding: 0

    property string fullName: ""
    property string companyName: ""

    signal exit()



    background: Rectangle {
        width: parent.width; height: parent.height
        radius: 20

        Rectangle {
            x: -5; y: 21
            width: 13; height: 13
            rotation: 45
            color: "#FFFFFF"
        }
        layer.enabled: true
        layer.effect: DropShadow {
            radius: 8
            samples: 16
            color: "#80000000"
        }
    }
    contentItem: Item {
        Label {
            x:13; y:5
            font.pixelSize: 18
            text: _popup.companyName
        }
        Label {
            x:13; y:38
            font.pixelSize: 18
            text: _popup.fullName
        }

        RoundButton {
            x: parent.width-width-16; y: parent.height-height-16
            width: 115; height: 40
            size: "custom"
            style: "dark blue"
            text: qsTr("Выйти")
            onClicked:  {
                _popup.close()
                _popup.exit()
            }
        }




    }

}
