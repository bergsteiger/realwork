unit l3PureMixIns;

interface

uses
 l3IntfUses
;

type
 // _ItemType_
 
 (*
 Ml3CountHolder = interface
 end;//Ml3CountHolder
 *)
 
 (*
 Ml3List = interface(Ml3CountHolder)
  {* Список. }
 end;//Ml3List
 *)
 
 (*
 Ml3ListEx = interface(Ml3List)
  function IndexOf(const anItem: _ItemType_): Integer;
  function Add(const anItem: _ItemType_): Integer;
 end;//Ml3ListEx
 *)
 
 (*
 Ml3CheckStamp = interface
  function CheckStamp(const aGUID: TGUID): Boolean;
   {* Проверяет метку реализации интерфейса. Например для того, чтобы узнать, что реализация наша "родная". }
 end;//Ml3CheckStamp
 *)
 
 (*
 Ml3ChangingChanged = interface
  procedure Changed;
   {* нотификация о завершении изменения состояния объекта. Для перекрытия и использования в потомках. }
  procedure Changing;
   {* нотификация о начале изменения состояния объекта. Для перекрытия и использования в потомках. }
 end;//Ml3ChangingChanged
 *)
 
implementation

uses
 l3ImplUses
;

end.
