unit kwMouseLeftUp;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwMouseLeftUp.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Mouse_LeftUp" MUID: (4F71C14601E6)
// Имя типа: "TkwMouseLeftUp"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwMouseUpDownSupport
;

type
 TkwMouseLeftUp = class(TkwMouseUpDownSupport)
  protected
   function GetMouseEventFlag: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwMouseLeftUp
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
;

function TkwMouseLeftUp.GetMouseEventFlag: Integer;
//#UC START# *4F967BED0186_4F71C14601E6_var*
//#UC END# *4F967BED0186_4F71C14601E6_var*
begin
//#UC START# *4F967BED0186_4F71C14601E6_impl*
 Result := MOUSEEVENTF_LEFTUP;
//#UC END# *4F967BED0186_4F71C14601E6_impl*
end;//TkwMouseLeftUp.GetMouseEventFlag

class function TkwMouseLeftUp.GetWordNameForRegister: AnsiString;
begin
 Result := 'Mouse:LeftUp';
end;//TkwMouseLeftUp.GetWordNameForRegister

initialization
 TkwMouseLeftUp.RegisterInEngine;
 {* Регистрация Mouse_LeftUp }
{$IfEnd} // NOT Defined(NoScripts)

end.
