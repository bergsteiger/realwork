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
  <xsl:with-param name="title" select="'Windows'"/>
  <xsl:with-param name="ann"   select="'All system windows in alphabet order.'"/>
  <xsl:with-param name="element" select="'usertype'"/>
 </xsl:call-template>

 <xsl:call-template name="summary">
  <xsl:with-param name="title" select="'Elements'"/>
  <xsl:with-param name="ann"   select="'All system elements in alphabet order.'"/>
  <xsl:with-param name="element" select="'entity'"/>
  <xsl:with-param name="visibility" select="'hide'"/>
 </xsl:call-template>

 <xsl:call-template name="summary">
  <xsl:with-param name="title" select="'Operations'"/>
  <xsl:with-param name="ann"   select="'All system operations in alphabet order.'"/>
  <xsl:with-param name="element" select="'operation'"/>
  <xsl:with-param name="visibility" select="'hide'"/>
 </xsl:call-template>

 <xsl:call-template name="mmenu"/>

 <xsl:call-template name="summary">
  <xsl:with-param name="title" select="'Keyboard shortcuts'"/>
  <xsl:with-param name="ann"   select="'Keyboard shortcuts allow you to call operations from keyboard.'"/>
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

 <topic title="MainMenu" id="reference-mmenu">
  <h3 class="topic">Main Menu</h3>
  <head>
   <link rel="stylesheet" type="text/css" href="mmenu.css"/>
   <script src="mmenu.js"/>
  </head>

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
 </topic>


 <topic title="Main menu (list view)" id="reference-mmenu-list">
<h3 class="topic">Main menu (list view)</h3>
  <p>
   At this page <com id="reference-mmenu"/> presented as a list of commands.
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
  <xsl:if test="/help/excludeddsc/com[@id=current()/@key]">
   <xsl:attribute name="cnt">hide</xsl:attribute>
  </xsl:if>

  <xsl:choose>
  <xsl:when test="not(/help/excludeddsc/com[@id=current()/@key])">

  <xsl:if test="@icon">
   <xsl:attribute name="icon">
    <xsl:value-of select="@icon"/>
   </xsl:attribute>
  </xsl:if>






<h3>
<xsl:attribute name="class">topic</xsl:attribute>
<xsl:value-of select="$dsc/h3[1]"/>
</h3>

   <table class="description" cellspacing="0">
    <tr>
    <td nowrap="true" width="1%">
     Window
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
     <sel><font color="#009933"><xsl:value-of select="$dsc/h3[1]/."/></font></sel>
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
       <xsl:value-of select="$dsc/font[@color='#808080']"/>
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


    <xsl:call-template name="listing">
      <xsl:with-param name="id" select="'operations'"/>
      <xsl:with-param name="list" select="../..//operation[not(excludeusertypes/usertype/@id=current()/@id)][not(@key=preceding::operation[@f=current()/@f]/@key)]"/>

      <xsl:with-param name="title">
       <hintn><font color="#009933">Operations</font>
	(<font color="#808080">List of operations which could be perfomed in this window.</font>)
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
   
<!-- Убираем из копируемого описания(description) имя топика(h3) и аннотацию(font) из текста -->

   <xsl:copy-of select="$dsc/node()[not(self::h3[1] or self::font[@class='description'])]"/>

</xsl:when> 
<xsl:otherwise>
<p style="attn">This feature is implemented in GARANT system in the Russian language.</p>
</xsl:otherwise>
</xsl:choose>


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

<xsl:choose>
<xsl:when test="not(/help/excludeddsc/com[@id=current()/@key])">

  <xsl:if test="@icon">
   <xsl:attribute name="icon">
    <xsl:value-of select="@icon"/>
   </xsl:attribute>
  </xsl:if>

  <kw name="{@title} (элемент интерфейса)"/>

<h3>
<xsl:attribute name="class">topic</xsl:attribute>
<xsl:value-of select="$dsc/h3[1]"/>
</h3>

   <table class="description" cellspacing="0">
    <tr>
    <td nowrap="true" width="1%">
     Element:
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
     <sel><font color="#009933"><xsl:value-of select="$dsc/h3[1]/."/></font></sel>
    </td>
    </tr>    

    <tr>
    <td nowrap="true">Description</td>
    <td>&#160;</td>
    <td>
      <xsl:if test="@description and @description!=@title">
       <xsl:value-of select="@description"/>
      </xsl:if>

      <xsl:if test="$dsc/@ann and not(@description and @description!=@title)">
       <xsl:value-of select="$dsc/font[@color='#808080']"/>
      </xsl:if>
      <br2/>
    </td>
    </tr>    
    
    <xsl:call-template name="listing">
      <xsl:with-param name="id" select="'operations'"/>
      <xsl:with-param name="list" select="$allops[generate-id(.)=generate-id(key('opsKey', concat(current()/@m, '-', @key)))][@p=current()/@id]"/>

      <!--  and @m=current()/@m убрать, если ключом сущности будет только ее @id -->

      <xsl:with-param name="title">
       <hintn> <font color="#009933">Operations</font>
        (<font color="#808080">List of operations which could be perfomed with this element.</font>)
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
        <hintn><font color="#009933">Placed in</font>
	(<font color="#808080">List of windows where this element placed in.</font>)
        </hintn>
      </xsl:with-param>
    </xsl:call-template>

   </table>

   <br2/>
   <!-- Убираем из копируемого описания(description) имя топика(h3) и аннотацию(font) из текста -->

   <xsl:copy-of select="$dsc/node()[not(self::h3[1] or self::font[@class='description'])]"/>

