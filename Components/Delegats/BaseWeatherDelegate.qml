import QtQuick 2.12
import QtQuick.Controls 2.5

Rectangle {

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
}
