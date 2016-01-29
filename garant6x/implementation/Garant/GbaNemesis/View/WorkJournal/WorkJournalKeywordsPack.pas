unit WorkJournalKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/WorkJournal/WorkJournalKeywordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Основные прецеденты::WorkJournal::View::WorkJournal::BaseWorkJournal::WorkJournalKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы WorkJournal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  WorkJournal_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  nscTreeViewWithAdapterDragDrop,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_WorkJournal = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы WorkJournal
----
*Пример использования*:
[code]
'aControl' форма::WorkJournal TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_WorkJournal

// start class Tkw_Form_WorkJournal

class function Tkw_Form_WorkJournal.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::WorkJournal';
end;//Tkw_Form_WorkJournal.GetWordNameForRegister

function Tkw_Form_WorkJournal.GetString: AnsiString;
 {-}
begin
 Result := 'WorkJournalForm';
end;//Tkw_Form_WorkJournal.GetString

type
  Tkw_WorkJournal_Control_JournalTree = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола JournalTree
----
*Пример использования*:
[code]
контрол::JournalTree TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_WorkJournal_Control_JournalTree

// start class Tkw_WorkJournal_Control_JournalTree

class function Tkw_WorkJournal_Control_JournalTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::JournalTree';
end;//Tkw_WorkJournal_Control_JournalTree.GetWordNameForRegister

function Tkw_WorkJournal_Control_JournalTree.GetString: AnsiString;
 {-}
begin
 Result := 'JournalTree';
end;//Tkw_WorkJournal_Control_JournalTree.GetString

class procedure Tkw_WorkJournal_Control_JournalTree.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_WorkJournal_Control_JournalTree.RegisterInEngine

type
  Tkw_WorkJournal_Control_JournalTree_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола JournalTree
----
*Пример использования*:
[code]
контрол::JournalTree:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_WorkJournal_Control_JournalTree_Push

// start class Tkw_WorkJournal_Control_JournalTree_Push

procedure Tkw_WorkJournal_Control_JournalTree_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('JournalTree');
 inherited;
end;//Tkw_WorkJournal_Control_JournalTree_Push.DoDoIt

class function Tkw_WorkJournal_Control_JournalTree_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::JournalTree:push';
end;//Tkw_WorkJournal_Control_JournalTree_Push.GetWordNameForRegister

type
  TkwWorkJournalFormJournalTree = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TWorkJournalForm.JournalTree
[panel]Контрол JournalTree формы TWorkJournalForm[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aWorkJournalForm .TWorkJournalForm.JournalTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function JournalTree(const aCtx: TtfwContext;
     aWorkJournalForm: TWorkJournalForm): TnscTreeViewWithAdapterDragDrop;
     {* Реализация слова скрипта .TWorkJournalForm.JournalTree }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwWorkJournalFormJournalTree

// start class TkwWorkJournalFormJournalTree

function TkwWorkJournalFormJournalTree.JournalTree(const aCtx: TtfwContext;
  aWorkJournalForm: TWorkJournalForm): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aWorkJournalForm.JournalTree;
end;//TkwWorkJournalFormJournalTree.JournalTree

procedure TkwWorkJournalFormJournalTree.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aWorkJournalForm : TWorkJournalForm;
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
 aCtx.rEngine.PushObj((JournalTree(aCtx, l_aWorkJournalForm)));
end;//TkwWorkJournalFormJournalTree.DoDoIt

class function TkwWorkJournalFormJournalTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TWorkJournalForm.JournalTree';
end;//TkwWorkJournalFormJournalTree.GetWordNameForRegister

procedure TkwWorkJournalFormJournalTree.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству JournalTree', aCtx);
end;//TkwWorkJournalFormJournalTree.SetValuePrim

function TkwWorkJournalFormJournalTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwWorkJournalFormJournalTree.GetResultTypeInfo

function TkwWorkJournalFormJournalTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwWorkJournalFormJournalTree.GetAllParamsCount

function TkwWorkJournalFormJournalTree.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TWorkJournalForm)]);
end;//TkwWorkJournalFormJournalTree.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_WorkJournal
 Tkw_Form_WorkJournal.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_WorkJournal_Control_JournalTree
 Tkw_WorkJournal_Control_JournalTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_WorkJournal_Control_JournalTree_Push
 Tkw_WorkJournal_Control_JournalTree_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация WorkJournalForm_JournalTree
 TkwWorkJournalFormJournalTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа WorkJournal
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWorkJournalForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscTreeViewWithAdapterDragDrop
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.