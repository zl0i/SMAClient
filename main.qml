import QtQuick 2.13
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import QtQml.Models 2.12

import Components 1.0
import Components.Dialogs 1.0

import MyStyle 1.0



ApplicationWindow {
    id: _window
    visible: true
    width: 1112;  height: 834
    title: qsTr("SMA Client")

    font {
        family: "Roboto"
        pixelSize: 14
    }

    Component.onCompleted: {
        MyStyle.theme = MyStyle.Theme.Black
    }


    Connections {
        target: _server
        onWinConnected: {
            _connectDialog.close()
        }
        onErrorConnected: {
            console.log(code)
            _connectDialog.setErrorCode(code)
        }
    }


    ConnectDialog {
        id: _connectDialog
        visible: true
        blurItem: _window.contentItem
        onAuthentication: {
            _server.connectToServer(url, port, login, password, true)
        }
        onQuit: {
            Qt.quit()
        }
    }
    ProfilePopup {
        id: _profilePopup
        x: 100; y:29
        companyName: _server.companyName
        fullName: _server.fullName
        onExit: {
            _connectDialog.open()
        }
    }

    TabMenu {
        id: _tabMenu
        z: 5
        width: 90; height: parent.height
        onProfileClicked: {
            _profilePopup.open()
        }
        onSelectMainPage: {
            _list.positionViewAtIndex(0, ListView.SnapPosition)
        }
        onSelectMapPage: {
            _list.positionViewAtIndex(1, ListView.SnapPosition)
        }
        onSelectWeatherPage: {
            _list.positionViewAtIndex(2, ListView.SnapPosition)
        }
        onSelectSettingsPage: {
            _list.positionViewAtIndex(3, ListView.SnapPosition)
        }
    }


    ListView {
        id: _list
        x: _tabMenu.width; y: 0
        width: parent.width-x; height: parent.height
        model: _pageModel
        interactive: false

    }


    ObjectModel {
        id: _pageModel
        MainPage {
            width: _list.width; height: _list.height
        }
        MapPage {
            width: _list.width; height: _list.height
        }
        WeatherPage {
            width: _list.width; height: _list.height
        }
        SettingsPage {
            width: _list.width; height: _list.height
        }
    }

}
