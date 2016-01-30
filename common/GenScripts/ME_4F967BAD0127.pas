unit kwMouseUpDownSupport;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwMouseUpDownSupport.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwSendInputSupport
 , Windows
 , tfwScriptingInterfaces
;

type
 TkwMouseUpDownSupport = {abstract} class(TkwSendInputSupport)
  protected
   function GetMouseEventFlag: Integer; virtual; abstract;
   function GetInputStruct(const aCtx: TtfwContext): TInput; override;
 end;//TkwMouseUpDownSupport
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
;

function TkwMouseUpDownSupport.GetInputStruct(const aCtx: TtfwContext): TInput;
//#UC START# *4F71A8960347_4F967BAD0127_var*
var
 l_P: TPoint;
//#UC END# *4F71A8960347_4F967BAD0127_var*
begin
//#UC START# *4F71A8960347_4F967BAD0127_impl*
 l3FillChar(Result, SizeOf(TInput));

 Windows.GetCursorPos(l_P);
 Result.Itype := INPUT_MOUSE;
 Result.mi.dx := l_P.X;
 Result.mi.dy := l_P.Y;
 Result.mi.dwFlags := GetMouseEventFlag;
//#UC END# *4F71A8960347_4F967BAD0127_impl*
end;//TkwMouseUpDownSupport.GetInputStruct

initialization
 TkwMouseUpDownSupport.RegisterClass;
 {* Регистрация TkwMouseUpDownSupport }
{$IfEnd} // NOT Defined(NoScripts)

end.
