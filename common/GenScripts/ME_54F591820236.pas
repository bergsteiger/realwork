unit tb97WordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tb97WordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoTB97)}
uses
 l3IntfUses
 , tb97Ctls
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoTB97)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoTB97)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopTB97ButtonDown = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:TB97Button:Down
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTB97Button pop:TB97Button:Down >>> l_Boolean
[code]  }
  private
   function Down(const aCtx: TtfwContext;
    aTB97Button: TCustomToolbarButton97): Boolean;
    {* Реализация слова скрипта pop:TB97Button:Down }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTB97ButtonDown

function TkwPopTB97ButtonDown.Down(const aCtx: TtfwContext;
 aTB97Button: TCustomToolbarButton97): Boolean;
 {* Реализация слова скрипта pop:TB97Button:Down }
//#UC START# *5E37302039D5_C746DA0CF72F_var*
//#UC END# *5E37302039D5_C746DA0CF72F_var*
begin
//#UC START# *5E37302039D5_C746DA0CF72F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5E37302039D5_C746DA0CF72F_impl*
end;//TkwPopTB97ButtonDown.Down

procedure TkwPopTB97ButtonDown.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C746DA0CF72F_var*
//#UC END# *4DAEEDE10285_C746DA0CF72F_var*
begin
//#UC START# *4DAEEDE10285_C746DA0CF72F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C746DA0CF72F_impl*
end;//TkwPopTB97ButtonDown.DoDoIt

class function TkwPopTB97ButtonDown.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TB97Button:Down';
end;//TkwPopTB97ButtonDown.GetWordNameForRegister

procedure TkwPopTB97ButtonDown.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C746DA0CF72F_var*
//#UC END# *52D00B00031A_C746DA0CF72F_var*
begin
//#UC START# *52D00B00031A_C746DA0CF72F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C746DA0CF72F_impl*
end;//TkwPopTB97ButtonDown.SetValuePrim

function TkwPopTB97ButtonDown.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C746DA0CF72F_var*
//#UC END# *551544E2001A_C746DA0CF72F_var*
begin
//#UC START# *551544E2001A_C746DA0CF72F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C746DA0CF72F_impl*
end;//TkwPopTB97ButtonDown.GetResultTypeInfo

function TkwPopTB97ButtonDown.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_C746DA0CF72F_var*
//#UC END# *559687E6025A_C746DA0CF72F_var*
begin
//#UC START# *559687E6025A_C746DA0CF72F_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_C746DA0CF72F_impl*
end;//TkwPopTB97ButtonDown.GetAllParamsCount

function TkwPopTB97ButtonDown.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C746DA0CF72F_var*
//#UC END# *5617F4D00243_C746DA0CF72F_var*
begin
//#UC START# *5617F4D00243_C746DA0CF72F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C746DA0CF72F_impl*
end;//TkwPopTB97ButtonDown.ParamsTypes

initialization
 TkwPopTB97ButtonDown.RegisterInEngine;
 {* Регистрация pop_TB97Button_Down }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCustomToolbarButton97));
 {* Регистрация типа TCustomToolbarButton97 }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoTB97)

end.
