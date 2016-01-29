unit k2NilOp;

interface

uses
 l3IntfUses
 , k2Op
;

type
 Tk2NilOp = class(Tk2Op)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//Tk2NilOp
 
implementation

uses
 l3ImplUses
;

end.
