import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
    id: _delegat
    width: 250; height: 86

    property int sensor_id
    property string nameSensor: ""
    property string belongsNameFiled: ""
    property real temperature: 0
    property real pressure: 0
    property real humidity: 0
    property var windSpeed: 0
    property var windDirection: ""
    property var ground: ({})
    property bool isFavorite: false
    property bool isLast: false

    property var latitude
    property var longitude

    signal clicked(var id, var coord)

    function getDirectionByDeg(deg) {
        if(deg >= 336  || deg < 22) return qsTr("с")
        if(deg >= 22 && deg < 67) return qsTr("с-в")
        if(deg >= 67 && deg < 112) return qsTr("в")
        if(deg >= 112 && deg < 157) return qsTr("ю-в")
        if(deg >= 157 && deg < 202) return qsTr("ю")
        if(deg >= 202 && deg < 247) return qsTr("ю-з")
        if(deg >= 247 && deg < 292) return qsTr("з")
        if(deg >= 292 && deg < 336) return qsTr("с-з")
        return " "
    }

    Label {
        id: _nameLable
        x:11; y:7
        width: 100; height: 16
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        color: "#FFFFFF"
        font.pixelSize: 18
        font.weight: Font.Bold
        text: nameSensor
    }
    Row {
        x:11; y: parent.height-height-45
        height: 11
        spacing: 10
        Label {
            color: "#FFFFFF"
            text: qsTr("T: %1 C").arg(_delegat.temperature)
        }
        Label {
            color: "#FFFFFF"
            text: qsTr("H: %1 %").arg(_delegat.humidity)
        }
        Label {
            color: "#FFFFFF"
            text: qsTr("P: %1 мм").arg(_delegat.pressure)
        }
    }
    Row {
        x:11; y: parent.height-height-28
        height: 11
        spacing: 7
        Label {
            color: "#FFFFFF"
            text: qsTr("g1: %1%").arg(_delegat.ground["1"])
        }
        Label {
            color: "#FFFFFF"
            text: qsTr("g2: %1%").arg(_delegat.ground["2"])
        }
        Label {
            color: "#FFFFFF"
            text: qsTr("g3: %1%").arg(_delegat.ground["3"])
        }
        Label {
            color: "#FFFFFF"
            text: qsTr("g4: %1%").arg(_delegat.ground["4"])
        }
    }
    Label {
        x:11; y: parent.height-height-10
        height: 11
        color: "#FFFFFF"
        text: qsTr("Ветер %1, %2 м/с").arg(_delegat.getDirectionByDeg(_delegat.windDirection)).arg(_delegat.windSpeed)
    }


    Image {
        x:parent.width-width-11;y: 13
        width: 30; height: 30
        fillMode: Image.PreserveAspectFit
        visible: _delegat.isFavorite
        source: "qrc:/image/other/favorite-blue.png"
    }
    Rectangle {
        x: 20; y: parent.height-height
        width: 200; height: 1
        visible: !_delegat.isLast
        color: "#C4C4C4"
    }
    Rectangle {
        width: parent.width; height: parent.height
        visible: _mouseArea.hovered
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
            _delegat.clicked(_delegat.sensor_id, {
                                 "latitude": _delegat.latitude,
                                 "longitude": _delegat.longitude
                             })
        }
    }

}
