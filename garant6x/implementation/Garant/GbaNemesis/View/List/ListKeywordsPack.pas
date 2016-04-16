unit ListKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы List }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\ListKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ListKeywordsPack" MUID: (0F9EB2C7D445)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If Defined(Nemesis)}
 , nscRemindersLine
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscReminder
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscEditor
 {$IfEnd} // Defined(Nemesis)
 , vtPanel
 , nscDocumentListTreeView
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , vtFocusLabel
 , bsTypes
 , l3TreeInterfaces
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , List_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_List = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы List
----
*Пример использования*:
[code]
'aControl' форма::List TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_List

 Tkw_List_Control_RemindersLine = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RemindersLine
----
*Пример использования*:
[code]
контрол::RemindersLine TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_RemindersLine

 Tkw_List_Control_RemindersLine_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола RemindersLine
----
*Пример использования*:
[code]
контрол::RemindersLine:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_RemindersLine_Push

 Tkw_List_Control_remListFiltered = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола remListFiltered
----
*Пример использования*:
[code]
контрол::remListFiltered TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_remListFiltered

 Tkw_List_Control_remListFiltered_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола remListFiltered
----
*Пример использования*:
[code]
контрол::remListFiltered:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_remListFiltered_Push

 Tkw_List_Control_remListModified = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола remListModified
----
*Пример использования*:
[code]
контрол::remListModified TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_remListModified

 Tkw_List_Control_remListModified_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола remListModified
----
*Пример использования*:
[code]
контрол::remListModified:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_remListModified_Push

 Tkw_List_Control_remTimeMachineWarning = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола remTimeMachineWarning
----
*Пример использования*:
[code]
контрол::remTimeMachineWarning TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_remTimeMachineWarning

 Tkw_List_Control_remTimeMachineWarning_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола remTimeMachineWarning
----
*Пример использования*:
[code]
контрол::remTimeMachineWarning:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_remTimeMachineWarning_Push

 Tkw_List_Control_EmptyListEditor = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола EmptyListEditor
----
*Пример использования*:
[code]
контрол::EmptyListEditor TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_EmptyListEditor

 Tkw_List_Control_EmptyListEditor_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола EmptyListEditor
----
*Пример использования*:
[code]
контрол::EmptyListEditor:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_EmptyListEditor_Push

 Tkw_List_Control_ListPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ListPanel
----
*Пример использования*:
[code]
контрол::ListPanel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_ListPanel

 Tkw_List_Control_ListPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола ListPanel
----
*Пример использования*:
[code]
контрол::ListPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_ListPanel_Push

 Tkw_List_Control_tvList = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvList
----
*Пример использования*:
[code]
контрол::tvList TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_tvList

 Tkw_List_Control_tvList_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола tvList
----
*Пример использования*:
[code]
контрол::tvList:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_tvList_Push

 Tkw_List_Control_cfList = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола cfList
----
*Пример использования*:
[code]
контрол::cfList TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_cfList

 Tkw_List_Control_cfList_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола cfList
----
*Пример использования*:
[code]
контрол::cfList:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_cfList_Push

 Tkw_List_Control_ExSearchPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ExSearchPanel
----
*Пример использования*:
[code]
контрол::ExSearchPanel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_ExSearchPanel

 Tkw_List_Control_ExSearchPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола ExSearchPanel
----
*Пример использования*:
[code]
контрол::ExSearchPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_ExSearchPanel_Push

 Tkw_List_Control_ExSearchLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ExSearchLabel
----
*Пример использования*:
[code]
контрол::ExSearchLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_ExSearchLabel

 Tkw_List_Control_ExSearchLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола ExSearchLabel
----
*Пример использования*:
[code]
контрол::ExSearchLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_List_Control_ExSearchLabel_Push

 TkwEfListRemindersLine = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefList.RemindersLine
[panel]Контрол RemindersLine формы TefList[panel]
*Тип результата:* TnscRemindersLine
*Пример:*
[code]
OBJECT VAR l_TnscRemindersLine
 aefList .TefList.RemindersLine >>> l_TnscRemindersLine
