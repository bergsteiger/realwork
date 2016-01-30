unit kwMouseMiddleDown;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwMouseMiddleDown.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwMouseUpDownSupport
;

type
 TkwMouseMiddleDown = {final} class(TkwMouseUpDownSupport)
  protected
   function GetMouseEventFlag: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwMouseMiddleDown
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function TkwMouseMiddleDown.GetMouseEventFlag: Integer;
//#UC START# *4F967BED0186_4F967CF70162_var*
//#UC END# *4F967BED0186_4F967CF70162_var*
begin
//#UC START# *4F967BED0186_4F967CF70162_impl*
 Result := MOUSEEVENTF_MIDDLEDOWN;
//#UC END# *4F967BED0186_4F967CF70162_impl*
end;//TkwMouseMiddleDown.GetMouseEventFlag

class function TkwMouseMiddleDown.GetWordNameForRegister: AnsiString;
begin
 Result := 'Mouse:MiddleDown';
end;//TkwMouseMiddleDown.GetWordNameForRegister

initialization
 TkwMouseMiddleDown.RegisterInEngine;
 {* Регистрация Mouse_MiddleDown }
{$IfEnd} // NOT Defined(NoScripts)

end.
