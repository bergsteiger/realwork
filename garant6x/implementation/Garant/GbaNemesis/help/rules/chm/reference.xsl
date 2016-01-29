<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet 
 version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:msxsl="urn:schemas-microsoft-com:xslt" 
 exclude-result-prefixes="msxsl"
>

<xsl:import href="..//common//identity.xsl"/>

<xsl:output 
 method="xml"
 encoding="windows-1251"
 indent="yes"
/>

<xsl:variable name="allops" select="//operation"/>

<xsl:key name="opsKey" match="//operation" use="concat(current()/@m, '-', @key)"/>

<xsl:variable name="toolbarMain" select="msxsl:node-set($allops[@vcm_ooShowInMainToolbar and not(@id=preceding::operation/@id)])"/>


<xsl:template match="reference">
 <xsl:call-template name="summary">
  <xsl:with-param name="title" select="'Окна'"/>
  <xsl:with-param name="ann"   select="'Все окна, описанные в настоящей справочной системе. Порядок следования - алфавитный.'"/>
  <xsl:with-param name="element" select="'usertype'"/>
 </xsl:call-template>


 <xsl:call-template name="summary">
  <xsl:with-param name="title" select="'Элементы'"/>
  <xsl:with-param name="ann"   select="'Все элементы, описанные в настоящей справочной системе. Порядок следования - алфавитный.'"/>
  <xsl:with-param name="element" select="'entity'"/>
  <xsl:with-param name="visibility" select="'hide'"/>
 </xsl:call-template>


 <xsl:call-template name="summary">
  <xsl:with-param name="title" select="'Команды'"/>
  <xsl:with-param name="ann"   select="'Все команды, описанные в настоящей справочной системе. Порядок следования - алфавитный.'"/>
  <xsl:with-param name="element" select="'operation'"/>
  <xsl:with-param name="visibility" select="'hide'"/>
 </xsl:call-template>

 <xsl:call-template name="mmenu"/>

 <xsl:call-template name="summary">
  <xsl:with-param name="title" select="'Горячие клавиши'"/>
  <xsl:with-param name="ann"   select="'Горячие клавиши, используемые для быстрого вызова команд системы ГАРАНТ.'"/>
  <xsl:with-param name="element" select="'shortcut'"/>
 </xsl:call-template>

</xsl:template>

<xsl:template match="application">
 <xsl:copy-of select="."/>                            
</xsl:template>

<!--                    -->
<!--    Главное меню    -->
<!--                    -->

<xsl:key 
 name="mmenuKey"
 match="//operation[@vcm_ooShowInMainMenu and @operationtype!='vcm_otShortCut']"
 use="concat(@category, '-', @key)"
/>

<xsl:variable name="mmenu"         select="$allops[@vcm_ooShowInMainMenu and @operationtype!='vcm_otShortCut']"/>
<xsl:variable name="mmenuTitle"    select="$mmenu[generate-id(.)=generate-id(key('mmenuKey', concat(@category, '-', @key)))]"/>

<xsl:template name="mmenu">

 <topic title="Главное меню" id="reference-mmenu">
  <head>
   <link rel="stylesheet" type="text/css" href="mmenu.css"/>
   <script src="mmenu.js"/>
  </head>

  <text>                   

  <div class="container" onselectstart="return false">
   <div class="caption">
     <xsl:value-of select="/help/application/@title"/>&#160;

<!--     <xsl:value-of select="/help/application/@versionname"/>

 Здесь я изменил содержимое заголовка на синем фоне 