[code]  }
  private
   function RemindersLine(const aCtx: TtfwContext;
    aefList: TefList): TnscRemindersLine;
    {* Реализация слова скрипта .TefList.RemindersLine }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfListRemindersLine

 TkwEfListRemListFiltered = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefList.remListFiltered
[panel]Контрол remListFiltered формы TefList[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aefList .TefList.remListFiltered >>> l_TnscReminder
[code]  }
  private
   function remListFiltered(const aCtx: TtfwContext;
    aefList: TefList): TnscReminder;
    {* Реализация слова скрипта .TefList.remListFiltered }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfListRemListFiltered

 TkwEfListRemListModified = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefList.remListModified
[panel]Контрол remListModified формы TefList[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aefList .TefList.remListModified >>> l_TnscReminder
[code]  }
  private
   function remListModified(const aCtx: TtfwContext;
    aefList: TefList): TnscReminder;
    {* Реализация слова скрипта .TefList.remListModified }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfListRemListModified

 TkwEfListRemTimeMachineWarning = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefList.remTimeMachineWarning
[panel]Контрол remTimeMachineWarning формы TefList[panel]
*Тип результата:* TnscReminder
*Пример:*
[code]
OBJECT VAR l_TnscReminder
 aefList .TefList.remTimeMachineWarning >>> l_TnscReminder
[code]  }
  private
   function remTimeMachineWarning(const aCtx: TtfwContext;
    aefList: TefList): TnscReminder;
    {* Реализация слова скрипта .TefList.remTimeMachineWarning }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfListRemTimeMachineWarning

 TkwEfListEmptyListEditor = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefList.EmptyListEditor
[panel]Контрол EmptyListEditor формы TefList[panel]
*Тип результата:* TnscEditor
*Пример:*
[code]
OBJECT VAR l_TnscEditor
 aefList .TefList.EmptyListEditor >>> l_TnscEditor
[code]  }
  private
   function EmptyListEditor(const aCtx: TtfwContext;
    aefList: TefList): TnscEditor;
    {* Реализация слова скрипта .TefList.EmptyListEditor }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfListEmptyListEditor

 TkwEfListListPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefList.ListPanel
[panel]Контрол ListPanel формы TefList[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aefList .TefList.ListPanel >>> l_TvtPanel
[code]  }
  private
   function ListPanel(const aCtx: TtfwContext;
    aefList: TefList): TvtPanel;
    {* Реализация слова скрипта .TefList.ListPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfListListPanel

 TkwEfListTvList = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefList.tvList
[panel]Контрол tvList формы TefList[panel]
*Тип результата:* TnscDocumentListTreeView
*Пример:*
[code]
OBJECT VAR l_TnscDocumentListTreeView
 aefList .TefList.tvList >>> l_TnscDocumentListTreeView
[code]  }
  private
   function tvList(const aCtx: TtfwContext;
    aefList: TefList): TnscDocumentListTreeView;
    {* Реализация слова скрипта .TefList.tvList }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfListTvList

 TkwEfListCfList = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefList.cfList
[panel]Контрол cfList формы TefList[panel]
*Тип результата:* TnscContextFilter
*Пример:*
[code]
OBJECT VAR l_TnscContextFilter
 aefList .TefList.cfList >>> l_TnscContextFilter
[code]  }
  private
   function cfList(const aCtx: TtfwContext;
    aefList: TefList): TnscContextFilter;
    {* Реализация слова скрипта .TefList.cfList }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfListCfList

 TkwEfListExSearchPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefList.ExSearchPanel
