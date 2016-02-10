unit ListKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы List }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\ListKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , List_Module
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
 Tkw_Form_List = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы List
----
*Пример использования*:
[code]
'aControl' форма::List TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_List

 Tkw_List_Control_RemindersLine = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RemindersLine
----
*Пример использования*:
[code]
контрол::RemindersLine TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_List_Control_RemindersLine

 Tkw_List_Control_RemindersLine_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_List_Control_remListFiltered

 Tkw_List_Control_remListFiltered_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_List_Control_remListModified

 Tkw_List_Control_remListModified_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_List_Control_remTimeMachineWarning

 Tkw_List_Control_remTimeMachineWarning_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_List_Control_EmptyListEditor

 Tkw_List_Control_EmptyListEditor_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_List_Control_ListPanel

 Tkw_List_Control_ListPanel_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_List_Control_tvList

 Tkw_List_Control_tvList_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_List_Control_cfList

 Tkw_List_Control_cfList_Push = {final} class(TkwBynameControlPush)
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

class function Tkw_Form_List.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::List';
end;//Tkw_Form_List.GetWordNameForRegister

function Tkw_Form_List.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E3D7804C32D0_var*
//#UC END# *4DDFD2EA0116_E3D7804C32D0_var*
begin
//#UC START# *4DDFD2EA0116_E3D7804C32D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E3D7804C32D0_impl*
end;//Tkw_Form_List.GetString

class function Tkw_List_Control_RemindersLine.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RemindersLine';
end;//Tkw_List_Control_RemindersLine.GetWordNameForRegister

function Tkw_List_Control_RemindersLine.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_EEE4E4036F9B_var*
//#UC END# *4DDFD2EA0116_EEE4E4036F9B_var*
begin
//#UC START# *4DDFD2EA0116_EEE4E4036F9B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_EEE4E4036F9B_impl*
end;//Tkw_List_Control_RemindersLine.GetString

class procedure Tkw_List_Control_RemindersLine.RegisterInEngine;
//#UC START# *52A086150180_EEE4E4036F9B_var*
//#UC END# *52A086150180_EEE4E4036F9B_var*
begin
//#UC START# *52A086150180_EEE4E4036F9B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_EEE4E4036F9B_impl*
end;//Tkw_List_Control_RemindersLine.RegisterInEngine

procedure Tkw_List_Control_RemindersLine_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C03DBBB30146_var*
//#UC END# *4DAEEDE10285_C03DBBB30146_var*
begin
//#UC START# *4DAEEDE10285_C03DBBB30146_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C03DBBB30146_impl*
end;//Tkw_List_Control_RemindersLine_Push.DoDoIt

class function Tkw_List_Control_RemindersLine_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RemindersLine:push';
end;//Tkw_List_Control_RemindersLine_Push.GetWordNameForRegister

class function Tkw_List_Control_remListFiltered.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::remListFiltered';
end;//Tkw_List_Control_remListFiltered.GetWordNameForRegister

function Tkw_List_Control_remListFiltered.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_00D920D82800_var*
//#UC END# *4DDFD2EA0116_00D920D82800_var*
begin
//#UC START# *4DDFD2EA0116_00D920D82800_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_00D920D82800_impl*
end;//Tkw_List_Control_remListFiltered.GetString

class procedure Tkw_List_Control_remListFiltered.RegisterInEngine;
//#UC START# *52A086150180_00D920D82800_var*
//#UC END# *52A086150180_00D920D82800_var*
begin
//#UC START# *52A086150180_00D920D82800_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_00D920D82800_impl*
end;//Tkw_List_Control_remListFiltered.RegisterInEngine

procedure Tkw_List_Control_remListFiltered_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D36F3D099A06_var*
//#UC END# *4DAEEDE10285_D36F3D099A06_var*
begin
//#UC START# *4DAEEDE10285_D36F3D099A06_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D36F3D099A06_impl*
end;//Tkw_List_Control_remListFiltered_Push.DoDoIt

class function Tkw_List_Control_remListFiltered_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::remListFiltered:push';
end;//Tkw_List_Control_remListFiltered_Push.GetWordNameForRegister

class function Tkw_List_Control_remListModified.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::remListModified';
end;//Tkw_List_Control_remListModified.GetWordNameForRegister

