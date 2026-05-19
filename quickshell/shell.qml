// https://quickshell.org/docs/v0.3.0/types/
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root

    property color colBg: "#16161d"
    property color colFg: "#fffefe"
    property color colMuted: "#444b6a"
    property color colCyan: "#0db9d7"
    property color colBlue: "#7aa2f7"
    property color colYellow: "#e0af68"
    property string fontFamily: "JetBrainsMonoNLNerdFontPropo"
    property int fontSize: 16
    property int fontSizeClock: 18

    anchors { top: true; left: true; right: true; }
    implicitHeight: 30
    color: root.colBg

    RowLayout {
        anchors { fill: parent; margins: 8 }
        spacing: 16

        RowLayout {
            spacing: 4
            // Workspaces
            Repeater {
                property int largestWorkspaceIndex: Math.max(0, ...Hyprland.workspaces.values.map(w => w.id))
                property int activeWorkspaceIndex: Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id : 0
                property int workspaceCount: Math.max(5, largestWorkspaceIndex, activeWorkspaceIndex)
                model: workspaceCount
                Text {
                    property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                    property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                    text: isActive ? "\uf444" : "\uf4c3"
                    color: root.colFg
                    font { family: root.fontFamily; pixelSize: root.fontSize }
                }
            }
        }

        Item { Layout.fillWidth: true }

        // Clock
        Text {
            id: clock
            anchors.centerIn: parent
            color: root.colFg
            font {
                family: root.fontFamily
                pixelSize: root.fontSizeClock
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
            color: colFg
            font {
                family: fontFamily
                pixelSize: fontSize
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
            color: colFg
            font {
                family: fontFamily
                pixelSize: fontSize
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
            id: batterytext
            property int batteryValue: UPower.displayDevice.percentage * 100
            property string batteryIcon: {
                if (batteryValue <= 10) return "󰁺"
                if (batteryValue <= 20) return "󰁻"
                if (batteryValue <= 30) return "󰁼"
                if (batteryValue <= 40) return "󰁽"
                if (batteryValue <= 50) return "󰁾"
                if (batteryValue <= 60) return "󰁿"
                if (batteryValue <= 70) return "󰂀"
                if (batteryValue <= 80) return "󰂁"
                if (batteryValue <= 90) return "󰂂"
                return "󰁹"
            }
            text: batteryIcon + " " + batteryValue + "%"
            color: colFg
            font {
                family: fontFamily
                pixelSize: fontSize
                bold: true
            }
        }


    }
}