.<xsl:value-of select="/help/application/@versionminor"/>  -->

   </div>
   <div class="mmenu">

    <xsl:for-each select="/help/application/menu/menuitem">
     <a 
      class="mButton"
      onclick="return false"
      onmouseover="buttonMouseover('{generate-id()}')"
      href=""
     >
      <xsl:value-of select="@title"/>
     </a>
    </xsl:for-each>
   </div>

   <xsl:for-each select="/help/application/menu/menuitem">
    <div 
     id="{generate-id()}"
     class="menu"
     onmouseover="menuMouseover()"
    >
     <xsl:for-each select="$mmenuTitle[@category=current()/@title]">
       <xsl:sort select="@groupid" data-type="number"/>

       <xsl:if test="@groupid and position()>1 and not(@groupid mod 100)">
        <div class="mItemSep"></div>
       </xsl:if>

       <xsl:call-template name="mmenuItem"/>
     </xsl:for-each>
    </div>
   </xsl:for-each>
 
   <xsl:call-template name="toolbar">
    <xsl:with-param name="toolbar" select="$toolbarMain"/>
    <xsl:with-param name="style"   select="'toolbarGrayR'"/>
   </xsl:call-template>

  </div>

  <br/>

  <p>
   <sel>Главным меню</sel> называется выпадающее меню, 
   расположенное в верхней части окна программы. 
   Выше представлено интерактивное описание главного меню
   системы ГАРАНТ. Чтобы получить описание команды, 
   подведите курсор к нужному пункту меню и щелкните по 
   нему мышью.
  </p>

  <p>
   В зависимости от контекста работы одна и та же команда 
   меню может действовать по-разному. Например, команда 
   <sel>Удалить</sel> для списка выполнит удаление 
   выделенных элементов списка, а для папок - удаление 
   текущего элемента папок.
  </p>
  </text>
 </topic>


 <topic title="Главное меню (список)" id="reference-mmenu-list">
  <text>
  <p>
   Ниже показано 
   <hintn title="главное меню ">
    - выпадающее меню, расположенное в верхней части окна программы.  
   </hintn>
   системы в виде развернутого списка команд.
  </p>

   <xsl:for-each select="/help/application/menu/menuitem">
 
    <a name="#{generate-id(.)}"/>
    <h3><xsl:value-of select="@title"/></h3>

    <ul style="list-style:none;">
    <xsl:for-each select="$mmenuTitle[@category=current()/@title]">
     <xsl:sort select="@groupid" data-type="number"/>

     <xsl:if test="@groupid and position()>1 and not(@groupid mod 100)">
      <li style="margin:2px;">
       <hr style="width:50%;border:1px solid gray; margin:2px;"/>
      </li>
     </xsl:if>

     <li style="margin:2px;">
      <com id="{@key}" icon="tab"/>
      <kbd><xsl:value-of select="@shortcut"/></kbd>
     </li>

    </xsl:for-each>
    </ul>
   </xsl:for-each>

  </text>
 </topic>

</xsl:template>


<xsl:template name="mmenuItem">
 <xsl:variable name="ann" select="/help/descriptions/description[@id=current()/@key]/@ann"/>
 <a 
  menu="m-{generate-id()}"
  class="mItem" 
  href="page-{@key}.htm"
  title="{$ann}&#10;&#13;Нажмите, чтобы перейти к описанию этой команды"
 >

  <xsl:if test="@icon">
   <img src="icon/{@icon}" align="absmiddle"/>
  </xsl:if>
  <xsl:if test="not(@icon)">
   <img src="help/empty16px.gif" align="absmiddle"/>
  </xsl:if>

  <span class="mItemText">
   <xsl:value-of select="@title"/>
  </span>

<!-- 
  <xsl:if test="@operationtype='vcm_otCombo' or @operationtype='vcm_otButtonCombo' or @operationtype='vcm_otButtonPopUp'">
   <span class="mItemArrow">&#187;</span>
  </xsl:if>
-->
 </a>

</xsl:template>


<!--                 -->
<!-- UserType (Окно) -->
<!--                 -->

<xsl:template match="usertype">

 <xsl:variable name="toolbar" select="msxsl:node-set(../..//operation[@vcm_ooShowInChildToolbar and not(excludeusertypes/usertype/@id=current()/@id)][not(@id=preceding::operation[@f=current()/@f]/@id)])"/>

 <xsl:variable name="dsc" select="/help/descriptions/description[@id=current()/@key]"/>
 
 <topic title="{@title}" id="{@key}">

