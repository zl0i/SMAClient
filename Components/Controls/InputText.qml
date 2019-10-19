import QtQuick 2.12
import QtQuick.Controls 2.5

TextField {
    id: _field
    width: 200; height: 35

    property color focusColor: "#487690"
    property color noFocusColor: "#828282"
    property color errorColor: "#D91818"

    property bool erorr: false

    states: [
        State {
            name: "focus"; when: _field.focus
        },
        State {
            name: "noFocus"; when: _field.focus === false
        },
        State {
            name: "erorr"; when: _field.erorr
        }
    ]
    state: "noFocus"

    background: Rectangle {
        width: parent.width; height: parent.height
        border.width: 2; border.color: {
            if(_field.state === "focus") return focusColor
            if(_field.state === "nofocus") return noFocusColor
            if(_field.state === "erorr") return errorColor
            return noFocusColor
        }
    }
}


