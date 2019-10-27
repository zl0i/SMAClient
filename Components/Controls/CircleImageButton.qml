import QtQuick 2.9
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0

Rectangle {
    id: _root
    width: 58
    height: 58
    radius: 58
    color: _mousearea.pressed ? pressedColor : releasedColor

    property bool isOverlayColor: false
    property color pressedIconColor
    property color releasedIconColor

    property color pressedColor
    property color releasedColor

    property alias source: _img.source
    property alias iconWidth: _img.width
    property alias iconHeight: _img.height

    property alias style: _root.state
    property alias ispressed: _mousearea.pressed

    signal clicked(var mouse)
    signal pressed(var mouse)
    signal released(var mouse)

    Behavior on color {
        ColorAnimation { duration: 150 }
    }


    states: [
        State {
            name: "black"
            PropertyChanges {
                target: _root
                releasedColor: "#1D1D1D"
                pressedColor: "#05AEF1"
            }
        },
        State {
            name: "white"
            PropertyChanges {
                target: _root
                releasedColor: "#FFFFFF"
                pressedColor: "#487690"
            }
        },
        State {
            name: "blue"
            PropertyChanges {
                target: _root
                releasedColor: "#13BBF2"
            }
        },
        State {
            name: "dark blue"
            PropertyChanges {
                target: _root
                pressedColor: "#2A4452"
                releasedColor: "#487690"
            }
        },
        State {
            name: "dark"
            PropertyChanges {
                target: _root
                releasedColor: "#292929"
                pressedColor: "#C4C4C4"
            }
        },
        State {
            name: "grey"
            PropertyChanges {
                target: _root
                releasedColor: "#C4C4C4"
                pressedColor: "#00BAF3"
            }
        },
        State {
            name: "transparent"
            PropertyChanges {
                target: _root
                releasedColor: "transparent"
                pressedColor: "transparent"
            }
        },
        State {
            name: "custom"
            PropertyChanges {
                target: _root
            }
        }
    ]
    state: "white"

    Image {
        id: _img
        anchors.centerIn: parent
        width: parent.width-20
        height: parent.height-20
        fillMode: Image.PreserveAspectFit
        antialiasing: true
        layer.enabled: isOverlayColor
        layer.effect: ColorOverlay {
            color: _mousearea.pressed ? pressedIconColor : releasedIconColor
        }
    }

    MouseArea {
        id: _mousearea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            parent.clicked(mouse)
        }
        onPressed: {
            _root.pressed(mouse)
        }
        onReleased: {
            _root.released(mouse)

        }
    }

}
