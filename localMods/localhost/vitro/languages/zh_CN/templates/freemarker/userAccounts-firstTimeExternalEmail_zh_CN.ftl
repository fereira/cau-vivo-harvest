<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- Confirmation that an account has been created for an externally-authenticated user. -->

<#assign subject = "您的 ${siteName} 帐号已经创建成功." />

<#assign html>
<html>
    <head>
        <title>${subject}</title>
    </head>
    <body>
        <p>
            ${userAccount.firstName} ${userAccount.lastName}
        </p>

        <p>
            <strong>恭喜您!</strong>
        </p>

        <p>
            我们已经为您创建了和邮箱${userAccount.emailAddress}绑定在一起的VIVO帐号.
        </p>

        <p>
            谢谢!
        </p>
    </body>
</html>
</#assign>

<#assign text>
${userAccount.firstName} ${userAccount.lastName}

恭喜您!

我们已经为您创建了和邮箱${userAccount.emailAddress}绑定在一起的VIVO帐号.

谢谢！
</#assign>

<@email subject=subject html=html text=text />
