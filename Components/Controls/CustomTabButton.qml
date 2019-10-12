import QtQuick 2.12
import QtQuick.Controls 2.5


TabButton {
    id: _tabButton
    property color backgroundColor
    property color checkedColor
    property color lineColor

    property var image

    indicator: Rectangle {
        width: parent.width; height: parent.height
        color: _tabButton.checked ? checkedColor : backgroundColor

        Rectangle {
            width: 3; height: parent.height
            visible: _tabButton.checked
            color: lineColor
        }
    }

    contentItem: Label {
        width: parent.width; height: parent.height
        verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
        color: "#FFFFFF" //_tabButton.checked ? "#000000" : "#404040"
        font.pixelSize: 12
        wrapMode: Text.WordWrap
        elide: Text.ElideRight
        text: _tabButton.text
    }

}