[panel]Контрол ExSearchPanel формы TefList[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aefList .TefList.ExSearchPanel >>> l_TvtPanel
[code]  }
  private
   function ExSearchPanel(const aCtx: TtfwContext;
    aefList: TefList): TvtPanel;
    {* Реализация слова скрипта .TefList.ExSearchPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfListExSearchPanel

 TkwEfListExSearchLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefList.ExSearchLabel
[panel]Контрол ExSearchLabel формы TefList[panel]
*Тип результата:* TvtFocusLabel
*Пример:*
[code]
OBJECT VAR l_TvtFocusLabel
 aefList .TefList.ExSearchLabel >>> l_TvtFocusLabel
[code]  }
  private
   function ExSearchLabel(const aCtx: TtfwContext;
    aefList: TefList): TvtFocusLabel;
    {* Реализация слова скрипта .TefList.ExSearchLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfListExSearchLabel

function Tkw_Form_List.GetString: AnsiString;
begin
 Result := 'efList';
end;//Tkw_Form_List.GetString

class function Tkw_Form_List.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::List';
end;//Tkw_Form_List.GetWordNameForRegister

function Tkw_List_Control_RemindersLine.GetString: AnsiString;
begin
 Result := 'RemindersLine';
end;//Tkw_List_Control_RemindersLine.GetString

class procedure Tkw_List_Control_RemindersLine.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscRemindersLine);
end;//Tkw_List_Control_RemindersLine.RegisterInEngine

class function Tkw_List_Control_RemindersLine.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RemindersLine';
end;//Tkw_List_Control_RemindersLine.GetWordNameForRegister

procedure Tkw_List_Control_RemindersLine_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RemindersLine');
 inherited;
end;//Tkw_List_Control_RemindersLine_Push.DoDoIt

class function Tkw_List_Control_RemindersLine_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RemindersLine:push';
end;//Tkw_List_Control_RemindersLine_Push.GetWordNameForRegister

function Tkw_List_Control_remListFiltered.GetString: AnsiString;
begin
 Result := 'remListFiltered';
end;//Tkw_List_Control_remListFiltered.GetString

class procedure Tkw_List_Control_remListFiltered.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_List_Control_remListFiltered.RegisterInEngine

class function Tkw_List_Control_remListFiltered.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::remListFiltered';
end;//Tkw_List_Control_remListFiltered.GetWordNameForRegister

procedure Tkw_List_Control_remListFiltered_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('remListFiltered');
 inherited;
end;//Tkw_List_Control_remListFiltered_Push.DoDoIt

class function Tkw_List_Control_remListFiltered_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::remListFiltered:push';
end;//Tkw_List_Control_remListFiltered_Push.GetWordNameForRegister

function Tkw_List_Control_remListModified.GetString: AnsiString;
begin
 Result := 'remListModified';
end;//Tkw_List_Control_remListModified.GetString

class procedure Tkw_List_Control_remListModified.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_List_Control_remListModified.RegisterInEngine

class function Tkw_List_Control_remListModified.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::remListModified';
end;//Tkw_List_Control_remListModified.GetWordNameForRegister

procedure Tkw_List_Control_remListModified_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('remListModified');
 inherited;
end;//Tkw_List_Control_remListModified_Push.DoDoIt

class function Tkw_List_Control_remListModified_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::remListModified:push';
end;//Tkw_List_Control_remListModified_Push.GetWordNameForRegister

function Tkw_List_Control_remTimeMachineWarning.GetString: AnsiString;
begin
 Result := 'remTimeMachineWarning';
end;//Tkw_List_Control_remTimeMachineWarning.GetString

class procedure Tkw_List_Control_remTimeMachineWarning.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_List_Control_remTimeMachineWarning.RegisterInEngine

class function Tkw_List_Control_remTimeMachineWarning.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::remTimeMachineWarning';
end;//Tkw_List_Control_remTimeMachineWarning.GetWordNameForRegister

procedure Tkw_List_Control_remTimeMachineWarning_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('remTimeMachineWarning');
 inherited;
end;//Tkw_List_Control_remTimeMachineWarning_Push.DoDoIt

class function Tkw_List_Control_remTimeMachineWarning_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::remTimeMachineWarning:push';
end;//Tkw_List_Control_remTimeMachineWarning_Push.GetWordNameForRegister

function Tkw_List_Control_EmptyListEditor.GetString: AnsiString;
begin
 Result := 'EmptyListEditor';
end;//Tkw_List_Control_EmptyListEditor.GetString

class procedure Tkw_List_Control_EmptyListEditor.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_List_Control_EmptyListEditor.RegisterInEngine

