import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Rectangle {
    width: 150; height: 150
    color: "#FFFFFF"
    radius: 10
    layer.enabled: true
    layer.effect: DropShadow {
        radius: 8
        samples: 16
        color: "#80000000"
    }

    property string name
    property string benzin
    property string speed


    Label {
        x: 10; y: 10
        text: name
    }
    Column {
        x: 10; y: 50
        spacing: 10
        Label {
            text: "benzin: " + benzin + " л"
        }
        Label {
            text: "speed: " + speed + " км/ч"
        }

    }
}