function Tkw_List_Control_remListModified.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7B075F9166B7_var*
//#UC END# *4DDFD2EA0116_7B075F9166B7_var*
begin
//#UC START# *4DDFD2EA0116_7B075F9166B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7B075F9166B7_impl*
end;//Tkw_List_Control_remListModified.GetString

class procedure Tkw_List_Control_remListModified.RegisterInEngine;
//#UC START# *52A086150180_7B075F9166B7_var*
//#UC END# *52A086150180_7B075F9166B7_var*
begin
//#UC START# *52A086150180_7B075F9166B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7B075F9166B7_impl*
end;//Tkw_List_Control_remListModified.RegisterInEngine

procedure Tkw_List_Control_remListModified_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5DA3536B17F2_var*
//#UC END# *4DAEEDE10285_5DA3536B17F2_var*
begin
//#UC START# *4DAEEDE10285_5DA3536B17F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5DA3536B17F2_impl*
end;//Tkw_List_Control_remListModified_Push.DoDoIt

class function Tkw_List_Control_remListModified_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::remListModified:push';
end;//Tkw_List_Control_remListModified_Push.GetWordNameForRegister

class function Tkw_List_Control_remTimeMachineWarning.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::remTimeMachineWarning';
end;//Tkw_List_Control_remTimeMachineWarning.GetWordNameForRegister

function Tkw_List_Control_remTimeMachineWarning.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1E3943818AF9_var*
//#UC END# *4DDFD2EA0116_1E3943818AF9_var*
begin
//#UC START# *4DDFD2EA0116_1E3943818AF9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1E3943818AF9_impl*
end;//Tkw_List_Control_remTimeMachineWarning.GetString

class procedure Tkw_List_Control_remTimeMachineWarning.RegisterInEngine;
//#UC START# *52A086150180_1E3943818AF9_var*
//#UC END# *52A086150180_1E3943818AF9_var*
begin
//#UC START# *52A086150180_1E3943818AF9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1E3943818AF9_impl*
end;//Tkw_List_Control_remTimeMachineWarning.RegisterInEngine

procedure Tkw_List_Control_remTimeMachineWarning_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F8A4502F0B51_var*
//#UC END# *4DAEEDE10285_F8A4502F0B51_var*
begin
//#UC START# *4DAEEDE10285_F8A4502F0B51_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F8A4502F0B51_impl*
end;//Tkw_List_Control_remTimeMachineWarning_Push.DoDoIt

class function Tkw_List_Control_remTimeMachineWarning_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::remTimeMachineWarning:push';
end;//Tkw_List_Control_remTimeMachineWarning_Push.GetWordNameForRegister

class function Tkw_List_Control_EmptyListEditor.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EmptyListEditor';
end;//Tkw_List_Control_EmptyListEditor.GetWordNameForRegister

function Tkw_List_Control_EmptyListEditor.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_DCB705344A08_var*
//#UC END# *4DDFD2EA0116_DCB705344A08_var*
begin
//#UC START# *4DDFD2EA0116_DCB705344A08_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_DCB705344A08_impl*
end;//Tkw_List_Control_EmptyListEditor.GetString

class procedure Tkw_List_Control_EmptyListEditor.RegisterInEngine;
//#UC START# *52A086150180_DCB705344A08_var*
//#UC END# *52A086150180_DCB705344A08_var*
begin
//#UC START# *52A086150180_DCB705344A08_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_DCB705344A08_impl*
end;//Tkw_List_Control_EmptyListEditor.RegisterInEngine

procedure Tkw_List_Control_EmptyListEditor_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_20DA9A8362D5_var*
//#UC END# *4DAEEDE10285_20DA9A8362D5_var*
begin
//#UC START# *4DAEEDE10285_20DA9A8362D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_20DA9A8362D5_impl*
end;//Tkw_List_Control_EmptyListEditor_Push.DoDoIt

class function Tkw_List_Control_EmptyListEditor_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EmptyListEditor:push';
end;//Tkw_List_Control_EmptyListEditor_Push.GetWordNameForRegister

class function Tkw_List_Control_ListPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ListPanel';
end;//Tkw_List_Control_ListPanel.GetWordNameForRegister

function Tkw_List_Control_ListPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6F2F68114B07_var*
//#UC END# *4DDFD2EA0116_6F2F68114B07_var*
begin
//#UC START# *4DDFD2EA0116_6F2F68114B07_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6F2F68114B07_impl*
end;//Tkw_List_Control_ListPanel.GetString

