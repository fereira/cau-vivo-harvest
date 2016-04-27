<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- Confirmation that an account has been created. -->

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
            我们已经为您创建了VIVO帐号，和邮箱 ${userAccount.emailAddress}绑定在一起.
        </p>

        <p>
            多谢!
        </p>
    </body>
</html>
</#assign>

<#assign text>
${userAccount.firstName} ${userAccount.lastName}

多谢!

我们已经为您创建了VIVO帐号，和邮箱${userAccount.emailAddress}绑定在一起.

多谢!
</#assign>

<@email subject=subject html=html text=text />
