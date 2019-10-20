import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Rectangle {
    id: _delegat
    width: 410; height: 200
    radius: 20
    gradient: Gradient {
        orientation: Gradient.Vertical
        GradientStop { position:  0.55;  color: "#FFFFFF"}
        GradientStop { position:  1.0;  color: "#126797"}
    }
    layer.enabled: true
    layer.effect: DropShadow {
        radius: 8
        samples: 16
        color: "#80000000"
    }

    property var date
    property int temperature
    property int minTemperature
    property int maxTemperature
    property int pressure
    property int humidity
    property var sunrise
    property var sunset
    property string windDirection
    property int windSpeed

    property string typeWeather
    property string localTypeWeather


    Label {
        x:16; y:3
        font.pixelSize: 20
        text: {
            if(date.getDate() === new Date().getDate()) {
                return qsTr("Сегодня (%1)").arg(date.toLocaleString(Qt.locale(), "dd MMMM"))
            }
            return date.toLocaleString(Qt.locale(), "dd MMMM")
        }
    }
    Label {
        id: _mainTemp
        x:16; y:35
        font.pixelSize: 36
        color: "#000000"
        text: (_delegat.temperature > 0 ? "+" : "")  + _delegat.temperature + " C"
    }
    Label {
        x: _mainTemp.x + _mainTemp.contentWidth + 10; y:31
        text: _delegat.maxTemperature
    }
    Label {
        x: _mainTemp.x + _mainTemp.contentWidth + 10; y:68
        text: _delegat.minTemperature
    }
    Row {
        x:146; y:32
        height: 17
        spacing: 7
        Image {
            width: 33; height: 17
            source: "qrc:/image/weather/upsun-black.svg"
        }
        Label {
            height: 17
            verticalAlignment: Text.AlignVCenter
            text: sunrise.toLocaleString(Qt.locale(), "HH:mm")
        }
    }
    Row {
        x:146; y:68
        height: 11
        spacing: 7
        Image {
            width: 33; height: 11
            source: "qrc:/image/weather/downsun-black.svg"
        }
        Label {
            height: 11
            verticalAlignment: Text.AlignVCenter
            text: sunrise.toLocaleString(Qt.locale(), "HH:mm")
        }
    }


    Row {
        x: 16; y:91
        height: 22
        spacing: 10
        Item {
            width: 20; height: 22
            Image {
                anchors.centerIn: parent
                width: 13; height: 20
                source: "qrc:/image/weather/humidity-black.svg"
            }
        }
        Label {
            height: 22
            verticalAlignment: Text.AlignVCenter
            text: _delegat.humidity + " %"
        }
        Item {
            width: 26; height: 22
            Image {
                anchors.centerIn: parent
                width: 20; height: 20
                source: "qrc:/image/weather/pressure-black.svg"
            }
        }
        Label {
            height: 22
            verticalAlignment: Text.AlignVCenter
            text: _delegat.pressure + " мм"
        }
        Item {
            width: 26; height: 22
            Image {
                anchors.centerIn: parent
                width: 26.5; height: 15
                antialiasing: true
                source: "qrc:/image/weather/wind-black.svg"
            }
        }
        Label {
            height: 22
            verticalAlignment: Text.AlignVCenter
            text: _delegat.windDirection
        }
        Label {
            height: 22
            verticalAlignment: Text.AlignVCenter
            text: _delegat.windSpeed + " м/с"
        }
    }
    Column {
        x: parent.width-width-20; y: 15
        spacing: 10
        Item {
            width: 100; height: 60
            Image {
                anchors.centerIn: parent
                width: 75; height: 60
                fillMode: Image.PreserveAspectFit
                source: "qrc:/image/weather/snow-black.svg"
            }
        }
        Label {
            width: 100; height: 32
            verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            text: "Снег"//"Перееменная облачность"
        }
    }

    Rectangle {
        x: 12; y: 122
        width: parent.width-24; height: 1
        color: "#6AABF7"
    }

    ListView {
        x: 16; y:134
        width: parent.width-x-16; height: 40
        orientation: ListView.Horizontal
        spacing: 20
        interactive: false
        model: 7
        delegate: Column {
            width: 37; height: 20
            spacing: 10
            Label {
                width: 37; height: 20
                verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
                text: "22:00"
            }
            Label {
                width: 37; height: 20
                verticalAlignment: Text.AlignVCenter; horizontalAlignment: Text.AlignHCenter
                text: "+8 C"
            }
        }
    }

}
