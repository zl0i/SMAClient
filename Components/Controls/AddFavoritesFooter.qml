import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Item {
    width: 168; height: 150

    signal add()

    Rectangle  {
        x:18
        width: parent.width-x; height: parent.height
        color: "#FFFFFF"
        radius: 10
        layer.enabled: true
        layer.effect: DropShadow {
            radius: 8
            samples: 16
            color: "#80000000"
        }
        Label {
            width: parent.width; height: parent.height
            verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
            text: qsTr("Добавить")
        }
        MouseArea {
            width: parent.width; height: parent.height
            onReleased: {
                add()
            }
        }
    }
}
