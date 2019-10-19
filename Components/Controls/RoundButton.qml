import QtQuick 2.9
import QtQuick.Controls 2.4

Rectangle {
    id: _rect

    property color releasedColor
    property color pressedColor
    property color disableColor

    property color releasedTextColor
    property color pressedTextColor
    property color disableTextColor

    property alias text: _txt.text
    property alias iconSource: _img.source
    property int maximumWidth: _txt.width + 100
    property alias style: _styleGroup.state
    property alias size: _rect.state

    property alias textEl: _txt
    property alias down: _mouseArea.pressed

    property bool extraMenu: false

    signal clicked(var mouse)
    signal extraMenuClicked(var mouse)

    StateGroup {
        id: _styleGroup
        states: [
            State {
                name: "dark"
                PropertyChanges {
                    target: _rect
                    releasedColor: "#404040"
                    releasedTextColor:  "#FFFFFF"
                    pressedColor: "#A4DDEF"
                    pressedTextColor: "#317287"
                    disableColor: "#9F9F9F"
                    disableTextColor: "#FFFFFF"
                }
            },
            State {
                name: "blue"
                PropertyChanges {
                    target: _rect
                    releasedColor: "#05AEF1"
                    releasedTextColor:  "#FFFFFF"
                    pressedColor: "#A4DDEF"
                    pressedTextColor: "#317287"
                    disableColor: "#9F9F9F"
                    disableTextColor: "#FFFFFF"
                }
            },
            State {
                name: "white"
                PropertyChanges {
                    target: _rect
                    releasedColor: "#FFFFFF"
                    releasedTextColor:  "#000000"
                    pressedColor: "#A4DDEF"
                    pressedTextColor: "#317287"
                    disableColor: "#9F9F9F"
                    disableTextColor: "#FFFFFF"
                }
            },
            State {
                name: "black"
                PropertyChanges {
                    target: _rect
                    releasedColor: "#292929"
                    releasedTextColor:  "#FFFFFF"
                    pressedColor: "#A4DDEF"
                    pressedTextColor: "#317287"
                    disableColor: "#9F9F9F"
                    disableTextColor: "#FFFFFF"
                }
            },
            State {
                name: "green"
                PropertyChanges {
                    target: _rect
                    releasedColor: "#6CB86C"
                    releasedTextColor:  "#FFFFFF"

                    pressedColor: "#A4DDEF"
                    pressedTextColor: "#317287"

                    disableColor: "#9F9F9F"
                    disableTextColor: "#FFFFFF"
                }
            },
            State {
                name: "red"
                PropertyChanges {
                    target: _rect
                    releasedColor: "#FFFFFF"
                    releasedTextColor:  "#EB5757"

                    pressedColor: "#EB5757"
                    pressedTextColor: "#FFFFFF"

                    disableColor: "#9F9F9F"
                    disableTextColor: "#FFFFFF"
                }
            },
            State {
                name: "dark blue"
                PropertyChanges {
                    target: _rect

                    releasedColor: "#487690"
                    releasedTextColor:  "#FFFFFF"

                    pressedColor: "#2A4452"
                    pressedTextColor: "#FFFFFF"

                    disableColor: "#76838B"
                    disableTextColor: "#353434"
                }
            },
            State {
                name: "transparent"
                PropertyChanges {
                    target: _rect
                    releasedColor: "transparent"
                    releasedTextColor:  "#000000"

                    pressedColor: "transparent"
                    pressedTextColor: "#317287"

                    disableColor: "#9F9F9F"
                    disableTextColor: "#FFFFFF"
                }
            },
            State {
                name: "custom"
                PropertyChanges {
                    target: _rect

                }
            }

        ]
        state: "dark blue"
    }

    Behavior on color {
        ColorAnimation {
            duration: 250
            easing.type: Easing.OutQuad
        }
    }

    width: (_txt.width + 100) > maximumWidth ? maximumWidth : (_txt.width + 100)
    radius: height/2
    color: _rect.enabled ? (_mouseArea.pressed ? pressedColor: releasedColor) : disableColor
    states: [
        State {
            name: "small"
            PropertyChanges {
                target: _rect
                height: 30
            }
        },
        State {
            name: "middle"
            PropertyChanges {
                target: _rect
                height: 40
            }
        },
        State {
            name: "big"
            PropertyChanges {
                target: _rect
                height: 60
            }
        },
        State {
            name: "custom"
            PropertyChanges {
                target: _rect
            }
        }

    ]
    state: "middle"

    Row {
        id: _row
        anchors.centerIn: parent
        spacing: 10
        Image {
            id: _img
            visible: status ===  Image.Null ? false : true
            width: 16;  height: 16
            fillMode: Image.PreserveAspectFit
        }
        Label {
            id: _txt
            height: _rect.height
            font.pixelSize: 16
            horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
            elide: Label.ElideRight
            color: _rect.enabled ? (_mouseArea.pressed ? pressedTextColor: releasedTextColor) : disableTextColor
        }
    }
    MouseArea {
        id: _mouseArea
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            parent.clicked(mouse)
        }
    }
    Item {
        x: parent.width-width; y:0
        width: parent.width/4; height: parent.height
        visible: _rect.extraMenu
        Rectangle {
            width: 1; height: parent.height
            color: "#529152"
        }
        Label {
            width: parent.width-_rect.radius/2; height: 2*parent.height/3
            verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 42
            font.weight: Font.ExtraBold
            color: "#FFFFFF"
            text: "..."
        }
        MouseArea {
            width: parent.width; height: parent.height
            onClicked: {
                _rect.extraMenuClicked(mouse)
            }
        }
    }
}