class function Tkw_List_Control_EmptyListEditor.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EmptyListEditor';
end;//Tkw_List_Control_EmptyListEditor.GetWordNameForRegister

procedure Tkw_List_Control_EmptyListEditor_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('EmptyListEditor');
 inherited;
end;//Tkw_List_Control_EmptyListEditor_Push.DoDoIt

class function Tkw_List_Control_EmptyListEditor_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EmptyListEditor:push';
end;//Tkw_List_Control_EmptyListEditor_Push.GetWordNameForRegister

function Tkw_List_Control_ListPanel.GetString: AnsiString;
begin
 Result := 'ListPanel';
end;//Tkw_List_Control_ListPanel.GetString

class procedure Tkw_List_Control_ListPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_List_Control_ListPanel.RegisterInEngine

class function Tkw_List_Control_ListPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ListPanel';
end;//Tkw_List_Control_ListPanel.GetWordNameForRegister

procedure Tkw_List_Control_ListPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ListPanel');
 inherited;
end;//Tkw_List_Control_ListPanel_Push.DoDoIt

class function Tkw_List_Control_ListPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ListPanel:push';
end;//Tkw_List_Control_ListPanel_Push.GetWordNameForRegister

function Tkw_List_Control_tvList.GetString: AnsiString;
begin
 Result := 'tvList';
end;//Tkw_List_Control_tvList.GetString

class procedure Tkw_List_Control_tvList.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscDocumentListTreeView);
end;//Tkw_List_Control_tvList.RegisterInEngine

class function Tkw_List_Control_tvList.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvList';
end;//Tkw_List_Control_tvList.GetWordNameForRegister

procedure Tkw_List_Control_tvList_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvList');
 inherited;
end;//Tkw_List_Control_tvList_Push.DoDoIt

class function Tkw_List_Control_tvList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvList:push';
end;//Tkw_List_Control_tvList_Push.GetWordNameForRegister

function Tkw_List_Control_cfList.GetString: AnsiString;
begin
 Result := 'cfList';
end;//Tkw_List_Control_cfList.GetString

class procedure Tkw_List_Control_cfList.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_List_Control_cfList.RegisterInEngine

class function Tkw_List_Control_cfList.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cfList';
end;//Tkw_List_Control_cfList.GetWordNameForRegister

procedure Tkw_List_Control_cfList_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('cfList');
 inherited;
end;//Tkw_List_Control_cfList_Push.DoDoIt

class function Tkw_List_Control_cfList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cfList:push';
end;//Tkw_List_Control_cfList_Push.GetWordNameForRegister

function Tkw_List_Control_ExSearchPanel.GetString: AnsiString;
begin
 Result := 'ExSearchPanel';
end;//Tkw_List_Control_ExSearchPanel.GetString

class procedure Tkw_List_Control_ExSearchPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_List_Control_ExSearchPanel.RegisterInEngine

class function Tkw_List_Control_ExSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ExSearchPanel';
end;//Tkw_List_Control_ExSearchPanel.GetWordNameForRegister

procedure Tkw_List_Control_ExSearchPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ExSearchPanel');
 inherited;
end;//Tkw_List_Control_ExSearchPanel_Push.DoDoIt

class function Tkw_List_Control_ExSearchPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ExSearchPanel:push';
end;//Tkw_List_Control_ExSearchPanel_Push.GetWordNameForRegister

function Tkw_List_Control_ExSearchLabel.GetString: AnsiString;
begin
 Result := 'ExSearchLabel';
end;//Tkw_List_Control_ExSearchLabel.GetString

class procedure Tkw_List_Control_ExSearchLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_List_Control_ExSearchLabel.RegisterInEngine

class function Tkw_List_Control_ExSearchLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ExSearchLabel';
end;//Tkw_List_Control_ExSearchLabel.GetWordNameForRegister

procedure Tkw_List_Control_ExSearchLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ExSearchLabel');
 inherited;
end;//Tkw_List_Control_ExSearchLabel_Push.DoDoIt

class function Tkw_List_Control_ExSearchLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ExSearchLabel:push';
end;//Tkw_List_Control_ExSearchLabel_Push.GetWordNameForRegister

