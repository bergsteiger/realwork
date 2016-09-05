unit kwMouseLeftDown;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwMouseLeftDown.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Mouse_LeftDown" MUID: (4F71C11F02F2)
// Имя типа: "TkwMouseLeftDown"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwMouseUpDownSupport
;

type
 TkwMouseLeftDown = class(TkwMouseUpDownSupport)
  protected
   function GetMouseEventFlag: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwMouseLeftDown
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
 //#UC START# *4F71C11F02F2impl_uses*
 //#UC END# *4F71C11F02F2impl_uses*
;

function TkwMouseLeftDown.GetMouseEventFlag: Integer;
//#UC START# *4F967BED0186_4F71C11F02F2_var*
//#UC END# *4F967BED0186_4F71C11F02F2_var*
begin
//#UC START# *4F967BED0186_4F71C11F02F2_impl*
 Result := MOUSEEVENTF_LEFTDOWN;
//#UC END# *4F967BED0186_4F71C11F02F2_impl*
end;//TkwMouseLeftDown.GetMouseEventFlag

class function TkwMouseLeftDown.GetWordNameForRegister: AnsiString;
begin
 Result := 'Mouse:LeftDown';
end;//TkwMouseLeftDown.GetWordNameForRegister

initialization
 TkwMouseLeftDown.RegisterInEngine;
 {* Регистрация Mouse_LeftDown }
{$IfEnd} // NOT Defined(NoScripts)

end.
