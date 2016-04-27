<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- Confirmation email for user account password reset -->

<#assign subject = "${siteName} 密码重置请求" />

<#assign html>
<html>
    <head>
        <title>${subject}</title>
    </head>
    <body>
        <p>
            尊敬的 ${userAccount.firstName} ${userAccount.lastName}:
        </p>
        
        <p>
            我们最近收到了网站 ${siteName} 上面的帐号 (${userAccount.emailAddress})的密码重置请求. 
        </p>
        
        <p>
            请根据下面的步骤进行您的密码重置.
        </p>
        
        <p>
            如果您没有进行过这项请求，请直接安全的忽视它。
            该请求将在30天内过期。
        </p>
        
        <p>
            直接点击链接，或者将链接拷贝到您的浏览器地址栏进行访问
        </p>
        
        <p>${passwordLink}</p>
        
        <p>谢谢!</p>
    </body>
</html>
</#assign>

<#assign text>
尊敬的 ${userAccount.firstName} ${userAccount.lastName}:
        
我们最近收到了网站 ${siteName} 上面的帐号 (${userAccount.emailAddress})的密码重置请求. 

请根据下面的步骤进行您的密码重置.

如果您没有进行过这项请求，请直接安全的忽视它。
该请求将在30天内过期。

直接点击链接，或者将链接拷贝到您的浏览器地址栏进行访问

${passwordLink}
        
谢谢!
</#assign>

<@email subject=subject html=html text=text />
