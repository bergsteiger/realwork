unit k2Op;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , k2Prim
;

type
 Tk2Op = class(Tl3CacheableBase)
  function CompareWith(anOp: Tk2Op): Integer;
  function CanJoinWith(anOperation: Tk2Op): Boolean;
  function DoJoin(anOperation: Tk2Op): Tk2Op;
   {* соединяет две операции и возвращает:
          nil  - соединение неудачно
          Self - соединение удачно и все поместилось в старую запись
          New  - распределена новая операция }
  procedure DoUndo(const Container: Ik2Op);
   {* отменить операцию }
  procedure DoRedo(const Container: Ik2Op);
   {* вернуть операцию }
 end;//Tk2Op
 
implementation

uses
 l3ImplUses
 , k2NilOp
;

end.
