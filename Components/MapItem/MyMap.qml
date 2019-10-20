import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12

Map {
    anchors.fill: parent
    plugin: Plugin { name: "osm" } //mapboxgl esri osm
    center: QtPositioning.coordinate(51.516005, 39.273783)
    zoomLevel: 14
    activeMapType: supportedMapTypes["0"]

    Component.onCompleted: {
        //console.log(JSON.stringify(supportedMapTypes))
    }
}
