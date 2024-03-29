import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import Components.Controls 1.0
import MyStyle 1.0

Dialog {
    id: _dialog
    parent: Overlay.overlay
    x: parent.width/2-width/2; y:parent.height/2-height/2
    width: 360; height: 280
    modal: true; dim: true
    padding: 0
    closePolicy: Popup.NoAutoClose

    property string url: _main.url
    property var port: 6666//_server.port
    property string login: _main.login
    property string password: _main.password
    property bool member: (_main.login.length !== 0) && (_main.password.length !== 0)

    property var blurItem
    signal authentication(var url, var port, var login, var password)
    signal quit()

    function setErrorCode(code) {
        _loader.sourceComponent = _inputComponent
        switch(code) {
        case 404:
            _errorState.state = "errorServer"
            break;
        case 200:
            _errorState.state = "idle"
            break;
        case 401:
            _errorState.state = "errorLogPass"
            break;
        }
    }

    function validate() {

    }


    StateGroup {
        id: _errorState
        states: [
            State {
                name: "idle"
            },
            State {
                name: "errorServer"
            },
            State {
                name: "errorLogPass"
            }
        ]
        state: "idle"
    }

    Overlay.modal: Rectangle {
        color: "#AA000000"
        FastBlur {
            anchors.fill: parent
            source: blurItem
            radius: 64
        }
    }
    onVisibleChanged: {
        if(visible) {
            _errorState.state = "idle"
            _loader.sourceComponent = _inputComponent
        }
    }

    background: Rectangle {
        width: parent.width; height: parent.height
        radius: 10
        color: MyStyle.foregroundColor
        layer.enabled: true
        layer.effect: DropShadow {
            samples: 8
            radius: 16
            color: "#80000000"
        }
    }
    contentItem: Loader {
        id: _loader
        width: parent.width; height: parent.height
        sourceComponent: _inputComponent
    }
    Component {
        id: _lodingComponent
        Item {
            width: parent.width; height: parent.height
            LoadingAnimation {
                x: parent.width/2 - width/2; y: 57
                width: 100; height: 100
                running: true
                externalColor: MyStyle.textColor
                internalColor: "#487690"
            }
            Label {
                x: 74; y: 164
                width: 230; height: 70
                verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                font.pixelSize: 24
                color: MyStyle.textColor
                text: qsTr("Идет подключение, одну секунду...")
            }
        }
    }

    Component{
        id: _inputComponent
        Item {
            width: parent.width; height: parent.height
            Column {
                x: 20; y:18
                spacing: 19
                Row {
                    Label {
                        width: 75; height: 35
                        verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignLeft
                        color:  MyStyle.textColor
                        text: qsTr("Адрес")
                    }
                    InputText {
                        id: _urlFielf
                        width: 186
                        placeholderText: "url"
                        error: _errorState.state === "errorServer"
                        text: _dialog.url

                    }
                    Label {
                        width: 14; height: 35
                        verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
                        color:  MyStyle.textColor
                        text: ":"
                    }
                    InputText {
                        id: _portField
                        width: 56;
                        placeholderText: "port"
                        text: _dialog.port
                        error: _errorState.state === "errorServer"
                    }
                }
                Row {
                    Label {
                        width: 75; height: 35
                        verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignLeft
                        color:  MyStyle.textColor
                        text: qsTr("Логин")
                    }
                    InputText {
                        id: _loginField
                        width: 256
                        text: _dialog.login
                        error: _errorState.state === "errorLogPass"
                    }
                }
                Row {
                    Label {
                        width: 75; height: 35
                        verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignLeft
                        color:  MyStyle.textColor
                        text: qsTr("Пароль")
                    }
                    InputText {
                        id: _passwordField
                        width: 256
                        text: _dialog.password
                        error: _errorState.state === "errorLogPass"
                        echoMode: TextInput.Password
                    }
                }                
            }
            Item {
                x: 20; y: 178
                width: parent.width - 30; height: 35
                Label {
                    width: 75; height: 35
                    verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignLeft
                    color:  MyStyle.textColor
                    text: qsTr("Запомнить меня")
                }
                CustomCheckBox {
                    anchors.right: parent.right
                    width: 35; height: 35
                    checked: _dialog.member
                    onClicked: {
                        _dialog.member = checked
                    }

                }
            }

            Row {
                anchors.bottom: parent.bottom; anchors.bottomMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20
                RoundButton {
                    text: qsTr("Войти")
                    onClicked: {
                        _loader.sourceComponent = _lodingComponent
                        if(member) {
                            _main.url = _urlFielf.text
                            _main.login = _loginField.text
                            _main.password = _passwordField.text
                        } else {
                            _main.login = ""
                            _main.password = ""
                        }

                        _dialog.authentication(_urlFielf.text,
                                               Number(_portField.text),
                                               _loginField.text,
                                               _passwordField.text)
                    }
                }
                RoundButton {
                    style: "dark"
                    text: qsTr("Выйти")
                    onClicked: {
                        _dialog.quit()
                    }
                }
            }
        }
    }

}
