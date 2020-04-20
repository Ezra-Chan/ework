<!--把最顶上左侧的logo，栅格系统分2份-->
<div class="col-lg-2 col-md-2 smallDiv" style="padding: 0; margin: 0; display: block;">
    <div class="col-md-12 green-g">
        <a href="index" class="navbar-brand" style="padding: 5px 0;">
            <img src="images/logo.png" class="smallLogo" />
            <div class="logoName">e-work</div>
        </a>
    </div>
    <div class="col-md-12 list-left" style="background: #222d32; height: 845px">
        <div class="user-panel">
            <div class="pull-left">
                <img src="/image/${(user.imgPath)!'/timg.jpg'}" class="img-circle user-image-left" />
            </div>
            <div class="pull-left info">
                <p style="color: #fff; line-height: 1.5;">
                    <span>${user.userName}</span>
                    <br>
                    <small>
                        <span class="glyphicon glyphicon-record" style="color: #00a65a;"></span> 在线
                    </small>
                </p>
            </div>
        </div>
        <div class="thistable">
            <#include "/common/leftlists.ftl">
        </div>
    </div>
</div>