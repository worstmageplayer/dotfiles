pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    function hyprlock() {
        hyprlockProcess.running = true
    }

    function suspend() {
        suspendProcess.running = true
    }
    Process {
        id: hyprlockProcess
        command: ["hyprlock"]
    }

    Process {
        id: suspendProcess
        command: ["systemctl", "suspend"]
    }
}
