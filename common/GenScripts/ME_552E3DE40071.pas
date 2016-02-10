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
//#UC START# *0B811F8AAF5C_06BAC463482F_var*
//#UC END# *0B811F8AAF5C_06BAC463482F_var*
begin
//#UC START# *0B811F8AAF5C_06BAC463482F_impl*
 !!! Needs to be implemented !!!
//#UC END# *0B811F8AAF5C_06BAC463482F_impl*
end;//TkwPopRadioButtonChecked.Checked

procedure TkwPopRadioButtonChecked.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_06BAC463482F_var*
//#UC END# *4DAEEDE10285_06BAC463482F_var*
begin
//#UC START# *4DAEEDE10285_06BAC463482F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_06BAC463482F_impl*
end;//TkwPopRadioButtonChecked.DoDoIt

class function TkwPopRadioButtonChecked.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:RadioButton:Checked';
end;//TkwPopRadioButtonChecked.GetWordNameForRegister

procedure TkwPopRadioButtonChecked.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_06BAC463482F_var*
//#UC END# *52D00B00031A_06BAC463482F_var*
begin
//#UC START# *52D00B00031A_06BAC463482F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_06BAC463482F_impl*
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
//#UC START# *5617F4D00243_06BAC463482F_var*
//#UC END# *5617F4D00243_06BAC463482F_var*
begin
//#UC START# *5617F4D00243_06BAC463482F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_06BAC463482F_impl*
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
