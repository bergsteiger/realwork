unit RadioButtonWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\RadioButtonWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "RadioButtonWordsPack" MUID: (552E3DE40071)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , StdCtrls
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopRadioButtonChecked = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:RadioButton:Checked }
  private
   function Checked(const aCtx: TtfwContext;
    aRadioButton: TRadioButton): Boolean;
    {* Реализация слова скрипта pop:RadioButton:Checked }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopRadioButtonChecked

function TkwPopRadioButtonChecked.Checked(const aCtx: TtfwContext;
 aRadioButton: TRadioButton): Boolean;
 {* Реализация слова скрипта pop:RadioButton:Checked }
begin
 Result := aRadioButton.Checked;
end;//TkwPopRadioButtonChecked.Checked

class function TkwPopRadioButtonChecked.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RadioButton:Checked';
end;//TkwPopRadioButtonChecked.GetWordNameForRegister

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

initialization
 TkwPopRadioButtonChecked.RegisterInEngine;
 {* Регистрация pop_RadioButton_Checked }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TRadioButton));
 {* Регистрация типа TRadioButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
