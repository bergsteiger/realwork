unit kwRAISE;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwRAISE = class(TtfwRegisterableWord)
  {* Зарезервированное слово RAISE. Аналогично raise из Delphi. Если не было исключения, то генерируется EtfwScriptException.
Пример:
[code]
TRY
 'Тестовое исключение' RAISE
EXCEPT
 true >>> WasException
END
[code] }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwRAISE
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
