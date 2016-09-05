unit kwMouseMiddleUp;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwMouseMiddleUp.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Mouse_MiddleUp" MUID: (4F967CDF0244)
// Имя типа: "TkwMouseMiddleUp"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

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
 //#UC START# *4F967CDF0244impl_uses*
 //#UC END# *4F967CDF0244impl_uses*
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
