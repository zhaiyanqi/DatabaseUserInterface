import QtQuick 2.9
import QtQuick.Controls 1.4

Item{
    width:960
    height: 640
    id:root;
    Loader{
        id:adminSceneLoader
        anchors.fill: root;
        source: ""
        focus: true
    }
    Loader{
        id:salemanSceneLoader
        anchors.fill: root;
        source: ""
        focus: true;
    }
    Loader{
        id:loginSecene
        anchors.fill: root
        visible: adminSceneLoader.source == ""&&salemanSceneLoader.source== "";
    }

    FontLoader{
        id:xinweiFont
        source: "qrc:/xinwei.ttf"
    }
    Component.onCompleted: {
        loginSecene.setSource("qrc:/LoginScene.qml");

    }
}