<!-- Согласно http://mdp.garant.ru/pages/viewpage.action?pageId=96483812&focusedCommentId=97354782#comment-97354782 -->
<!-- для топиков c атрибутом alias (preprocess.xsl) 							            -->
<!-- будет выполняться перенаправление на другие страницы (page.xsl),						    -->
<!-- а сами топики будут скрыты из оглавления (reference.xsl). 							    -->

  <xsl:if test="@alias">
   <xsl:attribute name="alias"><xsl:value-of select="@alias"/></xsl:attribute>
   <xsl:attribute name="cnt">hide</xsl:attribute>
  </xsl:if>

  <xsl:if test="@icon">
   <xsl:attribute name="icon">
    <xsl:value-of select="@icon"/>
   </xsl:attribute>
  </xsl:if>

  <kw name="{@title} (окно)"/>
  <text>

   <table class="description" cellspacing="0">
    <tr>
    <td nowrap="true" width="1%">
     Окно
    </td>
    <td width="1%">
     <xsl:choose>
      <xsl:when test="@icon">
       <img src="icon/{@icon}"/>
      </xsl:when>
      <xsl:otherwise>
       <img src="help/empty16px.gif"/>
      </xsl:otherwise>
     </xsl:choose>
    </td>
    <td width="*" nowrap="true">
     <sel><xsl:value-of select="@title"/></sel>
    </td>
    </tr>    
    
    <tr>
    <td>&#160;</td>
    <td>&#160;</td>
    <td>              
       <xsl:if test="@description!=@title">
        [<xsl:value-of select="@description"/>]
        <br/>
       </xsl:if>
       <xsl:value-of select="$dsc/@ann"/>
       <br2/>
    </td>
    </tr>

<!-- Закомментировано согласно CQ 27758

    <xsl:call-template name="listing">
      <xsl:with-param name="id" select="'elements'"/>
      <xsl:with-param name="list" select="../../entities/entity[.//operation[not(excludeusertypes/usertype/@id=current()/@id)][not(@key=preceding::operation[@f=current()/@f]/@key)]]"/>
      
      <xsl:with-param name="title">
       <hintn title="Содержит">
        Список элементов интерфейса, размещаемых в данном 
        окне.
       </hintn>
      </xsl:with-param>
    </xsl:call-template>

-->

