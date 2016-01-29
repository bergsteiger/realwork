unit tfwInteger;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , TypInfo
;

type
 TtfwInteger = class(TtfwRegisterableWord)
  {* Базовый предок для добавления слов в словарь. }
  function GetInteger: Integer;
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TtfwInteger
 
implementation

uses
 l3ImplUses
 , l3Except
 , l3Base
;

end.
