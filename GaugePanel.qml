import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12

Pane {
    id: gaugePanel
    implicitWidth: 150
    implicitHeight: 175
    property string name: "Suhu"
    property real value: 100
    property int radius: 10
    property string tempColor: "#D4290B"
    padding: 10
    Material.elevation: 2

    background: Rectangle {
        color: 'white'
        radius: parent.Material.elevation > 0 ? parent.radius : 0

        layer.enabled: parent.enabled && parent.Material.elevation > 0
        layer.effect: ElevationEffect {
            elevation: parent.Material.elevation
        }
    }
    CircleGauge{
        colorCircle: 'red'
        arcEnd: gaugePanel.value
        label: gaugePanel.name
    }

}

