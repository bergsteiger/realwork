unit FoldersElementInfoKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы FoldersElementInfo }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\FoldersElementInfoKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimFolders_Module
 , vtPanel
 , eeMemoWithEditOperations
 , vtLabel
 {$If Defined(Nemesis)}
 , nscComboBoxWithReadOnly
 {$IfEnd} // Defined(Nemesis)
 , vtCheckBox
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_FoldersElementInfo = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы FoldersElementInfo
----
*Пример использования*:
[code]
'aControl' форма::FoldersElementInfo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_FoldersElementInfo

 Tkw_FoldersElementInfo_Control_CommentPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола CommentPanel
----
*Пример использования*:
[code]
контрол::CommentPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_FoldersElementInfo_Control_CommentPanel

 Tkw_FoldersElementInfo_Control_CommentPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола CommentPanel
----
*Пример использования*:
[code]
контрол::CommentPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_CommentPanel_Push

 Tkw_FoldersElementInfo_Control_ElementComment = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ElementComment
----
*Пример использования*:
[code]
контрол::ElementComment TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_FoldersElementInfo_Control_ElementComment

 Tkw_FoldersElementInfo_Control_ElementComment_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ElementComment
----
*Пример использования*:
[code]
контрол::ElementComment:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_ElementComment_Push

 Tkw_FoldersElementInfo_Control_CaptionPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола CaptionPanel
----
*Пример использования*:
[code]
контрол::CaptionPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_FoldersElementInfo_Control_CaptionPanel

 Tkw_FoldersElementInfo_Control_CaptionPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола CaptionPanel
----
*Пример использования*:
[code]
контрол::CaptionPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_CaptionPanel_Push

 Tkw_FoldersElementInfo_Control_lblComment = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblComment
----
*Пример использования*:
[code]
контрол::lblComment TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_FoldersElementInfo_Control_lblComment

 Tkw_FoldersElementInfo_Control_lblComment_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lblComment
----
*Пример использования*:
[code]
контрол::lblComment:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_lblComment_Push

 Tkw_FoldersElementInfo_Control_TopPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TopPanel
----
*Пример использования*:
[code]
контрол::TopPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_FoldersElementInfo_Control_TopPanel

 Tkw_FoldersElementInfo_Control_TopPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола TopPanel
----
*Пример использования*:
[code]
контрол::TopPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_TopPanel_Push

 Tkw_FoldersElementInfo_Control_NamePanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола NamePanel
----
*Пример использования*:
[code]
контрол::NamePanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_FoldersElementInfo_Control_NamePanel

 Tkw_FoldersElementInfo_Control_NamePanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола NamePanel
----
*Пример использования*:
[code]
контрол::NamePanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_NamePanel_Push

 Tkw_FoldersElementInfo_Control_lblElementName = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblElementName
----
*Пример использования*:
[code]
контрол::lblElementName TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_FoldersElementInfo_Control_lblElementName

 Tkw_FoldersElementInfo_Control_lblElementName_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lblElementName
----
*Пример использования*:
[code]
контрол::lblElementName:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_lblElementName_Push

 Tkw_FoldersElementInfo_Control_ElementName = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ElementName
----
*Пример использования*:
[code]
контрол::ElementName TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_FoldersElementInfo_Control_ElementName

 Tkw_FoldersElementInfo_Control_ElementName_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ElementName
----
*Пример использования*:
[code]
контрол::ElementName:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_ElementName_Push

 Tkw_FoldersElementInfo_Control_cbShared = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола cbShared
----
*Пример использования*:
[code]
контрол::cbShared TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_FoldersElementInfo_Control_cbShared

 Tkw_FoldersElementInfo_Control_cbShared_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола cbShared
----
*Пример использования*:
[code]
контрол::cbShared:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_cbShared_Push

 Tkw_FoldersElementInfo_Control_InfoName = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола InfoName
----
*Пример использования*:
[code]
контрол::InfoName TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_FoldersElementInfo_Control_InfoName

 Tkw_FoldersElementInfo_Control_InfoName_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола InfoName
----
*Пример использования*:
[code]
контрол::InfoName:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_InfoName_Push

 TkwEnFoldersElementInfoCommentPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.CommentPanel
