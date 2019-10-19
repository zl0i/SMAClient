import QtQuick 2.12
import QtQuick.Controls 2.5


TabButton {
    id: _tabButton

    //property color backgroundColor
    property color checkedColor: "#487690"
    property color noCheckedColor: "#353434"

    contentItem: Label {
        width: parent.width; height: parent.height
        verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
        color: "#FFFFFF"
        font.pixelSize: 14
        wrapMode: Text.WordWrap
        elide: Text.ElideRight
        text: _tabButton.text
    }

    indicator: Rectangle {
        width: parent.width; height: parent.height
        color: _tabButton.checked ? checkedColor :noCheckedColor
    }

}
