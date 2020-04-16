<div>
    <form action="logins" method="post" onsubmit="return check();">
        <div class="accountPassword">
            <div class="account">
                <img src="images/account.png" alt="账号logo" class="accountLogo">
                <input class="accountInput userName test" placeholder="请输入用户名" autofocus="autofocus" value="${(userName)!''}" type="text" name="userName">
            </div>
            <div class="passwords">
                <img src="images/password.png" alt="密码logo" class="passwordLogo">
                <input class="passwordInput password test" placeholder="请输入登录密码" value="" type="password" name="password">
            </div>
            <div class="verificationCode">
                <img src="images/verificationCode.png" alt="验证码logo" class="verificationCodeLogo">
                <input name="code" class="verificationCodeInput code test" placeholder="请输入验证码" type="text">
                <img class="thisimg verificationCodeImg" onclick="this.src='captcha?r'+Date.now()" src="captcha" alt="验证码">
            </div>
        </div>
        <button class="submit" type="submit">登 录</button>
    </form>
</div>