function TkwEfListRemindersLine.RemindersLine(const aCtx: TtfwContext;
 aefList: TefList): TnscRemindersLine;
 {* Реализация слова скрипта .TefList.RemindersLine }
begin
 Result := aefList.RemindersLine;
end;//TkwEfListRemindersLine.RemindersLine

procedure TkwEfListRemindersLine.DoDoIt(const aCtx: TtfwContext);
var l_aefList: TefList;
begin
 try
  l_aefList := TefList(aCtx.rEngine.PopObjAs(TefList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefList: TefList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RemindersLine(aCtx, l_aefList));
end;//TkwEfListRemindersLine.DoDoIt

procedure TkwEfListRemindersLine.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству RemindersLine', aCtx);
end;//TkwEfListRemindersLine.SetValuePrim

function TkwEfListRemindersLine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscRemindersLine);
end;//TkwEfListRemindersLine.GetResultTypeInfo

function TkwEfListRemindersLine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfListRemindersLine.GetAllParamsCount

function TkwEfListRemindersLine.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefList)]);
end;//TkwEfListRemindersLine.ParamsTypes

class function TkwEfListRemindersLine.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefList.RemindersLine';
end;//TkwEfListRemindersLine.GetWordNameForRegister

function TkwEfListRemListFiltered.remListFiltered(const aCtx: TtfwContext;
 aefList: TefList): TnscReminder;
 {* Реализация слова скрипта .TefList.remListFiltered }
begin
 Result := aefList.remListFiltered;
end;//TkwEfListRemListFiltered.remListFiltered

procedure TkwEfListRemListFiltered.DoDoIt(const aCtx: TtfwContext);
var l_aefList: TefList;
begin
 try
  l_aefList := TefList(aCtx.rEngine.PopObjAs(TefList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefList: TefList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(remListFiltered(aCtx, l_aefList));
end;//TkwEfListRemListFiltered.DoDoIt

procedure TkwEfListRemListFiltered.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству remListFiltered', aCtx);
end;//TkwEfListRemListFiltered.SetValuePrim

function TkwEfListRemListFiltered.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscReminder);
end;//TkwEfListRemListFiltered.GetResultTypeInfo

function TkwEfListRemListFiltered.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfListRemListFiltered.GetAllParamsCount

function TkwEfListRemListFiltered.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefList)]);
end;//TkwEfListRemListFiltered.ParamsTypes

class function TkwEfListRemListFiltered.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefList.remListFiltered';
end;//TkwEfListRemListFiltered.GetWordNameForRegister

function TkwEfListRemListModified.remListModified(const aCtx: TtfwContext;
 aefList: TefList): TnscReminder;
 {* Реализация слова скрипта .TefList.remListModified }
begin
 Result := aefList.remListModified;
end;//TkwEfListRemListModified.remListModified

procedure TkwEfListRemListModified.DoDoIt(const aCtx: TtfwContext);
var l_aefList: TefList;
begin
 try
  l_aefList := TefList(aCtx.rEngine.PopObjAs(TefList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefList: TefList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(remListModified(aCtx, l_aefList));
end;//TkwEfListRemListModified.DoDoIt

procedure TkwEfListRemListModified.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству remListModified', aCtx);
end;//TkwEfListRemListModified.SetValuePrim

function TkwEfListRemListModified.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscReminder);
end;//TkwEfListRemListModified.GetResultTypeInfo

function TkwEfListRemListModified.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfListRemListModified.GetAllParamsCount

function TkwEfListRemListModified.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefList)]);
end;//TkwEfListRemListModified.ParamsTypes

class function TkwEfListRemListModified.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefList.remListModified';
end;//TkwEfListRemListModified.GetWordNameForRegister

function TkwEfListRemTimeMachineWarning.remTimeMachineWarning(const aCtx: TtfwContext;
 aefList: TefList): TnscReminder;
 {* Реализация слова скрипта .TefList.remTimeMachineWarning }
begin
 Result := aefList.remTimeMachineWarning;
end;//TkwEfListRemTimeMachineWarning.remTimeMachineWarning

