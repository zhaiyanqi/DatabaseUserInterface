import QtQuick 2.9
import QtQuick.Controls 1.4

Item {
    property var list: []
    Rectangle{
        anchors.fill: parent;
        color: "#4b4b4b"
        radius: 12
    }
    Button{
        id:returnButton
        text:"返回";
        anchors.right: parent.right
        anchors.top:parent.top
        onClicked: {
            adminSceneLoader.source = "qrc:/AdminScene.qml";
        }
    }

    Row {
        id:titleLabel
        spacing: 10
        Label {
            text: "编号"
            font.family: xinweiFont.name
            font.pixelSize: 20;
            color: "white"
        }
        Label {
            text: "运营商名称"
            font.family: xinweiFont.name
            font.pixelSize: 20;
            color: "white"
        }
        Label {
            text: "手续费比例"
            font.family: xinweiFont.name
            font.pixelSize: 20;
            color: "white"
        }
        Label {
            text: qsTr("选项")
            font.family: xinweiFont.name
            font.pixelSize: 18;
            color: "white"
        }
    }
    ListView {
        width: 600
        height: 600
        //anchors.horizontalCenter: parent.horizontalCenter
        //anchors.fill: parent
        anchors.top:titleLabel.bottom
        anchors.topMargin: 10
        //anchors.centerIn: parent;
        model: list.length / 3
        delegate: Row {
            spacing: 10
            Label {
                text: list[index * 3] + ""
                font.family: xinweiFont.name
                font.pixelSize: 20;
                color: "white"

            }
            Label {
                text: list[index * 3 + 1] + ""
                font.family: xinweiFont.name
                font.pixelSize: 20;
                color: "white"
            }
            Label {
                text: list[index * 3 + 2] + ""
                font.family: xinweiFont.name
                font.pixelSize: 20;
                color: "white"
            }
            Label {
                text: qsTr("修改信息")
                font.family: xinweiFont.name
                font.pixelSize: 18;
                color: "steelblue"
                MouseArea{
                    anchors.fill: parent;
                    onClicked: {
                        textFieldLoader.sourceComponent = changeInfoBar;
                        textFieldLoader.item.id_ =  list[index * 3] + "";
                        textFieldLoader.item.name_ =  list[index * 3 + 1] + "";
                        textFieldLoader.item.rate_ = list[index * 3 + 2] + ""
                    }
                }
            }
        }
    }
    Loader{
        id:textFieldLoader
        anchors.centerIn: parent;
        z:100
    }
    Component{
        id:changeInfoBar
        Item{
            width: 650
            height: 50
            property int id_: 1
            property string name_: "value"
            property double rate_: 0.01
            anchors.centerIn: parent;
            focus: true;
            Rectangle{
                anchors.fill: parent;
                color: "lightblue"
                radius: 12;
                MouseArea{
                    anchors.fill:parent
                }
            }
            Row{
                anchors.centerIn: parent;
                spacing: 10
                Label {
                    id:changeInfoBar_id
                    text: id_+""
                    font.family: xinweiFont.name
                    font.pixelSize: 22;
                    //color: "white"

                }
                TextField {
                    id:changeInfoBar_name
                    placeholderText: name_
                    font.family: xinweiFont.name
                    font.pixelSize: 20;
                }
                TextField {
                    id:changeInfoBar_rate
                    placeholderText: rate_+""
                    font.family: xinweiFont.name
                    font.pixelSize: 20;
                }
                Label {
                    id:changeInfoBar_confirm
                    text: qsTr("确认")
                    font.family: xinweiFont.name
                    font.pixelSize: 18;
                    color: "steelblue"
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: {
                            var str = id_+",'"+changeInfoBar_name.getText(0,20).trim()+"',"
                            +changeInfoBar_rate.getText(0,4).trim();
                            console.log(str);
                            str = "call change_sim_info("+str+")";
                            var result = Database.exec(str);
                            if(result) {
                                textFieldLoader.sourceComponent = null;
                                list = Database.allSIM();

                            }
                            else{
                                changeInfoBar_confirm.text = "输入有误";
                                changeInfoBar_confirm.color = "red";
                            }
                        }
                    }
                }
                Label {
                    text: qsTr("取消")
                    font.family: xinweiFont.name
                    font.pixelSize: 18;
                    color: "steelblue"
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: {
                            textFieldLoader.sourceComponent = null;
                        }
                    }
                }
            }
        }
    }
}
