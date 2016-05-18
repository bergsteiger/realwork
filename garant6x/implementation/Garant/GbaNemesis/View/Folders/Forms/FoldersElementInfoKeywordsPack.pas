unit FoldersElementInfoKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы FoldersElementInfo }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\FoldersElementInfoKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "FoldersElementInfoKeywordsPack" MUID: (4ABCD2AB00C5_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , FoldersElementInfo_Form
 , tfwPropertyLike
 , vtPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , eeMemoWithEditOperations
 , vtLabel
 {$If Defined(Nemesis)}
 , nscComboBoxWithReadOnly
 {$IfEnd} // Defined(Nemesis)
 , vtCheckBox
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwEnFoldersElementInfoCommentPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.CommentPanel }
  private
   function CommentPanel(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
    {* Реализация слова скрипта .TenFoldersElementInfo.CommentPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnFoldersElementInfoCommentPanel

 TkwEnFoldersElementInfoElementComment = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.ElementComment }
  private
   function ElementComment(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TeeMemoWithEditOperations;
    {* Реализация слова скрипта .TenFoldersElementInfo.ElementComment }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnFoldersElementInfoElementComment

 TkwEnFoldersElementInfoCaptionPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.CaptionPanel }
  private
   function CaptionPanel(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
    {* Реализация слова скрипта .TenFoldersElementInfo.CaptionPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnFoldersElementInfoCaptionPanel

 TkwEnFoldersElementInfoLblComment = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.lblComment }
  private
   function lblComment(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TvtLabel;
    {* Реализация слова скрипта .TenFoldersElementInfo.lblComment }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnFoldersElementInfoLblComment

 TkwEnFoldersElementInfoTopPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.TopPanel }
  private
   function TopPanel(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
    {* Реализация слова скрипта .TenFoldersElementInfo.TopPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnFoldersElementInfoTopPanel

 TkwEnFoldersElementInfoNamePanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.NamePanel }
  private
   function NamePanel(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
    {* Реализация слова скрипта .TenFoldersElementInfo.NamePanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnFoldersElementInfoNamePanel

 TkwEnFoldersElementInfoLblElementName = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.lblElementName }
  private
   function lblElementName(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TvtLabel;
    {* Реализация слова скрипта .TenFoldersElementInfo.lblElementName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnFoldersElementInfoLblElementName

 TkwEnFoldersElementInfoElementName = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.ElementName }
  private
   function ElementName(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TnscComboBoxWithReadOnly;
    {* Реализация слова скрипта .TenFoldersElementInfo.ElementName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnFoldersElementInfoElementName

 TkwEnFoldersElementInfoCbShared = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.cbShared }
  private
   function cbShared(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TvtCheckBox;
    {* Реализация слова скрипта .TenFoldersElementInfo.cbShared }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnFoldersElementInfoCbShared

 TkwEnFoldersElementInfoInfoName = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersElementInfo.InfoName }
  private
   function InfoName(const aCtx: TtfwContext;
    aenFoldersElementInfo: TenFoldersElementInfo): TvtLabel;
    {* Реализация слова скрипта .TenFoldersElementInfo.InfoName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnFoldersElementInfoInfoName

 Tkw_Form_FoldersElementInfo = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы FoldersElementInfo
----
*Пример использования*:
[code]форма::FoldersElementInfo TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_FoldersElementInfo

 Tkw_FoldersElementInfo_Control_CommentPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола CommentPanel
----
*Пример использования*:
[code]контрол::CommentPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_CommentPanel

 Tkw_FoldersElementInfo_Control_CommentPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола CommentPanel
----
*Пример использования*:
[code]контрол::CommentPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_CommentPanel_Push

 Tkw_FoldersElementInfo_Control_ElementComment = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ElementComment
----
*Пример использования*:
[code]контрол::ElementComment TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_ElementComment

 Tkw_FoldersElementInfo_Control_ElementComment_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ElementComment
----
*Пример использования*:
[code]контрол::ElementComment:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_ElementComment_Push

 Tkw_FoldersElementInfo_Control_CaptionPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола CaptionPanel
----
*Пример использования*:
[code]контрол::CaptionPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_CaptionPanel

 Tkw_FoldersElementInfo_Control_CaptionPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола CaptionPanel
----
*Пример использования*:
[code]контрол::CaptionPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_CaptionPanel_Push

 Tkw_FoldersElementInfo_Control_lblComment = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblComment
----
*Пример использования*:
[code]контрол::lblComment TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_lblComment

 Tkw_FoldersElementInfo_Control_lblComment_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lblComment
----
*Пример использования*:
[code]контрол::lblComment:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_lblComment_Push

 Tkw_FoldersElementInfo_Control_TopPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TopPanel
----
*Пример использования*:
[code]контрол::TopPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_TopPanel

 Tkw_FoldersElementInfo_Control_TopPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола TopPanel
----
*Пример использования*:
[code]контрол::TopPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_TopPanel_Push

 Tkw_FoldersElementInfo_Control_NamePanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола NamePanel
----
*Пример использования*:
[code]контрол::NamePanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_NamePanel

 Tkw_FoldersElementInfo_Control_NamePanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола NamePanel
----
*Пример использования*:
[code]контрол::NamePanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_NamePanel_Push

 Tkw_FoldersElementInfo_Control_lblElementName = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblElementName
----
*Пример использования*:
[code]контрол::lblElementName TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_lblElementName

 Tkw_FoldersElementInfo_Control_lblElementName_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lblElementName
----
*Пример использования*:
[code]контрол::lblElementName:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_lblElementName_Push

 Tkw_FoldersElementInfo_Control_ElementName = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ElementName
----
*Пример использования*:
[code]контрол::ElementName TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_ElementName

 Tkw_FoldersElementInfo_Control_ElementName_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ElementName
----
*Пример использования*:
[code]контрол::ElementName:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_ElementName_Push

 Tkw_FoldersElementInfo_Control_cbShared = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола cbShared
----
*Пример использования*:
[code]контрол::cbShared TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_cbShared

 Tkw_FoldersElementInfo_Control_cbShared_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола cbShared
----
*Пример использования*:
[code]контрол::cbShared:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_cbShared_Push

 Tkw_FoldersElementInfo_Control_InfoName = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола InfoName
----
*Пример использования*:
[code]контрол::InfoName TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_InfoName

 Tkw_FoldersElementInfo_Control_InfoName_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола InfoName
----
*Пример использования*:
[code]контрол::InfoName:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersElementInfo_Control_InfoName_Push

function TkwEnFoldersElementInfoCommentPanel.CommentPanel(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
 {* Реализация слова скрипта .TenFoldersElementInfo.CommentPanel }
begin
 Result := aenFoldersElementInfo.CommentPanel;
end;//TkwEnFoldersElementInfoCommentPanel.CommentPanel

class function TkwEnFoldersElementInfoCommentPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.CommentPanel';
end;//TkwEnFoldersElementInfoCommentPanel.GetWordNameForRegister

function TkwEnFoldersElementInfoCommentPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnFoldersElementInfoCommentPanel.GetResultTypeInfo

function TkwEnFoldersElementInfoCommentPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoCommentPanel.GetAllParamsCount

function TkwEnFoldersElementInfoCommentPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoCommentPanel.ParamsTypes

procedure TkwEnFoldersElementInfoCommentPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству CommentPanel', aCtx);
end;//TkwEnFoldersElementInfoCommentPanel.SetValuePrim

procedure TkwEnFoldersElementInfoCommentPanel.DoDoIt(const aCtx: TtfwContext);
var l_aenFoldersElementInfo: TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(CommentPanel(aCtx, l_aenFoldersElementInfo));
end;//TkwEnFoldersElementInfoCommentPanel.DoDoIt

function TkwEnFoldersElementInfoElementComment.ElementComment(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TeeMemoWithEditOperations;
 {* Реализация слова скрипта .TenFoldersElementInfo.ElementComment }
begin
 Result := aenFoldersElementInfo.ElementComment;
end;//TkwEnFoldersElementInfoElementComment.ElementComment

class function TkwEnFoldersElementInfoElementComment.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.ElementComment';
end;//TkwEnFoldersElementInfoElementComment.GetWordNameForRegister

function TkwEnFoldersElementInfoElementComment.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeMemoWithEditOperations);
end;//TkwEnFoldersElementInfoElementComment.GetResultTypeInfo

function TkwEnFoldersElementInfoElementComment.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoElementComment.GetAllParamsCount

function TkwEnFoldersElementInfoElementComment.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoElementComment.ParamsTypes

procedure TkwEnFoldersElementInfoElementComment.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ElementComment', aCtx);
end;//TkwEnFoldersElementInfoElementComment.SetValuePrim

procedure TkwEnFoldersElementInfoElementComment.DoDoIt(const aCtx: TtfwContext);
var l_aenFoldersElementInfo: TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ElementComment(aCtx, l_aenFoldersElementInfo));
end;//TkwEnFoldersElementInfoElementComment.DoDoIt

function TkwEnFoldersElementInfoCaptionPanel.CaptionPanel(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
 {* Реализация слова скрипта .TenFoldersElementInfo.CaptionPanel }
begin
 Result := aenFoldersElementInfo.CaptionPanel;
end;//TkwEnFoldersElementInfoCaptionPanel.CaptionPanel

class function TkwEnFoldersElementInfoCaptionPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.CaptionPanel';
end;//TkwEnFoldersElementInfoCaptionPanel.GetWordNameForRegister

function TkwEnFoldersElementInfoCaptionPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnFoldersElementInfoCaptionPanel.GetResultTypeInfo

function TkwEnFoldersElementInfoCaptionPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoCaptionPanel.GetAllParamsCount

function TkwEnFoldersElementInfoCaptionPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoCaptionPanel.ParamsTypes

procedure TkwEnFoldersElementInfoCaptionPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству CaptionPanel', aCtx);
end;//TkwEnFoldersElementInfoCaptionPanel.SetValuePrim

procedure TkwEnFoldersElementInfoCaptionPanel.DoDoIt(const aCtx: TtfwContext);
var l_aenFoldersElementInfo: TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(CaptionPanel(aCtx, l_aenFoldersElementInfo));
end;//TkwEnFoldersElementInfoCaptionPanel.DoDoIt

function TkwEnFoldersElementInfoLblComment.lblComment(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TvtLabel;
 {* Реализация слова скрипта .TenFoldersElementInfo.lblComment }
begin
 Result := aenFoldersElementInfo.lblComment;
end;//TkwEnFoldersElementInfoLblComment.lblComment

class function TkwEnFoldersElementInfoLblComment.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.lblComment';
end;//TkwEnFoldersElementInfoLblComment.GetWordNameForRegister

function TkwEnFoldersElementInfoLblComment.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnFoldersElementInfoLblComment.GetResultTypeInfo

function TkwEnFoldersElementInfoLblComment.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoLblComment.GetAllParamsCount

function TkwEnFoldersElementInfoLblComment.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoLblComment.ParamsTypes

procedure TkwEnFoldersElementInfoLblComment.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblComment', aCtx);
end;//TkwEnFoldersElementInfoLblComment.SetValuePrim

procedure TkwEnFoldersElementInfoLblComment.DoDoIt(const aCtx: TtfwContext);
var l_aenFoldersElementInfo: TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblComment(aCtx, l_aenFoldersElementInfo));
end;//TkwEnFoldersElementInfoLblComment.DoDoIt

function TkwEnFoldersElementInfoTopPanel.TopPanel(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
 {* Реализация слова скрипта .TenFoldersElementInfo.TopPanel }
begin
 Result := aenFoldersElementInfo.TopPanel;
end;//TkwEnFoldersElementInfoTopPanel.TopPanel

class function TkwEnFoldersElementInfoTopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.TopPanel';
end;//TkwEnFoldersElementInfoTopPanel.GetWordNameForRegister

function TkwEnFoldersElementInfoTopPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnFoldersElementInfoTopPanel.GetResultTypeInfo

function TkwEnFoldersElementInfoTopPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoTopPanel.GetAllParamsCount

function TkwEnFoldersElementInfoTopPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoTopPanel.ParamsTypes

procedure TkwEnFoldersElementInfoTopPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству TopPanel', aCtx);
end;//TkwEnFoldersElementInfoTopPanel.SetValuePrim

procedure TkwEnFoldersElementInfoTopPanel.DoDoIt(const aCtx: TtfwContext);
var l_aenFoldersElementInfo: TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TopPanel(aCtx, l_aenFoldersElementInfo));
end;//TkwEnFoldersElementInfoTopPanel.DoDoIt

function TkwEnFoldersElementInfoNamePanel.NamePanel(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
 {* Реализация слова скрипта .TenFoldersElementInfo.NamePanel }
begin
 Result := aenFoldersElementInfo.NamePanel;
end;//TkwEnFoldersElementInfoNamePanel.NamePanel

class function TkwEnFoldersElementInfoNamePanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.NamePanel';
end;//TkwEnFoldersElementInfoNamePanel.GetWordNameForRegister

function TkwEnFoldersElementInfoNamePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnFoldersElementInfoNamePanel.GetResultTypeInfo

function TkwEnFoldersElementInfoNamePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoNamePanel.GetAllParamsCount

function TkwEnFoldersElementInfoNamePanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoNamePanel.ParamsTypes

procedure TkwEnFoldersElementInfoNamePanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству NamePanel', aCtx);
end;//TkwEnFoldersElementInfoNamePanel.SetValuePrim

procedure TkwEnFoldersElementInfoNamePanel.DoDoIt(const aCtx: TtfwContext);
var l_aenFoldersElementInfo: TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(NamePanel(aCtx, l_aenFoldersElementInfo));
end;//TkwEnFoldersElementInfoNamePanel.DoDoIt

function TkwEnFoldersElementInfoLblElementName.lblElementName(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TvtLabel;
 {* Реализация слова скрипта .TenFoldersElementInfo.lblElementName }
begin
 Result := aenFoldersElementInfo.lblElementName;
end;//TkwEnFoldersElementInfoLblElementName.lblElementName

class function TkwEnFoldersElementInfoLblElementName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.lblElementName';
end;//TkwEnFoldersElementInfoLblElementName.GetWordNameForRegister

function TkwEnFoldersElementInfoLblElementName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnFoldersElementInfoLblElementName.GetResultTypeInfo

function TkwEnFoldersElementInfoLblElementName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoLblElementName.GetAllParamsCount

function TkwEnFoldersElementInfoLblElementName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoLblElementName.ParamsTypes

procedure TkwEnFoldersElementInfoLblElementName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblElementName', aCtx);
end;//TkwEnFoldersElementInfoLblElementName.SetValuePrim

procedure TkwEnFoldersElementInfoLblElementName.DoDoIt(const aCtx: TtfwContext);
var l_aenFoldersElementInfo: TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblElementName(aCtx, l_aenFoldersElementInfo));
end;//TkwEnFoldersElementInfoLblElementName.DoDoIt

function TkwEnFoldersElementInfoElementName.ElementName(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TnscComboBoxWithReadOnly;
 {* Реализация слова скрипта .TenFoldersElementInfo.ElementName }
begin
 Result := aenFoldersElementInfo.ElementName;
end;//TkwEnFoldersElementInfoElementName.ElementName

class function TkwEnFoldersElementInfoElementName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.ElementName';
end;//TkwEnFoldersElementInfoElementName.GetWordNameForRegister

function TkwEnFoldersElementInfoElementName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscComboBoxWithReadOnly);
end;//TkwEnFoldersElementInfoElementName.GetResultTypeInfo

function TkwEnFoldersElementInfoElementName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoElementName.GetAllParamsCount

function TkwEnFoldersElementInfoElementName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoElementName.ParamsTypes

procedure TkwEnFoldersElementInfoElementName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ElementName', aCtx);
end;//TkwEnFoldersElementInfoElementName.SetValuePrim

procedure TkwEnFoldersElementInfoElementName.DoDoIt(const aCtx: TtfwContext);
var l_aenFoldersElementInfo: TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ElementName(aCtx, l_aenFoldersElementInfo));
end;//TkwEnFoldersElementInfoElementName.DoDoIt

function TkwEnFoldersElementInfoCbShared.cbShared(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TvtCheckBox;
 {* Реализация слова скрипта .TenFoldersElementInfo.cbShared }
begin
 Result := aenFoldersElementInfo.cbShared;
end;//TkwEnFoldersElementInfoCbShared.cbShared

class function TkwEnFoldersElementInfoCbShared.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.cbShared';
end;//TkwEnFoldersElementInfoCbShared.GetWordNameForRegister

function TkwEnFoldersElementInfoCbShared.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwEnFoldersElementInfoCbShared.GetResultTypeInfo

function TkwEnFoldersElementInfoCbShared.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoCbShared.GetAllParamsCount

function TkwEnFoldersElementInfoCbShared.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoCbShared.ParamsTypes

procedure TkwEnFoldersElementInfoCbShared.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству cbShared', aCtx);
end;//TkwEnFoldersElementInfoCbShared.SetValuePrim

procedure TkwEnFoldersElementInfoCbShared.DoDoIt(const aCtx: TtfwContext);
var l_aenFoldersElementInfo: TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(cbShared(aCtx, l_aenFoldersElementInfo));
end;//TkwEnFoldersElementInfoCbShared.DoDoIt

function TkwEnFoldersElementInfoInfoName.InfoName(const aCtx: TtfwContext;
 aenFoldersElementInfo: TenFoldersElementInfo): TvtLabel;
 {* Реализация слова скрипта .TenFoldersElementInfo.InfoName }
begin
 Result := aenFoldersElementInfo.InfoName;
end;//TkwEnFoldersElementInfoInfoName.InfoName

class function TkwEnFoldersElementInfoInfoName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersElementInfo.InfoName';
end;//TkwEnFoldersElementInfoInfoName.GetWordNameForRegister

function TkwEnFoldersElementInfoInfoName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnFoldersElementInfoInfoName.GetResultTypeInfo

function TkwEnFoldersElementInfoInfoName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersElementInfoInfoName.GetAllParamsCount

function TkwEnFoldersElementInfoInfoName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoInfoName.ParamsTypes

procedure TkwEnFoldersElementInfoInfoName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству InfoName', aCtx);
end;//TkwEnFoldersElementInfoInfoName.SetValuePrim

procedure TkwEnFoldersElementInfoInfoName.DoDoIt(const aCtx: TtfwContext);
var l_aenFoldersElementInfo: TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(InfoName(aCtx, l_aenFoldersElementInfo));
end;//TkwEnFoldersElementInfoInfoName.DoDoIt

function Tkw_Form_FoldersElementInfo.GetString: AnsiString;
begin
 Result := 'enFoldersElementInfo';
end;//Tkw_Form_FoldersElementInfo.GetString

class procedure Tkw_Form_FoldersElementInfo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TenFoldersElementInfo);
end;//Tkw_Form_FoldersElementInfo.RegisterInEngine

class function Tkw_Form_FoldersElementInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::FoldersElementInfo';
end;//Tkw_Form_FoldersElementInfo.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_CommentPanel.GetString: AnsiString;
begin
 Result := 'CommentPanel';
end;//Tkw_FoldersElementInfo_Control_CommentPanel.GetString

class procedure Tkw_FoldersElementInfo_Control_CommentPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_FoldersElementInfo_Control_CommentPanel.RegisterInEngine

class function Tkw_FoldersElementInfo_Control_CommentPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CommentPanel';
end;//Tkw_FoldersElementInfo_Control_CommentPanel.GetWordNameForRegister

procedure Tkw_FoldersElementInfo_Control_CommentPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('CommentPanel');
 inherited;
end;//Tkw_FoldersElementInfo_Control_CommentPanel_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_CommentPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CommentPanel:push';
end;//Tkw_FoldersElementInfo_Control_CommentPanel_Push.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_ElementComment.GetString: AnsiString;
begin
 Result := 'ElementComment';
end;//Tkw_FoldersElementInfo_Control_ElementComment.GetString

class procedure Tkw_FoldersElementInfo_Control_ElementComment.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeMemoWithEditOperations);
end;//Tkw_FoldersElementInfo_Control_ElementComment.RegisterInEngine

class function Tkw_FoldersElementInfo_Control_ElementComment.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElementComment';
end;//Tkw_FoldersElementInfo_Control_ElementComment.GetWordNameForRegister

procedure Tkw_FoldersElementInfo_Control_ElementComment_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ElementComment');
 inherited;
end;//Tkw_FoldersElementInfo_Control_ElementComment_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_ElementComment_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElementComment:push';
end;//Tkw_FoldersElementInfo_Control_ElementComment_Push.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_CaptionPanel.GetString: AnsiString;
begin
 Result := 'CaptionPanel';
end;//Tkw_FoldersElementInfo_Control_CaptionPanel.GetString

class procedure Tkw_FoldersElementInfo_Control_CaptionPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_FoldersElementInfo_Control_CaptionPanel.RegisterInEngine

class function Tkw_FoldersElementInfo_Control_CaptionPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CaptionPanel';
end;//Tkw_FoldersElementInfo_Control_CaptionPanel.GetWordNameForRegister

procedure Tkw_FoldersElementInfo_Control_CaptionPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('CaptionPanel');
 inherited;
end;//Tkw_FoldersElementInfo_Control_CaptionPanel_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_CaptionPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CaptionPanel:push';
end;//Tkw_FoldersElementInfo_Control_CaptionPanel_Push.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_lblComment.GetString: AnsiString;
begin
 Result := 'lblComment';
end;//Tkw_FoldersElementInfo_Control_lblComment.GetString

class procedure Tkw_FoldersElementInfo_Control_lblComment.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_FoldersElementInfo_Control_lblComment.RegisterInEngine

class function Tkw_FoldersElementInfo_Control_lblComment.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblComment';
end;//Tkw_FoldersElementInfo_Control_lblComment.GetWordNameForRegister

procedure Tkw_FoldersElementInfo_Control_lblComment_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblComment');
 inherited;
end;//Tkw_FoldersElementInfo_Control_lblComment_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_lblComment_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblComment:push';
end;//Tkw_FoldersElementInfo_Control_lblComment_Push.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_TopPanel.GetString: AnsiString;
begin
 Result := 'TopPanel';
end;//Tkw_FoldersElementInfo_Control_TopPanel.GetString

class procedure Tkw_FoldersElementInfo_Control_TopPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_FoldersElementInfo_Control_TopPanel.RegisterInEngine

class function Tkw_FoldersElementInfo_Control_TopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TopPanel';
end;//Tkw_FoldersElementInfo_Control_TopPanel.GetWordNameForRegister

procedure Tkw_FoldersElementInfo_Control_TopPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('TopPanel');
 inherited;
end;//Tkw_FoldersElementInfo_Control_TopPanel_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_TopPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TopPanel:push';
end;//Tkw_FoldersElementInfo_Control_TopPanel_Push.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_NamePanel.GetString: AnsiString;
begin
 Result := 'NamePanel';
end;//Tkw_FoldersElementInfo_Control_NamePanel.GetString

class procedure Tkw_FoldersElementInfo_Control_NamePanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_FoldersElementInfo_Control_NamePanel.RegisterInEngine

class function Tkw_FoldersElementInfo_Control_NamePanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NamePanel';
end;//Tkw_FoldersElementInfo_Control_NamePanel.GetWordNameForRegister

procedure Tkw_FoldersElementInfo_Control_NamePanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('NamePanel');
 inherited;
end;//Tkw_FoldersElementInfo_Control_NamePanel_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_NamePanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NamePanel:push';
end;//Tkw_FoldersElementInfo_Control_NamePanel_Push.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_lblElementName.GetString: AnsiString;
begin
 Result := 'lblElementName';
end;//Tkw_FoldersElementInfo_Control_lblElementName.GetString

class procedure Tkw_FoldersElementInfo_Control_lblElementName.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_FoldersElementInfo_Control_lblElementName.RegisterInEngine

class function Tkw_FoldersElementInfo_Control_lblElementName.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblElementName';
end;//Tkw_FoldersElementInfo_Control_lblElementName.GetWordNameForRegister

procedure Tkw_FoldersElementInfo_Control_lblElementName_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblElementName');
 inherited;
end;//Tkw_FoldersElementInfo_Control_lblElementName_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_lblElementName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblElementName:push';
end;//Tkw_FoldersElementInfo_Control_lblElementName_Push.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_ElementName.GetString: AnsiString;
begin
 Result := 'ElementName';
end;//Tkw_FoldersElementInfo_Control_ElementName.GetString

class procedure Tkw_FoldersElementInfo_Control_ElementName.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithReadOnly);
end;//Tkw_FoldersElementInfo_Control_ElementName.RegisterInEngine

class function Tkw_FoldersElementInfo_Control_ElementName.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElementName';
end;//Tkw_FoldersElementInfo_Control_ElementName.GetWordNameForRegister

procedure Tkw_FoldersElementInfo_Control_ElementName_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ElementName');
 inherited;
end;//Tkw_FoldersElementInfo_Control_ElementName_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_ElementName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ElementName:push';
end;//Tkw_FoldersElementInfo_Control_ElementName_Push.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_cbShared.GetString: AnsiString;
begin
 Result := 'cbShared';
end;//Tkw_FoldersElementInfo_Control_cbShared.GetString

class procedure Tkw_FoldersElementInfo_Control_cbShared.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_FoldersElementInfo_Control_cbShared.RegisterInEngine

class function Tkw_FoldersElementInfo_Control_cbShared.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cbShared';
end;//Tkw_FoldersElementInfo_Control_cbShared.GetWordNameForRegister

procedure Tkw_FoldersElementInfo_Control_cbShared_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('cbShared');
 inherited;
end;//Tkw_FoldersElementInfo_Control_cbShared_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_cbShared_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cbShared:push';
end;//Tkw_FoldersElementInfo_Control_cbShared_Push.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_InfoName.GetString: AnsiString;
begin
 Result := 'InfoName';
end;//Tkw_FoldersElementInfo_Control_InfoName.GetString

class procedure Tkw_FoldersElementInfo_Control_InfoName.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_FoldersElementInfo_Control_InfoName.RegisterInEngine

class function Tkw_FoldersElementInfo_Control_InfoName.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::InfoName';
end;//Tkw_FoldersElementInfo_Control_InfoName.GetWordNameForRegister

procedure Tkw_FoldersElementInfo_Control_InfoName_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('InfoName');
 inherited;
end;//Tkw_FoldersElementInfo_Control_InfoName_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_InfoName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::InfoName:push';
end;//Tkw_FoldersElementInfo_Control_InfoName_Push.GetWordNameForRegister

initialization
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
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenFoldersElementInfo));
 {* Регистрация типа TenFoldersElementInfo }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