procedure TkwEfListRemTimeMachineWarning.DoDoIt(const aCtx: TtfwContext);
var l_aefList: TefList;
begin
 try
  l_aefList := TefList(aCtx.rEngine.PopObjAs(TefList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefList: TefList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(remTimeMachineWarning(aCtx, l_aefList));
end;//TkwEfListRemTimeMachineWarning.DoDoIt

procedure TkwEfListRemTimeMachineWarning.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству remTimeMachineWarning', aCtx);
end;//TkwEfListRemTimeMachineWarning.SetValuePrim

function TkwEfListRemTimeMachineWarning.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscReminder);
end;//TkwEfListRemTimeMachineWarning.GetResultTypeInfo

function TkwEfListRemTimeMachineWarning.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfListRemTimeMachineWarning.GetAllParamsCount

function TkwEfListRemTimeMachineWarning.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefList)]);
end;//TkwEfListRemTimeMachineWarning.ParamsTypes

class function TkwEfListRemTimeMachineWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefList.remTimeMachineWarning';
end;//TkwEfListRemTimeMachineWarning.GetWordNameForRegister

function TkwEfListEmptyListEditor.EmptyListEditor(const aCtx: TtfwContext;
 aefList: TefList): TnscEditor;
 {* Реализация слова скрипта .TefList.EmptyListEditor }
begin
 Result := aefList.EmptyListEditor;
end;//TkwEfListEmptyListEditor.EmptyListEditor

procedure TkwEfListEmptyListEditor.DoDoIt(const aCtx: TtfwContext);
var l_aefList: TefList;
begin
 try
  l_aefList := TefList(aCtx.rEngine.PopObjAs(TefList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefList: TefList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(EmptyListEditor(aCtx, l_aefList));
end;//TkwEfListEmptyListEditor.DoDoIt

procedure TkwEfListEmptyListEditor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству EmptyListEditor', aCtx);
end;//TkwEfListEmptyListEditor.SetValuePrim

function TkwEfListEmptyListEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEditor);
end;//TkwEfListEmptyListEditor.GetResultTypeInfo

function TkwEfListEmptyListEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfListEmptyListEditor.GetAllParamsCount

function TkwEfListEmptyListEditor.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefList)]);
end;//TkwEfListEmptyListEditor.ParamsTypes

class function TkwEfListEmptyListEditor.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefList.EmptyListEditor';
end;//TkwEfListEmptyListEditor.GetWordNameForRegister

function TkwEfListListPanel.ListPanel(const aCtx: TtfwContext;
 aefList: TefList): TvtPanel;
 {* Реализация слова скрипта .TefList.ListPanel }
begin
 Result := aefList.ListPanel;
end;//TkwEfListListPanel.ListPanel

procedure TkwEfListListPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefList: TefList;
begin
 try
  l_aefList := TefList(aCtx.rEngine.PopObjAs(TefList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefList: TefList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ListPanel(aCtx, l_aefList));
end;//TkwEfListListPanel.DoDoIt

procedure TkwEfListListPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ListPanel', aCtx);
end;//TkwEfListListPanel.SetValuePrim

function TkwEfListListPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfListListPanel.GetResultTypeInfo

function TkwEfListListPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfListListPanel.GetAllParamsCount

function TkwEfListListPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefList)]);
end;//TkwEfListListPanel.ParamsTypes

class function TkwEfListListPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefList.ListPanel';
end;//TkwEfListListPanel.GetWordNameForRegister

function TkwEfListTvList.tvList(const aCtx: TtfwContext;
 aefList: TefList): TnscDocumentListTreeView;
 {* Реализация слова скрипта .TefList.tvList }
begin
 Result := aefList.tvList;
end;//TkwEfListTvList.tvList

procedure TkwEfListTvList.DoDoIt(const aCtx: TtfwContext);
var l_aefList: TefList;
begin
 try
  l_aefList := TefList(aCtx.rEngine.PopObjAs(TefList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefList: TefList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvList(aCtx, l_aefList));
end;//TkwEfListTvList.DoDoIt

procedure TkwEfListTvList.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvList', aCtx);
end;//TkwEfListTvList.SetValuePrim

function TkwEfListTvList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscDocumentListTreeView);
end;//TkwEfListTvList.GetResultTypeInfo