class procedure Tkw_List_Control_ListPanel.RegisterInEngine;
//#UC START# *52A086150180_6F2F68114B07_var*
//#UC END# *52A086150180_6F2F68114B07_var*
begin
//#UC START# *52A086150180_6F2F68114B07_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6F2F68114B07_impl*
end;//Tkw_List_Control_ListPanel.RegisterInEngine

procedure Tkw_List_Control_ListPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D25792880D3C_var*
//#UC END# *4DAEEDE10285_D25792880D3C_var*
begin
//#UC START# *4DAEEDE10285_D25792880D3C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D25792880D3C_impl*
end;//Tkw_List_Control_ListPanel_Push.DoDoIt

class function Tkw_List_Control_ListPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ListPanel:push';
end;//Tkw_List_Control_ListPanel_Push.GetWordNameForRegister

class function Tkw_List_Control_tvList.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvList';
end;//Tkw_List_Control_tvList.GetWordNameForRegister

function Tkw_List_Control_tvList.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_75B5996C434D_var*
//#UC END# *4DDFD2EA0116_75B5996C434D_var*
begin
//#UC START# *4DDFD2EA0116_75B5996C434D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_75B5996C434D_impl*
end;//Tkw_List_Control_tvList.GetString

class procedure Tkw_List_Control_tvList.RegisterInEngine;
//#UC START# *52A086150180_75B5996C434D_var*
//#UC END# *52A086150180_75B5996C434D_var*
begin
//#UC START# *52A086150180_75B5996C434D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_75B5996C434D_impl*
end;//Tkw_List_Control_tvList.RegisterInEngine

procedure Tkw_List_Control_tvList_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0F6D0B8DEFDE_var*
//#UC END# *4DAEEDE10285_0F6D0B8DEFDE_var*
begin
//#UC START# *4DAEEDE10285_0F6D0B8DEFDE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0F6D0B8DEFDE_impl*
end;//Tkw_List_Control_tvList_Push.DoDoIt

class function Tkw_List_Control_tvList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvList:push';
end;//Tkw_List_Control_tvList_Push.GetWordNameForRegister

class function Tkw_List_Control_cfList.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cfList';
end;//Tkw_List_Control_cfList.GetWordNameForRegister

function Tkw_List_Control_cfList.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_FF4D166F0413_var*
//#UC END# *4DDFD2EA0116_FF4D166F0413_var*
begin
//#UC START# *4DDFD2EA0116_FF4D166F0413_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_FF4D166F0413_impl*
end;//Tkw_List_Control_cfList.GetString

class procedure Tkw_List_Control_cfList.RegisterInEngine;
//#UC START# *52A086150180_FF4D166F0413_var*
//#UC END# *52A086150180_FF4D166F0413_var*
begin
//#UC START# *52A086150180_FF4D166F0413_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_FF4D166F0413_impl*
end;//Tkw_List_Control_cfList.RegisterInEngine

procedure Tkw_List_Control_cfList_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_86A914F861D5_var*
//#UC END# *4DAEEDE10285_86A914F861D5_var*
begin
//#UC START# *4DAEEDE10285_86A914F861D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_86A914F861D5_impl*
end;//Tkw_List_Control_cfList_Push.DoDoIt

class function Tkw_List_Control_cfList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cfList:push';
end;//Tkw_List_Control_cfList_Push.GetWordNameForRegister

function TkwEfListRemindersLine.RemindersLine(const aCtx: TtfwContext;
 aefList: TefList): TnscRemindersLine;
 {* Реализация слова скрипта .TefList.RemindersLine }
//#UC START# *FC3E0760D9D4_4B02DC799E8A_var*
//#UC END# *FC3E0760D9D4_4B02DC799E8A_var*
begin
//#UC START# *FC3E0760D9D4_4B02DC799E8A_impl*
 !!! Needs to be implemented !!!
//#UC END# *FC3E0760D9D4_4B02DC799E8A_impl*
end;//TkwEfListRemindersLine.RemindersLine

procedure TkwEfListRemindersLine.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4B02DC799E8A_var*
//#UC END# *4DAEEDE10285_4B02DC799E8A_var*
begin
//#UC START# *4DAEEDE10285_4B02DC799E8A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4B02DC799E8A_impl*
end;//TkwEfListRemindersLine.DoDoIt

