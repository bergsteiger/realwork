unit ContentsKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Contents }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\ContentsKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Document_Module
 , vtPanel
 , vtLister
 , nscTreeViewWithAdapterDragDrop
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTasksPanelView
 {$IfEnd} // Defined(Nemesis)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
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
 Tkw_Form_Contents = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Contents
----
*Пример использования*:
[code]
'aControl' форма::Contents TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Contents

 Tkw_Contents_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Contents_Control_BackgroundPanel

 Tkw_Contents_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_BackgroundPanel_Push

 Tkw_Contents_Control_lstBookmarks = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lstBookmarks
----
*Пример использования*:
[code]
контрол::lstBookmarks TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Contents_Control_lstBookmarks

 Tkw_Contents_Control_lstBookmarks_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lstBookmarks
----
*Пример использования*:
[code]
контрол::lstBookmarks:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_lstBookmarks_Push

 Tkw_Contents_Control_lstComments = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lstComments
----
*Пример использования*:
[code]
контрол::lstComments TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Contents_Control_lstComments

 Tkw_Contents_Control_lstComments_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lstComments
----
*Пример использования*:
[code]
контрол::lstComments:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_lstComments_Push

 Tkw_Contents_Control_lstExternalObjects = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lstExternalObjects
----
*Пример использования*:
[code]
контрол::lstExternalObjects TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Contents_Control_lstExternalObjects

 Tkw_Contents_Control_lstExternalObjects_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lstExternalObjects
----
*Пример использования*:
[code]
контрол::lstExternalObjects:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_lstExternalObjects_Push

 Tkw_Contents_Control_ContentsTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ContentsTree
----
*Пример использования*:
[code]
контрол::ContentsTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Contents_Control_ContentsTree

 Tkw_Contents_Control_ContentsTree_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ContentsTree
----
*Пример использования*:
[code]
контрол::ContentsTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_ContentsTree_Push

 Tkw_Contents_Control_ContextFilter = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ContextFilter
----
*Пример использования*:
[code]
контрол::ContextFilter TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Contents_Control_ContextFilter

 Tkw_Contents_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ContextFilter
----
*Пример использования*:
[code]
контрол::ContextFilter:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_ContextFilter_Push

 Tkw_Contents_Control_Tasks = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Tasks
----
*Пример использования*:
[code]
контрол::Tasks TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Contents_Control_Tasks

 Tkw_Contents_Control_Tasks_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Tasks
----
*Пример использования*:
[code]
контрол::Tasks:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Contents_Control_Tasks_Push

 TkwContentsFormBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TContentsForm.BackgroundPanel
