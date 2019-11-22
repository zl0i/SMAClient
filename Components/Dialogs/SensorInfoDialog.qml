import QtQuick 2.12
import QtQuick.Controls 2.5
import QtCharts 2.0

import Components.Controls 1.0
import MyStyle 1.0

Dialog {
    id: _dialog

    parent: Overlay.overlay
    x: parent.width/2 - width/2; y: parent.height/2 - height/2
    width: 500; height: 280
    modal: true; dim: true
    padding: 20
    closePolicy: Popup.NoAutoClose

    property string sensorId
    property string name

    function setModel(model) {
        _modelData.clear()
        model.forEach(function(item) {
            _modelData.append({
                              type: item.type,
                              name: item.dataName,
                              value: item.value
                          })

        })
    }

    function show(model) {
        _dialog.sensorId = model.id
        _dialog.name = model.name
        setModel(model.info)
        _dialog.open()
    }


    Overlay.modal: Rectangle {
        color: "#AA000000"
    }

    background: Rectangle {
        width: 500; height: 280; radius: 20
        color: MyStyle.foregroundColor
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
        width: parent.width; height: parent.height
        Label {
            font { weight: Font.Bold; pixelSize: 24 }
            color: MyStyle.textColor
            text: _dialog.name
        }
        ListView {
            x:0; y: 40
            width:140; height: parent.height-50
            model:  ListModel {
                id: _modelData
            }
            clip: true
            spacing: 5
            delegate: Label {
                width: 140; height: 20
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                color: MyStyle.textColor
                elide: Text.ElideMiddle
                text: name + ": " + value
            }
            section.property: "type"
            section.criteria: ViewSection.FullString
            section.delegate: Rectangle {
                width: 140; height: 20
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: "#487690" }
                    GradientStop { position: 1.0; color: "transparent" }
                }

                color: "#487690"
                Label {
                    width: parent.width-3; height: parent.height
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 16
                    elide: Text.ElideRight
                    color: MyStyle.textColor
                    text: section
                }
            }



        }
        /*ChartView {
            id: chart
            x: 170; y: 50
            width: 307; height: 170
            PieSeries {
                id: pieSeries
                PieSlice { label: "Volkswagen"; value: 13.5 }
                PieSlice { label: "Toyota"; value: 10.9 }
                PieSlice { label: "Ford"; value: 8.6 }
                PieSlice { label: "Skoda"; value: 8.2 }
                PieSlice { label: "Volvo"; value: 6.8 }
            }
        }*/
    }



}
