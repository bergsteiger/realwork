unit kwMouseRightUp;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwMouseRightUp.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Mouse_RightUp" MUID: (4F967CBF016D)
// Имя типа: "TkwMouseRightUp"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwMouseUpDownSupport
;

type
 TkwMouseRightUp = {final} class(TkwMouseUpDownSupport)
  protected
   function GetMouseEventFlag: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwMouseRightUp
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
 //#UC START# *4F967CBF016Dimpl_uses*
 //#UC END# *4F967CBF016Dimpl_uses*
;

function TkwMouseRightUp.GetMouseEventFlag: Integer;
//#UC START# *4F967BED0186_4F967CBF016D_var*
//#UC END# *4F967BED0186_4F967CBF016D_var*
begin
//#UC START# *4F967BED0186_4F967CBF016D_impl*
 Result := MOUSEEVENTF_RIGHTUP;
//#UC END# *4F967BED0186_4F967CBF016D_impl*
end;//TkwMouseRightUp.GetMouseEventFlag

class function TkwMouseRightUp.GetWordNameForRegister: AnsiString;
begin
 Result := 'Mouse:RightUp';
end;//TkwMouseRightUp.GetWordNameForRegister

initialization
 TkwMouseRightUp.RegisterInEngine;
 {* Регистрация Mouse_RightUp }
{$IfEnd} // NOT Defined(NoScripts)

end.
