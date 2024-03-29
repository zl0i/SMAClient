import QtQuick 2.12
import QtQuick.Controls 2.5

Canvas {
    id: _canvas
    width: 150; height: 150

    property color externalColor: "#FFFFFF"
    property color internalColor: "#000000"
    property bool running: false
    property real speed: 1
    property real radius: Math.min(width, height)/2-3

    property real angle: 0

    onAngleChanged: requestPaint()

    NumberAnimation {
        target: _canvas
        property: "angle"
        from: 0; to: 360
        running: _canvas.running
        loops: Animation.Infinite
        duration: 1500 * _canvas.speed
    }
    onPaint: {
        var ctx = getContext("2d")
        ctx.reset()
        var centerX = width/2
        var centerY = height/2
        ctx.lineWidth = 3

        var angleK = angle*Math.PI/180

        ctx.strokeStyle = externalColor
        ctx.beginPath()
        ctx.arc(centerX, centerY, radius, 0 + angleK, Math.PI + angleK, true);
        ctx.stroke()

        ctx.translate(centerX,centerY )
        ctx.rotate(75*Math.PI/180)

        ctx.strokeStyle = internalColor
        ctx.beginPath()
        ctx.arc(0, 0,  radius-10, 0 + angleK*2, Math.PI + angleK*2, false);
        ctx.stroke()
    }
}
