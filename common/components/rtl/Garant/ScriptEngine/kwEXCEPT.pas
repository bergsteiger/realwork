unit kwEXCEPT;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwEXCEPT.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "EXCEPT" MUID: (52D7DDC80366)
// Имя типа: "TkwEXCEPT"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwMedianBacket
;

type
 TkwEXCEPT = {final} class(TkwMedianBacket)
  protected
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwEXCEPT
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *52D7DDC80366impl_uses*
 //#UC END# *52D7DDC80366impl_uses*
;

class function TkwEXCEPT.GetWordNameForRegister: AnsiString;
begin
 Result := 'EXCEPT';
end;//TkwEXCEPT.GetWordNameForRegister

initialization
 TkwEXCEPT.RegisterInEngine;
 {* Регистрация EXCEPT }
{$IfEnd} // NOT Defined(NoScripts)

end.
