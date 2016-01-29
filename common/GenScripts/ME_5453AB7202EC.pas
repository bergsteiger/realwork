unit m3BranchHandlePrim;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3SimpleMemoryManager
;

type
 Tm3BranchHandlePrimData = record
 end;//Tm3BranchHandlePrimData
 
 Pm3BranchHandlePrim = ^Tm3BranchHandlePrim;
 
 Tm3BranchHandlesManager = class(Tl3SimpleMemoryManager)
  procedure Create;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//Tm3BranchHandlesManager
 
 Tm3BranchHandlePrim = class(Tl3ProtoObject)
 end;//Tm3BranchHandlePrim
 
implementation

uses
 l3ImplUses
 , m3WideStringManager
 , m3BranchHandle
;

end.
