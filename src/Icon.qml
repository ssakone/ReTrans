import QtQuick 2.0

Text {
    id:control
    property string icon: ""
    FontLoader {
        id: font2
        source: "material2.ttf"
    }
    font.family: font2.name
    text:icon
}