[panel]Контрол BackgroundPanel формы TContentsForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aContentsForm .TContentsForm.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TvtPanel;
    {* Реализация слова скрипта .TContentsForm.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwContentsFormBackgroundPanel

 TkwContentsFormLstBookmarks = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TContentsForm.lstBookmarks
[panel]Контрол lstBookmarks формы TContentsForm[panel]
*Тип результата:* TvtLister
*Пример:*
[code]
OBJECT VAR l_TvtLister
 aContentsForm .TContentsForm.lstBookmarks >>> l_TvtLister
[code]  }
  private
   function lstBookmarks(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TvtLister;
    {* Реализация слова скрипта .TContentsForm.lstBookmarks }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwContentsFormLstBookmarks

 TkwContentsFormLstComments = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TContentsForm.lstComments
[panel]Контрол lstComments формы TContentsForm[panel]
*Тип результата:* TvtLister
*Пример:*
[code]
OBJECT VAR l_TvtLister
 aContentsForm .TContentsForm.lstComments >>> l_TvtLister
[code]  }
  private
   function lstComments(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TvtLister;
    {* Реализация слова скрипта .TContentsForm.lstComments }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwContentsFormLstComments

 TkwContentsFormLstExternalObjects = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TContentsForm.lstExternalObjects
[panel]Контрол lstExternalObjects формы TContentsForm[panel]
*Тип результата:* TvtLister
*Пример:*
[code]
OBJECT VAR l_TvtLister
 aContentsForm .TContentsForm.lstExternalObjects >>> l_TvtLister
[code]  }
  private
   function lstExternalObjects(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TvtLister;
    {* Реализация слова скрипта .TContentsForm.lstExternalObjects }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwContentsFormLstExternalObjects

 TkwContentsFormContentsTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TContentsForm.ContentsTree
[panel]Контрол ContentsTree формы TContentsForm[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aContentsForm .TContentsForm.ContentsTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function ContentsTree(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .TContentsForm.ContentsTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwContentsFormContentsTree

 TkwContentsFormContextFilter = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TContentsForm.ContextFilter
[panel]Контрол ContextFilter формы TContentsForm[panel]
*Тип результата:* TnscContextFilter
*Пример:*
[code]
OBJECT VAR l_TnscContextFilter
 aContentsForm .TContentsForm.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TnscContextFilter;
    {* Реализация слова скрипта .TContentsForm.ContextFilter }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwContentsFormContextFilter

 TkwContentsFormTasks = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TContentsForm.Tasks
[panel]Контрол Tasks формы TContentsForm[panel]
*Тип результата:* TnscTasksPanelView
*Пример:*
[code]
OBJECT VAR l_TnscTasksPanelView
 aContentsForm .TContentsForm.Tasks >>> l_TnscTasksPanelView
[code]  }
  private
   function Tasks(const aCtx: TtfwContext;
    aContentsForm: TContentsForm): TnscTasksPanelView;
    {* Реализация слова скрипта .TContentsForm.Tasks }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwContentsFormTasks

class function Tkw_Form_Contents.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Contents';
end;//Tkw_Form_Contents.GetWordNameForRegister

function Tkw_Form_Contents.GetString: AnsiString;
begin
 Result := 'ContentsForm';
end;//Tkw_Form_Contents.GetString

class function Tkw_Contents_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_Contents_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_Contents_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_Contents_Control_BackgroundPanel.GetString

class procedure Tkw_Contents_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Contents_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_Contents_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A6DCC692D7A7_var*
//#UC END# *4DAEEDE10285_A6DCC692D7A7_var*
begin
//#UC START# *4DAEEDE10285_A6DCC692D7A7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A6DCC692D7A7_impl*
end;//Tkw_Contents_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_Contents_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_Contents_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_Contents_Control_lstBookmarks.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lstBookmarks';
end;//Tkw_Contents_Control_lstBookmarks.GetWordNameForRegister

function Tkw_Contents_Control_lstBookmarks.GetString: AnsiString;
begin
 Result := 'lstBookmarks';
end;//Tkw_Contents_Control_lstBookmarks.GetString

class procedure Tkw_Contents_Control_lstBookmarks.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLister);
end;//Tkw_Contents_Control_lstBookmarks.RegisterInEngine

procedure Tkw_Contents_Control_lstBookmarks_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DC2C371B5EC2_var*
//#UC END# *4DAEEDE10285_DC2C371B5EC2_var*
begin
//#UC START# *4DAEEDE10285_DC2C371B5EC2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DC2C371B5EC2_impl*
end;//Tkw_Contents_Control_lstBookmarks_Push.DoDoIt

class function Tkw_Contents_Control_lstBookmarks_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lstBookmarks:push';
end;//Tkw_Contents_Control_lstBookmarks_Push.GetWordNameForRegister

class function Tkw_Contents_Control_lstComments.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lstComments';
end;//Tkw_Contents_Control_lstComments.GetWordNameForRegister

function Tkw_Contents_Control_lstComments.GetString: AnsiString;
begin
 Result := 'lstComments';
end;//Tkw_Contents_Control_lstComments.GetString

class procedure Tkw_Contents_Control_lstComments.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLister);
end;//Tkw_Contents_Control_lstComments.RegisterInEngine

procedure Tkw_Contents_Control_lstComments_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4B60A82AAB7C_var*
//#UC END# *4DAEEDE10285_4B60A82AAB7C_var*
begin
//#UC START# *4DAEEDE10285_4B60A82AAB7C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4B60A82AAB7C_impl*
end;//Tkw_Contents_Control_lstComments_Push.DoDoIt

