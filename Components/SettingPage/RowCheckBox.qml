import QtQuick 2.12
import QtQuick.Controls 2.5

import MyStyle 1.0
import Components.Controls 1.0

Item {
    id: _root
    height: 35
    property string text

    property alias checked: _checkBox.checked
    signal clicked();

    Label {
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 18
        color: MyStyle.textColor
        text: _root.text
    }
    CustomCheckBox {
        id: _checkBox
        x: parent.width-width
        onClicked: {
           _root.clicked()
        }
    }
}
