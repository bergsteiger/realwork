unit elCustomEditKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Forms"
// Модуль: "w:/common/components/gui/Garant/Daily/Forms/elCustomEditKeywordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> Shared Delphi Operations For Tests::TestForms::Forms::Everest::elCustomEditKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы elCustomEdit
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
uses
  elCustomEdit,
  elCustomEdit_Form,
  tfwScriptingInterfaces,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 Tkw_Form_elCustomEdit = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора формы elCustomEdit
----
*Пример использования*:
[code]
'aControl' форма::elCustomEdit TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_elCustomEdit

// start class Tkw_Form_elCustomEdit

class function Tkw_Form_elCustomEdit.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::elCustomEdit';
end;//Tkw_Form_elCustomEdit.GetWordNameForRegister

function Tkw_Form_elCustomEdit.GetString: AnsiString;
 {-}
begin
 Result := 'elCustomEditForm';
end;//Tkw_Form_elCustomEdit.GetString

type
 Tkw_elCustomEdit_Component_Edit = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Edit
----
*Пример использования*:
[code]
компонент::Edit TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_elCustomEdit_Component_Edit

// start class Tkw_elCustomEdit_Component_Edit

class function Tkw_elCustomEdit_Component_Edit.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'компонент::Edit';
end;//Tkw_elCustomEdit_Component_Edit.GetWordNameForRegister

function Tkw_elCustomEdit_Component_Edit.GetString: AnsiString;
 {-}
begin
 Result := 'Edit';
end;//Tkw_elCustomEdit_Component_Edit.GetString

class procedure Tkw_elCustomEdit_Component_Edit.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TelCustomEdit);
end;//Tkw_elCustomEdit_Component_Edit.RegisterInEngine

type
 TkwElCustomEditFormEdit = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TelCustomEditForm.Edit
[panel]Контрол Edit формы TelCustomEditForm[panel]
*Тип результата:* TelCustomEdit
*Пример:*
[code]
OBJECT VAR l_TelCustomEdit
 aelCustomEditForm .TelCustomEditForm.Edit >>> l_TelCustomEdit
[code]  }
 private
 // private methods
   function Edit(const aCtx: TtfwContext;
    aelCustomEditForm: TelCustomEditForm): TelCustomEdit;
     {* Реализация слова скрипта .TelCustomEditForm.Edit }
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
 end;//TkwElCustomEditFormEdit

// start class TkwElCustomEditFormEdit

function TkwElCustomEditFormEdit.Edit(const aCtx: TtfwContext;
  aelCustomEditForm: TelCustomEditForm): TelCustomEdit;
 {-}
begin
 Result := aelCustomEditForm.Edit;
end;//TkwElCustomEditFormEdit.Edit

procedure TkwElCustomEditFormEdit.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aelCustomEditForm : TelCustomEditForm;
begin
 try
  l_aelCustomEditForm := TelCustomEditForm(aCtx.rEngine.PopObjAs(TelCustomEditForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aelCustomEditForm: TelCustomEditForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Edit(aCtx, l_aelCustomEditForm)));
end;//TkwElCustomEditFormEdit.DoDoIt

class function TkwElCustomEditFormEdit.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TelCustomEditForm.Edit';
end;//TkwElCustomEditFormEdit.GetWordNameForRegister

procedure TkwElCustomEditFormEdit.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Edit', aCtx);
end;//TkwElCustomEditFormEdit.SetValuePrim

function TkwElCustomEditFormEdit.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TelCustomEdit);
end;//TkwElCustomEditFormEdit.GetResultTypeInfo

function TkwElCustomEditFormEdit.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwElCustomEditFormEdit.GetAllParamsCount

function TkwElCustomEditFormEdit.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TelCustomEditForm)]);
end;//TkwElCustomEditFormEdit.ParamsTypes
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_Form_elCustomEdit
 Tkw_Form_elCustomEdit.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация Tkw_elCustomEdit_Component_Edit
 Tkw_elCustomEdit_Component_Edit.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация elCustomEditForm_Edit
 TkwElCustomEditFormEdit.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа elCustomEdit
 TtfwTypeRegistrator.RegisterType(TypeInfo(TelCustomEditForm));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация типа TelCustomEdit
 TtfwTypeRegistrator.RegisterType(TypeInfo(TelCustomEdit));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

end.