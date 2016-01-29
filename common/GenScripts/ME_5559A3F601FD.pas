unit vcmFormSetContainerRegistry;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , vcmInterfaces
 , l3ProtoDataContainer
;

type
 TvcmFormSetContainerMapItem = object
 end;//TvcmFormSetContainerMapItem
 
 TvcmFormSetContainerMapIterator_ForEachF_Action = function(const anItem: IvcmFormSet): Boolean;
  {* Тип подитеративной функции для TvcmFormSetContainerMapIterator.ForEachF }
 
 TvcmFormSetContainerMapIterator_ForOneF_Action = function(const anItem: IvcmFormSet): Boolean;
  {* Тип подитеративной функции для TvcmFormSetContainerMapIterator.ForOneF }
 
 (*
 TvcmFormSetContainerMapIterator = interface
  procedure ForEachF;
  procedure ForOneF;
 end;//TvcmFormSetContainerMapIterator
 *)
 
 PvcmFormSetContainerMapItem = ^TvcmFormSetContainerMapItem;
 
 TvcmFormSetContainerMap = class(Tl3ProtoDataContainer)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
  procedure ForEachF;
  procedure ForOneF;
 end;//TvcmFormSetContainerMap
 
 TvcmFormSetContainerRegistry = class(Tl3ProtoObject)
  function GetFormSetContainer(const aFormSet: IvcmFormSet): IvcmContainer;
  function GetContainedFormSet(const aContainer: IvcmContainer): IvcmFormSet;
  procedure Create;
  procedure RegisterFormSet(const aFormSet: IvcmFormSet;
   const aContainer: IvcmContainer);
  procedure UnregisterFormSet(const aFormSet: IvcmFormSet);
  function GetFormSetCount(const aContainer: IvcmContainer): Integer;
  procedure UnregisterContainer(const aContainer: IvcmContainer);
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TvcmFormSetContainerRegistry
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3InterfacesMisc
 , l3Base
 , l3MinMax
 , RTLConsts
;

end.
