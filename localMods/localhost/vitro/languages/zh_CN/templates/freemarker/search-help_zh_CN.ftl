<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#if origination?has_content && origination == "helpLink">
    <h2>搜索提示</h2>
    <span id="searchHelp">
        <a href="#" onClick="history.back();return false;" title="back to results">返回结果</a>
    </span>
<#else>
    <h3>搜索提示</h3>        
</#if>
<ul class="searchTips">
    <li>保持简洁! 除非您的搜索返回大量的结果，否则的话，尽量保持简短，独立的词.</li>
    <li>采用双引号来搜索整个短语 -- 比如., "<i>protein folding</i>".</li>
    <li>除了布尔操作以外, 搜索是 <strong>不</strong> 区分大小写的, 因此 "Geneva" 和 "geneva" 相同的搜索结果</li>
    <li>如果您无法确定输入的是否是正确的拼写, 可以在输入的词后面加上～ -- 比如, <i>cabage~</i> 可以匹配到 <i>cabbage</i>, <i>steven~</i> 可以匹配到 <i>Stephen</i> 和 <i>Stefan</i> (其余类似).</li>
</ul>
    
<h4><a id="advTipsLink" href="#">高级提示</a></h4>    
<ul id="advanced" class="searchTips" style="visibility:hidden">
    <li>当您输入多个词时, 搜索的结果会返回包含所有词的结果，除非您在词之间加入 "OR" -- 例如, <i>鸡</i> OR <i>蛋</i>.</li>
    <li>NOT 可以用来过滤搜索结果 -- 比如, <i>climate</i> NOT <i>change</i>.</li>
    <li>短语也可以用来进行布尔操作 -- 比如 "<i>climate change</i>" OR "<i>global warming</i>".</li>
    <li>词的基本形态也可以匹配各种扩展形势 -- 比如, <i>sequence</i> 可以匹配 <i>sequences</i> 和 <i>sequencing</i>.</li>
    <li>使用*来匹配更加广泛的形式 -- 比如, <i>nano*</i> 可以匹配 <i>nanotechnology</i> 和 <i>nanofabrication</i>.</li>
    <li>搜索时，采用词的最简短形式 -- 比如, 用 <i>cogniti*</i> 查找不到结果, 但是用 <i>cognit*</i> 可以找到 <i>cognitive</i> 和 <i>cognition</i>.</li> 
</ul>
<a id="closeLink" href="#"  style="visibility:hidden;font-size:.825em;padding-left:8px">Close</a>
${stylesheets.add('<link rel="stylesheet" href="${urls.base}/css/search.css" />')}
<script type="text/javascript">
    $(document).ready(function(){
        $('a#advTipsLink').click(function() {
           $('ul#advanced').css("visibility","visible"); 
           $('a#closeLink').css("visibility","visible");
           $('a#closeLink').click(function() {
              $('ul#advanced').css("visibility","hidden"); 
              $('a#closeLink').css("visibility","hidden");
           });

        });
    });
    
</script>