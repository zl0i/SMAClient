import QtQuick 2.13
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import QtQml.Models 2.12

import Components 1.0
import Components.Dialogs 1.0



ApplicationWindow {
    id: _window
    visible: true
    width: 1112;  height: 834
    title: qsTr("SMA Client")   

    font {
        family: "Roboto"
        pixelSize: 14
    }
    Timer {
        id: _tim
        interval: 500
        running: false
        repeat: false
        onTriggered: {
            _connectDialog.close()
        }
    }

    ConnectDialog {
        id: _connectDialog
        visible: true
        blurItem: _window.contentItem
        onAuthentication: {
            _tim.start()
            //close()
        }
        onQuit: {
            Qt.quit()
        }
    }
    ProfilePopup {
        id: _profilePopup
        x: 100; y:29
        companyName: "ИП Сукачев"
        fullName: "Сукачев Александр Игоревич"
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

    /*Connections {
        target: _models
        onSensorModelChanged: {
            var sensors = Qt.createComponent("SensorMapItem.qml")
            for(var i = 0; i < _models.sensorModel.rowCount(); i++) {
                var index = _models.sensorModel.index(i, 0);
                var item = sensors.createObject(_window.map, {
                                                    "center.latitude": _models.sensorModel.data(index, 258),
                                                    "center.longitude": _models.sensorModel.data(index, 259)
                                                })
                _window.map.addMapItem(item)
                sensorsArray[i] = item
            }

            console.log("sensor")
        }
        onCarsModelChanged: {
            var sensors = Qt.createComponent("CarMapItem.qml")
            for(var i = 0; i < _models.carsModel.rowCount(); i++) {
                var index = _models.carsModel.index(i, 0);
                var item = sensors.createObject(_window.map, {
                                                    "center.latitude": _models.carsModel.data(index, 265),
                                                    "center.longitude": _models.carsModel.data(index, 266)
                                                })
                _window.map.addMapItem(item)
                carsArray[i] = item
            }
            console.log("cars")
        }
    }*/

}
