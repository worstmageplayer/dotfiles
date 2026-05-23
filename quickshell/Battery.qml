pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
    id: root

    property int batteryValue: UPower.displayDevice.percentage * 100
    property string batteryIcon: {
        if (root.batteryValue <= 10) return "󰁺"
        if (root.batteryValue <= 20) return "󰁻"
        if (root.batteryValue <= 30) return "󰁼"
        if (root.batteryValue <= 40) return "󰁽"
        if (root.batteryValue <= 50) return "󰁾"
        if (root.batteryValue <= 60) return "󰁿"
        if (root.batteryValue <= 70) return "󰂀"
        if (root.batteryValue <= 80) return "󰂁"
        if (root.batteryValue <= 90) return "󰂂"
        return "󰁹"
    }
    property string batteryText: batteryIcon + " " + batteryValue + "%"
    property var mouseBattery: UPower.devices.values.find(
        d => d.model === "Logitech PRO X 2"
    )
    property int mouseBatteryPercent: mouseBattery ? Math.round(mouseBattery.percentage * 100) : 0

    property string mouseBatteryText: "󰍽 " + mouseBatteryPercent + "%"
}
