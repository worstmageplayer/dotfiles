// https://quickshell.org/docs/v0.3.0/types/
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import "./"

PanelWindow {
    id: root

    anchors { top: true; left: true; right: true; }
    implicitHeight: 28
    color: Theme.colBg

    RowLayout {
        anchors { fill: parent; margins: 6 }
        spacing: 16

        RowLayout {
            id: leftSide
            Layout.leftMargin: 4
            spacing: 6
            // Workspaces
            Repeater {
                property int largestWorkspaceIndex: Math.max(0, ...Hyprland.workspaces.values.map(w => w.id))
                property int activeWorkspaceIndex: Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id : 0
                property int workspaceCount: Math.max(5, largestWorkspaceIndex, activeWorkspaceIndex)
                model: workspaceCount
                Text {
                    id: wsBar
                    required property int index
                    property int wsId: index + 1
                    property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                    property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                    text: isActive ? "\uf444" : "\uf4c3"
                    color: Theme.colFg
                    font { family: Theme.fontFamily; pixelSize: Theme.fontSize }

                    MouseArea {
                        anchors { fill: parent }
                        onClicked: Hyprland.dispatch(`hl.dsp.focus({workspace = '${wsBar.wsId}'})`)
                    }
                }
            }
        }


        // Clock
        Text {
            id: clockBar
            property int formatIndex: 0

            text: {
                if (formatIndex === 0) return Clock.time
                if (formatIndex === 1) return Clock.date
                return Clock.day
            }
            anchors { centerIn: parent }
            color: Theme.colFg
            font {
                family: Theme.fontFamily
                pixelSize: Theme.fontSize
                bold: true
            }
            MouseArea {
                anchors { fill: parent }
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: (mouse) => {
                    Clock.clockUpdate()
                    if (mouse.button == Qt.LeftButton)
                    clockBar.formatIndex = (clockBar.formatIndex + 1) % 3;
                    else
                    clockBar.formatIndex = (clockBar.formatIndex + 2) % 3;
                }
            }
        }

        RowLayout {
            id: rightSide
            Layout.rightMargin: 4
            Layout.alignment: Qt.AlignRight
            spacing: 16
            // Brightness
            Text {
                id: brightnessBar
                text: Brightness.brightnessText
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
                            Brightness.brightnessUp()
                        } else {
                            Brightness.brightnessDown()
                        }
                    }
                }
            }

            // Volume
            Text {
                id: volumeBar
                text: Volume.volumeText
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
                            Volume.volumeUp()
                        } else {
                            Volume.volumeDown()
                        }
                    }
                    onClicked: Volume.volumeMute()
                }
            }

            // Battery
            Text {
                id: batteryBar
                property bool hovered: false
                text: hovered ? Battery.mouseBatteryText : Battery.batteryText
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
                        batteryBar.hovered = true
                    }
                    onExited: {
                        batteryBar.hovered = false
                    }
                }
            }

            Text {
                id: powerBar
                text: ""
                color: Theme.colFg
                font {
                    family: Theme.fontFamily
                    pixelSize: Theme.fontSize - 2
                }
                MouseArea {
                    anchors { fill: parent }
                    hoverEnabled: true
                    onClicked: {
                        Power.suspend()
                    }
                    onEntered: {
                        powerBar.color = Theme.colHov
                    }
                    onExited: {
                        powerBar.color = Theme.colFg
                    }
                }
            }

        }
    }
}

