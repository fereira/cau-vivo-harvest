<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- Confirmation that an password has been created. -->

<#assign subject = "您的 ${siteName} 密码已经创建成功." />

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
            <strong>密码创建成功.</strong>
        </p>

        <p>
            您邮箱${userAccount.emailAddress}对应的密码创建成功.
        </p>

        <p>
            谢谢.
        </p>
    </body>
</html>
</#assign>

<#assign text>
${userAccount.firstName} ${userAccount.lastName}

密码创建成功.

您的邮箱 ${userAccount.emailAddress}对应的密码创建成功.

谢谢.
</#assign>

<@email subject=subject html=html text=text />
