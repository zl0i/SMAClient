import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Dialog {
    id: _dialog
    parent: Overlay.overlay
    x: parent.width/2-width/2; y:parent.height/2-height/2
    width: 350; height: 230
    modal: true; dim: true
    padding: 0
    closePolicy: Popup.NoAutoClose

    property var blurItem
    signal authentication(var url, var port, var login, var password)
    signal quit()

    Overlay.modal: Rectangle {
        color: "#aa000000"
        FastBlur {
            z: -1
            anchors.fill: parent
            source: blurItem
            radius: 32
        }
    }

    background: Rectangle {
        width: parent.width; height: parent.height
        radius: 10
        color: "#FFFFFF"
    }

    contentItem: Item {
        anchors.fill: parent
        Column {
            anchors.top: parent.top; anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            Row {
                Label {
                    width: 100; height: 40
                    verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignLeft
                    text: qsTr("Адрес")
                }
                TextField {
                    id: _urlFielf
                    width: 150; height: 40
                    placeholderText: "url"
                }
                Label {
                    height: 40
                    verticalAlignment: Text.AlignVCenter
                    text: ":"
                }
                TextField {
                    id: _portField
                    width: 45; height: 40
                    placeholderText: "port"
                }
            }
            Row {
                Label {
                    width: 100; height: 40
                    verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignLeft
                    text: qsTr("Логин")
                }
                TextField {
                    id: _loginField
                    width: 200; height: 40
                }
            }
            Row {
                Label {
                    width: 100; height: 40
                    verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignLeft
                    text: qsTr("Пароль")
                }
                TextField {
                    id: _passwordField
                    width: 200; height: 40
                }
            }
        }
        Row {
            anchors.bottom: parent.bottom; anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20
            Button {
                text: qsTr("Войти")
                onClicked: {
                    _dialog.authentication(_urlFielf.text,
                                           _portField.text,
                                           _loginField.text,
                                           _passwordField.text)
                }
            }
            Button {
                text: qsTr("Выйти")
                onClicked: {
                    _dialog.quit()
                }
            }
        }
    }

}
