import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import MyStyle 1.0

Rectangle {
    width: 100; height: 200; radius: 20
    layer.enabled: true
    layer.effect: DropShadow {
        radius: 8
        samples: 16
        color: "#80000000"
    }
    gradient: Gradient {
        orientation: Gradient.Vertical
        GradientStop {position: 0.5; color: MyStyle.foregroundColor }
        GradientStop {position: Math.min(1.0, gradientPosition); color: getColorByTemperature(temperature) }
    }

    property var gradientPosition: 1.0

    property string typeWeather
    property int temperature
    property int pressure
    property int humidity
    property var sunrise
    property var sunset
    property int windSpeed


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

    function getColorByTemperature(temp) {
        if(temp < -23) return "#540294"
        if(temp >= -23 && temp < -15) return "#6D3FB8"
        if(temp >= -15 && temp < -9) return "#1743B4"
        if(temp >= -9 && temp < 0) return "#1E9BB6"
        if(temp >= 0 && temp < 7) return "#30C89B"
        if(temp >= 7 && temp < 12) return "#2D8A47"
        if(temp >= 12 && temp < 18) return "#30C323"
        if(temp >= 18 && temp < 23) return "#D0B00A"
        if(temp >= 23 && temp < 28) return "#E34D1D"
        if(temp >=28) return "#D61717"
    }
}
