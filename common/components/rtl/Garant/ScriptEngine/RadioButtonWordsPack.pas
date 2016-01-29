unit RadioButtonWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$VT"
// Модуль: "RadioButtonWordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi::ScriptEngine$VT::vtControlsFromStackWords::RadioButtonWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  StdCtrls
  {$IfEnd} //not NoVCL
  ,
  tfwScriptingInterfaces,
  tfwPropertyLike
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwPopRadioButtonChecked = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:RadioButton:Checked
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aRadioButton pop:RadioButton:Checked >>> l_Boolean
[code]  }
 private
 // private methods
   function Checked(const aCtx: TtfwContext;
    aRadioButton: TRadioButton): Boolean;
     {* Реализация слова скрипта pop:RadioButton:Checked }
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
 end;//TkwPopRadioButtonChecked

// start class TkwPopRadioButtonChecked

function TkwPopRadioButtonChecked.Checked(const aCtx: TtfwContext;
  aRadioButton: TRadioButton): Boolean;
 {-}
begin
 Result := aRadioButton.Checked;
end;//TkwPopRadioButtonChecked.Checked

procedure TkwPopRadioButtonChecked.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRadioButton : TRadioButton;
begin
 try
  l_aRadioButton := TRadioButton(aCtx.rEngine.PopObjAs(TRadioButton));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRadioButton: TRadioButton : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((Checked(aCtx, l_aRadioButton)));
end;//TkwPopRadioButtonChecked.DoDoIt

class function TkwPopRadioButtonChecked.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:RadioButton:Checked';
end;//TkwPopRadioButtonChecked.GetWordNameForRegister

procedure TkwPopRadioButtonChecked.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
var
 l_RadioButton: TRadioButton;
begin
 try
  l_RadioButton := TRadioButton(aCtx.rEngine.PopObjAs(TRadioButton));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра l_RadioButton: TRadioButton : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 l_RadioButton.Checked := (aValue.AsBoolean);
end;//TkwPopRadioButtonChecked.SetValuePrim

function TkwPopRadioButtonChecked.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopRadioButtonChecked.GetResultTypeInfo

function TkwPopRadioButtonChecked.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopRadioButtonChecked.GetAllParamsCount

function TkwPopRadioButtonChecked.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TRadioButton)]);
end;//TkwPopRadioButtonChecked.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация pop_RadioButton_Checked
 TkwPopRadioButtonChecked.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TRadioButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TRadioButton));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts

end.