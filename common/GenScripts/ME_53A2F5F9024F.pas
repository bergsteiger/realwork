unit ddClientMessageSortableList;

interface

uses
 l3IntfUses
 , csClientMessageRequest
 , l3ProtoObject
 , ddClientMessageSortableListPrim
;

type
 ddClientMessageIterator_ForEachF_Action = function(anItem: TddClientMessage): Boolean;
  {* Тип подитеративной функции для ddClientMessageIterator.ForEachF }
 
 (*
 ddClientMessageIterator = interface
  procedure ForEachF;
 end;//ddClientMessageIterator
 *)
 
 TddClientMessageSortableList = class(Tl3ProtoObject)
  procedure Add(anItem: TddClientMessage);
  procedure Clear;
  procedure ForEachF;
 end;//TddClientMessageSortableList
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
;

end.
