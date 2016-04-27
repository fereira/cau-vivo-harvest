<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- Confirmation that an account has been created. -->

<#assign subject = "您的 ${siteName} 帐号已经建立" />

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
            <strong>恭喜您！</strong>
        </p>

        <p>
            我们已经在${siteName}上面为您创建了网站, 和邮箱${userAccount.emailAddress}绑定在一起.
        </p>

        <p>
            如果您没有进行过新帐号的请求，可以直接安全的忽视该邮件。
            邮件将在30天后过期。
        </p>

        <p>
            点击下面的连接，通过我们的安全服务器为您的新建帐号创建密码。
        </p>

        <p>
            <a href="${passwordLink}" title="password">${passwordLink}</a>
        </p>

        <p>
            如果上面的链接点击无效，可以直接把链接拷贝到浏览器的地址栏进行访问。
        </p>

        <p>
            多谢!
        </p>
    </body>
</html>
</#assign>

<#assign text>
${userAccount.firstName} ${userAccount.lastName}

恭喜您!

我们已经在 ${siteName}上面为您创建了帐号,
和邮箱 ${userAccount.emailAddress} 绑定在一起.

如果您没有进行过新帐号的请求，可以直接安全的忽视该邮件。
邮件将在30天后过期。

通过我们的安全服务器，拷贝下面的链接到浏览器的地址栏进行访问：
${passwordLink}

多谢!
</#assign>

<@email subject=subject html=html text=text />
