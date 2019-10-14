import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import Components.Controls 1.0

Item {
    Label {
        x: 50; y:10
        font.pixelSize: 48
        font.weight: Font.Bold
        text: qsTr("Главная")
    }
    Column {
        x: 50; y: 80
        width: parent.width
        spacing: 10
        Label {
            text: qsTr("Избранные поля")
        }
        Item {
            width: parent.width-40; height: 170
            clip: true
            ListView {
                x:10; y: 10
                width: parent.width; height: parent.height
                orientation: ListView.Horizontal
                spacing: 18
                model: fieldModel
                delegate: FavoritesFieldDelegate {
                    name: modelData.name
                    area: modelData.area
                    count: modelData.count
                }

                footer: AddFavoritesFooter {
                    onAdd: {
                        console.log("Добавить поле")
                    }
                }
            }
        }

        Label {
            font.pixelSize: 14
            text: qsTr("Избранные датчики")
        }
        Item {
            width: parent.width-40; height: 170
            clip: true
            ListView {
                x:10; y: 10
                width: parent.width; height: parent.height
                orientation: ListView.Horizontal
                spacing: 18
                model: sensorModel
                delegate: FavoritesSensorDelegate {
                    name: modelData.name
                    temperature: modelData.temperature
                    humidity: modelData.humidity
                    pressure: modelData.pressure
                }
                footer: AddFavoritesFooter {
                    onAdd: {
                        console.log("Добавить датчик")
                    }
                }
            }

        }
        Label {
            text: qsTr("Избранные машины")
        }
        Item {
            width: parent.width-40; height: 170
            clip: true
            ListView {
                x:10; y: 10
                width: parent.width; height: parent.height
                orientation: ListView.Horizontal
                spacing: 18
                model: carModel
                delegate: FavoritesCarDelegate {
                    name: modelData.name
                    benzin: modelData.benzin
                    speed: modelData.speed
                }

                footer: AddFavoritesFooter {
                    onAdd: {
                        console.log("Добавить машину")
                    }
                }
            }
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
