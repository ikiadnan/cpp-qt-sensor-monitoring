import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12

ApplicationWindow {
    id: root
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("Monitoring Suhu")
    visibility: "Maximized"
    Material.theme: Material.Light
    Material.accent: Material.Orange
//    header: TopBar {

//    }
//    footer: BottomBar {

//    }
    header: ConfigPanel{

    }
    ScrollView{
        padding: 10
        anchors.fill: parent
        contentHeight: 40 + pressurePanel.height+ thrustPanel.height + temperaturePanel.height
        //ScrollBar.horizontal.policy: ScrollBar.AlwaysOn
        GaugePanel{
            id: pressurePanel
            //x: leftControlPanel.width
            value: 123
            name: 'Pressure'
        }
        PanelGraph{
            x: pressurePanel.width +10
        }

        GaugePanel{
            id: thrustPanel
            //x: leftControlPanel.width
            anchors.top: pressurePanel.bottom
            anchors.topMargin: 10
            value: 234
            name: 'Thrust'
        }
        PanelGraph{
            x: thrustPanel.width +10
            y: thrustPanel.y
        }
        GaugePanel{
            id: temperaturePanel
            //: leftControlPanel.width
            anchors.top: thrustPanel.bottom
            anchors.topMargin: 10
            value: 360
            name: 'Temperature'
        }
        PanelGraph{
            x: temperaturePanel.width +10
            y: temperaturePanel.y
        }
    }
//    LeftPanel{
//        id: leftControlPanel
//    }





}
