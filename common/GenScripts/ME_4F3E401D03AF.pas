unit kwIntegerFactory;

interface

uses
 l3IntfUses
 , kwIntegerArray
 , kwInteger
;

type
 TkwIntegerFactory = class(TkwIntegerArray)
  function MakeKW(aValue: Integer): TkwInteger;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TkwIntegerFactory
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
