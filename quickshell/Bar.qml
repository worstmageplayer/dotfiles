// https://quickshell.org/docs/v0.3.0/types/
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

import "./Battery.qml"
import "./Theme.qml"

PanelWindow {
    id: root

    anchors { top: true; left: true; right: true; }
    implicitHeight: 30
    color: Theme.colBg

    RowLayout {
        anchors { fill: parent; margins: 8 }
        spacing: 16

        RowLayout {
            spacing: 6
            // Workspaces
            Repeater {
                property int largestWorkspaceIndex: Math.max(0, ...Hyprland.workspaces.values.map(w => w.id))
                property int activeWorkspaceIndex: Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id : 0
                property int workspaceCount: Math.max(5, largestWorkspaceIndex, activeWorkspaceIndex)
                model: workspaceCount
                Text {
                    Layout.fillHeight: true
                    property int wsId: index + 1
                    property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                    property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                    text: isActive ? "\uf444" : "\uf4c3"
                    color: Theme.colFg
                    font { family: Theme.fontFamily; pixelSize: Theme.fontSize }

                    MouseArea {
                        anchors { fill: parent }
                        onClicked: Hyprland.dispatch(`hl.dsp.focus({workspace = '${wsId}'})`)
                    }
                }
            }
        }

        Item { Layout.fillWidth: true }

        // Clock
        Text {
            id: clock
            Layout.fillHeight: true
            anchors {
                centerIn: parent
            }
            color: Theme.colFg
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSizeClock
                bold: true
            }

            Process {
                id: dateProc
                command: ["date", "+%H:%M"]
                running: true
                stdout: StdioCollector {
                    onStreamFinished: {
                        const value =this.text.trim()
                        clock.text = value
                    }
                }
            }

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: dateProc.running = true
            }
        }

        // Brightness
        Text {
            id: brightnessText
            property int brightnessValue: 10
            property int maxBrightnessValue: 10
            text: " " + Math.round(brightnessValue*100/maxBrightnessValue) + "%"
            color: Theme.colFg
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSize
                bold: true
            }

            MouseArea {
                anchors { fill: parent }
                onWheel: (event) => {
                    if (event.angleDelta.y > 0) {
                        brightnessUpProcess.running = true
                    } else {
                        brightnessDownProcess.running = true
                    }
                }
            }
        }

        Process {
            id: brightnessUpProcess
            command: ["brightnessctl", "set", "1%+"]
            onExited: getBrightnessProcess.running = true
        }

        Process {
            id: brightnessDownProcess
            command: ["brightnessctl", "set", "1%-"]
            onExited: getBrightnessProcess.running = true
        }

        Process {
            id: getMaxBrightnessProcess
            running: true
            command: ["brightnessctl", "max"]
            stdout: StdioCollector {
                onStreamFinished: {
                    const value = parseInt(this.text.trim())
                    getBrightnessProcess.running = true
                    brightnessText.maxBrightnessValue = value
                }
            }
        }

        Process {
            id: getBrightnessProcess
            command: ["brightnessctl", "get"]
            stdout: StdioCollector {
                onStreamFinished: {
                    const value = parseInt(this.text.trim())
                    brightnessText.brightnessValue = value
                }
            }
        }

        // Volume
        PwObjectTracker { objects: [ Pipewire.defaultAudioSink ] }

        Text {
            id: volumeText
            property int volumeValue: Math.round(Pipewire.defaultAudioSink.audio.volume * 100)
            property string volumeIcon: {
                if (volumeValue < 50) return "\uf027"
                else return "\uf028"
            }
            text: volumeIcon + " " + volumeValue + "%"
            color: Theme.colFg
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSize
                bold: true
            }

            MouseArea {
                anchors.fill: parent
                onWheel: (event) => {
                    if (event.angleDelta.y > 0) {
                        volumeUpProcess.running = true
                    } else {
                        volumeDownProcess.running = true
                    }
                }
            }
        }

        Process {
            id: volumeUpProcess
            command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "1%+"]
        }

        Process {
            id: volumeDownProcess
            command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "1%-"]
        }

        // Battery
        Text {
            id: batteryBar
            text: Battery.batteryText
            color: Theme.colFg
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSize
                bold: true
            }

            MouseArea  {
                anchors { fill: parent }
                hoverEnabled: true
                onEntered: {
                    hoverBattery.visible = true
                }
                onExited: hoverBattery.visible = false
            }
        }

    }

    PopupWindow {
        id: hoverBattery
        visible: false
        anchor {
            window: root
            rect {
                x: parentWindow.width
                y: parentWindow.height + 4
            }
        }
        width: hoverText.implicitWidth + 16
        height: hoverText.implicitHeight + 8
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            radius: 3
            color: Theme.colBg

            Text {
                id: hoverText
                anchors.centerIn: parent
                text: Battery.mouseBatteryText
                color: Theme.colFg

                font {
                    family: Theme.fontFamily
                    pixelSize: Theme.fontSize
                    bold: true
                }
            }
        }
    }
}

