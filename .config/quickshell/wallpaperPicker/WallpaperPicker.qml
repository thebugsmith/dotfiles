import QtQuick
import QtQuick.Controls
import Qt.labs.folderlistmodel
import Quickshell

Item {
    id: root

    readonly property string baseDir: Quickshell.env("HOME") + "/Pictures/Wallpapers"
    readonly property var transitions: ["grow", "outer", "any", "wipe", "wave", "pixel", "center"]

    property int loadedDirCount: 0
    property int totalDirCount: 0

    function setWallpaper(filePath) {
        const randomTransition = transitions[Math.floor(Math.random() * transitions.length)]
        const cmd = "awww img '" + filePath + "' --transition-type " + randomTransition +
                    " --transition-pos 0.5,0.5 --transition-fps 144 --transition-duration 1"
        Quickshell.execDetached(["bash", "-c", cmd])
    }

    ListModel {
        id: combinedModel
    }

    FolderListModel {
        id: dirLister
        folder: "file://" + baseDir
        showDirs: true
        showDotAndDotDot: false
        nameFilters: []

        onStatusChanged: {
            if (status === FolderListModel.Ready) {
                root.totalDirCount = count
                for (let i = 0; i < count; i++) {
                    const dirName = get(i, "fileName")
                    loadWallpapersFromDir(dirName)
                }
            }
        }
    }

    Component {
        id: folderModelComponent

        FolderListModel {
            nameFilters: ["*.jpg", "*.jpeg", "*.png", "*.webp"]
            showDirs: false
            sortField: FolderListModel.Name

            onStatusChanged: {
                if (status === FolderListModel.Ready) {
                    const dirName = folder.toString().split('/').pop()
                    for (let i = 0; i < count; i++) {
                        combinedModel.append({
                            fileName: get(i, "fileName"),
                            fileUrl: get(i, "fileUrl"),
                            dirName: dirName
                        })
                    }
                    root.loadedDirCount++
                    if (root.loadedDirCount === root.totalDirCount) {
                        view.currentIndex = Math.min(3, combinedModel.count - 1)
                        view.positionViewAtIndex(view.currentIndex, ListView.Center)
                    }
                }
            }
        }
    }

    function loadWallpapersFromDir(dirName) {
        folderModelComponent.createObject(root, {
            folder: "file://" + baseDir + "/" + dirName
        })
    }

    Component.onCompleted: {
        view.forceActiveFocus()
    }

    ListView {
        id: view
        anchors.fill: parent
        orientation: ListView.Horizontal
        spacing: 0
        clip: true
        cacheBuffer: 500

        highlightRangeMode: ListView.StrictlyEnforceRange
        preferredHighlightBegin: (width / 2) - (centerItemWidth / 2)
        preferredHighlightEnd: (width / 2) + (centerItemWidth / 2)
        highlightMoveDuration: 300

        focus: true

        Keys.onLeftPressed: view.decrementCurrentIndex()
        Keys.onRightPressed: view.incrementCurrentIndex()
        Keys.onPressed: (event) => {
            if (event.key === Qt.Key_H) view.decrementCurrentIndex()
            if (event.key === Qt.Key_L) view.incrementCurrentIndex()
            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                const item = combinedModel.get(view.currentIndex)
                const currentFile = root.baseDir + "/" + item.dirName + "/" + item.fileName
                root.setWallpaper(currentFile)
            }
        }

        readonly property int centerItemWidth: 480
        readonly property int centerItemHeight: 270

        model: combinedModel

        delegate: Item {
            id: delegateRoot

            readonly property bool isCurrent: ListView.isCurrentItem
            readonly property int distanceFromCenter: index - view.currentIndex
            readonly property real absDist: Math.abs(distanceFromCenter)

            width: isCurrent ? view.centerItemWidth : Math.max(60, view.centerItemWidth * Math.pow(0.72, absDist))
            height: view.height

            Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }

            Item {
                width: delegateRoot.width
                height: delegateRoot.isCurrent ? view.centerItemHeight : view.centerItemHeight * Math.pow(0.85, delegateRoot.absDist)
                anchors.verticalCenter: parent.verticalCenter

                Behavior on height { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }

                Rectangle {
                    visible: delegateRoot.isCurrent
                    anchors.fill: parent
                    anchors.margins: -3
                    color: "transparent"
                    border.color: "white"
                    border.width: 3
                    z: 2
                }

                Image {
                    id: img
                    anchors.fill: parent
                    source: fileUrl
                    fillMode: Image.PreserveAspectCrop
                    asynchronous: true
                    sourceSize: Qt.size(480, 270)
                    opacity: Math.max(0.2, 1.0 - delegateRoot.absDist * 0.25)
                    Behavior on opacity { NumberAnimation { duration: 300 } }
                }

                Rectangle {
                    anchors.fill: parent
                    color: "#333"
                    visible: img.status !== Image.Ready
                    opacity: img.opacity
                    Text {
                        anchors.centerIn: parent
                        color: "#888"
                        text: img.status === Image.Error ? "✕" : "..."
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (delegateRoot.isCurrent) {
                            const item = combinedModel.get(index)
                            const currentFile = root.baseDir + "/" + item.dirName + "/" + item.fileName
                            root.setWallpaper(currentFile)
                        } else {
                            view.currentIndex = index
                        }
                    }
                }
            }
        }

        ScrollBar.horizontal: ScrollBar { policy: ScrollBar.AlwaysOff }
    }
}
