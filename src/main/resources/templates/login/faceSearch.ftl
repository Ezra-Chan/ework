<div>
    <video id="video" width="350px" height="300px" autoplay class="faceVideo"></video>
    <canvas id="canvas" width="350px" height="300px" class="faceCanvas"></canvas>
    <button class="submit" onclick="query()">点击识别</button>
</div>

<script type="text/javascript">
    //获取摄像头对象
    canvas = document.getElementById("canvas");
    context = canvas.getContext("2d");
    //获取视频流
    video = document.getElementById("video");
    var videoObj = {
        "video" : true
    }, errBack = function(error) {
        console.log("Video capture error: ", error.code);
    };
    //初始化摄像头参数
    if (navigator.getUserMedia || navigator.webkitGetUserMedia
        || navigator.mozGetUserMedia) {
        navigator.getUserMedia = navigator.getUserMedia
            || navigator.webkitGetUserMedia
            || navigator.mozGetUserMedia;
        navigator.getUserMedia(videoObj, function(stream) {
            video.srcObject = stream;
            video.play();
        }, errBack);
    }


    //获取人脸照片的base64，用于发送给后台进行识别
    function getBase64() {
        var imgSrc = document.getElementById("canvas").toDataURL("image/png");
        return imgSrc.split("base64,")[1];
    };


    //发送人脸识别的请求
    function query(){
        context.drawImage(video,0,0,300,300);//把流媒体数据画到canvas画布上
        var base = getBase64();
        $.ajax({
            url:'/faceAjax',
            type:'post',
            datatype:'json',
            data:{'base':base},
            success:function(resp){
                if(resp===0) {
                    alert("识别失败！");
                }else if (resp===-1) {
                    alert("请勿使用照片进行识别！");
                }else if (resp===-2) {
                    alert("匹配度不高，请正对摄像头再识别一次！");
                }else if (resp===-3) {
                    alert("人脸信息未注册，请使用账号登录!");
                }else{
                    window.location.href = "/faceLogin";
                }
            },
            error:function(resp){
                alert("未识别到人脸，请正对摄像头！");
            }
        });
    }
</script>
</body>
</html>
