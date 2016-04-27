<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- Confirmation that a password has been reset. -->

<#assign subject = "您的 ${siteName} 密码更改成功." />

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
            <strong>您的密码更改成功.</strong>
        </p>

        <p>
            您邮箱帐号${userAccount.emailAddress}对应的密码更改成功.
        </p>

        <p>
            谢谢.
        </p>
    </body>
</html>
</#assign>

<#assign text>
${userAccount.firstName} ${userAccount.lastName}

您的密码更改成功。

您邮箱帐号${userAccount.emailAddress}对应的密码更改成功.

谢谢.
</#assign>

<@email subject=subject html=html text=text />
