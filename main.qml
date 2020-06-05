import QtQuick 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.4



Window {
    visible: true
    width: 1000
    height: 480
    title: qsTr("Login")

    color: "transparent"
    property bool isEmailValid: false
    property bool isEmailGreen: false
    property bool isEmailGrey: true
    property bool isPasswordGreen: false
    property bool isPasswordGrey: true
    property bool isEmailError: false
    property bool isPasswordError: false


    MouseArea
    {
        anchors.fill: parent
        onClicked:
        {
            isEmailGreen = false
            isEmailGrey = true
            isPasswordGreen = false
            isPasswordGrey = true
            console.log("window area clicked")
        }
    }

    Rectangle
    {
        id: root

        anchors.fill: parent

        LinearGradient
        {
            anchors.fill: parent
            start: Qt.point(0,0)
            end: Qt.point(300,0)

            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "#3240a8"
                }
                GradientStop {
                    position: 1.0
                    color: "#8132a8"
                }
            }
        }

        Rectangle
        {
            id: loginRect

            anchors.fill: parent
            anchors.topMargin: 15
            anchors.bottomMargin: 15
            anchors.leftMargin: 100
            anchors.rightMargin: 100
            radius: 10

            Row
            {
                id: grid

                width: parent.width
                height: parent.height
                anchors.centerIn: parent

                spacing: 100

                //Left side Image
                Rectangle
                {
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height*(2/3)
                    width: parent.width/2

                    Image
                    {
                        id: img

                        width: parent.width*1.2/2
                        height: parent.height*1.2/2
                        anchors.centerIn: parent

                        source: "img-01.png"

                        states: [ "mouseIn", "mouseOut" ]
                        state: "mouseOut"

                        transitions: [
                            Transition {
                                from: "*"
                                to: "mouseIn"
                                NumberAnimation {
                                    target: img
                                    properties: "scale"
                                    from: 1
                                    to: 1.2
                                    duration: Animation.Infinite
                                    loops: 1
                                    easing.type: Easing.OutBounce
                                }
                            },
                            Transition {
                                from: "mouseIn"
                                to: "mouseOut"
                                NumberAnimation {
                                    target: img
                                    properties: "scale"
                                    from: 1.1
                                    to: 1
                                    duration: Animation.Infinite
                                    loops: 1
                                    easing.type: Easing.OutBounce
                                }
                            }
                        ]

                        MouseArea
                        {
                            anchors.fill: parent
                            hoverEnabled: true
                            onContainsMouseChanged:
                            {
                                img.state = containsMouse ? "mouseIn" : "mouseOut"
                            }
                        }
                    }
                }

                //Right side controls
                Rectangle
                {
                    height: parent.height*(2/3)
                    width: parent.width/2
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    Column
                    {
                        anchors.fill: parent

                        spacing: 20

                        //Title text
                        Text
                        {
                            id:labeltext

                            height: 20
                            width: parent.width/2
                            anchors.horizontalCenter: parent.horizontalCenter

                            text: "Member Login"
                            font.bold: true
                            font.pointSize: 18
                        }

                        Item
                        {
                            width: 1
                            height: 20
                        }
                        //Email Glow
                        RectangularGlow {
                            id: emailGlow
                            anchors.fill: emailRect
                            glowRadius: 40
                            spread: 0.2
                            color: "#9df57f"
                            cornerRadius: emailRect.radius + glowRadius
                            visible: false
                        }

                        //Email Rectangle
                        Rectangle
                        {
                            id: emailRect

                            width: parent.width*2/3
                            height: 50
                            radius: 25
                            anchors.horizontalCenter: parent.horizontalCenter

                            color: "#ebe8e1"

                            clip: true

                            Row
                            {
                                anchors.fill: parent

                                spacing: 5

                                Rectangle
                                {
                                    height: 15
                                    width: 10
                                    anchors.verticalCenter: parent.verticalCenter

                                    color: "#ebe8e1"
                                }

                                Rectangle
                                {
                                    height: 15
                                    width: 15
                                    anchors.verticalCenter: parent.verticalCenter

                                    color: "#ebe8e1"

                                    Image {
                                        id: emailIccon

                                        height: 15
                                        width: 15
                                        anchors.verticalCenter: parent.verticalCenter

                                        source: "EmailGreen.png"
                                        visible: isEmailGreen? true: false
                                    }
                                }

                                Rectangle
                                {
                                    height: 15
                                    width: 15
                                    anchors.verticalCenter: parent.verticalCenter

                                    color: "#ebe8e1"

                                    Image {
                                        id: emailIcon1

                                        height: 15
                                        width: 15
                                        anchors.verticalCenter: parent.verticalCenter

                                        source: "EmailGrey.png"
                                        visible: isEmailGrey? true: false
                                    }
                                }

                                TextField
                                {
                                    id: email

                                    height: parent.height
                                    width: parent.width * 2.8/4

                                    color: "grey"
                                    background:Rectangle {color: "#ebe8e1"; radius: 25}
                                    font.pixelSize: 12
                                    placeholderText: "Email"

                                    validator: RegExpValidator { regExp:/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/ }
                                    onTextChanged: acceptableInput? isEmailValid = true: isEmailValid = false
                                }
                                Rectangle
                                {
                                    id: emaildErrorRect

                                    width: 18
                                    height: 18
                                    anchors.verticalCenter: parent.verticalCenter

                                    color: "#ebe8e1"

                                    Image
                                    {
                                        id: emailError

                                        width: 15
                                        height: 15
                                        anchors.verticalCenter: parent.verticalCenter

                                        source: "error.png"
                                        visible: isEmailError? true : false

                                        MouseArea
                                        {
                                            id: emailErrorMouseArea
                                            anchors.fill: parent
                                            hoverEnabled: true
                                        }
                                    }
                                }

                                Rectangle
                                {
                                    id:toolTipEmail

                                    width: toolTipTextEmail.width + 30
                                    height: emailRect.height - 4
                                    anchors.verticalCenter: emailRect.verticalCenter
                                    anchors.right: emaildErrorRect.right

                                    border.color:"#bf160a"
                                    radius: 15

                                    Row{
                                        anchors.fill: parent

                                        spacing: 3

                                        Text {
                                            id: toolTipTextEmail

                                            anchors.verticalCenter: parent.verticalCenter
                                            leftPadding: 3

                                            font.pixelSize: 15
                                            color:"#bf160a"
                                            text: "Valid email is required:\n ex@abc.xyz"
                                        }
                                        Image
                                        {
                                            id: emailErrorToolTip

                                            width: 15
                                            height: 15
                                            anchors.verticalCenter: parent.verticalCenter

                                            source: "error.png"
                                        }
                                    }
                                    visible: emailErrorMouseArea.containsMouse || toolTipEmailMouseArea.containsMouse

                                    MouseArea
                                    {
                                        id: toolTipEmailMouseArea

                                        anchors.fill: parent
                                        hoverEnabled: true
                                    }
                                }

                            }
                            MouseArea
                            {
                                anchors.fill: parent
                                propagateComposedEvents: true

                                onClicked:
                                {
                                    emailGlowAnimation.start()
                                    isEmailGreen = true
                                    isEmailGrey = false

                                    isPasswordGreen = false
                                    isPasswordGrey = true
                                    email.focus = true

                                    isEmailError = false
                                    console.log("Clicked enable mouse")
                                }

                            }
                        }


                        RectangularGlow {
                            id: passwordGlow

                            anchors.fill: passwordRect

                            glowRadius: 40
                            spread: 0.2
                            color: "#9df57f"
                            cornerRadius: passwordRect.radius + glowRadius
                            visible: false
                        }
                        //password Rectangle
                        Rectangle
                        {
                            id: passwordRect

                            width: parent.width*2/3
                            height: 50
                            radius: 25
                            anchors.horizontalCenter: parent.horizontalCenter

                            color: "#ebe8e1"

                            clip: true

                            Row
                            {
                                anchors.fill: parent

                                spacing: 5

                                Rectangle
                                {
                                    height: 15
                                    width: 10
                                    anchors.verticalCenter: parent.verticalCenter

                                    color: "#ebe8e1"
                                }
                                Rectangle
                                {
                                    height: 15
                                    width: 15
                                    anchors.verticalCenter: parent.verticalCenter

                                    color: "#ebe8e1"

                                    Image {
                                        id: passwordIcon

                                        height: 15
                                        width: 15
                                        anchors.centerIn: parent

                                        source: "lockGreen.png"
                                        visible: isPasswordGreen? true: false
                                    }

                                }
                                Rectangle
                                {
                                    height: 15
                                    width: 15
                                    anchors.verticalCenter: parent.verticalCenter

                                    color: "#ebe8e1"

                                    Image {
                                        id: passwordIcon1

                                        height: 15
                                        width: 15
                                        anchors.centerIn: parent

                                        source: "lockGrey.png"
                                        visible: isPasswordGrey? true : false
                                    }

                                }
                                TextField
                                {
                                    id: password

                                    height: parent.height
                                    width: parent.width * 2.8/4

                                    color: "grey"
                                    background:Rectangle {color: "#ebe8e1"; radius: 25}
                                    placeholderText: "Password"
                                }

                                Rectangle
                                {
                                    id: passwordErrorRect

                                    width: 18
                                    height: 18
                                    anchors.verticalCenter: parent.verticalCenter

                                    color: "#ebe8e1"

                                    Image
                                    {
                                        id: passwordError

                                        width: 15
                                        height: 15
                                        anchors.verticalCenter: parent.verticalCenter

                                        source: "error.png"
                                        visible: isPasswordError? true : false

                                        /* ToolTip
                                        {
                                            anchors.centerIn: parent
                                            contentItem: Text
                                            {
                                               color:"#bf160a"
                                               text: "Password is required"

                                            }
                                            background: Rectangle
                                            {
                                                width: emailRect.width * 1/2
                                                border.color: "#bf160a"
                                                color: "transparent"
                                                radius: 15
                                            }
                                            visible: passwordErrorMouseArea.containsMouse
                                        }*/
                                        MouseArea
                                        {
                                            id: passwordErrorMouseArea

                                            anchors.fill: parent
                                            hoverEnabled: true
                                        }
                                    }
                                }

                                Rectangle
                                {
                                    id:toolTipPassword

                                    width: toolTipText.width + 30
                                    height: passwordRect.height*2/3
                                    radius: 15
                                    anchors.verticalCenter: passwordErrorRect.verticalCenter
                                    anchors.right: passwordErrorRect.right

                                    border.color:"#bf160a"

                                    Row
                                    {
                                        anchors.fill: parent

                                        Text {
                                            id: toolTipText

                                            anchors.verticalCenter: parent.verticalCenter
                                            leftPadding: 3

                                            font.pixelSize: 15
                                            color:"#bf160a"
                                            text: "Password is required"
                                        }
                                        Image
                                        {
                                            id: passwordErrorToolTip

                                            width: 15
                                            height: 15
                                            anchors.verticalCenter: parent.verticalCenter

                                            source: "error.png"
                                        }
                                    }
                                    visible: passwordErrorMouseArea.containsMouse || toolTipPasswordMouseArea.containsMouse

                                    MouseArea
                                    {
                                        id: toolTipPasswordMouseArea

                                        anchors.fill: parent
                                        hoverEnabled: true
                                    }
                                }
                            }

                            MouseArea
                            {
                                anchors.fill: parent
                                propagateComposedEvents: true
                                onClicked:
                                {
                                    passwordGlowAnimation.start()
                                    isEmailGreen = false
                                    isEmailGrey = true

                                    isPasswordGreen = true
                                    isPasswordGrey = false
                                    password.focus = true

                                    isPasswordError = false
                                }
                            }
                        }

                        Rectangle
                        {
                            id: loginButton

                            width: parent.width*2/3
                            height: 50
                            radius: 25
                            anchors.horizontalCenter: parent.horizontalCenter

                            color: "#32a852"

                            Text
                            {
                                anchors.centerIn: parent

                                text: "LOGIN"
                                color: "white"
                                font.bold: true
                            }

                            MouseArea
                            {
                                hoverEnabled: true
                                anchors.fill: parent
                                onClicked:
                                {
                                    if(password.length === 0)
                                    {
                                        isPasswordError = true
                                    }
                                    if(!isEmailValid)
                                    {
                                        isEmailError = true
                                    }
                                }
                                onEntered:
                                {
                                    loginButton.color = 'black'
                                }
                                onExited:
                                {
                                    loginButton.color = "#32a852"
                                }
                            }
                        }

                        Rectangle {
                            id: forgetPassword

                            height: 50
                            width: parent.width*2/3
                            radius: 25
                            anchors.horizontalCenter: parent.horizontalCenter

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: "Forgot Username / Password?"
                                color: "grey"
                            }

                        }
                    }
                }
            }

            SequentialAnimation
            {
                id:emailGlowAnimation
                PropertyAction {
                    target: emailGlow
                    property: "visible"
                    value: true
                }

                PauseAnimation {
                    duration: 500
                }
                PropertyAction {
                    target: emailGlow
                    property: "visible"
                    value: false
                }
            }

            SequentialAnimation
            {
                id:passwordGlowAnimation
                PropertyAction {
                    target: passwordGlow
                    property: "visible"
                    value: true
                }

                PauseAnimation {
                    duration: 500
                }
                PropertyAction {
                    target: passwordGlow
                    property: "visible"
                    value: false
                }
            }
        }
    }
}