class function Tkw_Contents_Control_lstComments_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lstComments:push';
end;//Tkw_Contents_Control_lstComments_Push.GetWordNameForRegister

class function Tkw_Contents_Control_lstExternalObjects.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lstExternalObjects';
end;//Tkw_Contents_Control_lstExternalObjects.GetWordNameForRegister

function Tkw_Contents_Control_lstExternalObjects.GetString: AnsiString;
begin
 Result := 'lstExternalObjects';
end;//Tkw_Contents_Control_lstExternalObjects.GetString

class procedure Tkw_Contents_Control_lstExternalObjects.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLister);
end;//Tkw_Contents_Control_lstExternalObjects.RegisterInEngine

procedure Tkw_Contents_Control_lstExternalObjects_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BCDC18D563E6_var*
//#UC END# *4DAEEDE10285_BCDC18D563E6_var*
begin
//#UC START# *4DAEEDE10285_BCDC18D563E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BCDC18D563E6_impl*
end;//Tkw_Contents_Control_lstExternalObjects_Push.DoDoIt

class function Tkw_Contents_Control_lstExternalObjects_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lstExternalObjects:push';
end;//Tkw_Contents_Control_lstExternalObjects_Push.GetWordNameForRegister

class function Tkw_Contents_Control_ContentsTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContentsTree';
end;//Tkw_Contents_Control_ContentsTree.GetWordNameForRegister

function Tkw_Contents_Control_ContentsTree.GetString: AnsiString;
begin
 Result := 'ContentsTree';
end;//Tkw_Contents_Control_ContentsTree.GetString

class procedure Tkw_Contents_Control_ContentsTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_Contents_Control_ContentsTree.RegisterInEngine

procedure Tkw_Contents_Control_ContentsTree_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CEF92672CF37_var*
//#UC END# *4DAEEDE10285_CEF92672CF37_var*
begin
//#UC START# *4DAEEDE10285_CEF92672CF37_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CEF92672CF37_impl*
end;//Tkw_Contents_Control_ContentsTree_Push.DoDoIt

class function Tkw_Contents_Control_ContentsTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContentsTree:push';
end;//Tkw_Contents_Control_ContentsTree_Push.GetWordNameForRegister

class function Tkw_Contents_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter';
end;//Tkw_Contents_Control_ContextFilter.GetWordNameForRegister

function Tkw_Contents_Control_ContextFilter.GetString: AnsiString;
begin
 Result := 'ContextFilter';
end;//Tkw_Contents_Control_ContextFilter.GetString

class procedure Tkw_Contents_Control_ContextFilter.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_Contents_Control_ContextFilter.RegisterInEngine

procedure Tkw_Contents_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9C078DD36879_var*
//#UC END# *4DAEEDE10285_9C078DD36879_var*
begin
//#UC START# *4DAEEDE10285_9C078DD36879_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9C078DD36879_impl*
end;//Tkw_Contents_Control_ContextFilter_Push.DoDoIt

class function Tkw_Contents_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter:push';
end;//Tkw_Contents_Control_ContextFilter_Push.GetWordNameForRegister

class function Tkw_Contents_Control_Tasks.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Tasks';
end;//Tkw_Contents_Control_Tasks.GetWordNameForRegister

function Tkw_Contents_Control_Tasks.GetString: AnsiString;
begin
 Result := 'Tasks';
end;//Tkw_Contents_Control_Tasks.GetString

class procedure Tkw_Contents_Control_Tasks.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTasksPanelView);
end;//Tkw_Contents_Control_Tasks.RegisterInEngine

procedure Tkw_Contents_Control_Tasks_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B74BD809B3F5_var*
//#UC END# *4DAEEDE10285_B74BD809B3F5_var*
begin
//#UC START# *4DAEEDE10285_B74BD809B3F5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B74BD809B3F5_impl*
end;//Tkw_Contents_Control_Tasks_Push.DoDoIt

