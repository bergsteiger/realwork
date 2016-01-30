unit l3PureMixIns;
 {* Абстрактные примеси. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3PureMixIns.pas"
// Стереотип: "Interfaces"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
;

type
 // _ItemType_

 (*
 Ml3CountHolder = interface
  function pm_GetCount: Integer;
  property Count: Integer
   read pm_GetCount;
   {* Число элементов. }
 end;//Ml3CountHolder
 *)

 (*
 Ml3List = interface(Ml3CountHolder)
  {* Список. }
  function pm_GetEmpty: Boolean;
  function pm_GetFirst: _ItemType_;
  function pm_GetLast: _ItemType_;
  function pm_GetItems(anIndex: Integer): _ItemType_;
  property Empty: Boolean
   read pm_GetEmpty;
  property First: _ItemType_
   read pm_GetFirst;
   {* Первый элемент. }
  property Last: _ItemType_
   read pm_GetLast;
   {* Последний элемент. }
  property Items[anIndex: Integer]: _ItemType_
   read pm_GetItems;
   default;
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
