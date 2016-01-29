unit k2NullTagImpl;

interface

uses
 l3IntfUses
 , k2NullTagImplPrim
;

type
 Tk2NullTagImpl = class(Tk2NullTagImplPrim)
  {* Реализация пустого тега }
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//Tk2NullTagImpl
 
implementation

uses
 l3ImplUses
;

end.
