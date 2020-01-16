import QtQuick 2.12
import QtQuick.Controls 2.5

import MyStyle 1.0
import Components.Controls 1.0

Rectangle {
    id: _bar
    width: 280; height: 26; radius: 15
    color: MyStyle.backgroundColor
    border { width: 1; color: MyStyle.textColor }

    property alias text: _text.text

    signal search(var text)
    signal clear()

    CircleImageButton {
        x: 3; y:3
        width: 20; height: 20
        iconWidth: 11; iconHeight: 11
        style: "dark blue"
        source: "qrc:/image/other/lens-white.svg"
        onClicked: _bar.search(_text.text)
    }

    CircleImageButton {
        x: parent.width-23; y:3
        width: 20; height: 20
        iconWidth: 14; iconHeight: 14
        style: "dark"
        source: "qrc:/image/other/exit-white.svg"
        onClicked: {
            _text.text = ""
            _bar.clear()
        }
    }


    TextInput {
        id: _text
        x: 30
        width: parent.width-60; height: parent.height
        verticalAlignment: Text.AlignVCenter
        color: MyStyle.textColor
        selectByMouse: true
        selectionColor: "#487690"
        font.pixelSize: 16
        clip: true
        onAccepted: _bar.search();
    }


}