function TkwEfListTvList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfListTvList.GetAllParamsCount

function TkwEfListTvList.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefList)]);
end;//TkwEfListTvList.ParamsTypes

class function TkwEfListTvList.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefList.tvList';
end;//TkwEfListTvList.GetWordNameForRegister

function TkwEfListCfList.cfList(const aCtx: TtfwContext;
 aefList: TefList): TnscContextFilter;
 {* Реализация слова скрипта .TefList.cfList }
begin
 Result := aefList.cfList;
end;//TkwEfListCfList.cfList

procedure TkwEfListCfList.DoDoIt(const aCtx: TtfwContext);
var l_aefList: TefList;
begin
 try
  l_aefList := TefList(aCtx.rEngine.PopObjAs(TefList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefList: TefList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(cfList(aCtx, l_aefList));
end;//TkwEfListCfList.DoDoIt

procedure TkwEfListCfList.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству cfList', aCtx);
end;//TkwEfListCfList.SetValuePrim

function TkwEfListCfList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEfListCfList.GetResultTypeInfo

function TkwEfListCfList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfListCfList.GetAllParamsCount

function TkwEfListCfList.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefList)]);
end;//TkwEfListCfList.ParamsTypes

class function TkwEfListCfList.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefList.cfList';
end;//TkwEfListCfList.GetWordNameForRegister

function TkwEfListExSearchPanel.ExSearchPanel(const aCtx: TtfwContext;
 aefList: TefList): TvtPanel;
 {* Реализация слова скрипта .TefList.ExSearchPanel }
begin
 Result := aefList.ExSearchPanel;
end;//TkwEfListExSearchPanel.ExSearchPanel

procedure TkwEfListExSearchPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefList: TefList;
begin
 try
  l_aefList := TefList(aCtx.rEngine.PopObjAs(TefList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefList: TefList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ExSearchPanel(aCtx, l_aefList));
end;//TkwEfListExSearchPanel.DoDoIt

procedure TkwEfListExSearchPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ExSearchPanel', aCtx);
end;//TkwEfListExSearchPanel.SetValuePrim

function TkwEfListExSearchPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfListExSearchPanel.GetResultTypeInfo

function TkwEfListExSearchPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfListExSearchPanel.GetAllParamsCount

function TkwEfListExSearchPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefList)]);
end;//TkwEfListExSearchPanel.ParamsTypes

class function TkwEfListExSearchPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefList.ExSearchPanel';
end;//TkwEfListExSearchPanel.GetWordNameForRegister

function TkwEfListExSearchLabel.ExSearchLabel(const aCtx: TtfwContext;
 aefList: TefList): TvtFocusLabel;
 {* Реализация слова скрипта .TefList.ExSearchLabel }
begin
 Result := aefList.ExSearchLabel;
end;//TkwEfListExSearchLabel.ExSearchLabel

procedure TkwEfListExSearchLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefList: TefList;
begin
 try
  l_aefList := TefList(aCtx.rEngine.PopObjAs(TefList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefList: TefList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ExSearchLabel(aCtx, l_aefList));
end;//TkwEfListExSearchLabel.DoDoIt

procedure TkwEfListExSearchLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ExSearchLabel', aCtx);
end;//TkwEfListExSearchLabel.SetValuePrim

function TkwEfListExSearchLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwEfListExSearchLabel.GetResultTypeInfo

function TkwEfListExSearchLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfListExSearchLabel.GetAllParamsCount

function TkwEfListExSearchLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefList)]);
end;//TkwEfListExSearchLabel.ParamsTypes

class function TkwEfListExSearchLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefList.ExSearchLabel';
end;//TkwEfListExSearchLabel.GetWordNameForRegister

