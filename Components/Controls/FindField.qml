import QtQuick 2.12
import QtQuick.Controls 2.5

TextField {
    id: _field
    width: 236; height: 26
    leftPadding: 30
    rightPadding: 30
    verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignLeft

    property bool emitIfTextChanged: false
    signal find(var text)

    background: Rectangle {
        width: parent.width; height: parent.height
        radius: height/2
        color: "#FFFFFF"
    }
    onTextChanged: {
        if(emitIfTextChanged) _field.find(text)
    }

    CircleImageButton {
        x: 4; y:3
        width: 20; height: 20
        iconWidth: 18; iconHeight: 18
        style: "dark"
        source: "qrc:image/other/exit-white.svg"
        onClicked: {
            _field.clear()
        }

    }
    CircleImageButton {
        x: parent.width-width-4; y:3
        width: 20; height: 20
        iconWidth: 12; iconHeight: 12
        style: "dark blue"
        source: "qrc:image/other/lens-white.svg"
        onClicked: {
            _field.find(_field.text)
        }
    }


}
