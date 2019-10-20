import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Rectangle {
    id: _delegat

    width: 100; height: 160
    radius: 20
    gradient: Gradient {
        orientation: Gradient.Vertical
        GradientStop { position:  0.3;  color: "#FFFFFF"}
        GradientStop { position:  1.0;  color: "#487690"}
    }
    layer.enabled: true
    layer.effect: DropShadow {
        radius: 8
        samples: 16
        color: "#80000000"
    }

    property string date
    property string typeWeather: ""
    property real temperature: 0
    property real pressure: 0
    property real humidity: 0
    property real windSpeed: 0

    function getIconByWeather(type) {
        switch(type) {
        case "clear sky":
            return "qrc:/image/weather/clearSky-black.svg"
        case "few clouds":
            return "qrc:/image/weather/fewClouds-black.svg"
        case "scattered clouds":
            return "qrc:/image/weather/scatteredClouds-black.svg"
        case "broken clouds":
            return "qrc:/image/weather/brokenClouds-black.svg"
        case "rain":
            return "qrc:/image/weather/rain-black.svg"
        case "shower raind":
            return "qrc:/image/weather/showerRain-black.svg"
        case "thunderstorm":
            return "qrc:/image/weather/thunderstorm-black.svg"
        case "snow":
            return "qrc:/image/weather/snow-black.svg"
        case "mist":
            return "qrc:/image/weather/mist-black.svg"
        default :
            return "qrc:/image/weather/clearSky-black.svg"
        }
    }

    Label {
        x: 0; y: 7
        width: parent.width
        verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
        color: "#000000"
        text: "16 октября"
    }

    Image {
        x: parent.width/2-width/2; y: 26
        width: 30; height: 30
        fillMode: Image.PreserveAspectFit
        source: getIconByWeather(_delegat.typeWeather)
    }
    Column {
        x: 15; y: 65
        spacing: 6
        Row {
            spacing: 10
            Item {
                width: 20; height: 18
                Image {
                    anchors.centerIn: parent
                    width: 8; height: 16
                    source: "qrc:/image/weather/temperature-black.svg"
                }
            }
            Label {
                width: 53; height: 18
                verticalAlignment: Text.AlignVCenter
                text: _delegat.temperature + " C"
            }
        }
        Row {
            spacing: 10
            Item {
                width: 20; height: 18
                Image {
                    anchors.centerIn: parent
                    width: 16; height: 16
                    source: "qrc:/image/weather/pressure-black.svg"
                }
            }
            Label {
                width: 53; height: 18
                verticalAlignment: Text.AlignVCenter
                text: _delegat.pressure + " мм"
            }
        }
        Row {
            spacing: 10
            Item {
                width: 20; height: 18
                Image {
                    anchors.centerIn: parent
                    width: 16; height: 20
                    source: "qrc:/image/weather/humidity-black.svg"
                }
            }
            Label {
                width: 53; height: 18
                verticalAlignment: Text.AlignVCenter
                text: _delegat.humidity + " %"
            }
        }
        Row {
            spacing: 10
            Item {
                width: 20; height: 18
                Image {
                    anchors.centerIn: parent
                    width: 20; height: 13
                    source: "qrc:/image/weather/wind-black.svg"
                }
            }
            Label {
                width: 53; height: 18
                verticalAlignment: Text.AlignVCenter
                text: _delegat.windSpeed + " м/с"
            }
        }
    }

}
