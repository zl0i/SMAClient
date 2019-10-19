import QtQuick 2.12
import QtQuick.Controls 2.5
import QtLocation 5.13
import QtPositioning 5.6
import QtQml.Models 2.12

import Components.MapItem 1.0

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

    }

}
