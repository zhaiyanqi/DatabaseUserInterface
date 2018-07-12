import QtQuick 2.9
import QtQml 2.2

import QtQuick.Controls 1.4

Item{
    width:960
    height: 640
    id:adminScene
    property string currentTime: (new Date()).toLocaleString();
    Timer {
        interval: 500; running: true; repeat: true
        onTriggered: currentTime = (new Date()).toLocaleString();
    }
    Rectangle{
        color: "#464646"
        anchors.fill: parent;
    }
    Button{
        anchors.right: parent.right
        anchors.top:parent.top
        text:qsTr("退出系统")
        onClicked: {
            adminSceneLoader.source = "";
        }
    }
    Row{
        id:timeTitle;
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 5
        Label{
            id:topLine
            text:qsTr("当前用户为 管理员 ,当前时间:") + currentTime;
            font.family: xinweiFont.name
            font.pixelSize: 20
            color: "steelblue"
        }
    }

    Component.onCompleted: {
        if(!Database.connectToDatabase()) topLine.text = "登陆失败！"
    }

    //
    Grid{
        spacing: 10
        anchors.top:timeTitle.bottom
        anchors.topMargin: 10;
        Button{
            text:qsTr("运营商管理")
            onClicked: {
                adminSceneLoader.source = "qrc:/SIMScene.qml";
                var list = Database.allSIM();
                adminSceneLoader.item.list = list;
            }
        }
        Button{
            text:qsTr("加盟商户管理")
            onClicked: {
                adminSceneLoader.source = "qrc:/ShopperTable.qml";
                var list = Database.allShopper();
                adminSceneLoader.item.list = list;
            }
        }
        Button{
            text:qsTr("查询和报表")
            onClicked: {

            }
        }
    }
}
