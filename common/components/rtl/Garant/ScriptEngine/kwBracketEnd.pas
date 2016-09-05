unit kwBracketEnd;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwBracketEnd.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "BracketEnd" MUID: (52D7B7360146)
// Имя типа: "TkwBracketEnd"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCloseBracket
;

type
 TkwBracketEnd = {final} class(TkwCloseBracket)
  protected
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwBracketEnd
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *52D7B7360146impl_uses*
 //#UC END# *52D7B7360146impl_uses*
;

class function TkwBracketEnd.GetWordNameForRegister: AnsiString;
begin
 Result := ')';
end;//TkwBracketEnd.GetWordNameForRegister

initialization
 TkwBracketEnd.RegisterInEngine;
 {* Регистрация BracketEnd }
{$IfEnd} // NOT Defined(NoScripts)

end.
