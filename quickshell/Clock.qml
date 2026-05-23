pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string time
    property string date
    property string day

    function clockUpdate() {
        dateProc.running = true
        dayProc.running = true
        timeProc.running = true
    }

    Process {
        id: dayProc
        command: ["date", "+%A"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.day = this.text
            }
        }
    }

    Process {
        id: dateProc
        command: ["date", "+%D"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.date = this.text
            }
        }
    }

    Process {
        id: timeProc
        command: ["date", "+%H:%M"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const value = this.text.trim()
                root.time = value
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: timeProc.running = true
    }
}
