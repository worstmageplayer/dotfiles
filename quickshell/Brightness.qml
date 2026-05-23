pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int brightnessValue: 0
    property int maxBrightnessValue: 800
    property string brightnessText: " " + Math.round(brightnessValue*100/maxBrightnessValue) + "%"

    function brightnessUp() {
        brightnessUpProcess.running = true
    }

    function brightnessDown() {
        brightnessDownProcess.running = true
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
                root.maxBrightnessValue = value
            }
        }
    }

    Process {
        id: getBrightnessProcess
        command: ["brightnessctl", "get"]
        stdout: StdioCollector {
            onStreamFinished: {
                const value = parseInt(this.text.trim())
                root.brightnessValue = value
            }
        }
    }
}

