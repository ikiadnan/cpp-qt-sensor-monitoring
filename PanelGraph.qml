import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import QtCharts 2.3
import com.ar 1.0

Pane {
    id: control
    implicitWidth: Window.width - 180
    implicitHeight: 175
    property string name: "Suhu"
    property real value: 100
    property int radius: 10
    property string tempColor: "#D4290B"
    Material.elevation: 2
    padding: 0
    background: Rectangle {
        //color: Material.White
        radius: control.Material.elevation > 0 ? control.radius : 0

        layer.enabled: control.enabled && control.Material.elevation > 0
        layer.effect: ElevationEffect {
            elevation: control.Material.elevation
        }
    }

        ChartView{
            //title: 'Title'
            id: chartView
            anchors.fill: parent
            antialiasing: true
            plotArea: Qt.rect(40,25,parent.width - 50,parent.height - 50)
            legend.visible: false
            ValueAxis {
                id: axisX
                min: 0
                max: 1024
            }
            ValueAxis {
                id: axisY
                min: -1
                max: 4
            }
            LineSeries {
                id: lineSeries1
                name: "signal 1"
                axisX: axisX
                axisY: axisY
            }
            Timer {
                id: refreshTimer
                interval: 1 / 60 * 1000 // 60 Hz
                running: true
                repeat: true
                onTriggered: {
                    DataStream.update(chartView.series(0));
                }
            }
        }

}
