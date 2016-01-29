unit l3MultiThreadIntegerList;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3ProtoIntegerList
;

type
 IntegerIterator_ForEachF_Action = function(anItem: Integer): Boolean;
  {* Тип подитеративной функции для IntegerIterator.ForEachF }
 
 IntegerIterator_ForOneF_Action = function(anItem: Integer): Boolean;
  {* Тип подитеративной функции для IntegerIterator.ForOneF }
 
 (*
 IntegerIterator = interface
  procedure ForEachF;
  procedure ForOneF;
 end;//IntegerIterator
 *)
 
 Tl3MultiThreadIntegerList = class(Tl3ProtoObject)
  procedure Add(anItem: Integer);
  procedure Remove(anItem: Integer);
  function NeedSort: Boolean;
  procedure Clear;
  procedure ForEachF;
  procedure ForOneF;
 end;//Tl3MultiThreadIntegerList
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
;

end.