[panel]Контрол CommentPanel формы TenFoldersElementInfo[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aenFoldersElementInfo .TenFoldersElementInfo.CommentPanel >>> l_TvtPanel
[code]  }
  private
   function CommentPanel(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
    {* Реализация слова скрипта .TenFoldersElementInfo.CommentPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnFoldersElementInfoCommentPanel

 TkwEnFoldersElementInfoElementComment = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.ElementComment
[panel]Контрол ElementComment формы TenFoldersElementInfo[panel]
*Тип результата:* TeeMemoWithEditOperations
*Пример:*
[code]
OBJECT VAR l_TeeMemoWithEditOperations
 aenFoldersElementInfo .TenFoldersElementInfo.ElementComment >>> l_TeeMemoWithEditOperations
[code]  }
  private
   function ElementComment(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TeeMemoWithEditOperations;
    {* Реализация слова скрипта .TenFoldersElementInfo.ElementComment }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnFoldersElementInfoElementComment

 TkwEnFoldersElementInfoCaptionPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.CaptionPanel
[panel]Контрол CaptionPanel формы TenFoldersElementInfo[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aenFoldersElementInfo .TenFoldersElementInfo.CaptionPanel >>> l_TvtPanel
[code]  }
  private
   function CaptionPanel(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
    {* Реализация слова скрипта .TenFoldersElementInfo.CaptionPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnFoldersElementInfoCaptionPanel

 TkwEnFoldersElementInfoLblComment = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.lblComment
[panel]Контрол lblComment формы TenFoldersElementInfo[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aenFoldersElementInfo .TenFoldersElementInfo.lblComment >>> l_TvtLabel
[code]  }
  private
   function lblComment(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TvtLabel;
    {* Реализация слова скрипта .TenFoldersElementInfo.lblComment }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnFoldersElementInfoLblComment

 TkwEnFoldersElementInfoTopPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.TopPanel
[panel]Контрол TopPanel формы TenFoldersElementInfo[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aenFoldersElementInfo .TenFoldersElementInfo.TopPanel >>> l_TvtPanel
[code]  }
  private
   function TopPanel(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
    {* Реализация слова скрипта .TenFoldersElementInfo.TopPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnFoldersElementInfoTopPanel

 TkwEnFoldersElementInfoNamePanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.NamePanel
[panel]Контрол NamePanel формы TenFoldersElementInfo[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aenFoldersElementInfo .TenFoldersElementInfo.NamePanel >>> l_TvtPanel
[code]  }
  private
   function NamePanel(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
    {* Реализация слова скрипта .TenFoldersElementInfo.NamePanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnFoldersElementInfoNamePanel

 TkwEnFoldersElementInfoLblElementName = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.lblElementName
[panel]Контрол lblElementName формы TenFoldersElementInfo[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aenFoldersElementInfo .TenFoldersElementInfo.lblElementName >>> l_TvtLabel
[code]  }
  private
   function lblElementName(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TvtLabel;
    {* Реализация слова скрипта .TenFoldersElementInfo.lblElementName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnFoldersElementInfoLblElementName

 TkwEnFoldersElementInfoElementName = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.ElementName
[panel]Контрол ElementName формы TenFoldersElementInfo[panel]
*Тип результата:* TnscComboBoxWithReadOnly
*Пример:*
[code]
OBJECT VAR l_TnscComboBoxWithReadOnly
 aenFoldersElementInfo .TenFoldersElementInfo.ElementName >>> l_TnscComboBoxWithReadOnly
[code]  }
  private
   function ElementName(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TnscComboBoxWithReadOnly;
    {* Реализация слова скрипта .TenFoldersElementInfo.ElementName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnFoldersElementInfoElementName

 TkwEnFoldersElementInfoCbShared = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.cbShared
[panel]Контрол cbShared формы TenFoldersElementInfo[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aenFoldersElementInfo .TenFoldersElementInfo.cbShared >>> l_TvtCheckBox
[code]  }
  private
   function cbShared(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TvtCheckBox;
    {* Реализация слова скрипта .TenFoldersElementInfo.cbShared }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnFoldersElementInfoCbShared

 TkwEnFoldersElementInfoInfoName = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.InfoName
[panel]Контрол InfoName формы TenFoldersElementInfo[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aenFoldersElementInfo .TenFoldersElementInfo.InfoName >>> l_TvtLabel
[code]  }
  private
   function InfoName(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TvtLabel;
    {* Реализация слова скрипта .TenFoldersElementInfo.InfoName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnFoldersElementInfoInfoName

class function Tkw_Form_FoldersElementInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::FoldersElementInfo';
end;//Tkw_Form_FoldersElementInfo.GetWordNameForRegister

function Tkw_Form_FoldersElementInfo.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_62255BAB72F3_var*
//#UC END# *4DDFD2EA0116_62255BAB72F3_var*
begin
//#UC START# *4DDFD2EA0116_62255BAB72F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_62255BAB72F3_impl*
end;//Tkw_Form_FoldersElementInfo.GetString

class function Tkw_FoldersElementInfo_Control_CommentPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CommentPanel';
end;//Tkw_FoldersElementInfo_Control_CommentPanel.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_CommentPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_09E958E65FBC_var*
//#UC END# *4DDFD2EA0116_09E958E65FBC_var*
begin
//#UC START# *4DDFD2EA0116_09E958E65FBC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_09E958E65FBC_impl*
end;//Tkw_FoldersElementInfo_Control_CommentPanel.GetString

class procedure Tkw_FoldersElementInfo_Control_CommentPanel.RegisterInEngine;
//#UC START# *52A086150180_09E958E65FBC_var*
//#UC END# *52A086150180_09E958E65FBC_var*
begin
//#UC START# *52A086150180_09E958E65FBC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_09E958E65FBC_impl*
end;//Tkw_FoldersElementInfo_Control_CommentPanel.RegisterInEngine

procedure Tkw_FoldersElementInfo_Control_CommentPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_83ABE026B17E_var*
//#UC END# *4DAEEDE10285_83ABE026B17E_var*
begin
//#UC START# *4DAEEDE10285_83ABE026B17E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_83ABE026B17E_impl*
end;//Tkw_FoldersElementInfo_Control_CommentPanel_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_CommentPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CommentPanel:push';
end;//Tkw_FoldersElementInfo_Control_CommentPanel_Push.GetWordNameForRegister

class function Tkw_FoldersElementInfo_Control_ElementComment.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElementComment';
end;//Tkw_FoldersElementInfo_Control_ElementComment.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_ElementComment.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_CD901EF69045_var*
//#UC END# *4DDFD2EA0116_CD901EF69045_var*
begin
//#UC START# *4DDFD2EA0116_CD901EF69045_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_CD901EF69045_impl*
end;//Tkw_FoldersElementInfo_Control_ElementComment.GetString

class procedure Tkw_FoldersElementInfo_Control_ElementComment.RegisterInEngine;
//#UC START# *52A086150180_CD901EF69045_var*
//#UC END# *52A086150180_CD901EF69045_var*
begin
//#UC START# *52A086150180_CD901EF69045_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_CD901EF69045_impl*
end;//Tkw_FoldersElementInfo_Control_ElementComment.RegisterInEngine

procedure Tkw_FoldersElementInfo_Control_ElementComment_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E60EFBE7D8F_var*
//#UC END# *4DAEEDE10285_4E60EFBE7D8F_var*
begin
//#UC START# *4DAEEDE10285_4E60EFBE7D8F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4E60EFBE7D8F_impl*
end;//Tkw_FoldersElementInfo_Control_ElementComment_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_ElementComment_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElementComment:push';
end;//Tkw_FoldersElementInfo_Control_ElementComment_Push.GetWordNameForRegister

class function Tkw_FoldersElementInfo_Control_CaptionPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CaptionPanel';
end;//Tkw_FoldersElementInfo_Control_CaptionPanel.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_CaptionPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9357DEEAFAD7_var*
//#UC END# *4DDFD2EA0116_9357DEEAFAD7_var*
begin
//#UC START# *4DDFD2EA0116_9357DEEAFAD7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9357DEEAFAD7_impl*
end;//Tkw_FoldersElementInfo_Control_CaptionPanel.GetString

class procedure Tkw_FoldersElementInfo_Control_CaptionPanel.RegisterInEngine;
//#UC START# *52A086150180_9357DEEAFAD7_var*
//#UC END# *52A086150180_9357DEEAFAD7_var*
begin
//#UC START# *52A086150180_9357DEEAFAD7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_9357DEEAFAD7_impl*
end;//Tkw_FoldersElementInfo_Control_CaptionPanel.RegisterInEngine

procedure Tkw_FoldersElementInfo_Control_CaptionPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_51DDDC067A91_var*
//#UC END# *4DAEEDE10285_51DDDC067A91_var*
begin
//#UC START# *4DAEEDE10285_51DDDC067A91_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_51DDDC067A91_impl*
end;//Tkw_FoldersElementInfo_Control_CaptionPanel_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_CaptionPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CaptionPanel:push';
end;//Tkw_FoldersElementInfo_Control_CaptionPanel_Push.GetWordNameForRegister

class function Tkw_FoldersElementInfo_Control_lblComment.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblComment';
end;//Tkw_FoldersElementInfo_Control_lblComment.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_lblComment.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_107B2E51722D_var*
//#UC END# *4DDFD2EA0116_107B2E51722D_var*
begin
//#UC START# *4DDFD2EA0116_107B2E51722D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_107B2E51722D_impl*
end;//Tkw_FoldersElementInfo_Control_lblComment.GetString

class procedure Tkw_FoldersElementInfo_Control_lblComment.RegisterInEngine;
//#UC START# *52A086150180_107B2E51722D_var*
//#UC END# *52A086150180_107B2E51722D_var*
begin
//#UC START# *52A086150180_107B2E51722D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_107B2E51722D_impl*
end;//Tkw_FoldersElementInfo_Control_lblComment.RegisterInEngine

procedure Tkw_FoldersElementInfo_Control_lblComment_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A694C1AC6010_var*
//#UC END# *4DAEEDE10285_A694C1AC6010_var*
begin
//#UC START# *4DAEEDE10285_A694C1AC6010_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A694C1AC6010_impl*
end;//Tkw_FoldersElementInfo_Control_lblComment_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_lblComment_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblComment:push';
end;//Tkw_FoldersElementInfo_Control_lblComment_Push.GetWordNameForRegister

class function Tkw_FoldersElementInfo_Control_TopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TopPanel';
end;//Tkw_FoldersElementInfo_Control_TopPanel.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_TopPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C560D946A761_var*
//#UC END# *4DDFD2EA0116_C560D946A761_var*
begin
//#UC START# *4DDFD2EA0116_C560D946A761_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C560D946A761_impl*
end;//Tkw_FoldersElementInfo_Control_TopPanel.GetString

class procedure Tkw_FoldersElementInfo_Control_TopPanel.RegisterInEngine;
//#UC START# *52A086150180_C560D946A761_var*
//#UC END# *52A086150180_C560D946A761_var*
begin
//#UC START# *52A086150180_C560D946A761_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_C560D946A761_impl*
end;//Tkw_FoldersElementInfo_Control_TopPanel.RegisterInEngine

procedure Tkw_FoldersElementInfo_Control_TopPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_47BB3C78223A_var*
//#UC END# *4DAEEDE10285_47BB3C78223A_var*
begin
//#UC START# *4DAEEDE10285_47BB3C78223A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_47BB3C78223A_impl*
end;//Tkw_FoldersElementInfo_Control_TopPanel_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_TopPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TopPanel:push';
end;//Tkw_FoldersElementInfo_Control_TopPanel_Push.GetWordNameForRegister

class function Tkw_FoldersElementInfo_Control_NamePanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NamePanel';
end;//Tkw_FoldersElementInfo_Control_NamePanel.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_NamePanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5469525C6B1E_var*
//#UC END# *4DDFD2EA0116_5469525C6B1E_var*
begin
//#UC START# *4DDFD2EA0116_5469525C6B1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5469525C6B1E_impl*
end;//Tkw_FoldersElementInfo_Control_NamePanel.GetString

class procedure Tkw_FoldersElementInfo_Control_NamePanel.RegisterInEngine;
//#UC START# *52A086150180_5469525C6B1E_var*
//#UC END# *52A086150180_5469525C6B1E_var*
begin
//#UC START# *52A086150180_5469525C6B1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5469525C6B1E_impl*
end;//Tkw_FoldersElementInfo_Control_NamePanel.RegisterInEngine

procedure Tkw_FoldersElementInfo_Control_NamePanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9683F822B943_var*
//#UC END# *4DAEEDE10285_9683F822B943_var*
begin
//#UC START# *4DAEEDE10285_9683F822B943_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9683F822B943_impl*
end;//Tkw_FoldersElementInfo_Control_NamePanel_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_NamePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NamePanel:push';
end;//Tkw_FoldersElementInfo_Control_NamePanel_Push.GetWordNameForRegister

class function Tkw_FoldersElementInfo_Control_lblElementName.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblElementName';
end;//Tkw_FoldersElementInfo_Control_lblElementName.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_lblElementName.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_377936B0D7D9_var*
//#UC END# *4DDFD2EA0116_377936B0D7D9_var*
begin
//#UC START# *4DDFD2EA0116_377936B0D7D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_377936B0D7D9_impl*
end;//Tkw_FoldersElementInfo_Control_lblElementName.GetString

class procedure Tkw_FoldersElementInfo_Control_lblElementName.RegisterInEngine;
//#UC START# *52A086150180_377936B0D7D9_var*
//#UC END# *52A086150180_377936B0D7D9_var*
begin
//#UC START# *52A086150180_377936B0D7D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_377936B0D7D9_impl*
end;//Tkw_FoldersElementInfo_Control_lblElementName.RegisterInEngine

procedure Tkw_FoldersElementInfo_Control_lblElementName_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_15D0C8E1E5F3_var*
//#UC END# *4DAEEDE10285_15D0C8E1E5F3_var*
begin
//#UC START# *4DAEEDE10285_15D0C8E1E5F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_15D0C8E1E5F3_impl*
end;//Tkw_FoldersElementInfo_Control_lblElementName_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_lblElementName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblElementName:push';
end;//Tkw_FoldersElementInfo_Control_lblElementName_Push.GetWordNameForRegister

class function Tkw_FoldersElementInfo_Control_ElementName.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElementName';
end;//Tkw_FoldersElementInfo_Control_ElementName.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_ElementName.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_20039A382622_var*
//#UC END# *4DDFD2EA0116_20039A382622_var*
begin
//#UC START# *4DDFD2EA0116_20039A382622_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_20039A382622_impl*
end;//Tkw_FoldersElementInfo_Control_ElementName.GetString

class procedure Tkw_FoldersElementInfo_Control_ElementName.RegisterInEngine;
//#UC START# *52A086150180_20039A382622_var*
//#UC END# *52A086150180_20039A382622_var*
begin
//#UC START# *52A086150180_20039A382622_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_20039A382622_impl*
end;//Tkw_FoldersElementInfo_Control_ElementName.RegisterInEngine

procedure Tkw_FoldersElementInfo_Control_ElementName_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4FC40930D75D_var*
//#UC END# *4DAEEDE10285_4FC40930D75D_var*
begin
//#UC START# *4DAEEDE10285_4FC40930D75D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4FC40930D75D_impl*
end;//Tkw_FoldersElementInfo_Control_ElementName_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_ElementName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElementName:push';
end;//Tkw_FoldersElementInfo_Control_ElementName_Push.GetWordNameForRegister

class function Tkw_FoldersElementInfo_Control_cbShared.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cbShared';
end;//Tkw_FoldersElementInfo_Control_cbShared.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_cbShared.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_86C191799612_var*
//#UC END# *4DDFD2EA0116_86C191799612_var*
begin
//#UC START# *4DDFD2EA0116_86C191799612_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_86C191799612_impl*
end;//Tkw_FoldersElementInfo_Control_cbShared.GetString

class procedure Tkw_FoldersElementInfo_Control_cbShared.RegisterInEngine;
//#UC START# *52A086150180_86C191799612_var*
//#UC END# *52A086150180_86C191799612_var*
begin
//#UC START# *52A086150180_86C191799612_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_86C191799612_impl*
end;//Tkw_FoldersElementInfo_Control_cbShared.RegisterInEngine

procedure Tkw_FoldersElementInfo_Control_cbShared_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5D65119DF168_var*
//#UC END# *4DAEEDE10285_5D65119DF168_var*
begin
//#UC START# *4DAEEDE10285_5D65119DF168_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5D65119DF168_impl*
end;//Tkw_FoldersElementInfo_Control_cbShared_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_cbShared_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cbShared:push';
end;//Tkw_FoldersElementInfo_Control_cbShared_Push.GetWordNameForRegister

class function Tkw_FoldersElementInfo_Control_InfoName.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::InfoName';
end;//Tkw_FoldersElementInfo_Control_InfoName.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_InfoName.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_DB6F345D65FD_var*
//#UC END# *4DDFD2EA0116_DB6F345D65FD_var*
begin
//#UC START# *4DDFD2EA0116_DB6F345D65FD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_DB6F345D65FD_impl*
end;//Tkw_FoldersElementInfo_Control_InfoName.GetString

class procedure Tkw_FoldersElementInfo_Control_InfoName.RegisterInEngine;
//#UC START# *52A086150180_DB6F345D65FD_var*
//#UC END# *52A086150180_DB6F345D65FD_var*
begin
//#UC START# *52A086150180_DB6F345D65FD_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_DB6F345D65FD_impl*
end;//Tkw_FoldersElementInfo_Control_InfoName.RegisterInEngine

procedure Tkw_FoldersElementInfo_Control_InfoName_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6B4867369118_var*
//#UC END# *4DAEEDE10285_6B4867369118_var*
begin
//#UC START# *4DAEEDE10285_6B4867369118_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6B4867369118_impl*
end;//Tkw_FoldersElementInfo_Control_InfoName_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_InfoName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::InfoName:push';
end;//Tkw_FoldersElementInfo_Control_InfoName_Push.GetWordNameForRegister

function TkwEnFoldersElementInfoCommentPanel.CommentPanel(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
 {* Реализация слова скрипта .TenFoldersElementInfo.CommentPanel }
//#UC START# *6E75820A9A29_FC246B9E60E7_var*
//#UC END# *6E75820A9A29_FC246B9E60E7_var*
begin
//#UC START# *6E75820A9A29_FC246B9E60E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *6E75820A9A29_FC246B9E60E7_impl*
end;//TkwEnFoldersElementInfoCommentPanel.CommentPanel

procedure TkwEnFoldersElementInfoCommentPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FC246B9E60E7_var*
//#UC END# *4DAEEDE10285_FC246B9E60E7_var*
begin
//#UC START# *4DAEEDE10285_FC246B9E60E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FC246B9E60E7_impl*
end;//TkwEnFoldersElementInfoCommentPanel.DoDoIt

class function TkwEnFoldersElementInfoCommentPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.CommentPanel';
end;//TkwEnFoldersElementInfoCommentPanel.GetWordNameForRegister

procedure TkwEnFoldersElementInfoCommentPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_FC246B9E60E7_var*
//#UC END# *52D00B00031A_FC246B9E60E7_var*
begin
//#UC START# *52D00B00031A_FC246B9E60E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_FC246B9E60E7_impl*
end;//TkwEnFoldersElementInfoCommentPanel.SetValuePrim

function TkwEnFoldersElementInfoCommentPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_FC246B9E60E7_var*
//#UC END# *551544E2001A_FC246B9E60E7_var*
begin
//#UC START# *551544E2001A_FC246B9E60E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_FC246B9E60E7_impl*
end;//TkwEnFoldersElementInfoCommentPanel.GetResultTypeInfo

function TkwEnFoldersElementInfoCommentPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoCommentPanel.GetAllParamsCount

function TkwEnFoldersElementInfoCommentPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_FC246B9E60E7_var*
//#UC END# *5617F4D00243_FC246B9E60E7_var*
begin
//#UC START# *5617F4D00243_FC246B9E60E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_FC246B9E60E7_impl*
end;//TkwEnFoldersElementInfoCommentPanel.ParamsTypes

function TkwEnFoldersElementInfoElementComment.ElementComment(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TeeMemoWithEditOperations;
 {* Реализация слова скрипта .TenFoldersElementInfo.ElementComment }
//#UC START# *FDBAF6D6D042_4551FFBCF0C6_var*
//#UC END# *FDBAF6D6D042_4551FFBCF0C6_var*
begin
//#UC START# *FDBAF6D6D042_4551FFBCF0C6_impl*
 !!! Needs to be implemented !!!
//#UC END# *FDBAF6D6D042_4551FFBCF0C6_impl*
end;//TkwEnFoldersElementInfoElementComment.ElementComment

procedure TkwEnFoldersElementInfoElementComment.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4551FFBCF0C6_var*
//#UC END# *4DAEEDE10285_4551FFBCF0C6_var*
begin
//#UC START# *4DAEEDE10285_4551FFBCF0C6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4551FFBCF0C6_impl*
end;//TkwEnFoldersElementInfoElementComment.DoDoIt

class function TkwEnFoldersElementInfoElementComment.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.ElementComment';
end;//TkwEnFoldersElementInfoElementComment.GetWordNameForRegister

procedure TkwEnFoldersElementInfoElementComment.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_4551FFBCF0C6_var*
//#UC END# *52D00B00031A_4551FFBCF0C6_var*
begin
//#UC START# *52D00B00031A_4551FFBCF0C6_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_4551FFBCF0C6_impl*
end;//TkwEnFoldersElementInfoElementComment.SetValuePrim

function TkwEnFoldersElementInfoElementComment.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4551FFBCF0C6_var*
//#UC END# *551544E2001A_4551FFBCF0C6_var*
begin
//#UC START# *551544E2001A_4551FFBCF0C6_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_4551FFBCF0C6_impl*
end;//TkwEnFoldersElementInfoElementComment.GetResultTypeInfo

function TkwEnFoldersElementInfoElementComment.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoElementComment.GetAllParamsCount

function TkwEnFoldersElementInfoElementComment.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4551FFBCF0C6_var*
//#UC END# *5617F4D00243_4551FFBCF0C6_var*
begin
//#UC START# *5617F4D00243_4551FFBCF0C6_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4551FFBCF0C6_impl*
end;//TkwEnFoldersElementInfoElementComment.ParamsTypes

function TkwEnFoldersElementInfoCaptionPanel.CaptionPanel(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
 {* Реализация слова скрипта .TenFoldersElementInfo.CaptionPanel }
//#UC START# *70B31DC38D6E_A0B79FE250B1_var*
//#UC END# *70B31DC38D6E_A0B79FE250B1_var*
begin
//#UC START# *70B31DC38D6E_A0B79FE250B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *70B31DC38D6E_A0B79FE250B1_impl*
end;//TkwEnFoldersElementInfoCaptionPanel.CaptionPanel

procedure TkwEnFoldersElementInfoCaptionPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A0B79FE250B1_var*
//#UC END# *4DAEEDE10285_A0B79FE250B1_var*
begin
//#UC START# *4DAEEDE10285_A0B79FE250B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A0B79FE250B1_impl*
end;//TkwEnFoldersElementInfoCaptionPanel.DoDoIt

class function TkwEnFoldersElementInfoCaptionPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.CaptionPanel';
end;//TkwEnFoldersElementInfoCaptionPanel.GetWordNameForRegister

procedure TkwEnFoldersElementInfoCaptionPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A0B79FE250B1_var*
//#UC END# *52D00B00031A_A0B79FE250B1_var*
begin
//#UC START# *52D00B00031A_A0B79FE250B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A0B79FE250B1_impl*
end;//TkwEnFoldersElementInfoCaptionPanel.SetValuePrim

function TkwEnFoldersElementInfoCaptionPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_A0B79FE250B1_var*
//#UC END# *551544E2001A_A0B79FE250B1_var*
begin
//#UC START# *551544E2001A_A0B79FE250B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A0B79FE250B1_impl*
end;//TkwEnFoldersElementInfoCaptionPanel.GetResultTypeInfo

function TkwEnFoldersElementInfoCaptionPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoCaptionPanel.GetAllParamsCount

function TkwEnFoldersElementInfoCaptionPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_A0B79FE250B1_var*
//#UC END# *5617F4D00243_A0B79FE250B1_var*
begin
//#UC START# *5617F4D00243_A0B79FE250B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A0B79FE250B1_impl*
end;//TkwEnFoldersElementInfoCaptionPanel.ParamsTypes

function TkwEnFoldersElementInfoLblComment.lblComment(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TvtLabel;
 {* Реализация слова скрипта .TenFoldersElementInfo.lblComment }
//#UC START# *D66FE10D5BBB_F4AFE53A600D_var*
//#UC END# *D66FE10D5BBB_F4AFE53A600D_var*
begin
//#UC START# *D66FE10D5BBB_F4AFE53A600D_impl*
 !!! Needs to be implemented !!!
//#UC END# *D66FE10D5BBB_F4AFE53A600D_impl*
end;//TkwEnFoldersElementInfoLblComment.lblComment

procedure TkwEnFoldersElementInfoLblComment.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F4AFE53A600D_var*
//#UC END# *4DAEEDE10285_F4AFE53A600D_var*
begin
//#UC START# *4DAEEDE10285_F4AFE53A600D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F4AFE53A600D_impl*
end;//TkwEnFoldersElementInfoLblComment.DoDoIt

class function TkwEnFoldersElementInfoLblComment.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.lblComment';
end;//TkwEnFoldersElementInfoLblComment.GetWordNameForRegister

procedure TkwEnFoldersElementInfoLblComment.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_F4AFE53A600D_var*
//#UC END# *52D00B00031A_F4AFE53A600D_var*
begin
//#UC START# *52D00B00031A_F4AFE53A600D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_F4AFE53A600D_impl*
end;//TkwEnFoldersElementInfoLblComment.SetValuePrim

function TkwEnFoldersElementInfoLblComment.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F4AFE53A600D_var*
//#UC END# *551544E2001A_F4AFE53A600D_var*
begin
//#UC START# *551544E2001A_F4AFE53A600D_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F4AFE53A600D_impl*
end;//TkwEnFoldersElementInfoLblComment.GetResultTypeInfo

function TkwEnFoldersElementInfoLblComment.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoLblComment.GetAllParamsCount

function TkwEnFoldersElementInfoLblComment.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F4AFE53A600D_var*
//#UC END# *5617F4D00243_F4AFE53A600D_var*
begin
//#UC START# *5617F4D00243_F4AFE53A600D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F4AFE53A600D_impl*
end;//TkwEnFoldersElementInfoLblComment.ParamsTypes

function TkwEnFoldersElementInfoTopPanel.TopPanel(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
 {* Реализация слова скрипта .TenFoldersElementInfo.TopPanel }
//#UC START# *D0485E43FFC7_0598428B8405_var*
//#UC END# *D0485E43FFC7_0598428B8405_var*
begin
//#UC START# *D0485E43FFC7_0598428B8405_impl*
 !!! Needs to be implemented !!!
//#UC END# *D0485E43FFC7_0598428B8405_impl*
end;//TkwEnFoldersElementInfoTopPanel.TopPanel

procedure TkwEnFoldersElementInfoTopPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0598428B8405_var*
//#UC END# *4DAEEDE10285_0598428B8405_var*
begin
//#UC START# *4DAEEDE10285_0598428B8405_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0598428B8405_impl*
end;//TkwEnFoldersElementInfoTopPanel.DoDoIt

class function TkwEnFoldersElementInfoTopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.TopPanel';
end;//TkwEnFoldersElementInfoTopPanel.GetWordNameForRegister

procedure TkwEnFoldersElementInfoTopPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_0598428B8405_var*
//#UC END# *52D00B00031A_0598428B8405_var*
begin
//#UC START# *52D00B00031A_0598428B8405_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_0598428B8405_impl*
end;//TkwEnFoldersElementInfoTopPanel.SetValuePrim

function TkwEnFoldersElementInfoTopPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0598428B8405_var*
//#UC END# *551544E2001A_0598428B8405_var*
begin
//#UC START# *551544E2001A_0598428B8405_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0598428B8405_impl*
end;//TkwEnFoldersElementInfoTopPanel.GetResultTypeInfo

function TkwEnFoldersElementInfoTopPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoTopPanel.GetAllParamsCount

function TkwEnFoldersElementInfoTopPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0598428B8405_var*
//#UC END# *5617F4D00243_0598428B8405_var*
begin
//#UC START# *5617F4D00243_0598428B8405_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0598428B8405_impl*
end;//TkwEnFoldersElementInfoTopPanel.ParamsTypes

function TkwEnFoldersElementInfoNamePanel.NamePanel(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
 {* Реализация слова скрипта .TenFoldersElementInfo.NamePanel }
//#UC START# *5F902738E230_52A5040B9075_var*
//#UC END# *5F902738E230_52A5040B9075_var*
begin
//#UC START# *5F902738E230_52A5040B9075_impl*
 !!! Needs to be implemented !!!
//#UC END# *5F902738E230_52A5040B9075_impl*
end;//TkwEnFoldersElementInfoNamePanel.NamePanel

procedure TkwEnFoldersElementInfoNamePanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52A5040B9075_var*
//#UC END# *4DAEEDE10285_52A5040B9075_var*
begin
//#UC START# *4DAEEDE10285_52A5040B9075_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_52A5040B9075_impl*
end;//TkwEnFoldersElementInfoNamePanel.DoDoIt

class function TkwEnFoldersElementInfoNamePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.NamePanel';
end;//TkwEnFoldersElementInfoNamePanel.GetWordNameForRegister

procedure TkwEnFoldersElementInfoNamePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_52A5040B9075_var*
//#UC END# *52D00B00031A_52A5040B9075_var*
begin
//#UC START# *52D00B00031A_52A5040B9075_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_52A5040B9075_impl*
end;//TkwEnFoldersElementInfoNamePanel.SetValuePrim

function TkwEnFoldersElementInfoNamePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_52A5040B9075_var*
//#UC END# *551544E2001A_52A5040B9075_var*
begin
//#UC START# *551544E2001A_52A5040B9075_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_52A5040B9075_impl*
end;//TkwEnFoldersElementInfoNamePanel.GetResultTypeInfo

function TkwEnFoldersElementInfoNamePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoNamePanel.GetAllParamsCount

function TkwEnFoldersElementInfoNamePanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_52A5040B9075_var*
//#UC END# *5617F4D00243_52A5040B9075_var*
begin
//#UC START# *5617F4D00243_52A5040B9075_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_52A5040B9075_impl*
end;//TkwEnFoldersElementInfoNamePanel.ParamsTypes

function TkwEnFoldersElementInfoLblElementName.lblElementName(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TvtLabel;
 {* Реализация слова скрипта .TenFoldersElementInfo.lblElementName }
//#UC START# *16D09F0E0B43_D5C00B48FC3E_var*
//#UC END# *16D09F0E0B43_D5C00B48FC3E_var*
begin
//#UC START# *16D09F0E0B43_D5C00B48FC3E_impl*
 !!! Needs to be implemented !!!
//#UC END# *16D09F0E0B43_D5C00B48FC3E_impl*
end;//TkwEnFoldersElementInfoLblElementName.lblElementName

procedure TkwEnFoldersElementInfoLblElementName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D5C00B48FC3E_var*
//#UC END# *4DAEEDE10285_D5C00B48FC3E_var*
begin
//#UC START# *4DAEEDE10285_D5C00B48FC3E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D5C00B48FC3E_impl*
end;//TkwEnFoldersElementInfoLblElementName.DoDoIt

class function TkwEnFoldersElementInfoLblElementName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.lblElementName';
end;//TkwEnFoldersElementInfoLblElementName.GetWordNameForRegister

procedure TkwEnFoldersElementInfoLblElementName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D5C00B48FC3E_var*
//#UC END# *52D00B00031A_D5C00B48FC3E_var*
begin
//#UC START# *52D00B00031A_D5C00B48FC3E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D5C00B48FC3E_impl*
end;//TkwEnFoldersElementInfoLblElementName.SetValuePrim

function TkwEnFoldersElementInfoLblElementName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D5C00B48FC3E_var*
//#UC END# *551544E2001A_D5C00B48FC3E_var*
begin
//#UC START# *551544E2001A_D5C00B48FC3E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D5C00B48FC3E_impl*
end;//TkwEnFoldersElementInfoLblElementName.GetResultTypeInfo

function TkwEnFoldersElementInfoLblElementName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoLblElementName.GetAllParamsCount

function TkwEnFoldersElementInfoLblElementName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D5C00B48FC3E_var*
//#UC END# *5617F4D00243_D5C00B48FC3E_var*
begin
//#UC START# *5617F4D00243_D5C00B48FC3E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D5C00B48FC3E_impl*
end;//TkwEnFoldersElementInfoLblElementName.ParamsTypes

function TkwEnFoldersElementInfoElementName.ElementName(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TnscComboBoxWithReadOnly;
 {* Реализация слова скрипта .TenFoldersElementInfo.ElementName }
//#UC START# *5DDFB165AD04_267BC48F5895_var*
//#UC END# *5DDFB165AD04_267BC48F5895_var*
begin
//#UC START# *5DDFB165AD04_267BC48F5895_impl*
 !!! Needs to be implemented !!!
//#UC END# *5DDFB165AD04_267BC48F5895_impl*
end;//TkwEnFoldersElementInfoElementName.ElementName

procedure TkwEnFoldersElementInfoElementName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_267BC48F5895_var*
//#UC END# *4DAEEDE10285_267BC48F5895_var*
begin
//#UC START# *4DAEEDE10285_267BC48F5895_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_267BC48F5895_impl*
end;//TkwEnFoldersElementInfoElementName.DoDoIt

class function TkwEnFoldersElementInfoElementName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.ElementName';
end;//TkwEnFoldersElementInfoElementName.GetWordNameForRegister

procedure TkwEnFoldersElementInfoElementName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_267BC48F5895_var*
//#UC END# *52D00B00031A_267BC48F5895_var*
begin
//#UC START# *52D00B00031A_267BC48F5895_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_267BC48F5895_impl*
end;//TkwEnFoldersElementInfoElementName.SetValuePrim

function TkwEnFoldersElementInfoElementName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_267BC48F5895_var*
//#UC END# *551544E2001A_267BC48F5895_var*
begin
//#UC START# *551544E2001A_267BC48F5895_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_267BC48F5895_impl*
end;//TkwEnFoldersElementInfoElementName.GetResultTypeInfo

function TkwEnFoldersElementInfoElementName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoElementName.GetAllParamsCount

function TkwEnFoldersElementInfoElementName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_267BC48F5895_var*
//#UC END# *5617F4D00243_267BC48F5895_var*
begin
//#UC START# *5617F4D00243_267BC48F5895_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_267BC48F5895_impl*
end;//TkwEnFoldersElementInfoElementName.ParamsTypes

function TkwEnFoldersElementInfoCbShared.cbShared(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TvtCheckBox;
 {* Реализация слова скрипта .TenFoldersElementInfo.cbShared }
//#UC START# *334AECAD88B1_11977A9AAA59_var*
//#UC END# *334AECAD88B1_11977A9AAA59_var*
begin
//#UC START# *334AECAD88B1_11977A9AAA59_impl*
 !!! Needs to be implemented !!!
//#UC END# *334AECAD88B1_11977A9AAA59_impl*
end;//TkwEnFoldersElementInfoCbShared.cbShared

procedure TkwEnFoldersElementInfoCbShared.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_11977A9AAA59_var*
//#UC END# *4DAEEDE10285_11977A9AAA59_var*
begin
//#UC START# *4DAEEDE10285_11977A9AAA59_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_11977A9AAA59_impl*
end;//TkwEnFoldersElementInfoCbShared.DoDoIt

class function TkwEnFoldersElementInfoCbShared.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.cbShared';
end;//TkwEnFoldersElementInfoCbShared.GetWordNameForRegister

procedure TkwEnFoldersElementInfoCbShared.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_11977A9AAA59_var*
//#UC END# *52D00B00031A_11977A9AAA59_var*
begin
//#UC START# *52D00B00031A_11977A9AAA59_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_11977A9AAA59_impl*
end;//TkwEnFoldersElementInfoCbShared.SetValuePrim

function TkwEnFoldersElementInfoCbShared.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_11977A9AAA59_var*
//#UC END# *551544E2001A_11977A9AAA59_var*
begin
//#UC START# *551544E2001A_11977A9AAA59_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_11977A9AAA59_impl*
end;//TkwEnFoldersElementInfoCbShared.GetResultTypeInfo

function TkwEnFoldersElementInfoCbShared.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoCbShared.GetAllParamsCount

function TkwEnFoldersElementInfoCbShared.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_11977A9AAA59_var*
//#UC END# *5617F4D00243_11977A9AAA59_var*
begin
//#UC START# *5617F4D00243_11977A9AAA59_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_11977A9AAA59_impl*
end;//TkwEnFoldersElementInfoCbShared.ParamsTypes

function TkwEnFoldersElementInfoInfoName.InfoName(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TvtLabel;
 {* Реализация слова скрипта .TenFoldersElementInfo.InfoName }
//#UC START# *85618E8FF478_4CFE9C00804F_var*
//#UC END# *85618E8FF478_4CFE9C00804F_var*
begin
//#UC START# *85618E8FF478_4CFE9C00804F_impl*
 !!! Needs to be implemented !!!
//#UC END# *85618E8FF478_4CFE9C00804F_impl*
end;//TkwEnFoldersElementInfoInfoName.InfoName

procedure TkwEnFoldersElementInfoInfoName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4CFE9C00804F_var*
//#UC END# *4DAEEDE10285_4CFE9C00804F_var*
begin
//#UC START# *4DAEEDE10285_4CFE9C00804F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4CFE9C00804F_impl*
end;//TkwEnFoldersElementInfoInfoName.DoDoIt

class function TkwEnFoldersElementInfoInfoName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.InfoName';
end;//TkwEnFoldersElementInfoInfoName.GetWordNameForRegister

procedure TkwEnFoldersElementInfoInfoName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_4CFE9C00804F_var*
//#UC END# *52D00B00031A_4CFE9C00804F_var*
begin
//#UC START# *52D00B00031A_4CFE9C00804F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_4CFE9C00804F_impl*
end;//TkwEnFoldersElementInfoInfoName.SetValuePrim

function TkwEnFoldersElementInfoInfoName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4CFE9C00804F_var*
//#UC END# *551544E2001A_4CFE9C00804F_var*
begin
//#UC START# *551544E2001A_4CFE9C00804F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_4CFE9C00804F_impl*
end;//TkwEnFoldersElementInfoInfoName.GetResultTypeInfo

function TkwEnFoldersElementInfoInfoName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoInfoName.GetAllParamsCount

function TkwEnFoldersElementInfoInfoName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4CFE9C00804F_var*
//#UC END# *5617F4D00243_4CFE9C00804F_var*
begin
//#UC START# *5617F4D00243_4CFE9C00804F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4CFE9C00804F_impl*
end;//TkwEnFoldersElementInfoInfoName.ParamsTypes

initialization
 Tkw_Form_FoldersElementInfo.RegisterInEngine;
 {* Регистрация Tkw_Form_FoldersElementInfo }
 Tkw_FoldersElementInfo_Control_CommentPanel.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_CommentPanel }
 Tkw_FoldersElementInfo_Control_CommentPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_CommentPanel_Push }
 Tkw_FoldersElementInfo_Control_ElementComment.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_ElementComment }
 Tkw_FoldersElementInfo_Control_ElementComment_Push.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_ElementComment_Push }
 Tkw_FoldersElementInfo_Control_CaptionPanel.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_CaptionPanel }
 Tkw_FoldersElementInfo_Control_CaptionPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_CaptionPanel_Push }
 Tkw_FoldersElementInfo_Control_lblComment.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_lblComment }
 Tkw_FoldersElementInfo_Control_lblComment_Push.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_lblComment_Push }
 Tkw_FoldersElementInfo_Control_TopPanel.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_TopPanel }
 Tkw_FoldersElementInfo_Control_TopPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_TopPanel_Push }
 Tkw_FoldersElementInfo_Control_NamePanel.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_NamePanel }
 Tkw_FoldersElementInfo_Control_NamePanel_Push.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_NamePanel_Push }
 Tkw_FoldersElementInfo_Control_lblElementName.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_lblElementName }
 Tkw_FoldersElementInfo_Control_lblElementName_Push.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_lblElementName_Push }
 Tkw_FoldersElementInfo_Control_ElementName.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_ElementName }
 Tkw_FoldersElementInfo_Control_ElementName_Push.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_ElementName_Push }
 Tkw_FoldersElementInfo_Control_cbShared.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_cbShared }
 Tkw_FoldersElementInfo_Control_cbShared_Push.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_cbShared_Push }
 Tkw_FoldersElementInfo_Control_InfoName.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_InfoName }
 Tkw_FoldersElementInfo_Control_InfoName_Push.RegisterInEngine;
 {* Регистрация Tkw_FoldersElementInfo_Control_InfoName_Push }
 TkwEnFoldersElementInfoCommentPanel.RegisterInEngine;
 {* Регистрация enFoldersElementInfo_CommentPanel }
 TkwEnFoldersElementInfoElementComment.RegisterInEngine;
 {* Регистрация enFoldersElementInfo_ElementComment }
 TkwEnFoldersElementInfoCaptionPanel.RegisterInEngine;
 {* Регистрация enFoldersElementInfo_CaptionPanel }
 TkwEnFoldersElementInfoLblComment.RegisterInEngine;
 {* Регистрация enFoldersElementInfo_lblComment }
 TkwEnFoldersElementInfoTopPanel.RegisterInEngine;
 {* Регистрация enFoldersElementInfo_TopPanel }
 TkwEnFoldersElementInfoNamePanel.RegisterInEngine;
 {* Регистрация enFoldersElementInfo_NamePanel }
 TkwEnFoldersElementInfoLblElementName.RegisterInEngine;
 {* Регистрация enFoldersElementInfo_lblElementName }
 TkwEnFoldersElementInfoElementName.RegisterInEngine;
 {* Регистрация enFoldersElementInfo_ElementName }
 TkwEnFoldersElementInfoCbShared.RegisterInEngine;
 {* Регистрация enFoldersElementInfo_cbShared }
 TkwEnFoldersElementInfoInfoName.RegisterInEngine;
 {* Регистрация enFoldersElementInfo_InfoName }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenFoldersElementInfo));
 {* Регистрация типа FoldersElementInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeMemoWithEditOperations));
 {* Регистрация типа TeeMemoWithEditOperations }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscComboBoxWithReadOnly));
 {* Регистрация типа TnscComboBoxWithReadOnly }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCheckBox));
 {* Регистрация типа TvtCheckBox }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