class function Tkw_Contents_Control_Tasks_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Tasks:push';
end;//Tkw_Contents_Control_Tasks_Push.GetWordNameForRegister

function TkwContentsFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TvtPanel;
 {* Реализация слова скрипта .TContentsForm.BackgroundPanel }
begin
 Result := aContentsForm.BackgroundPanel;
end;//TkwContentsFormBackgroundPanel.BackgroundPanel

procedure TkwContentsFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aContentsForm: TContentsForm;
begin
 try
  l_aContentsForm := TContentsForm(aCtx.rEngine.PopObjAs(TContentsForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aContentsForm: TContentsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aContentsForm));
end;//TkwContentsFormBackgroundPanel.DoDoIt

class function TkwContentsFormBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.BackgroundPanel';
end;//TkwContentsFormBackgroundPanel.GetWordNameForRegister

procedure TkwContentsFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwContentsFormBackgroundPanel.SetValuePrim

function TkwContentsFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwContentsFormBackgroundPanel.GetResultTypeInfo

function TkwContentsFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContentsFormBackgroundPanel.GetAllParamsCount

function TkwContentsFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormBackgroundPanel.ParamsTypes

function TkwContentsFormLstBookmarks.lstBookmarks(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TvtLister;
 {* Реализация слова скрипта .TContentsForm.lstBookmarks }
begin
 Result := aContentsForm.lstBookmarks;
end;//TkwContentsFormLstBookmarks.lstBookmarks

procedure TkwContentsFormLstBookmarks.DoDoIt(const aCtx: TtfwContext);
var l_aContentsForm: TContentsForm;
begin
 try
  l_aContentsForm := TContentsForm(aCtx.rEngine.PopObjAs(TContentsForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aContentsForm: TContentsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lstBookmarks(aCtx, l_aContentsForm));
end;//TkwContentsFormLstBookmarks.DoDoIt

class function TkwContentsFormLstBookmarks.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.lstBookmarks';
end;//TkwContentsFormLstBookmarks.GetWordNameForRegister

procedure TkwContentsFormLstBookmarks.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lstBookmarks', aCtx);
end;//TkwContentsFormLstBookmarks.SetValuePrim

function TkwContentsFormLstBookmarks.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLister);
end;//TkwContentsFormLstBookmarks.GetResultTypeInfo

function TkwContentsFormLstBookmarks.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContentsFormLstBookmarks.GetAllParamsCount

function TkwContentsFormLstBookmarks.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormLstBookmarks.ParamsTypes

function TkwContentsFormLstComments.lstComments(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TvtLister;
 {* Реализация слова скрипта .TContentsForm.lstComments }
begin
 Result := aContentsForm.lstComments;
end;//TkwContentsFormLstComments.lstComments

procedure TkwContentsFormLstComments.DoDoIt(const aCtx: TtfwContext);
var l_aContentsForm: TContentsForm;
begin
 try
  l_aContentsForm := TContentsForm(aCtx.rEngine.PopObjAs(TContentsForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aContentsForm: TContentsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lstComments(aCtx, l_aContentsForm));
end;//TkwContentsFormLstComments.DoDoIt

class function TkwContentsFormLstComments.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.lstComments';
end;//TkwContentsFormLstComments.GetWordNameForRegister

procedure TkwContentsFormLstComments.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lstComments', aCtx);
end;//TkwContentsFormLstComments.SetValuePrim

function TkwContentsFormLstComments.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLister);
end;//TkwContentsFormLstComments.GetResultTypeInfo

function TkwContentsFormLstComments.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContentsFormLstComments.GetAllParamsCount

function TkwContentsFormLstComments.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormLstComments.ParamsTypes

function TkwContentsFormLstExternalObjects.lstExternalObjects(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TvtLister;
 {* Реализация слова скрипта .TContentsForm.lstExternalObjects }
begin
 Result := aContentsForm.lstExternalObjects;
end;//TkwContentsFormLstExternalObjects.lstExternalObjects

procedure TkwContentsFormLstExternalObjects.DoDoIt(const aCtx: TtfwContext);
var l_aContentsForm: TContentsForm;
begin
 try
  l_aContentsForm := TContentsForm(aCtx.rEngine.PopObjAs(TContentsForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aContentsForm: TContentsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lstExternalObjects(aCtx, l_aContentsForm));
end;//TkwContentsFormLstExternalObjects.DoDoIt

class function TkwContentsFormLstExternalObjects.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.lstExternalObjects';
end;//TkwContentsFormLstExternalObjects.GetWordNameForRegister

procedure TkwContentsFormLstExternalObjects.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lstExternalObjects', aCtx);
end;//TkwContentsFormLstExternalObjects.SetValuePrim

function TkwContentsFormLstExternalObjects.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLister);
end;//TkwContentsFormLstExternalObjects.GetResultTypeInfo

function TkwContentsFormLstExternalObjects.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContentsFormLstExternalObjects.GetAllParamsCount

function TkwContentsFormLstExternalObjects.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormLstExternalObjects.ParamsTypes

function TkwContentsFormContentsTree.ContentsTree(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .TContentsForm.ContentsTree }
begin
 Result := aContentsForm.ContentsTree;
end;//TkwContentsFormContentsTree.ContentsTree

procedure TkwContentsFormContentsTree.DoDoIt(const aCtx: TtfwContext);
var l_aContentsForm: TContentsForm;
begin
 try
  l_aContentsForm := TContentsForm(aCtx.rEngine.PopObjAs(TContentsForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aContentsForm: TContentsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ContentsTree(aCtx, l_aContentsForm));
end;//TkwContentsFormContentsTree.DoDoIt

class function TkwContentsFormContentsTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.ContentsTree';
end;//TkwContentsFormContentsTree.GetWordNameForRegister

procedure TkwContentsFormContentsTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ContentsTree', aCtx);
end;//TkwContentsFormContentsTree.SetValuePrim

function TkwContentsFormContentsTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwContentsFormContentsTree.GetResultTypeInfo

function TkwContentsFormContentsTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContentsFormContentsTree.GetAllParamsCount

function TkwContentsFormContentsTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormContentsTree.ParamsTypes

function TkwContentsFormContextFilter.ContextFilter(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TnscContextFilter;
 {* Реализация слова скрипта .TContentsForm.ContextFilter }
begin
 Result := aContentsForm.ContextFilter;
end;//TkwContentsFormContextFilter.ContextFilter

procedure TkwContentsFormContextFilter.DoDoIt(const aCtx: TtfwContext);
var l_aContentsForm: TContentsForm;
begin
 try
  l_aContentsForm := TContentsForm(aCtx.rEngine.PopObjAs(TContentsForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aContentsForm: TContentsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ContextFilter(aCtx, l_aContentsForm));
end;//TkwContentsFormContextFilter.DoDoIt

class function TkwContentsFormContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.ContextFilter';
end;//TkwContentsFormContextFilter.GetWordNameForRegister

procedure TkwContentsFormContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ContextFilter', aCtx);
end;//TkwContentsFormContextFilter.SetValuePrim

function TkwContentsFormContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwContentsFormContextFilter.GetResultTypeInfo

function TkwContentsFormContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContentsFormContextFilter.GetAllParamsCount

function TkwContentsFormContextFilter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormContextFilter.ParamsTypes

function TkwContentsFormTasks.Tasks(const aCtx: TtfwContext;
 aContentsForm: TContentsForm): TnscTasksPanelView;
 {* Реализация слова скрипта .TContentsForm.Tasks }
begin
 Result := aContentsForm.Tasks;
end;//TkwContentsFormTasks.Tasks

procedure TkwContentsFormTasks.DoDoIt(const aCtx: TtfwContext);
var l_aContentsForm: TContentsForm;
begin
 try
  l_aContentsForm := TContentsForm(aCtx.rEngine.PopObjAs(TContentsForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aContentsForm: TContentsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Tasks(aCtx, l_aContentsForm));
end;//TkwContentsFormTasks.DoDoIt

class function TkwContentsFormTasks.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContentsForm.Tasks';
end;//TkwContentsFormTasks.GetWordNameForRegister

procedure TkwContentsFormTasks.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Tasks', aCtx);
end;//TkwContentsFormTasks.SetValuePrim

function TkwContentsFormTasks.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTasksPanelView);
end;//TkwContentsFormTasks.GetResultTypeInfo

function TkwContentsFormTasks.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContentsFormTasks.GetAllParamsCount

function TkwContentsFormTasks.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContentsForm)]);
end;//TkwContentsFormTasks.ParamsTypes

initialization
 Tkw_Form_Contents.RegisterInEngine;
 {* Регистрация Tkw_Form_Contents }
 Tkw_Contents_Control_BackgroundPanel.RegisterInEngine;
 {* Регистрация Tkw_Contents_Control_BackgroundPanel }
 Tkw_Contents_Control_BackgroundPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_Contents_Control_BackgroundPanel_Push }
 Tkw_Contents_Control_lstBookmarks.RegisterInEngine;
 {* Регистрация Tkw_Contents_Control_lstBookmarks }
 Tkw_Contents_Control_lstBookmarks_Push.RegisterInEngine;
 {* Регистрация Tkw_Contents_Control_lstBookmarks_Push }
 Tkw_Contents_Control_lstComments.RegisterInEngine;
 {* Регистрация Tkw_Contents_Control_lstComments }
 Tkw_Contents_Control_lstComments_Push.RegisterInEngine;
 {* Регистрация Tkw_Contents_Control_lstComments_Push }
 Tkw_Contents_Control_lstExternalObjects.RegisterInEngine;
 {* Регистрация Tkw_Contents_Control_lstExternalObjects }
 Tkw_Contents_Control_lstExternalObjects_Push.RegisterInEngine;
 {* Регистрация Tkw_Contents_Control_lstExternalObjects_Push }
 Tkw_Contents_Control_ContentsTree.RegisterInEngine;
 {* Регистрация Tkw_Contents_Control_ContentsTree }
 Tkw_Contents_Control_ContentsTree_Push.RegisterInEngine;
 {* Регистрация Tkw_Contents_Control_ContentsTree_Push }
 Tkw_Contents_Control_ContextFilter.RegisterInEngine;
 {* Регистрация Tkw_Contents_Control_ContextFilter }
 Tkw_Contents_Control_ContextFilter_Push.RegisterInEngine;
 {* Регистрация Tkw_Contents_Control_ContextFilter_Push }
 Tkw_Contents_Control_Tasks.RegisterInEngine;
 {* Регистрация Tkw_Contents_Control_Tasks }
 Tkw_Contents_Control_Tasks_Push.RegisterInEngine;
 {* Регистрация Tkw_Contents_Control_Tasks_Push }
 TkwContentsFormBackgroundPanel.RegisterInEngine;
 {* Регистрация ContentsForm_BackgroundPanel }
 TkwContentsFormLstBookmarks.RegisterInEngine;
 {* Регистрация ContentsForm_lstBookmarks }
 TkwContentsFormLstComments.RegisterInEngine;
 {* Регистрация ContentsForm_lstComments }
 TkwContentsFormLstExternalObjects.RegisterInEngine;
 {* Регистрация ContentsForm_lstExternalObjects }
 TkwContentsFormContentsTree.RegisterInEngine;
 {* Регистрация ContentsForm_ContentsTree }
 TkwContentsFormContextFilter.RegisterInEngine;
 {* Регистрация ContentsForm_ContextFilter }
 TkwContentsFormTasks.RegisterInEngine;
 {* Регистрация ContentsForm_Tasks }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TContentsForm));
 {* Регистрация типа Contents }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLister));
 {* Регистрация типа TvtLister }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* Регистрация типа TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTasksPanelView));
 {* Регистрация типа TnscTasksPanelView }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
