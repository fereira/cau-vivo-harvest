<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- Confirmation that the user has changed his email account. -->

<#assign subject = "您的 ${siteName} 邮箱已经改变。" />

<#assign html>
<html>
    <head>
        <title>${subject}</title>
    </head>
    <body>
        <p>
            您好, ${userAccount.firstName} ${userAccount.lastName}
        </p>

        <p>
            您最近改变了和 
            ${userAccount.firstName} ${userAccount.lastName}绑定在一起的邮箱地址。
        </p>

        <p>
            谢谢.
        </p>
    </body>
</html>
</#assign>

<#assign text>
您好, ${userAccount.firstName} ${userAccount.lastName}，

您最近改变了和
${userAccount.firstName} ${userAccount.lastName}绑定在一起的邮箱地址。

 谢谢。
</#assign>

<@email subject=subject html=html text=text />
