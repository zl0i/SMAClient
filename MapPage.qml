import QtQuick 2.12
import QtQuick.Controls 2.5
import QtLocation 5.13
import QtPositioning 5.6
import QtQml.Models 2.12

import Components.MapItem 1.0
import Components.Controls 1.0
import Components.Dialogs 1.0

import MyStyle 1.0

Item {
    id: _root
    property alias map: _mapLoader.item



    Loader {
        id: _mapLoader
        anchors.fill: parent
        source: "qrc:/Components/MapItem/MyMap.qml"
        asynchronous: true
    }

    NavigationMap {
        id: _navigationMap
        onSelectFields: {
            _fields.updateFields();
        }
        onSelectSensors: {
            _sensors.updateSensors();
        }
        onSelectCar: {
            _cars.updateCars()
        }

        onMoveMap: {
            map.moveCenter(coordinate)
        }

    }

    CircleImageButton {
        x: parent.width - width-20; y: 20
        width: 40; height: 40        
        style: "custom"
        releasedColor: MyStyle.foregroundColor
        pressedColor: "#487690"
        isOverlayColor: true
        releasedIconColor: MyStyle.textColor
        pressedIconColor: MyStyle.textColor
        source: "qrc:/image/other/more-black.svg"
        onClicked:  {
            _filterPopup.open()
        }

        FilterMapPopup {
            id: _filterPopup
            x: parent.width-width
            onVisibleFiledsChanged: {
                map.visibleFields = visibleFileds
            }
            onVisibleBorderFieldsChanged: {
                map.visibleBorderFields = visibleBorderFields
            }
            onVisibleSensorsChanged: {
                map.visibleSensors = visibleSensors
            }
            onVisibleCarsChanged: {
                map.visibleCars = visibleCars
            }
        }
    }

    CircleImageButton {
        x: parent.width - width-20; y: 80
        width: 40; height: 40
        iconWidth: 22.5; iconHeight: 20
        style: "custom"
        releasedColor: MyStyle.foregroundColor
        pressedColor: "#487690"
        isOverlayColor: true
        releasedIconColor: MyStyle.textColor
        pressedIconColor: MyStyle.textColor
        source: "qrc:/image/other/menu-black.svg"
        onClicked:  {
            _selectTileMapPopup.open()
        }

        SelectTileMapPopup {
            id: _selectTileMapPopup
            x: parent.width-width

        }

    }

    CircleImageButton {
        id: _addFieldButton
        x: parent.width - width-20; y: 140
        width: 40; height: 40
        visible: !map.isEditMode
        iconWidth: 20; iconHeight: 20
        style: "custom"
        releasedColor: MyStyle.foregroundColor
        pressedColor: "#487690"
        isOverlayColor: true
        releasedIconColor: MyStyle.textColor
        pressedIconColor: MyStyle.textColor
        source: "qrc:/image/other/plus-black.svg"
        onClicked: {
            _addFieldDialog.reset()
            _addFieldDialog.open()
        }
    }

    AddFieldDialog {
        id: _addFieldDialog
        onEditField: {
            map.inputEditMode()
            close()
            map.endEditMode.connect(function (path) {
                pathField = path
                open()
                map.exitEditMode()
            })
        }
        onNewFiled: {
            _fields.addField(nameField, pathField)
            close()
        }
        onEarlierClosed: {
            map.exitEditMode()
            close()
        }

    }



}