class function TkwEfListRemindersLine.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefList.RemindersLine';
end;//TkwEfListRemindersLine.GetWordNameForRegister

procedure TkwEfListRemindersLine.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
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
 Result := OpenTypesToTypes([]);
end;//TkwEfListRemindersLine.ParamsTypes

function TkwEfListRemListFiltered.remListFiltered(const aCtx: TtfwContext;
 aefList: TefList): TnscReminder;
 {* Реализация слова скрипта .TefList.remListFiltered }
//#UC START# *8CF8EA21467C_9EDC79448FB0_var*
//#UC END# *8CF8EA21467C_9EDC79448FB0_var*
begin
//#UC START# *8CF8EA21467C_9EDC79448FB0_impl*
 !!! Needs to be implemented !!!
//#UC END# *8CF8EA21467C_9EDC79448FB0_impl*
end;//TkwEfListRemListFiltered.remListFiltered

procedure TkwEfListRemListFiltered.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9EDC79448FB0_var*
//#UC END# *4DAEEDE10285_9EDC79448FB0_var*
begin
//#UC START# *4DAEEDE10285_9EDC79448FB0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9EDC79448FB0_impl*
end;//TkwEfListRemListFiltered.DoDoIt

class function TkwEfListRemListFiltered.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefList.remListFiltered';
end;//TkwEfListRemListFiltered.GetWordNameForRegister

procedure TkwEfListRemListFiltered.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
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
 Result := OpenTypesToTypes([]);
end;//TkwEfListRemListFiltered.ParamsTypes

function TkwEfListRemListModified.remListModified(const aCtx: TtfwContext;
 aefList: TefList): TnscReminder;
 {* Реализация слова скрипта .TefList.remListModified }
//#UC START# *4117870BA6DC_715456D52720_var*
//#UC END# *4117870BA6DC_715456D52720_var*
begin
//#UC START# *4117870BA6DC_715456D52720_impl*
 !!! Needs to be implemented !!!
//#UC END# *4117870BA6DC_715456D52720_impl*
end;//TkwEfListRemListModified.remListModified

procedure TkwEfListRemListModified.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_715456D52720_var*
//#UC END# *4DAEEDE10285_715456D52720_var*
begin
//#UC START# *4DAEEDE10285_715456D52720_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_715456D52720_impl*
end;//TkwEfListRemListModified.DoDoIt

class function TkwEfListRemListModified.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefList.remListModified';
end;//TkwEfListRemListModified.GetWordNameForRegister

procedure TkwEfListRemListModified.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
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
 Result := OpenTypesToTypes([]);
end;//TkwEfListRemListModified.ParamsTypes

function TkwEfListRemTimeMachineWarning.remTimeMachineWarning(const aCtx: TtfwContext;
 aefList: TefList): TnscReminder;
 {* Реализация слова скрипта .TefList.remTimeMachineWarning }
//#UC START# *C6CBA655E894_914FC12132E1_var*
//#UC END# *C6CBA655E894_914FC12132E1_var*
begin
//#UC START# *C6CBA655E894_914FC12132E1_impl*
 !!! Needs to be implemented !!!
//#UC END# *C6CBA655E894_914FC12132E1_impl*
end;//TkwEfListRemTimeMachineWarning.remTimeMachineWarning

procedure TkwEfListRemTimeMachineWarning.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_914FC12132E1_var*
//#UC END# *4DAEEDE10285_914FC12132E1_var*
begin
//#UC START# *4DAEEDE10285_914FC12132E1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_914FC12132E1_impl*
end;//TkwEfListRemTimeMachineWarning.DoDoIt

class function TkwEfListRemTimeMachineWarning.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefList.remTimeMachineWarning';
end;//TkwEfListRemTimeMachineWarning.GetWordNameForRegister

procedure TkwEfListRemTimeMachineWarning.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
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
 Result := OpenTypesToTypes([]);
end;//TkwEfListRemTimeMachineWarning.ParamsTypes

function TkwEfListEmptyListEditor.EmptyListEditor(const aCtx: TtfwContext;
 aefList: TefList): TnscEditor;
 {* Реализация слова скрипта .TefList.EmptyListEditor }
