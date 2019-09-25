import QtQuick 2.12
import QtQuick.Controls 2.5
import QtLocation 5.13
import QtPositioning 5.6

Map {
    anchors.fill: parent
    plugin: Plugin { name: "esri" } //mapboxgl esri osm
    center: QtPositioning.coordinate(51.516005, 39.273783)
    zoomLevel: 14


}