<!-- 
Данный код является тем самым ухищрением, которое позволяет 
объединить списки команд для объединенных окон, согласно пожеланию УМ 
(http://mdp.garant.ru/pages/viewpage.action?pageId=96483812&focusedCommentId=102041856#comment-102041856):


<xsl:variable name="alias" select="//usertype[@alias=current()/@id]"/>

Определяем переменную $alias как множество узлов usertype, у которых атрибут alias равен атрибуту id контекстного узла (т.е. текущего usetype-а)


following::form[.//usertype/@alias=current()/@id]//operation[not(excludeusertypes/usertype/@id=$alias/@id)][not(@key=preceding::operation[@f=$alias/@f]/@key)]|

Выбираем во всех узлах, следующих за контекстным узлом, 
узлы operation, у которых есть предок form 
(такой, что у него есть потомок usertype с атрибутом alias равным атрибуту id контекстного узла), 
и которые удовлетворяют следующим условиям (предикатам):
у операции нет узла-потомка excludeusertypes/usertype чей атрибут id равен атрибуту id переменной $alias
атрибут key операции не равен атрибуту key предшествующих узлов operation, у которых атрибут f равен атрибуту f переменной $alias

preceding::form[.//usertype/@alias=current()/@id]//operation[not(excludeusertypes/usertype/@id=$alias/@id)][not(@key=preceding::operation[@f=$alias/@f]/@key)]"/>

-->

<xsl:variable name="alias" select="//usertype[@alias=current()/@id]"/>


    <xsl:call-template name="listing">
      <xsl:with-param name="id" select="'operations'"/>
      <xsl:with-param name="list" select="../..//operation[not(excludeusertypes/usertype/@id=current()/@id)][not(@key=preceding::operation[@f=current()/@f]/@key)]|
					  following::form[.//usertype/@alias=current()/@id]//operation[not(excludeusertypes/usertype/@id=$alias/@id)][not(@key=preceding::operation[@f=$alias/@f]/@key)]|
					  preceding::form[.//usertype/@alias=current()/@id]//operation[not(excludeusertypes/usertype/@id=$alias/@id)][not(@key=preceding::operation[@f=$alias/@f]/@key)]"/>



      <xsl:with-param name="title">
       <hintn title="Команды">
        Команды, выполняемые в данном окне.
       </hintn>
      </xsl:with-param>
    </xsl:call-template>


<!-- Закомментировано согласно CQ 27758

    <xsl:if test="$toolbar or (@id='utMainWindow')">
     <tr>
     <td nowrap="true" valign="top">
       <hintn title="Панель">
        Команды, представленные на панели инструментов данного окна. 
        Подведите курсор мыши к пиктограмме, чтобы получить краткое описание команды.
       </hintn>
     </td>
     <td>&#160;</td>
     <td>
      <xsl:if test="@id='utMainWindow'">
       <xsl:call-template name="toolbar">
        <xsl:with-param name="toolbar" select="$toolbarMain"/>
        <xsl:with-param name="style"   select="'toolbar'"/>
       </xsl:call-template>
      </xsl:if>
      <xsl:if test="@id!='utMainWindow'">
       <xsl:call-template name="toolbar">
        <xsl:with-param name="toolbar" select="$toolbar"/>
        <xsl:with-param name="style"   select="'toolbar'"/>
       </xsl:call-template>
      </xsl:if>
     </td>
     </tr>
    </xsl:if>

-->
     </table>

   <br2/>
   <xsl:copy-of select="$dsc/*"/>

  </text>      
 </topic>

</xsl:template>


<!--          -->
<!--  Тулбар  -->
<!--          -->


<xsl:template name="toolbar">
 <xsl:param name="toolbar"/>
 <xsl:param name="style"/>

  <div 
   class="{$style}"
   onmouseover="var e=event.srcElement;if(e.href) e.className='outset'"
   onmouseout ="var e=event.srcElement;if(e.href) e.className=''"
   onclick    ="var e=event.srcElement;if(e.href) navigate(e.href)"
   title="Подведите курсор мыши к пиктограмме, чтобы увидеть название команды."
  >

  <xsl:for-each select="$toolbar">
   <span 
    title="&quot;{@title}&quot;&#10;&#13;{/help/descriptions/description[@id=current()/@key]/@ann}"
    style="background-image: url(icon/{@icon});"
    href ="page-{@key}.htm"
   >                                      
    <xsl:choose>
     <xsl:when test="(@operationtype='vcm_otCombo') or (@operationtype='vcm_otEditCombo')">
       <xsl:attribute name="style">width:40px;background-image:url(help/ctrl_combo.gif);</xsl:attribute>
     </xsl:when>
     <xsl:when test="(@operationtype='vcm_otEdit') or (@operationtype='vcm_otTyper')">
       <xsl:attribute name="style">width:40px;background-image:url(help/ctrl_edit.gif);</xsl:attribute>
     </xsl:when>
     <xsl:when test="@operationtype='vcm_otDate'">
       <xsl:attribute name="style">width:40px;background-image:url(help/ctrl_date.gif);</xsl:attribute>
     </xsl:when>
   </xsl:choose>
    &#160;
   </span>
  </xsl:for-each>

  </div>

</xsl:template>


<!--          -->
<!-- Сущность -->
<!--          -->


<xsl:template match="entity">
 <xsl:variable name="dsc" select="/help/descriptions/description[@id=current()/@key]"/>

<!-- CQ 27758 -->

 <topic title="{@title}" id="{@key}" cnt="hide">

  <xsl:if test="@icon">
   <xsl:attribute name="icon">
    <xsl:value-of select="@icon"/>
   </xsl:attribute>
  </xsl:if>

  <kw name="{@title} (элемент интерфейса)"/>
  <text>

   <table class="description" cellspacing="0">
    <tr>
    <td nowrap="true" width="1%">
     Элемент:
    </td>
    <td width="1%">
     <xsl:choose>
      <xsl:when test="@icon">
       <img src="icon/{@icon}"/>
      </xsl:when>
      <xsl:otherwise>
       <img src="help/empty16px.gif"/>
      </xsl:otherwise>
     </xsl:choose>
    </td>

    <td nowrap="true">
     <sel><xsl:value-of select="@title"/></sel>
    </td>
    </tr>    

    <tr>
    <td nowrap="true">Описание</td>
    <td>&#160;</td>
    <td>
      <xsl:if test="@description and @description!=@title">
       <xsl:value-of select="@description"/>
      </xsl:if>

      <xsl:if test="$dsc/@ann and not(@description and @description!=@title)">
       <xsl:value-of select="$dsc/@ann"/>
      </xsl:if>
      <br2/>
    </td>
    </tr>    
    
    <xsl:call-template name="listing">
      <xsl:with-param name="id" select="'operations'"/>
      <xsl:with-param name="list" select="$allops[generate-id(.)=generate-id(key('opsKey', concat(current()/@m, '-', @key)))][@p=current()/@id]"/>

      <!--  and @m=current()/@m убрать, если ключом сущности будет только ее @id -->

      <xsl:with-param name="title">
       <hintn title="Команды">
        Операции, выполняемые над данным элементом.
       </hintn>
      </xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="listing">
      <xsl:with-param name="id" select="'usertypes'"/>
<!--
      <xsl:with-param name="list" select="ancestor::module[1]//usertype[current()/operations/operation[not(excludeusertypes/usertype/@id=current()/@id)]][@m=current()/@m]"/>
-->
      <xsl:with-param name="list" select="ancestor::form[1]/usertypes/usertype[current()/operations/operation[not(excludeusertypes/usertype/@id=current()/@id)]]"/>

      <xsl:with-param name="title">
        <hintn title="Размещается в">
         Разновидности окон, в которых размещается данный элемент
        </hintn>
      </xsl:with-param>
    </xsl:call-template>

   </table>

   <br2/>
   <xsl:copy-of select="$dsc/*"/>

  </text>
 </topic>

</xsl:template>


<!--          -->
<!-- Операция -->
<!--          -->


<xsl:template match="operation">
 <xsl:variable name="dsc" select="/help/descriptions/description[@id=current()/@key]"/>

 <topic title="{@title}" id="{@key}" cnt="hide">

  <xsl:if test="@icon">
   <xsl:attribute name="icon">
    <xsl:value-of select="@icon"/>
   </xsl:attribute>
  </xsl:if>

  <kw name="{@title} (команда)"/>
  
  <text>
   <table class="description" cellspacing="0">

    <tr>
    <td nowrap="true" width="1%">
     Команда:
    </td>
    <td width="1%">
     <xsl:choose>
      <xsl:when test="@icon">
       <img src="icon/{@icon}"/>
      </xsl:when>
      <xsl:otherwise>
       <img src="help/empty16px.gif"/>
      </xsl:otherwise>
     </xsl:choose>
    </td>
    <td>
     <sel><xsl:value-of select="@title"/></sel>
     <xsl:if test="@shortcut">
      <kbd>
       <xsl:value-of select="@shortcut"/>
      </kbd>
     </xsl:if>

     <xsl:if test="@vcm_ooShowInMainMenu">
      [меню <com 
        id="reference-mmenu-list" 
        title="{@category}" 
        a="#{generate-id(/help/application/menu/menuitem[@title=current()/@category])}"
        hint="Пункт главного меню системы, в который входит данная команда."
       />]
     </xsl:if>

    </td>
    </tr>    

    <tr>
    <td>&#160;</td>
    <td>&#160;</td>
    <td>
       <xsl:if test="@description!=@title">
<!--
        [<xsl:value-of select="@description"/>]
        <br/>
-->
       </xsl:if>
       <xsl:value-of select="$dsc/@ann"/>
       <br2/>
    </td>
    </tr>    

    <tr>
    <td nowrap="true">
     <hintn title="Вид">
      Элемент интерфейса, посредством которого данная операция 
      вызывается с панели инструментов (если она там есть).
     </hintn>
    </td>
    <td>&#160;</td>
    <td>

     <xsl:choose>
       <xsl:when test="@operationtype='vcm_otButton'">
        <hintn title="Кнопка">
         Кнопка панели инструментов.
        </hintn>
       </xsl:when>
       <xsl:when test="@operationtype='vcm_otCheck'">
        <hintn title="Переключатель">
         а) Кнопка панели инструментов, запоминающая свое состояние. 
         Кнопка может быть во вжатом или отжатом состояниях.
         б) Отметка-&quot;галочка&quot;.
        </hintn>
       </xsl:when>
       <xsl:when test="@operationtype='vcm_otTextButton'">
        <hintn title="Кнопка с текстом">
         Кнопка с текстовой надписью.
        </hintn>
       </xsl:when>
       <xsl:when test="@operationtype='vcm_otCombo'">
        <hintn title="Список выбора">
         Выпадающий список для выбора одного из предопределенных 
         значений. Не допускает редактирования.
        </hintn>
       </xsl:when>
       <xsl:when test="@operationtype='vcm_otEditCombo'">
        <hintn title="Список выбора (редактируемый)">
         Выпадающий список для выбора одного из значений. Можно также 
         ввести с клавиатуры собственный вариант.
        </hintn>
       </xsl:when>
       <xsl:when test="@operationtype='vcm_otButtonCombo'">
        <hintn title="Кнопка с расширением">
         Кнопка панели инструментов с небольшой стрелкой справа. 
         Стрелка отделена от кнопки вертикальным разделителем.
         
         При нажатии на стрелку выпадает меню, из которого можно 
         выбрать нужное действие. При нажатии на саму кнопку 
         выполняется действие из этого меню, принятое по умолчанию 
         (обычно первое в списке). 
         
         Такая кнопка используется для расширения функциональности 
         обычной кнопки, позволяя выбрать один из нескольких 
         вариантов действия.
        </hintn>
       </xsl:when>
       <xsl:when test="@operationtype='vcm_otButtonPopUp'">
        <hintn title="Кнопка расширения">
         Кнопка панели инструментов с небольшой стрелкой справа. 
         Стрелка от кнопки не отделяется.
         
         При нажатии на кнопку выпадает меню, из которого можно 
         выбрать нужное действие. Действия, принятого по умолчанию, 
         не существует.

         Такая кнопка используется для расширения функциональности 
         обычной кнопки, позволяя выбрать один из нескольких 
         вариантов действия.
        </hintn>
       </xsl:when>
      <xsl:when test="@operationtype='vcm_otEdit'">
        <hintn title="Поле ввода">
         Поле, предназначенное для ввода текста или номера. Действие, 
         связанное с введенным значением, начинается после нажатия клавиши 
         Enter.
        </hintn>
       </xsl:when>
       <xsl:when test="@operationtype='vcm_otTyper'">
        <hintn title="Поле ввода (с откликом)">
         Поле, предназначенное для ввода текста. Действие, связанное  
         с вводимым значением, исполняется немедленно при любом 
         изменении содержимого поля ввода. Другими словами, система 
         откликается на всякое изменение текста в таком поле.
        </hintn>
       </xsl:when>
       <xsl:when test="@operationtype='vcm_otDate'">
        <hintn title="Поле ввода даты">
         Поле, предназначенное для ввода даты. Сопровождается 
         календарем, который вызывается кнопкой справа.
         
         Поле имеет фиксированные разделители dd.mm.yyyy, достраивает 
         неполный год до полного и проверяет корректность введенной 
         даты. 
        </hintn>
       </xsl:when>
       <xsl:when test="@operationtype='vcm_otShortCut'">
        <hintn title="Комбинация клавиш">
         Комбинация клавиатурных клавиш для вызова какого-либо 
         действия. Не имеет никакого визуального воплощения;        
         на панели инструментов не отображается.
        </hintn>
       </xsl:when>
     </xsl:choose>
    </td>
    </tr>    

<!-- Закомментировано согласно CQ 27758


    <xsl:for-each select="//entity[operations/operation/@key=current()/@key][not(@key=preceding::entity[operations/operation/@key=current()/@key]/@key)]">
     <tr>
     <td nowrap="true">
      <xsl:if test="position()=1">
       <hintn title="Применяется к">
        Элемент, на который действует данная команда.
       </hintn>
      </xsl:if>
     </td>
     <td>&#160;</td>
     <td>
      <com id="{@key}"/>
     </td>
     </tr>    
    </xsl:for-each>
-->


   </table>

   <br2/>

   <xsl:copy-of select="$dsc/*"/>

  </text>
 </topic>
</xsl:template>



<!-- Вспомогательные шаблоны  -->

<!--                    -->
<!--  Список элементов  -->
<!--                    -->

<xsl:template name="listing">
 <xsl:param name="id"/>
 <xsl:param name="list"/>
 <xsl:param name="title"/>

 <tr >
  <td 
   height="16"
   nowrap="true" 
   rowspan="{count($list) + 1}" 
   valign="top"
  >
    <xsl:copy-of select="$title"/>

<!-- Это изображение-заглушка добавлено, чтобы ячейка, содержащая слово "Команды" была полностью залита -->
    <img src="help/empty1px_16c.gif"/>

  </td>
  <td width="1%">
    <img src="help/empty16px.gif"/>
  </td>
  <td width="99%" 
   nowrap="true"
   onselectstart= "return false;"
   onmouseover  = "this.className = 'outset'"
   onmouseout   = "this.className=''"
   onclick="switchList(this)"
   id="{$id}"
   state="false"
   title="Всего элементов: {count($list)}"
  >
  <xsl:if test="not(count($list))">
   <xsl:attribute name="disabled">true</xsl:attribute>
  </xsl:if>

   <span id="show{$id}" class="u">
     показать <img src="help/advanced_show.gif" valign="absmiddle"/>
   </span>
   <span id="hide{$id}" class="uh">
     скрыть <img src="help/advanced_hide.gif" valign="absmiddle"/>
   </span>
   </td>
 </tr>

  <xsl:for-each select="$list">
   <tr id="{$id}" class="list">
     <td>
     </td>
     <td nowrap="true">
      <com id="{@key}" icon="tab"/>
      <xsl:if test="@shortcut">
       &#160;<kbd><xsl:value-of select="@shortcut"/></kbd>
      </xsl:if>
     </td>
   </tr>
  </xsl:for-each>

</xsl:template>

<!--                              -->
<!--  Горячие клавиши, аннотации  -->
<!--           для                -->
<!--  	списка всех объектов      -->
<!--                              -->
<!--                              -->

<xsl:template name="summary">
 <xsl:param name="title"/>
 <xsl:param name="ann"/>
 <xsl:param name="visibility"/>
 <xsl:param name="element"/>

 <topic title="{$title}" id="{$element}_summary" cnt="{$visibility}">

 <xsl:choose>

  <xsl:when test="$element='shortcut'">

   <text>
    <p>
     <xsl:value-of select="$ann"/>
    </p>

    <table class="description" cellspacing="1">


<!--  При выборе модулей делаем исключения в соответствии с CQ 26764 (п.2) -->

     <xsl:for-each select="//module[.//@shortcut and 
				    @id!='mo_Settings' and
				    @id!='mo_Users']">

      <thead>
       <tr>
        <td colspan="2" class="caption">"<xsl:value-of select="@title"/>"</td>
       </tr>
      </thead>

      <xsl:for-each select=".//operation[@shortcut and 
					 not(@key=preceding::operation[@m=current()/@id]/@key) and
					 not(@key='enResult-opOk') and
					 not(@key='enResult-opCancel') and
					 not(@key='enEdit-opDelete') and
					 not(@key='enEdit-opCopy') and
					 not(@key='enEdit-opPaste') and
					 not(@key='enEdit-opCut')]">
       <tr>
        <td>
         <kbd><xsl:value-of select="@shortcut"/></kbd>
        </td>
        <td>
         <com id="{@key}" icon="tab"/>
        </td>
       </tr>
      </xsl:for-each>
      <tr>
       <td colspan="2">&#160;</td>
      </tr>

     </xsl:for-each>


<!-- "Костыль" для п.5 CQ 26764.                                      -->
<!-- Его можно будет убрать, когда будет реализована задача CQ26793   -->
     
      <thead>
         <tr>
          <td colspan="2" class="caption">"Общие горячие клавиши"</td>
         </tr>
      </thead>
       <tr><td><kbd>Enter</kbd></td><td><com id="enResult-opOk"/></td></tr> 
       <tr><td><kbd>Esc</kbd></td><td><com id="enResult-opCancel"/></td></tr> 
       <tr><td><kbd>Delete</kbd></td><td><com id="enEdit-opDelete"/></td></tr>
       <tr><td><kbd>Ctrl</kbd>+<kbd>C</kbd></td><td><com id="enEdit-opCopy"/></td></tr>
       <tr><td><kbd>Ctrl</kbd>+<kbd>V</kbd></td><td><com id="enEdit-opPaste"/></td></tr>
       <tr><td><kbd>Ctrl</kbd>+<kbd>X</kbd></td><td><com id="enEdit-opCut"/></td></tr>

<!-- Вместе с "Костылем" - не забыть! условия для operation[@shortcut -->

    </table>
   </text>

  </xsl:when>

  <xsl:otherwise>


   <xsl:variable name="nodes" select="msxsl:node-set(//node()[name()=$element and @key and not(@key=preceding::node()/@key)])"/>


    <text>
     <p>
      <xsl:value-of select="$ann"/>
     </p>

     <table class="description" cellspacing="1">
      <thead>
       <tr>
        <td class="caption" colspan="2">&#160;<xsl:value-of select="$title"/></td>
       </tr>
      </thead>

      <tbody>
       <xsl:for-each select="$nodes[not(@alias)]">
        <xsl:sort select="@title"/>
        <tr>
        <td>
         <xsl:number value="position()" format="1"/>
        </td>
        <td>
         <com id="{@key}" icon="tab"/>
         <xsl:if test="name()='operation'">
          &#160;<kbd><xsl:value-of select="@shortcut"/></kbd>
         </xsl:if>
        </td>
        </tr>
       </xsl:for-each>
      </tbody>
     </table>
    </text>
    <xsl:apply-templates select="$nodes">
     <xsl:sort select="@title"/>
    </xsl:apply-templates>
  </xsl:otherwise>
 </xsl:choose>

 </topic>

</xsl:template>

<!--                           -->
<!--  Список всех изображений  -->
<!--                           -->

<xsl:template match="imagesList">
 <xsl:for-each select="//screen[not(@src=preceding::screen/@src)]">
  <screen src="{@src}" summary="true">
   <xsl:if test="@nopreview">
    <xsl:attribute name="nopreview">true</xsl:attribute>
   </xsl:if>
  </screen>
  <br2/><hr/><br2/>
 </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
