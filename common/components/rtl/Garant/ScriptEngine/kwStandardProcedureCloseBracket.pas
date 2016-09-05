unit kwStandardProcedureCloseBracket;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwStandardProcedureCloseBracket.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "StandardProcedureCloseBracket" MUID: (52D6AC5402E7)
// Имя типа: "TkwStandardProcedureCloseBracket"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCloseBracket
;

type
 TkwStandardProcedureCloseBracket = {final} class(TkwCloseBracket)
  protected
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwStandardProcedureCloseBracket
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *52D6AC5402E7impl_uses*
 //#UC END# *52D6AC5402E7impl_uses*
;

class function TkwStandardProcedureCloseBracket.GetWordNameForRegister: AnsiString;
begin
 Result := ';';
end;//TkwStandardProcedureCloseBracket.GetWordNameForRegister

initialization
 TkwStandardProcedureCloseBracket.RegisterInEngine;
 {* Регистрация StandardProcedureCloseBracket }
{$IfEnd} // NOT Defined(NoScripts)

end.