initialization
 Tkw_Form_List.RegisterInEngine;
 {* Регистрация Tkw_Form_List }
 Tkw_List_Control_RemindersLine.RegisterInEngine;
 {* Регистрация Tkw_List_Control_RemindersLine }
 Tkw_List_Control_RemindersLine_Push.RegisterInEngine;
 {* Регистрация Tkw_List_Control_RemindersLine_Push }
 Tkw_List_Control_remListFiltered.RegisterInEngine;
 {* Регистрация Tkw_List_Control_remListFiltered }
 Tkw_List_Control_remListFiltered_Push.RegisterInEngine;
 {* Регистрация Tkw_List_Control_remListFiltered_Push }
 Tkw_List_Control_remListModified.RegisterInEngine;
 {* Регистрация Tkw_List_Control_remListModified }
 Tkw_List_Control_remListModified_Push.RegisterInEngine;
 {* Регистрация Tkw_List_Control_remListModified_Push }
 Tkw_List_Control_remTimeMachineWarning.RegisterInEngine;
 {* Регистрация Tkw_List_Control_remTimeMachineWarning }
 Tkw_List_Control_remTimeMachineWarning_Push.RegisterInEngine;
 {* Регистрация Tkw_List_Control_remTimeMachineWarning_Push }
 Tkw_List_Control_EmptyListEditor.RegisterInEngine;
 {* Регистрация Tkw_List_Control_EmptyListEditor }
 Tkw_List_Control_EmptyListEditor_Push.RegisterInEngine;
 {* Регистрация Tkw_List_Control_EmptyListEditor_Push }
 Tkw_List_Control_ListPanel.RegisterInEngine;
 {* Регистрация Tkw_List_Control_ListPanel }
 Tkw_List_Control_ListPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_List_Control_ListPanel_Push }
 Tkw_List_Control_tvList.RegisterInEngine;
 {* Регистрация Tkw_List_Control_tvList }
 Tkw_List_Control_tvList_Push.RegisterInEngine;
 {* Регистрация Tkw_List_Control_tvList_Push }
 Tkw_List_Control_cfList.RegisterInEngine;
 {* Регистрация Tkw_List_Control_cfList }
 Tkw_List_Control_cfList_Push.RegisterInEngine;
 {* Регистрация Tkw_List_Control_cfList_Push }
 Tkw_List_Control_ExSearchPanel.RegisterInEngine;
 {* Регистрация Tkw_List_Control_ExSearchPanel }
 Tkw_List_Control_ExSearchPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_List_Control_ExSearchPanel_Push }
 Tkw_List_Control_ExSearchLabel.RegisterInEngine;
 {* Регистрация Tkw_List_Control_ExSearchLabel }
 Tkw_List_Control_ExSearchLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_List_Control_ExSearchLabel_Push }
 TkwEfListRemindersLine.RegisterInEngine;
 {* Регистрация efList_RemindersLine }
 TkwEfListRemListFiltered.RegisterInEngine;
 {* Регистрация efList_remListFiltered }
 TkwEfListRemListModified.RegisterInEngine;
 {* Регистрация efList_remListModified }
 TkwEfListRemTimeMachineWarning.RegisterInEngine;
 {* Регистрация efList_remTimeMachineWarning }
 TkwEfListEmptyListEditor.RegisterInEngine;
 {* Регистрация efList_EmptyListEditor }
 TkwEfListListPanel.RegisterInEngine;
 {* Регистрация efList_ListPanel }
 TkwEfListTvList.RegisterInEngine;
 {* Регистрация efList_tvList }
 TkwEfListCfList.RegisterInEngine;
 {* Регистрация efList_cfList }
 TkwEfListExSearchPanel.RegisterInEngine;
 {* Регистрация efList_ExSearchPanel }
 TkwEfListExSearchLabel.RegisterInEngine;
 {* Регистрация efList_ExSearchLabel }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefList));
 {* Регистрация типа List }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscRemindersLine));
 {* Регистрация типа TnscRemindersLine }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscReminder));
 {* Регистрация типа TnscReminder }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* Регистрация типа TnscEditor }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscDocumentListTreeView));
 {* Регистрация типа TnscDocumentListTreeView }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* Регистрация типа TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtFocusLabel));
 {* Регистрация типа TvtFocusLabel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
