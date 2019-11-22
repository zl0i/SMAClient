import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import Components.Controls 1.0
import Components.Delegats 1.0
import MyStyle 1.0

Dialog {
    id: _dialog

    parent: Overlay.overlay
    x: parent.width/2-width/2; y: parent.height/2 - height/2
    width: 450; height: 620
    modal: true; dim: true
    closePolicy: Popup.NoAutoClose

    Overlay.modal: Rectangle {
        color: "#AA000000"
    }

    background: Rectangle {
        width: parent.width; height: parent.height; radius: 20
        color: MyStyle.foregroundColor
        CircleImageButton {
            x: parent.width-width-20; y: 20
            width:20; height: 20
            iconWidth: 20; iconHeight: 20
            style: "transparent"
            source: "qrc:/image/other/exit-black.svg"
            isOverlayColor: true
            pressedIconColor: "#487690"
            releasedIconColor: MyStyle.textColor
            onClicked: {
                _dialog.close()
            }
        }
    }

    contentItem: Item {
        width: parent.width; height: parent.height
        Label {
            x:20; y:10
            font.pixelSize: 24
            color: MyStyle.textColor
            text: qsTr("Добавить виджет")
        }
        SwipeView {
            id: _swipeView
            x:15; y: 57
            width: 420; height: 445
            ListView {
                anchors.fill: parent
                spacing: 10

                model: ["../Delegats/WeatherDelegat.qml", "../Delegats/SmallWeatherDelegat.qml"]
                delegate: Loader {
                    source: modelData
                    asynchronous: true
                }
            }
        }
        PageIndicator {
            x:parent.width/2-width; y: 513
            count: _swipeView.count
            currentIndex: _swipeView.currentIndex
        }

        RoundButton {
            x: 20; y: parent.height-height-20
            text: qsTr("Добавить")
        }
        RoundButton {
            x: parent.width-width-20; y: parent.height-height-20
            style: "transparent"
            text: qsTr("Отмена")
            onClicked: {
                _dialog.close()
            }
        }
    }
}
