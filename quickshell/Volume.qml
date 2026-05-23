pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire

Singleton {
    PwObjectTracker { objects: [ Pipewire.defaultAudioSink ] }

    property int volumeValue: Math.round(Pipewire.defaultAudioSink.audio.volume * 100)
    property var volumeMuted: Pipewire.defaultAudioSink.audio.muted
    property string volumeIcon: {
        if (volumeMuted) return "\ueee8"
        if (volumeValue === 0) return "\uf026"
        if (volumeValue < 50) return "\uf027"
        return "\uf028"
    }
    property string volumeText: volumeIcon + " " + volumeValue + "%"

    Process {
        id: volumeUpProcess
        command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "1%+"]
    }

    Process {
        id: volumeDownProcess
        command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "1%-"]
    }

    Process {
        id: volumeMuteProcess
        command: ["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"]
    }

    function volumeUp() {
        volumeUpProcess.running = true
    }

    function volumeDown() {
        volumeDownProcess.running = true
    }

    function volumeMute() {
        volumeMuteProcess.running = true
    }

}
