unit WorkJournalKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы WorkJournal }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\Forms\WorkJournalKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "WorkJournalKeywordsPack" MUID: (4A811C620210_Pack)

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
 , WorkJournal_Form
 , tfwPropertyLike
 , nscTreeViewWithAdapterDragDrop
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4A811C620210_Packimpl_uses*
 //#UC END# *4A811C620210_Packimpl_uses*
;

type
 TkwWorkJournalFormJournalTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TWorkJournalForm.JournalTree }
  private
   function JournalTree(const aCtx: TtfwContext;
    aWorkJournalForm: TWorkJournalForm): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .TWorkJournalForm.JournalTree }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwWorkJournalFormJournalTree

 Tkw_Form_WorkJournal = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы WorkJournal
----
*Пример использования*:
[code]форма::WorkJournal TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_WorkJournal

 Tkw_WorkJournal_Control_JournalTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола JournalTree
----
*Пример использования*:
[code]контрол::JournalTree TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_WorkJournal_Control_JournalTree

 Tkw_WorkJournal_Control_JournalTree_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола JournalTree
----
*Пример использования*:
[code]контрол::JournalTree:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_WorkJournal_Control_JournalTree_Push

function TkwWorkJournalFormJournalTree.JournalTree(const aCtx: TtfwContext;
 aWorkJournalForm: TWorkJournalForm): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .TWorkJournalForm.JournalTree }
begin
 Result := aWorkJournalForm.JournalTree;
end;//TkwWorkJournalFormJournalTree.JournalTree

class function TkwWorkJournalFormJournalTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TWorkJournalForm.JournalTree';
end;//TkwWorkJournalFormJournalTree.GetWordNameForRegister

function TkwWorkJournalFormJournalTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwWorkJournalFormJournalTree.GetResultTypeInfo

function TkwWorkJournalFormJournalTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwWorkJournalFormJournalTree.GetAllParamsCount

function TkwWorkJournalFormJournalTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TWorkJournalForm)]);
end;//TkwWorkJournalFormJournalTree.ParamsTypes

procedure TkwWorkJournalFormJournalTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству JournalTree', aCtx);
end;//TkwWorkJournalFormJournalTree.SetValuePrim

procedure TkwWorkJournalFormJournalTree.DoDoIt(const aCtx: TtfwContext);
var l_aWorkJournalForm: TWorkJournalForm;
begin
 try
  l_aWorkJournalForm := TWorkJournalForm(aCtx.rEngine.PopObjAs(TWorkJournalForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWorkJournalForm: TWorkJournalForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(JournalTree(aCtx, l_aWorkJournalForm));
end;//TkwWorkJournalFormJournalTree.DoDoIt

function Tkw_Form_WorkJournal.GetString: AnsiString;
begin
 Result := 'WorkJournalForm';
end;//Tkw_Form_WorkJournal.GetString

class procedure Tkw_Form_WorkJournal.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TWorkJournalForm);
end;//Tkw_Form_WorkJournal.RegisterInEngine

class function Tkw_Form_WorkJournal.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::WorkJournal';
end;//Tkw_Form_WorkJournal.GetWordNameForRegister

function Tkw_WorkJournal_Control_JournalTree.GetString: AnsiString;
begin
 Result := 'JournalTree';
end;//Tkw_WorkJournal_Control_JournalTree.GetString

class procedure Tkw_WorkJournal_Control_JournalTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_WorkJournal_Control_JournalTree.RegisterInEngine

class function Tkw_WorkJournal_Control_JournalTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::JournalTree';
end;//Tkw_WorkJournal_Control_JournalTree.GetWordNameForRegister

procedure Tkw_WorkJournal_Control_JournalTree_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('JournalTree');
 inherited;
end;//Tkw_WorkJournal_Control_JournalTree_Push.DoDoIt

class function Tkw_WorkJournal_Control_JournalTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::JournalTree:push';
end;//Tkw_WorkJournal_Control_JournalTree_Push.GetWordNameForRegister

initialization
 TkwWorkJournalFormJournalTree.RegisterInEngine;
 {* Регистрация WorkJournalForm_JournalTree }
 Tkw_Form_WorkJournal.RegisterInEngine;
 {* Регистрация Tkw_Form_WorkJournal }
 Tkw_WorkJournal_Control_JournalTree.RegisterInEngine;
 {* Регистрация Tkw_WorkJournal_Control_JournalTree }
 Tkw_WorkJournal_Control_JournalTree_Push.RegisterInEngine;
 {* Регистрация Tkw_WorkJournal_Control_JournalTree_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWorkJournalForm));
 {* Регистрация типа TWorkJournalForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
