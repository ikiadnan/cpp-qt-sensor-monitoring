import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12
import com.ar 1.0

Pane {
    id: controlPanel
    width: root.width
    height: 75
    property real s1: 0.2
    background: Rectangle {
        id: mainBg
        color: 'white'
        radius: 0
        layer.enabled: true
        layer.effect: ElevationEffect {
            elevation: 2
        }
    }
    RowLayout {
        spacing: 10
        //anchors.fill: parent
        Button {
            Layout.preferredWidth: 100
            id: btnOpen
            flat: true
            property bool isPlaying: false
            text: qsTr("Open")
            Material.background: Material.Red
            Material.foreground: 'white'
            Material.elevation: 2
            onClicked: {
            }
        }
        Button {
            id: btnSave
            Layout.preferredWidth: 100
            flat: true
            property bool isPlaying: false
            text: qsTr("Save")
            Material.background: Material.Red
            Material.foreground: 'white'
            Material.elevation: 2
            onClicked: {
            }
        }
        Button {
            id: btnExport
            Layout.preferredWidth: 100
            flat: true
            property bool isPlaying: false
            text: qsTr("Export")
            Material.background: Material.Red
            Material.foreground: 'white'
            Material.elevation: 2
            onClicked: {
            }
        }
        Button {
            id: btnClear
            Layout.preferredWidth: 100
            flat: true
            property bool isPlaying: false
            text: qsTr("Clear")
            Material.background: Material.Red
            Material.foreground: 'white'
            Material.elevation: 2
            onClicked: {
            }
        }
        Text {
            text: "Port:"
        }

        ComboBox {
            id: cbAvailablePort
            model: Port.getAvailablePorts()
            Material.foreground: Material.White
            //flat : true
        }
        Button {
            id: btnPlay
            flat: true
            property bool isPlaying: false
            text: qsTr("Start")
            Material.background: Material.Red
            Material.foreground: 'white'
            Material.elevation: 2
            onClicked: {
                //if (!controlPanel.wind.visible)
                if(isPlaying){
                    btnPlay.text = "Start"
                    timer.running = false;
                    Port.close();
                }
                else{
                    Port.setup(cbAvailablePort.currentText);
                    Port.open();
                    timer.running = true;
                    btnPlay.text = "Stop"
                }

                isPlaying = !isPlaying
            }
        }
        Timer {
            id: timer
            interval: 500
            running: false
            repeat: true
            onTriggered:{
                Port.readData();


            }
        }

    }
}

