unit csMessageRecepientList;

interface

uses
 l3IntfUses
 , csMessageRecepient
 , l3ProtoObject
 , csMessageRecepientListPrim
;

type
 csMessageRecepientIterator_ForEachF_Action = function(anItem: TcsMessageRecepient): Boolean;
  {* Тип подитеративной функции для csMessageRecepientIterator.ForEachF }
 
 (*
 csMessageRecepientIterator = interface
  procedure ForEachF;
 end;//csMessageRecepientIterator
 *)
 
 TcsMessageRecepientList = class(Tl3ProtoObject)
  function Add(anItem: TcsMessageRecepient): TcsMessageRecepient;
  procedure Clear;
  procedure ForEachF;
 end;//TcsMessageRecepientList
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
;

end.
