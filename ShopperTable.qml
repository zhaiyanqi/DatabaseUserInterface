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
            text: "商户名称"
            font.family: xinweiFont.name
            font.pixelSize: 20;
            color: "white"
        }
        Label {
            text: "保证金余额"
            font.family: xinweiFont.name
            font.pixelSize: 20;
            color: "white"
        }
        Label {
            text: qsTr("添加商户")
            font.family: xinweiFont.name
            font.pixelSize: 18;
            color: "red"
            MouseArea{
                anchors.fill: parent;
                onClicked: {
                    textFieldLoader.sourceComponent = addInfoBar;
                }
            }
        }

    }
    ListView {
        width: 600
        height: 600
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
            Label {
                text: qsTr("删除商户")
                font.family: xinweiFont.name
                font.pixelSize: 18;
                color: "steelblue"
                MouseArea{
                    anchors.fill: parent;
                    onClicked: {
                        var str = list[index * 3] + "";
                        str = "call del_shopper("+str+")";
                        console.log(str);
                        var result = Database.exec(str);
                        if(result){
                            list = Database.allShopper();
                        }
                        else{
                            console.log("sss")
                        }
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
        id:addInfoBar
        Item{
            width: 650
            height: 50
            property int id_: 2000
            property string name_: "value"
            property double securitymoney_: 1000
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
                TextField {
                    id:addInfoBar_id
                    placeholderText: id_
                    font.family: xinweiFont.name
                    font.pixelSize: 20;
                }
                TextField {
                    id:addInfoBar_name
                    placeholderText: name_
                    font.family: xinweiFont.name
                    font.pixelSize: 20;
                }
                TextField {
                    id:addInfoBar_securitymoney
                    placeholderText: securitymoney_+""
                    font.family: xinweiFont.name
                    font.pixelSize: 20;
                }
                Label {
                    id:addInfoBar_confirm
                    text: qsTr("确认")
                    font.family: xinweiFont.name
                    font.pixelSize: 18;
                    color: "steelblue"
                    MouseArea{
                        anchors.fill: parent;
                        onClicked: {
                            var str = addInfoBar_id.getText(0,5).trim()+",'"
                                    +addInfoBar_name.getText(0,20).trim()+"',"
                                    +addInfoBar_securitymoney.getText(0,8).trim();
                            console.log(str);
                            str = "call add_shopper("+str+")";
                            Database.exec(str);
                            textFieldLoader.sourceComponent = null;
                            list = Database.allShopper();
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
                            +changeInfoBar_rate.getText(0,8).trim();
                            console.log(str);
                            str = "call update_shopper("+str+")";
                            var result = Database.exec(str);
                            if(result) {
                                textFieldLoader.sourceComponent = null;
                                list = Database.allShopper();

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
