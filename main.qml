import QtQuick 2.13
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import QtQml.Models 2.12

import Components 1.0
import Components.Dialogs 1.0



ApplicationWindow {
    id: _window
    visible: true
    width: 920;  height: 700
    title: qsTr("SMA Client")   

    font {
        pixelSize: 14
    }

    Component.onCompleted: {
        _connectDialog.open()
    }

    ConnectDialog {
        id: _connectDialog
        blurItem: _window.contentItem
        onAuthentication: {
            close()
        }
        onQuit: {
            Qt.quit()
        }
    }

    TabMenu {
        id: _tabMenu
        width: 75; height: parent.height
        onSelectStartPage: {
            _list.positionViewAtIndex(0, ListView.SnapPosition)
        }
        onSelectMapPage: {
            _list.positionViewAtIndex(1, ListView.SnapPosition)
        }
        onSelectSettingsPage: {
            _list.positionViewAtIndex(2, ListView.SnapPosition)
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
