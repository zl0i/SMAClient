import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

import MyStyle 1.0
import Components.Controls 1.0


Dialog {
    id: _dialog

    x: parent.width/2 - width/2; y: parent.height/2 - height/2
    width: 400; height: 560
    //padding: 0
    modal: true; dim: true
    closePolicy: Popup.NoAutoClose

    background: Rectangle {
        width: parent.width; height: parent.height; radius: 20
        color: MyStyle.backgroundColor
        layer.enabled: true
        layer.effect: DropShadow {
            samples: 8
            radius: 16
            color: "#80000000"
        }
        CircleImageButton {
            x: parent.width-width-20; y: 20
            width:20; height: 20
            iconWidth: 20; iconHeight: 20
            style: "transparent"
            source: "qrc:/image/other/exit-black.svg"
            isOverlayColor: true
            pressedIconColor: "#487690"
            releasedIconColor: MyStyle.textColor
            onClicked: {
                _dialog.close()
            }
        }
    }

    contentItem: Item {
        Label {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            font { weight: Font.Bold; pixelSize: 24 }
            color: MyStyle.textColor
            text: qsTr("Список мест")
        }


        ListView {
            id: _cityList
            y: 35
            width: parent.width; height: parent.height-80
            clip: true
            model: _weather.placeModel
            ScrollIndicator.vertical: ScrollIndicator { }

            section.property: "cityCountry"
            section.delegate: Item {
                width: parent.width; height: 30
                Label {
                    x: 10
                    width: parent.width; height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    text: section
                    color: MyStyle.textColor
                }
                Rectangle {
                    y: parent.height
                    width: parent.width; height: 1
                    color: "#C4C4C4"
                }
            }

            delegate: Item {
                id: _delegate
                width: parent.width; height: 30

                property var cId: cityId
                property var cName: cityName

                Rectangle {
                    width: parent.width; height: parent.height
                    opacity: _delegate.ListView.isCurrentItem ? 0.9 : 0.3
                    visible: _mouseAreaDelegate.hovered || _delegate.ListView.isCurrentItem
                    color: "#C4C4C4"
                }

                Label {
                    x: 15
                    width: parent.width-15; height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    color: MyStyle.textColor
                    text: cityName
                }
                MouseArea {
                    id: _mouseAreaDelegate
                    width: parent.width; height: parent.height
                    hoverEnabled: true
                    property bool hovered: false
                    onEntered: hovered = true
                    onExited: hovered = false
                    onClicked: _cityList.currentIndex = index
                }

            }


        }

        RoundButton {
            x: 10; y: parent.height - height
            text: qsTr("Добавить")
            onClicked: {
                _weather.addPlaceWeather(_cityList.currentItem.cId, _cityList.currentItem.cName)
                _dialog.close()
            }
        }

        RoundButton {
            x: parent.width-width-10; y: parent.height - height
            text: qsTr("Отмена")
            onClicked: _dialog.close()
        }

    }



}
