unit kwMouseGetCursorPosition;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwMouseGetCursorPosition.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "mouse_GetCursorPosition" MUID: (4EF0937D000A)
// Имя типа: "TkwMouseGetCursorPosition"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwMouseGetCursorPosition = class(TtfwRegisterableWord)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwMouseGetCursorPosition
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
;

class function TkwMouseGetCursorPosition.GetWordNameForRegister: AnsiString;
begin
 Result := 'mouse:GetCursorPosition';
end;//TkwMouseGetCursorPosition.GetWordNameForRegister

procedure TkwMouseGetCursorPosition.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4EF0937D000A_var*
var
 l_CursorPos: TPoint;
//#UC END# *4DAEEDE10285_4EF0937D000A_var*
begin
//#UC START# *4DAEEDE10285_4EF0937D000A_impl*
 Windows.GetCursorPos(l_CursorPos);
 aCtx.rEngine.PushInt(l_CursorPos.X);
 aCtx.rEngine.PushInt(l_CursorPos.Y);
//#UC END# *4DAEEDE10285_4EF0937D000A_impl*
end;//TkwMouseGetCursorPosition.DoDoIt

initialization
 TkwMouseGetCursorPosition.RegisterInEngine;
 {* Регистрация mouse_GetCursorPosition }
{$IfEnd} // NOT Defined(NoScripts)

end.