</xsl:when> 
<xsl:otherwise>
<p style="attn">This feature is implemented in GARANT system in the Russian language.</p>
</xsl:otherwise>
</xsl:choose>
 </topic>

</xsl:template>


<!--          -->
<!-- Операция -->
<!--          -->


<xsl:template match="operation">
 <xsl:variable name="dsc" select="/help/descriptions/description[@id=current()/@key]"/>

 <topic title="{@title}" id="{@key}" cnt="hide">

<xsl:choose>
<xsl:when test="not(/help/excludeddsc/com[@id=current()/@key])">

  <xsl:if test="@icon">
   <xsl:attribute name="icon">
    <xsl:value-of select="@icon"/>
   </xsl:attribute>
  </xsl:if>

  <kw name="{@title} (команда)"/>
  
<h3>
<xsl:attribute name="class">topic</xsl:attribute>
<xsl:value-of select="$dsc/h3[1]"/>
</h3>

   <table class="description" cellspacing="0">

    <tr>
    <td nowrap="true" width="1%">
     Operation:
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
     <sel><font color="#009933"><xsl:value-of select="$dsc/h3[1]/."/></font></sel>
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
        hint="Main menu item, which contains this operation."
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
       <xsl:value-of select="$dsc/font[@color='#808080']"/>
       <br2/>
    </td>
    </tr>    

    <tr>
    <td nowrap="true">
     <hintn title="Appearance">
     Type of control, which represent the operation on toolbar.
     </hintn>
    </td>
    <td>&#160;</td>
    <td>

     <xsl:choose>
       <xsl:when test="@operationtype='vcm_otButton'">
        <hintn title="Button">
         A button represented as icon.
        </hintn>
       </xsl:when>
       <xsl:when test="@operationtype='vcm_otCheck'">
        <hintn title="Check Box">
         a) 'Pressed state'-depended button.
         b) Check box.
        </hintn>
       </xsl:when>
       <xsl:when test="@operationtype='vcm_otTextButton'">
        <hintn title="Button with text">
         A button represented as icon and text.
        </hintn>
       </xsl:when>
       <xsl:when test="@operationtype='vcm_otCombo'">
        <hintn title="ComboBox">
         Combobox
        </hintn>
       </xsl:when>
       <xsl:when test="@operationtype='vcm_otEditCombo'">
        <hintn title="List box">
         List box
        </hintn>
       </xsl:when>
       <xsl:when test="@operationtype='vcm_otButtonCombo'">
        <hintn title="Button with extension">
         A combo box represented as icon.
        </hintn>
       </xsl:when>
       <xsl:when test="@operationtype='vcm_otButtonPopUp'">
        <hintn title="Button With Extension">
         A combo box represented as icon.
        </hintn>
       </xsl:when>
      <xsl:when test="@operationtype='vcm_otEdit'">
        <hintn title="Textbox">
         Textbox.
        </hintn>
       </xsl:when>
       <xsl:when test="@operationtype='vcm_otTyper'">
        <hintn title="Context Filtering Textbox">
         A textbox which content is filtering appropriate list or tree.
        </hintn>
       </xsl:when>
       <xsl:when test="@operationtype='vcm_otDate'">
        <hintn title="Data entry field">
         A field for entering data, with pop-up calendar invoking by extension arrow.
        </hintn>
       </xsl:when>
       <xsl:when test="@operationtype='vcm_otShortCut'">
        <hintn title="Keyboard Shortcut">
         Keyboard Shortcut
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

 <xsl:copy-of select="$dsc/node()[not(self::h3[1] or self::font[@class='description'])]"/>

</xsl:when> 
<xsl:otherwise>
<p style="attn">This feature is implemented in GARANT system in the Russian language.</p>
</xsl:otherwise>
</xsl:choose>

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
    <!-- Здесь поменяли value на copy, ввиду того, что hintn в английской версии - это нода -->
    
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
   title="Total count: {count($list)}"
  >
  <xsl:if test="not(count($list))">
   <xsl:attribute name="disabled">true</xsl:attribute>
  </xsl:if>

   <span id="show{$id}" class="u">
     show <img src="help/advanced_show.gif" valign="absmiddle"/>
   </span>
   <span id="hide{$id}" class="uh">
     hide <img src="help/advanced_hide.gif" valign="absmiddle"/>
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

<h3 class="topic"><xsl:value-of select="$title"/></h3>

 <xsl:choose>

  <xsl:when test="$element='shortcut'">

   
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
  

  </xsl:when>

  <xsl:otherwise>

   <xsl:variable name="nodes" select="msxsl:node-set(//node()[name()=$element and @key and not(@key=preceding::node()/@key)])"/>

    <p>
      <xsl:value-of select="$ann"/>
    </p>

     <table class="description" cellspacing="1">
      <thead>
       <tr>
        <td class="caption" colspan="2">&#160;<xsl:value-of select="$title"/></td>
       </tr>
      </thead>

<!-- Если будет время, нужно разобраться как исключить из выборки переменной $nodes usertype-ы, 
которые внесены в исключения excludeddsc
[@key=following::excludeddsc/com[@id=self::node()/@key]/@id]
 -->

      <tbody>
       <xsl:for-each select="$nodes">
        <xsl:sort select="@title"/>
        <xsl:if test="not(/help/excludeddsc/com[@id=current()/@key])">
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
        </xsl:if>
       </xsl:for-each>
      </tbody>
     </table>
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
