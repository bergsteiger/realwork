unit kwMouseMiddleUp;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwMouseMiddleUp.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwMouseUpDownSupport
;

type
 TkwMouseMiddleUp = {final} class(TkwMouseUpDownSupport)
  protected
   function GetMouseEventFlag: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwMouseMiddleUp
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
;

function TkwMouseMiddleUp.GetMouseEventFlag: Integer;
//#UC START# *4F967BED0186_4F967CDF0244_var*
//#UC END# *4F967BED0186_4F967CDF0244_var*
begin
//#UC START# *4F967BED0186_4F967CDF0244_impl*
 Result := MOUSEEVENTF_MIDDLEUP;
//#UC END# *4F967BED0186_4F967CDF0244_impl*
end;//TkwMouseMiddleUp.GetMouseEventFlag

class function TkwMouseMiddleUp.GetWordNameForRegister: AnsiString;
begin
 Result := 'Mouse:MiddleUp';
end;//TkwMouseMiddleUp.GetWordNameForRegister

initialization
 TkwMouseMiddleUp.RegisterInEngine;
 {* Регистрация Mouse_MiddleUp }
{$IfEnd} // NOT Defined(NoScripts)

end.
