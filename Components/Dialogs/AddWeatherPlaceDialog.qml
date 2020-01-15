import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQml.Models 2.3

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

    /*Component.onCompleted:  {
        console.log( _weather.placeModel.rowCount())
        for(var i = 0; i <  _weather.placeModel.rowCount(); i++) {

        }

    }*/


    contentItem: Item {
        Label {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            font { weight: Font.Bold; pixelSize: 24 }
            color: MyStyle.textColor
            text: qsTr("Список мест")
        }
        ListModel {
            id: _listModel
        }

        ListView {
            y: 35
            width: parent.width; height: parent.height-80
            clip: true
            model: _weather.placeModel
            spacing: 10
            section.property: "cityCountry"
            section.delegate: Item {
                width: parent.width; height: 20
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
                    color: MyStyle.foregroundColor
                }
            }
            delegate: Label {
                leftPadding: 15
                width: parent.width; height: 30
                verticalAlignment: Text.AlignVCenter
                color: MyStyle.textColor
                text: cityName
            }

            ScrollBar.vertical: ScrollBar { }
        }




        RoundButton {
            x: 10; y: parent.height - height
            text: qsTr("Добавить")
        }

        RoundButton {
            x: parent.width-width-10; y: parent.height - height
            text: qsTr("Отмена")
            onClicked: _dialog.close()
        }

    }



}
