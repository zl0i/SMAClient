pragma Singleton
import QtQuick 2.0

QtObject {

    property var theme: _main.style

    enum Theme {
        White,
        Black
    }

    property color backgroundColor: {
        switch(theme) {
        case MyStyle.Theme.White:
            return "#FFFFFF"
        case MyStyle.Theme.Black:
            return "#101010"
        }
    }

    property color foregroundColor: {
        switch(theme) {
        case MyStyle.Theme.White:
            return "#FFFFFF"
        case MyStyle.Theme.Black:
            return "#202020"
        }
    }

    property color textColor: {
        switch(theme) {
        case MyStyle.Theme.White:
            return "#000000"
        case MyStyle.Theme.Black:
            return "#FFFFFF"
        }
    }

}
