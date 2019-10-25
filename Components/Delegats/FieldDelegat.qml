import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
    id: _delegat
    width: 233; height: 55

    property string nameField: ""
    property int countSensors
    property int temperature
    property int pressure
    property int humidity
    property var location
    property bool isFavorite: false
    property bool isLast: false

    signal clicked(var name, var coord)

    Label {
        id: _nameLable
        x:11; y:7
        width: 100; height: 16
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        color: "#FFFFFF"
        font.pixelSize: 18
        font.weight: Font.Bold
        text: nameField        
    }
    Label {
        x: _nameLable.x + _nameLable.contentWidth+5; y:7
        height: 16
        verticalAlignment: Text.AlignVCenter
        color: "#FFFFFF"
        text: qsTr("(%1 датчик)").arg(countSensors)
    }
    Row {
        x:11; y: parent.height-height-11
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

    Image {
        x:parent.width-width-11; y: 13
        width: 30; height: 30
        fillMode: Image.PreserveAspectFit
        visible: _delegat.isFavorite
        source: "qrc:/image/other/favorite-blue.png"
    }
    Rectangle {
        x: 19; y: parent.height-height
        width: 189; height: 1
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
            console.log(JSON.stringify(location))
            _delegat.clicked(_delegat.nameField, location[0])
        }
    }

}
