unit kwMouseWheelSupport;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwMouseWheelSupport.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwMouseWheelSupport" MUID: (50C852B30225)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwSendInputSupport
 , tfwScriptingInterfaces
 , Windows
;

type
 TkwMouseWheelSupport = {abstract} class(TkwSendInputSupport)
  protected
   function GetLineCount(const aCtx: TtfwContext): Integer; virtual; abstract;
   function GetInputStruct(const aCtx: TtfwContext): TInput; override;
 end;//TkwMouseWheelSupport
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
 //#UC START# *50C852B30225impl_uses*
 //#UC END# *50C852B30225impl_uses*
;

function TkwMouseWheelSupport.GetInputStruct(const aCtx: TtfwContext): TInput;
//#UC START# *4F71A8960347_50C852B30225_var*
var
 l_P: TPoint;
//#UC END# *4F71A8960347_50C852B30225_var*
begin
//#UC START# *4F71A8960347_50C852B30225_impl*
 l3FillChar(Result, SizeOf(TInput));

 Windows.GetCursorPos(l_P);
 Result.Itype := INPUT_MOUSE;
 Result.mi.dx := l_P.X;
 Result.mi.dy := l_P.Y;
 Result.mi.mouseData := DWORD(WHEEL_DELTA * GetLineCount(aCtx)); // msdn://MOUSEINPUT
                                                         //mouseData
          //If dwFlags contains MOUSEEVENTF_WHEEL, then mouseData provides the amount of wheel movement.
          //A positive value indicates that the wheel was rotated forward, away from the user; a negative
          //value indicates that the wheel was rotated backward, toward the user. One wheel click is
          //defined as WHEEL_DELTA, which is 120.
 Result.mi.dwFlags := MOUSEEVENTF_WHEEL;
//#UC END# *4F71A8960347_50C852B30225_impl*
end;//TkwMouseWheelSupport.GetInputStruct

initialization
 TkwMouseWheelSupport.RegisterClass;
 {* Регистрация TkwMouseWheelSupport }
{$IfEnd} // NOT Defined(NoScripts)

end.
