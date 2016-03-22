unit kwEND;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwEND.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "END" MUID: (52D7B71F01DC)
// Имя типа: "TkwEND"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCloseBracket
;

type
 TkwEND = {final} class(TkwCloseBracket)
  protected
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwEND
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

class function TkwEND.GetWordNameForRegister: AnsiString;
begin
 Result := 'END';
end;//TkwEND.GetWordNameForRegister

initialization
 TkwEND.RegisterInEngine;
 {* Регистрация END }
{$IfEnd} // NOT Defined(NoScripts)

end.
