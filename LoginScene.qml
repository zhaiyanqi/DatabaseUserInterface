import QtQuick 2.9
import QtQuick.Controls 1.4
Item {

    Rectangle{
        anchors.fill: parent;
        color: "#464646"
        radius: 8
    }
    Column{
        spacing: 10
        anchors.centerIn: parent;
        Button{
            id:adminButton
            text: qsTr("管理员登陆");
            onClicked: {
                adminSceneLoader.source = "qrc:/AdminScene.qml";
            }
        }

        Button{
            text: qsTr("业务员登陆");
            onClicked: {
                salemanSceneLoader.source = "qrc:/SalemanScene.qml";
            }
        }
        Button{
            text:qsTr("退出")
            width: adminButton.width
            onClicked: {
                Qt.quit();
            }
        }
    }
}
