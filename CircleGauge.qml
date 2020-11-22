import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtGraphicalEffects 1.0

Item{
    id: gaugerowlayout
    width: parent.width
    height: parent.height
    property real arcBegin: 0
    property real arcEnd: 270
    property real arcOffset: 0
    property real lineWidth: 10
    property string colorCircle: '#CC3333'
    property string label: 'Gauge'

    property alias beginAnimation : animationArcBegin.enabled
    property alias endAnimation : animationArcEnd.enabled


    onArcBeginChanged: canv.requestPaint()
    onArcEndChanged: canv.requestPaint()

    Behavior on arcBegin {
        id: animationArcBegin
        enabled: true
        NumberAnimation{
            duration: parent.animationDuration
            easing.type: Easing.InOutCubic
        }
    }

    Behavior on arcEnd {
        id: animationArcEnd
        enabled: true
        NumberAnimation{
            duration: parent.animationDuration
            easing.type: Easing.InOutCubic
        }
    }

    property int animationDuration: 200
    Text{
        width: gaugerowlayout.width
        text: gaugerowlayout.label
        font.family: 'Segoe UI'
        font.pointSize: 12
        anchors.centerIn: gaugerowlayout.Center
        anchors.bottom: gaugerowlayout.bottom
        color:'#666666'
    }

    Item {
        id: circle
        width: gaugerowlayout.width
        height: gaugerowlayout.width
        rotation : 135
        anchors.fill: parent
        Canvas{
            id: canv
            width: circle.width
            height: circle.height
            rotation: gaugerowlayout.arcOffset
            onPaint: {
                var context = getContext('2d');
                var x = width * 0.5
                var y = height * 0.5
                var start = Math.PI * ((gaugerowlayout.arcBegin) / 180 * 0.75)
                var end = Math.PI * ((gaugerowlayout.arcEnd) / 180 * 0.75)
                context.reset()

                context.beginPath();
                context.arc(x,y,(width * 0.5)- gaugerowlayout.lineWidth * 0.5, 0, Math.PI * (2 * 0.75),false)
                context.lineWidth = gaugerowlayout.lineWidth
                context.strokeStyle = '#cccccc'
                context.stroke()

                context.beginPath();
                var grd = context.createConicalGradient(x,y, 2 * Math.PI)

                grd.addColorStop(0.44, '#FF0000')
                grd.addColorStop(0.88, '#00FF00')
                context.arc(x,y,(width * 0.5)- gaugerowlayout.lineWidth * 0.5, start, end,false)
                context.lineWidth = gaugerowlayout.lineWidth
                context.strokeStyle = grd
                context.stroke()

                context.beginPath();
                context.arc(x,y,(width*0.25), 0, 360)
                context.lineWidt = 0
                context.fillStyle = gaugerowlayout.colorCircle
                context.fill()
            }
        }
    }
    Text{
        anchors.fill: parent
        text: gaugerowlayout.arcEnd
        font.family: 'Segoe UI'
        font.pointSize: 20
        font.bold: true
        color: 'white'
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

}



