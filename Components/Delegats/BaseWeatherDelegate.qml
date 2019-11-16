import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import MyStyle 1.0

Rectangle {
    width: 100; height: 200; radius: 20
    antialiasing: true
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

    property var date
    property string typeWeather
    property string descriptionWeather
    property int temperature
    property int pressure
    property int humidity
    property var sunrise
    property var sunset
    property int windSpeed

    readonly property string degTemperatureStr: "°"


    function getIconByWeather(type, description) {
        switch(type) {
        case "Clear":
            return "qrc:/image/weather/Clear/clearSky.svg"
        case "Clouds":
            return getIconByClouds(description)
        case "Rain":
            return "qrc:/image/weather/Rain/rain.svg"
        case "Drizzle":
            return "qrc:/image/weather/Drizzle/drizzle.svg"
        case "Snow":
            return "qrc:/image/weather/Snow/snow.svg"
        case "Atmosphere":
            return getIconByAtmosphere(description)
        case "Thunderstorm":
            return getIconByThunderstrom(description)
        }
    }

    function getIconByClouds(description) {
        switch (description) {
        case "few clouds" :
            return "qrc:/image/weather/Clouds/fewClouds.svg"
        case "scattered clouds":
            return "qrc:/image/weather/Clouds/scatteredClouds.svg"
        case "broken clouds":
            return "qrc:/image/weather/Clouds/brokenClouds.svg"
        case "overcast clouds":
            return "qrc:/image/weather/Clouds/overcastClouds.svg"
        }
    }

    function getIconByThunderstrom(description) {
        switch (description) {
        case "light thunderstorm" || "thunderstrom" || "heavy thunderstorm":
            return "qrc:/image/weather/Thunderstrom/thunderstrom.svg"
        case "thunderstorm with light rain" || "thunderstrom rain" || "ragged thunderstorm" || "thunderstorm with light drizzle" || "thunderstorm with drizzle":
            return "qrc:/image/weather/Thunderstrom/thunderstrom-rain.svg"
        case "thunderstorm with heavy rain" || "thunderstorm with heavy drizzle":
            return "qrc:/image/weather/Thunderstrom/thunderstrom-heavyRain.svg"
        }
    }

    function getIconByAtmosphere(description) {
        switch (description) {
        case "mist" :
            return "qrc:/image/weather/Atmosphere/mist.svg"
        case "tornado":
            return "qrc:/image/weather/Atmosphere/tornado.svg"
        }
    }

    function getNameByWeather(description) {
        switch(description) {
        case "thunderstorm with light rain":
            return qsTr("Гроза с небольшим дождем")
        case "thunderstorm with rain":
            return qsTr("Гроза с дождем")
        case "thunderstorm with heavy rain":
            return qsTr("Гроза с проливным дождем")
        case "light thunderstorm":
            return qsTr("Легкая гроза")
        case "thunderstorm":
            return qsTr("Гроза")
        case "heavy thunderstorm":
            return qsTr("Сильная гроза")
        case "ragged thunderstorm":
            return qsTr("Рваная гроза")
        case "thunderstorm with light drizzle":
            return qsTr("Гроза с легкой моросью")
        case "thunderstorm with drizzle":
            return qsTr("Гроза с моросящим дождем")
        case "thunderstorm with heavy drizzle":
            return qsTr("Гроза с сильным моросящим дождем")
        case "light intensity drizzle":
            return qsTr("Моросящий дождь")
        case "drizzle":
            return qsTr("Изморось")
        case "heavy intensity drizzle":
            return qsTr("Сильная морось")
        case "light intensity drizzle rain":
            return qsTr("Интенсивный моросящий дождь")
        case "drizzle rain":
            return qsTr("Моросящий дождь")
        case "heavy intensity drizzle rain":
            return qsTr("Сильный дождь")
        case "shower rain and drizzle":
            return qsTr("Дождь")
        case "heavy shower rain and drizzle":
            return qsTr("Сильный ливень и морось")
        case "shower drizzle":
            return qsTr("Моросящий дождь")
        case "light rain":
            return qsTr("Легкий дождь")
        case "moderate rain":
            return qsTr("Умеренный дождь")
        case "heavy intensity rain":
            return qsTr("Сильный дождь")
        case "very heavy rain":
            return qsTr("Очень сильный дождь")
        case "extreme rain":
            return qsTr("Сверх сильный дождь")
        case "freezing rain":
            return qsTr("Холодный дождь")
        case "light intensity shower rain":
            return qsTr("Легкая интенсивность дождя")
        case "shower rain":
            return qsTr("Дождь")
        case "heavy intensity shower rain":
            return qsTr("Сильный дождь")
        case "ragged shower rain":
            return qsTr("Рваный дождь")
        case "light snow":
            return qsTr("Небольшой снег")
        case "Snow":
            return qsTr("Снег")
        case "Heavy snow":
            return qsTr("Сильный снегопад")
        case "Sleet":
            return qsTr("Мокрый снег")
        case "Light shower sleet":
            return qsTr("Легкий мокрый снег")
        case "Shower sleet":
            return qsTr("Дождь со снегом")
        case "Light rain and snow":
            return qsTr("Небольшой дождь и снег")
        case "Rain and snow":
            return qsTr("Дождь и снег")
        case "Light shower snow":
            return qsTr("Легкий снегопад")
        case "Shower snow":
            return qsTr("Снегопад")
        case "Heavy shower snow":
            return qsTr("Сильный снегопад")
        case "mist":
            return qsTr("Туман")
        case "Smoke":
            return qsTr("Дым")
        case "Haze":
            return qsTr("Мгла")
        case "sand/ dust whirls":
            return qsTr("Песчаная пыль")
        case "fog":
            return qsTr("Дымка")
        case "sand":
            return qsTr("Песок")
        case "dust":
            return qsTr("Пыль")
        case "volcanic ash":
            return qsTr("Вулканический пепел")
        case "squalls":
            return qsTr("Шквалы")
        case "tornado":
            return qsTr("Торнадо")
        case "clear sky":
            return qsTr("Ясно")
        case "few clouds":
            return qsTr("Малооблачно")
        case "scattered clouds":
            return qsTr("Переменная облачность")
        case "broken clouds":
            return qsTr("Облачно")
        case "overcast clouds":
            return qsTr("Пасмурные облака")
        default :
            return ""
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

    function getDirectionByDeg(deg) {
        if(deg >= 336  || deg < 22) return qsTr("с")
        if(deg >= 22 && deg < 67) return qsTr("с-в")
        if(deg >= 67 && deg < 112) return qsTr("в")
        if(deg >= 112 && deg < 157) return qsTr("ю-в")
        if(deg >= 157 && deg < 202) return qsTr("ю")
        if(deg >= 202 && deg < 247) return qsTr("ю-з")
        if(deg >= 247 && deg < 292) return qsTr("з")
        if(deg >= 292 && deg < 336) return qsTr("с-з")
        return " "
    }
}
