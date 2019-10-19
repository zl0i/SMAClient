import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQml.Models 2.12
import QtGraphicalEffects 1.0

import Components.Controls 1.0

Item {
    Label {
        x: 50; y:25
        font.pixelSize: 36
        font.weight: Font.Bold
        text: qsTr("Избранные данные")
    }
    Flickable {
        x: 50; y: 100
        width: parent.width-x; height: parent.height-y
        contentHeight: _flow.height+20
        clip: true
        Flow {
            id: _flow
            width: parent.width;// height: parent.height
            spacing: 10
            Repeater {
                model: _favoritModel
            }
        }
    }
    GridView {

    }

    ObjectModel {
        id: _favoritModel
        Rectangle {
            width: 400; height: 400
            color: "red"
        }
        Rectangle {
            width: 400; height: 400
            color: "red"
        }
        Rectangle {
            width: 810; height: 400
            color: "red"
        }
        Rectangle {
            width: 400; height: 400
            color: "red"
        }
        Rectangle {
            width: 400; height: 400
            color: "red"
        }
        Rectangle {
            width: 400; height: 400
            color: "red"
        }
    }





    readonly property var fieldModel: [
        {
            "id": 1,
            "name": "filed1",
            "count": 1,
            "area": 20
        },
        {
            "id": 1,
            "name": "filed2",
            "count": 1,
            "area": 20
        },
        {
            "id": 1,
            "name": "filed3",
            "count": 2,
            "area": 40
        }
    ]



    readonly property var sensorModel: [
        {
            "id": 1,
            "name": "sensors1",
            "latitude": 51.511281,
            "longitude": 39.267537,
            "temperature": 24.5,
            "humidity": 75,
            "pressure": 785
        },
        {
            "id": 2,
            "name": "sensors2",
            "latitude": 51.522671,
            "longitude": 39.267861,
            "temperature": 27,
            "humidity": 65,
            "pressure": 780
        },
        {
            "id": 3,
            "name": "sensors3",
            "latitude": 51.521788,
            "longitude": 39.279748,
            "temperature": 23,
            "humidity": 82,
            "pressure": 790
        },
        {
            "id": 4,
            "name": "sensors4",
            "latitude": 51.510167,
            "longitude": 39.279191,
            "temperature": 20,
            "humidity": 50,
            "pressure": 460
        }
    ]

    readonly property var carModel: [
        {
            "id": 1,
            "name": "car1",
            "benzin": 40,
            "speed": 0
        },
        {
            "id": 1,
            "name": "car2",
            "benzin": 40,
            "speed": 0
        },
        {
            "id": 1,
            "name": "car3",
            "benzin": 20,
            "speed": 10
        }
    ]

}
