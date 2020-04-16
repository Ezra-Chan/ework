<style type="text/css">
    .btn_login {
        background-color: #82b2c9;
        border: none;
        padding: 10px;
        width: 200px;
        border-radius:10px;
        box-shadow: 1px 5px 20px -5px rgba(0,0,0,0.4);
        color: #fff;
        cursor: pointer;
        font-size: 20px;
        margin: 0 0 20px 50px;
    }
</style>
<div class="modal fade" id="uploadFace" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content" style="width: 302px;">
            <div class="modal-header">
                <button type="button" class="modalclose close" data-dismiss="modal"
                        aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">上传人脸信息</h4>
            </div>
            <video id="video" width="300px" height="300px" autoplay></video>
            <canvas id="canvas" width="300px" height="300px" style="display: none;"></canvas>
            <button class="btn_login btn" onclick="add()">上传</button>
        </div>
    </div>
</div>
<script type="text/javascript">
    var video = document.getElementById("video");
    var context = canvas.getContext("2d");
    var con  ={
        audio:false,
        video:{
            width:1980,
            height:1024,
        }
    };
    navigator.mediaDevices.getUserMedia(con).then(function(stream){
        video.srcObject = stream;
        video.onloadmetadate = function(e){
            video.play();
        }
    });

    //获取人脸照片的base64，用于发送给后台进行识别
    function getBase64() {
        var imgSrc = document.getElementById("canvas").toDataURL("image/png");
        return imgSrc.split("base64,")[1];
    };

    function add() {
        context.drawImage(video,0,0,300,300);//把流媒体数据画到convas画布上
        var base = getBase64();
        $.ajax({
            url:"/uploadFace",
            type:'post',
            datatype:'json',
            data:{'base':base},
            success:function(resp){
                if (resp !== 0) {
                    alert("上传成功");
                    window.location.reload();
                } else {
                    alert("上传失败！请重新上传！");
                }
            }
        });
    }
</script>