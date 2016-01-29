unit RedactionsKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/RedactionsKeywordsPack.pas"
// Начат: 05.02.2009 19:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Работа с документом и списком документов::Document::View::Document::Document::RedactionsKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы Redactions
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
  Redactions_Form,
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
  Tkw_Form_Redactions = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы Redactions
----
*Пример использования*:
[code]
'aControl' форма::Redactions TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_Redactions

// start class Tkw_Form_Redactions

class function Tkw_Form_Redactions.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::Redactions';
end;//Tkw_Form_Redactions.GetWordNameForRegister

function Tkw_Form_Redactions.GetString: AnsiString;
 {-}
begin
 Result := 'RedactionsForm';
end;//Tkw_Form_Redactions.GetString

type
  Tkw_Redactions_Control_RedactionTree = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола RedactionTree
----
*Пример использования*:
[code]
контрол::RedactionTree TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Redactions_Control_RedactionTree

// start class Tkw_Redactions_Control_RedactionTree

class function Tkw_Redactions_Control_RedactionTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RedactionTree';
end;//Tkw_Redactions_Control_RedactionTree.GetWordNameForRegister

function Tkw_Redactions_Control_RedactionTree.GetString: AnsiString;
 {-}
begin
 Result := 'RedactionTree';
end;//Tkw_Redactions_Control_RedactionTree.GetString

class procedure Tkw_Redactions_Control_RedactionTree.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_Redactions_Control_RedactionTree.RegisterInEngine

type
  Tkw_Redactions_Control_RedactionTree_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола RedactionTree
----
*Пример использования*:
[code]
контрол::RedactionTree:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Redactions_Control_RedactionTree_Push

// start class Tkw_Redactions_Control_RedactionTree_Push

procedure Tkw_Redactions_Control_RedactionTree_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('RedactionTree');
 inherited;
end;//Tkw_Redactions_Control_RedactionTree_Push.DoDoIt

class function Tkw_Redactions_Control_RedactionTree_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RedactionTree:push';
end;//Tkw_Redactions_Control_RedactionTree_Push.GetWordNameForRegister

type
  TkwRedactionsFormRedactionTree = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TRedactionsForm.RedactionTree
[panel]Контрол RedactionTree формы TRedactionsForm[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aRedactionsForm .TRedactionsForm.RedactionTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function RedactionTree(const aCtx: TtfwContext;
     aRedactionsForm: TRedactionsForm): TnscTreeViewWithAdapterDragDrop;
     {* Реализация слова скрипта .TRedactionsForm.RedactionTree }
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
  end;//TkwRedactionsFormRedactionTree

// start class TkwRedactionsFormRedactionTree

function TkwRedactionsFormRedactionTree.RedactionTree(const aCtx: TtfwContext;
  aRedactionsForm: TRedactionsForm): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aRedactionsForm.RedactionTree;
end;//TkwRedactionsFormRedactionTree.RedactionTree

procedure TkwRedactionsFormRedactionTree.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRedactionsForm : TRedactionsForm;
begin
 try
  l_aRedactionsForm := TRedactionsForm(aCtx.rEngine.PopObjAs(TRedactionsForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRedactionsForm: TRedactionsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RedactionTree(aCtx, l_aRedactionsForm)));
end;//TkwRedactionsFormRedactionTree.DoDoIt

class function TkwRedactionsFormRedactionTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TRedactionsForm.RedactionTree';
end;//TkwRedactionsFormRedactionTree.GetWordNameForRegister

procedure TkwRedactionsFormRedactionTree.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству RedactionTree', aCtx);
end;//TkwRedactionsFormRedactionTree.SetValuePrim

function TkwRedactionsFormRedactionTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwRedactionsFormRedactionTree.GetResultTypeInfo

function TkwRedactionsFormRedactionTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwRedactionsFormRedactionTree.GetAllParamsCount

function TkwRedactionsFormRedactionTree.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TRedactionsForm)]);
end;//TkwRedactionsFormRedactionTree.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_Redactions
 Tkw_Form_Redactions.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Redactions_Control_RedactionTree
 Tkw_Redactions_Control_RedactionTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Redactions_Control_RedactionTree_Push
 Tkw_Redactions_Control_RedactionTree_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация RedactionsForm_RedactionTree
 TkwRedactionsFormRedactionTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа Redactions
 TtfwTypeRegistrator.RegisterType(TypeInfo(TRedactionsForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscTreeViewWithAdapterDragDrop
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.