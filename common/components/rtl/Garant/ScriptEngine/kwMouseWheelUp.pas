unit kwMouseWheelUp;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwMouseWheelUp.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwMouseWheelSupport
 , tfwScriptingInterfaces
;

type
 TkwMouseWheelUp = {final} class(TkwMouseWheelSupport)
  protected
   function GetLineCount(const aCtx: TtfwContext): Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwMouseWheelUp
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
;

function TkwMouseWheelUp.GetLineCount(const aCtx: TtfwContext): Integer;
//#UC START# *50C861750031_50C8531900E4_var*
//#UC END# *50C861750031_50C8531900E4_var*
begin
//#UC START# *50C861750031_50C8531900E4_impl*
 RunnerAssert(aCtx.rEngine.IsTopInt, 'Не задано количество линий для прокрутки', aCtx);
 Result := aCtx.rEngine.PopInt;
//#UC END# *50C861750031_50C8531900E4_impl*
end;//TkwMouseWheelUp.GetLineCount

class function TkwMouseWheelUp.GetWordNameForRegister: AnsiString;
begin
 Result := 'Mouse:WheelUp';
end;//TkwMouseWheelUp.GetWordNameForRegister

initialization
 TkwMouseWheelUp.RegisterInEngine;
 {* Регистрация Mouse_WheelUp }
{$IfEnd} // NOT Defined(NoScripts)

end.
