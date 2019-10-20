import QtQuick 2.12
import QtQuick.Controls 2.5
import QtLocation 5.13
import QtPositioning 5.6
import QtQml.Models 2.12

import Components.MapItem 1.0
import Components.Controls 1.0

Item {
    id: _root
    property alias map: _mapLoader.item

    /*Component.onCompleted: {
        if(map) return
        var component = Qt.createComponent("MyMap.qml", Component.Asynchronous, _root)
        component.statusChanged.connect(function(status) {
            if(status === Component.Ready) {
                _mapLoader.sourceComponent = component
                _root.map = component.incubateObject(_root, {"z":0}, Qt.Asynchronous)
                map.onStatusChanged = function(status) {
                    if (status === Component.Ready) {
                        console.log("win!")

                    }
                }
            }
        })
    }*/

    Loader {
        id: _mapLoader
        anchors.fill: parent
        source: "qrc:/Components/MapItem/MyMap.qml"
        asynchronous: true
    }

    NavigationMap {
        id: _navigationMap
        onMoveMap: {

        }

    }

    CircleImageButton {
        x: parent.width - width-20; y: 20
        width: 40; height: 40
         //iconWidth: 20; iconHeight: 20
        source: "qrc:/image/other/more-black.svg"

    }

    CircleImageButton {
        x: parent.width - width-20; y: 80
        width: 40; height: 40
        iconWidth: 22.5; iconHeight: 20
        source: "qrc:/image/other/menu-black.svg"

    }

    CircleImageButton {
        x: parent.width - width-20; y: 140
        width: 40; height: 40
        iconWidth: 20; iconHeight: 20
        source: "qrc:/image/other/plus-black.svg"

    }



}
