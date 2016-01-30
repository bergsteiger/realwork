unit kwMouseWheelDown;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwMouseWheelDown.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwMouseWheelSupport
 , tfwScriptingInterfaces
;

type
 TkwMouseWheelDown = {final} class(TkwMouseWheelSupport)
  protected
   function GetLineCount(const aCtx: TtfwContext): Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwMouseWheelDown
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function TkwMouseWheelDown.GetLineCount(const aCtx: TtfwContext): Integer;
//#UC START# *50C861750031_50C8532700B0_var*
//#UC END# *50C861750031_50C8532700B0_var*
begin
//#UC START# *50C861750031_50C8532700B0_impl*
 RunnerAssert(aCtx.rEngine.IsTopInt, 'Не задано количество линий для прокрутки', aCtx);
 Result := - aCtx.rEngine.PopInt;
//#UC END# *50C861750031_50C8532700B0_impl*
end;//TkwMouseWheelDown.GetLineCount

class function TkwMouseWheelDown.GetWordNameForRegister: AnsiString;
begin
 Result := 'Mouse:WheelDown';
end;//TkwMouseWheelDown.GetWordNameForRegister

initialization
 TkwMouseWheelDown.RegisterInEngine;
 {* Регистрация Mouse_WheelDown }
{$IfEnd} // NOT Defined(NoScripts)

end.
