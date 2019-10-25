import QtQuick 2.12
import QtQuick.Controls 2.5

import MyStyle 1.0

TextField {
    id: _field
    width: 200; height: 35
    selectByMouse: true
    selectedTextColor: MyStyle.textColor
    selectionColor: "#80487690"

    property color focusColor: "#487690"
    property color noFocusColor: "#828282"
    property color errorColor: "#D91818"

    property bool error: false

    states: [
        State {
            name: "focus"; when: _field.focus
        },
        State {
            name: "noFocus"; when: !_field.focus
        },
        State {
            name: "error"; when: _field.error
        }
    ]
    state: "noFocus"

    onTextEdited: {
        error = false
    }
    color: MyStyle.textColor

    background: Rectangle {
        width: parent.width; height: parent.height
        color: MyStyle.foregroundColor
        border.width: 2; border.color: {
            if(error) return errorColor
            if(_field.state === "focus") return focusColor
            if(_field.state === "nofocus") return noFocusColor            
            return noFocusColor
        }
    }
}


