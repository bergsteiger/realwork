unit RadioButtonWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\RadioButtonWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopRadioButtonChecked = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:RadioButton:Checked
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aRadioButton pop:RadioButton:Checked >>> l_Boolean
[code]  }
  private
   function Checked(const aCtx: TtfwContext;
    aRadioButton: TRadioButton): Boolean;
    {* Реализация слова скрипта pop:RadioButton:Checked }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopRadioButtonChecked

function TkwPopRadioButtonChecked.Checked(const aCtx: TtfwContext;
 aRadioButton: TRadioButton): Boolean;
 {* Реализация слова скрипта pop:RadioButton:Checked }
begin
 Result := aRadioButton.Checked;
end;//TkwPopRadioButtonChecked.Checked

procedure TkwPopRadioButtonChecked.DoDoIt(const aCtx: TtfwContext);
var l_aRadioButton: TRadioButton;
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
 aCtx.rEngine.PushBool(Checked(aCtx, l_aRadioButton));
end;//TkwPopRadioButtonChecked.DoDoIt

class function TkwPopRadioButtonChecked.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RadioButton:Checked';
end;//TkwPopRadioButtonChecked.GetWordNameForRegister

procedure TkwPopRadioButtonChecked.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_RadioButton: TRadioButton;
begin
 try
  l_RadioButton := TRadioButton(aCtx.rEngine.PopObjAs(TRadioButton));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра RadioButton: TRadioButton : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 l_RadioButton.Checked := aValue.AsBoolean;
end;//TkwPopRadioButtonChecked.SetValuePrim

function TkwPopRadioButtonChecked.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopRadioButtonChecked.GetResultTypeInfo

function TkwPopRadioButtonChecked.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopRadioButtonChecked.GetAllParamsCount

function TkwPopRadioButtonChecked.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TRadioButton)]);
end;//TkwPopRadioButtonChecked.ParamsTypes

initialization
 TkwPopRadioButtonChecked.RegisterInEngine;
 {* Регистрация pop_RadioButton_Checked }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TRadioButton));
 {* Регистрация типа TRadioButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // NOT Defined(NoScripts)

end.
