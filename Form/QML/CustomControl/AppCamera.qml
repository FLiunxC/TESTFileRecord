import QtQuick 2.0
import QtMultimedia 5.8
import QtQuick.Window 2.2
Rectangle {
    implicitWidth: Screen.desktopAvailableWidth
    implicitHeight: Screen.desktopAvailableHeight
    focus: true
    Camera {
        id: camera

        captureMode: Camera.CaptureStillImage;//捕获静态图像
        focus{
            focusMode:Camera.FocusAuto;//自动变焦
            focusPointMode: Camera.FocusPointCenter;//中心焦点
        }
        imageProcessing{
            whiteBalanceMode:CameraImageProcessing.WhiteBalanceAuto;//白平衡自动
        }

        flash.mode:Camera.FlashAuto;//闪光灯自动

        imageCapture {
            onImageCaptured: {
                console.info("进来---")
                camera.stop();
                photoPreview.source = preview  // Show the preview in an Image
            }
        }
    }


    VideoOutput {
        id: viewfinder
        visible: true

        x: 0
        y: 0
        anchors.fill: parent

        source: camera
        autoOrientation: true
        fillMode: VideoOutput.Stretch
        z:2
    }

    Image {
        id: photoPreview
        width: parent.width/2
        height: parent.height/2
        anchors.centerIn: parent
    }


    Keys.onPressed:
    {
        console.info("当前输入的键值 = ",event.key)

        switch(event.key)
        {
        case Qt.Key_Escape:
            console.info("Escap")
            break
        case Qt.Key_Left:
            console.info("Left")
            break
        case Qt.Key_Right:
            console.info("Right")
            break
        case 33554431:
            var keyValue = event.key
            camera.imageCapture.capture();
        //    console.info("按键键值16进制= ",keyValue.toString(10))
            break;
        }
    }

    Keys.onBackPressed:
    {
        console.info("返回点击")
    }
}
