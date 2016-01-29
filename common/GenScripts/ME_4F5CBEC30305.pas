unit l3CEmptyString;

interface

uses
 l3IntfUses
 , l3CEmptyStringPrim
;

type
 Tl3CEmptyString = class(Tl3CEmptyStringPrim)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//Tl3CEmptyString
 
implementation

uses
 l3ImplUses
;

end.