//#UC START# *FB07DB2118E3_4926301346C5_var*
//#UC END# *FB07DB2118E3_4926301346C5_var*
begin
//#UC START# *FB07DB2118E3_4926301346C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *FB07DB2118E3_4926301346C5_impl*
end;//TkwEfListEmptyListEditor.EmptyListEditor

procedure TkwEfListEmptyListEditor.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4926301346C5_var*
//#UC END# *4DAEEDE10285_4926301346C5_var*
begin
//#UC START# *4DAEEDE10285_4926301346C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4926301346C5_impl*
end;//TkwEfListEmptyListEditor.DoDoIt

class function TkwEfListEmptyListEditor.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefList.EmptyListEditor';
end;//TkwEfListEmptyListEditor.GetWordNameForRegister

procedure TkwEfListEmptyListEditor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
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
 Result := OpenTypesToTypes([]);
end;//TkwEfListEmptyListEditor.ParamsTypes

function TkwEfListListPanel.ListPanel(const aCtx: TtfwContext;
 aefList: TefList): TvtPanel;
 {* Реализация слова скрипта .TefList.ListPanel }
//#UC START# *10E83E5249D5_27A65BB46620_var*
//#UC END# *10E83E5249D5_27A65BB46620_var*
begin
//#UC START# *10E83E5249D5_27A65BB46620_impl*
 !!! Needs to be implemented !!!
//#UC END# *10E83E5249D5_27A65BB46620_impl*
end;//TkwEfListListPanel.ListPanel

procedure TkwEfListListPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_27A65BB46620_var*
//#UC END# *4DAEEDE10285_27A65BB46620_var*
begin
//#UC START# *4DAEEDE10285_27A65BB46620_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_27A65BB46620_impl*
end;//TkwEfListListPanel.DoDoIt

class function TkwEfListListPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefList.ListPanel';
end;//TkwEfListListPanel.GetWordNameForRegister

procedure TkwEfListListPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
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
 Result := OpenTypesToTypes([]);
end;//TkwEfListListPanel.ParamsTypes

function TkwEfListTvList.tvList(const aCtx: TtfwContext;
 aefList: TefList): TnscDocumentListTreeView;
 {* Реализация слова скрипта .TefList.tvList }
//#UC START# *7C59F455979A_8A0E3F8249F5_var*
//#UC END# *7C59F455979A_8A0E3F8249F5_var*
begin
//#UC START# *7C59F455979A_8A0E3F8249F5_impl*
 !!! Needs to be implemented !!!
//#UC END# *7C59F455979A_8A0E3F8249F5_impl*
end;//TkwEfListTvList.tvList

procedure TkwEfListTvList.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8A0E3F8249F5_var*
//#UC END# *4DAEEDE10285_8A0E3F8249F5_var*
begin
//#UC START# *4DAEEDE10285_8A0E3F8249F5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8A0E3F8249F5_impl*
end;//TkwEfListTvList.DoDoIt

class function TkwEfListTvList.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefList.tvList';
end;//TkwEfListTvList.GetWordNameForRegister

procedure TkwEfListTvList.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
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
 Result := OpenTypesToTypes([]);
end;//TkwEfListTvList.ParamsTypes

function TkwEfListCfList.cfList(const aCtx: TtfwContext;
 aefList: TefList): TnscContextFilter;
 {* Реализация слова скрипта .TefList.cfList }
//#UC START# *D45300956210_E2E83C1BEE9F_var*
//#UC END# *D45300956210_E2E83C1BEE9F_var*
begin
//#UC START# *D45300956210_E2E83C1BEE9F_impl*
 !!! Needs to be implemented !!!
//#UC END# *D45300956210_E2E83C1BEE9F_impl*
end;//TkwEfListCfList.cfList

procedure TkwEfListCfList.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E2E83C1BEE9F_var*
//#UC END# *4DAEEDE10285_E2E83C1BEE9F_var*
begin
//#UC START# *4DAEEDE10285_E2E83C1BEE9F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E2E83C1BEE9F_impl*
end;//TkwEfListCfList.DoDoIt

class function TkwEfListCfList.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefList.cfList';
end;//TkwEfListCfList.GetWordNameForRegister

procedure TkwEfListCfList.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
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
 Result := OpenTypesToTypes([]);
end;//TkwEfListCfList.ParamsTypes

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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
