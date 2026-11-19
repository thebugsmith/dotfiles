import QtQuick
import Quickshell

FloatingWindow {
    id: window
    title: "WallpaperPicker"
    width: 1920
    height: 500
    color: "transparent"
    visible: true
    
    WallpaperPicker {
        anchors.fill: parent
    }

    Shortcut {
        sequence: "Escape"
        onActivated: Qt.quit()
    }
}