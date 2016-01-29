unit tfwString;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , TypInfo
;

type
 TtfwString = class(TtfwRegisterableWord)
  {* Базовый предок для добавления слов в словарь. }
  function GetString: AnsiString;
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TtfwString
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3Except
 , tfwScriptingTypes
;

end.
