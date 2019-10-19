import QtQuick 2.12
import QtQuick.Controls 2.5


MouseArea {
    id: _tabButton
    hoverEnabled: true


    property bool hovered: false
    property string text: ""
    property bool checked: false

    property color backgroundColor
    property color checkedColor
    property color lineColor

    onEntered: hovered = true
    onExited:  hovered = false

    Label {
        width: parent.width; height: parent.height
        verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
        color: "#FFFFFF"
        font.pixelSize: 14
        wrapMode: Text.WordWrap
        elide: Text.ElideRight
        text: _tabButton.text
    }

    Rectangle {
        width: parent.width; height: parent.height
        color: checkedColor
        opacity: 0.3
        visible: _tabButton.hovered || _tabButton.checked

        Rectangle {
            width: 4; height: parent.height
            visible: _tabButton.checked
            color: lineColor
        }
    }
}
