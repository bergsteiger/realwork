unit l3Tool;

interface

uses
 l3IntfUses
 , l3ProtoObjectWithCOMQI
 , l3Interfaces
;

type
 Tl3Tool = class(Tl3ProtoObjectWithCOMQI, Il3Tool)
  procedure Create(const anOwner: Il3ToolOwner);
  procedure OwnerDead;
   {* Нотификация о смерти родителя. }
 end;//Tl3Tool
 
implementation

uses
 l3ImplUses
;

end.
