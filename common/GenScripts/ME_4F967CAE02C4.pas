unit kwMouseRightDown;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwMouseRightDown.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwMouseUpDownSupport
;

type
 TkwMouseRightDown = {final} class(TkwMouseUpDownSupport)
  protected
   function GetMouseEventFlag: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwMouseRightDown
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
;

function TkwMouseRightDown.GetMouseEventFlag: Integer;
//#UC START# *4F967BED0186_4F967CAE02C4_var*
//#UC END# *4F967BED0186_4F967CAE02C4_var*
begin
//#UC START# *4F967BED0186_4F967CAE02C4_impl*
 Result := MOUSEEVENTF_RIGHTDOWN;
//#UC END# *4F967BED0186_4F967CAE02C4_impl*
end;//TkwMouseRightDown.GetMouseEventFlag

class function TkwMouseRightDown.GetWordNameForRegister: AnsiString;
begin
 Result := 'Mouse:RightDown';
end;//TkwMouseRightDown.GetWordNameForRegister

initialization
 TkwMouseRightDown.RegisterInEngine;
 {* Регистрация Mouse_RightDown }
{$IfEnd} // NOT Defined(NoScripts)

end.
