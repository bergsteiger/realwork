unit vcmFormSetContainerRegistry;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmFormSetContainerRegistry.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoObject
 , vcmInterfaces
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 PvcmFormSetContainerMapItem = ^TvcmFormSetContainerMapItem;

 TvcmFormSetContainerMapItem = object
  public
   rContainer: Pointer;
   rFormSet: Pointer;
  public
   function EQ(const anOther: TvcmFormSetContainerMapItem): Boolean;
 end;//TvcmFormSetContainerMapItem

 TvcmFormSetContainerMapIterator_ForEachF_Action = function(const anItem: IvcmFormSet): Boolean;
  {* Тип подитеративной функции для TvcmFormSetContainerMapIterator.ForEachF }

 TvcmFormSetContainerMapIterator_ForOneF_Action = function(const anItem: IvcmFormSet): Boolean;
  {* Тип подитеративной функции для TvcmFormSetContainerMapIterator.ForOneF }

 (*
 TvcmFormSetContainerMapIterator = interface
  procedure ForEachF(anAction: TvcmFormSetContainerMapIterator_ForEachF_Action;
   const aContainer: IvcmContainer);
  procedure ForOneF(anAction: TvcmFormSetContainerMapIterator_ForOneF_Action;
   const aContainer: IvcmContainer;
   anIndex: Integer);
 end;//TvcmFormSetContainerMapIterator
 *)

 _ItemType_ = TvcmFormSetContainerMapItem;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3RecordWithEQList.imp.pas}
 TvcmFormSetContainerMap = class(_l3RecordWithEQList_)
  public
   procedure ForEachF(anAction: TvcmFormSetContainerMapIterator_ForEachF_Action;
    const aContainer: IvcmContainer);
   procedure ForOneF(anAction: TvcmFormSetContainerMapIterator_ForOneF_Action;
    const aContainer: IvcmContainer;
    anIndex: Integer);
 end;//TvcmFormSetContainerMap

 TvcmFormSetContainerRegistry = class(Tl3ProtoObject)
  private
   f_Map: TvcmFormSetContainerMap;
    {* Поле для свойства Map }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   function GetFormSetContainer(const aFormSet: IvcmFormSet): IvcmContainer;
   function GetContainedFormSet(const aContainer: IvcmContainer): IvcmFormSet;
   constructor Create; reintroduce;
   procedure RegisterFormSet(const aFormSet: IvcmFormSet;
    const aContainer: IvcmContainer);
   procedure UnregisterFormSet(const aFormSet: IvcmFormSet);
   function GetFormSetCount(const aContainer: IvcmContainer): Integer;
   procedure UnregisterContainer(const aContainer: IvcmContainer);
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TvcmFormSetContainerRegistry;
    {* Метод получения экземпляра синглетона TvcmFormSetContainerRegistry }
  public
   property Map: TvcmFormSetContainerMap
    read f_Map;
 end;//TvcmFormSetContainerRegistry

function TvcmFormSetContainerMapItem_C(const aFormSet: IvcmFormSet;
 const aContainer: IvcmContainer): TvcmFormSetContainerMapItem;
function L2TvcmFormSetContainerMapIteratorForEachFAction(anAction: pointer): TvcmFormSetContainerMapIterator_ForEachF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для TvcmFormSetContainerMapIterator.ForEachF }
function L2TvcmFormSetContainerMapIteratorForOneFAction(anAction: pointer): TvcmFormSetContainerMapIterator_ForOneF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для TvcmFormSetContainerMapIterator.ForOneF }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3InterfacesMisc
 , l3Base
 , l3MinMax
 , RTLConsts
;

var g_TvcmFormSetContainerRegistry: TvcmFormSetContainerRegistry = nil;
 {* Экземпляр синглетона TvcmFormSetContainerRegistry }

function TvcmFormSetContainerMapItem_C(const aFormSet: IvcmFormSet;
 const aContainer: IvcmContainer): TvcmFormSetContainerMapItem;
//#UC START# *5559A5520116_5559A50B0336_var*
//#UC END# *5559A5520116_5559A50B0336_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *5559A5520116_5559A50B0336_impl*
 Result.rContainer := Pointer(aContainer);
 Result.rFormSet := Pointer(aFormSet);
//#UC END# *5559A5520116_5559A50B0336_impl*
end;//TvcmFormSetContainerMapItem_C

function L2TvcmFormSetContainerMapIteratorForEachFAction(anAction: pointer): TvcmFormSetContainerMapIterator_ForEachF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для TvcmFormSetContainerMapIterator.ForEachF }
asm
 jmp l3LocalStub
end;//L2TvcmFormSetContainerMapIteratorForEachFAction

function L2TvcmFormSetContainerMapIteratorForOneFAction(anAction: pointer): TvcmFormSetContainerMapIterator_ForOneF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для TvcmFormSetContainerMapIterator.ForOneF }
asm
 jmp l3LocalStub
end;//L2TvcmFormSetContainerMapIteratorForOneFAction

procedure TvcmFormSetContainerRegistryFree;
 {* Метод освобождения экземпляра синглетона TvcmFormSetContainerRegistry }
begin
 l3Free(g_TvcmFormSetContainerRegistry);
end;//TvcmFormSetContainerRegistryFree

function TvcmFormSetContainerMapItem.EQ(const anOther: TvcmFormSetContainerMapItem): Boolean;
//#UC START# *5559A53B02B4_5559A50B0336_var*
//#UC END# *5559A53B02B4_5559A50B0336_var*
begin
//#UC START# *5559A53B02B4_5559A50B0336_impl*
 Result := (rFormSet = anOther.rFormSet) and (rContainer = anOther.rContainer);
//#UC END# *5559A53B02B4_5559A50B0336_impl*
end;//TvcmFormSetContainerMapItem.EQ

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5559A56501B4_var*
//#UC END# *47B2C42A0163_5559A56501B4_var*
begin
//#UC START# *47B2C42A0163_5559A56501B4_impl*
 Assert(False);
//#UC END# *47B2C42A0163_5559A56501B4_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_5559A56501B4_var*
//#UC END# *47B99D4503A2_5559A56501B4_var*
begin
//#UC START# *47B99D4503A2_5559A56501B4_impl*
 Assert(False);
//#UC END# *47B99D4503A2_5559A56501B4_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmFormSetContainerMap;

{$Include l3RecordWithEQList.imp.pas}

procedure TvcmFormSetContainerMap.ForEachF(anAction: TvcmFormSetContainerMapIterator_ForEachF_Action;
 const aContainer: IvcmContainer);
//#UC START# *55E04C9E0301_5559A56501B4_var*

 function lp_DoForEach(aData: PvcmFormSetContainerMapItem; anIndex: Integer): Boolean;
 begin
  if l3IEQ(IvcmContainer(aData^.rContainer), aContainer) then
   Result := anAction(IvcmFormSet(aData^.rFormSet))
  else
   Result := True;
 end;//lp_DoForEach

var
 Hack : Pointer absolute anAction;
//#UC END# *55E04C9E0301_5559A56501B4_var*
begin
//#UC START# *55E04C9E0301_5559A56501B4_impl*
 try
  IterateAllF(l3L2IA(@lp_DoForEach));
 finally
  l3FreeLocalStub(Hack);
 end;
//#UC END# *55E04C9E0301_5559A56501B4_impl*
end;//TvcmFormSetContainerMap.ForEachF

procedure TvcmFormSetContainerMap.ForOneF(anAction: TvcmFormSetContainerMapIterator_ForOneF_Action;
 const aContainer: IvcmContainer;
 anIndex: Integer);
//#UC START# *55E04CAE01EA_5559A56501B4_var*
//#UC END# *55E04CAE01EA_5559A56501B4_var*
begin
//#UC START# *55E04CAE01EA_5559A56501B4_impl*
// !!! Needs to be implemented !!!
//#UC END# *55E04CAE01EA_5559A56501B4_impl*
end;//TvcmFormSetContainerMap.ForOneF

function TvcmFormSetContainerRegistry.GetFormSetContainer(const aFormSet: IvcmFormSet): IvcmContainer;
//#UC START# *5559A45102B1_5559A3F601FD_var*
var
 l_Container: IvcmContainer;

 function lp_DoGetFormSetContainer(anItem: PvcmFormSetContainerMapItem; anIndex: Integer): Boolean;
 begin
  Result := True;
  if l3IEQ(IvcmFormSet(anItem^.rFormSet), aFormSet) then
  begin
   l_Container := IvcmContainer(anItem^.rContainer);
   Result := False;
  end;
 end;

//#UC END# *5559A45102B1_5559A3F601FD_var*
begin
//#UC START# *5559A45102B1_5559A3F601FD_impl*
 l_Container := nil;
 f_Map.IterateAllF(l3L2IA(@lp_DoGetFormSetContainer));
 Result := l_Container;
//#UC END# *5559A45102B1_5559A3F601FD_impl*
end;//TvcmFormSetContainerRegistry.GetFormSetContainer

function TvcmFormSetContainerRegistry.GetContainedFormSet(const aContainer: IvcmContainer): IvcmFormSet;
//#UC START# *5559A45F0070_5559A3F601FD_var*
var
 l_FormSet: IvcmFormSet;

 function lp_DoGetContainedFormSet(anItem: PvcmFormSetContainerMapItem; anIndex: Integer): Boolean;
 begin
  Result := True;
  if (anItem^.rContainer = Pointer(aContainer)) then
  begin
   l_FormSet := IvcmFormSet(anItem^.rFormSet);
   Result := False;
  end;
 end;

//#UC END# *5559A45F0070_5559A3F601FD_var*
begin
//#UC START# *5559A45F0070_5559A3F601FD_impl*
 l_FormSet := nil;
 f_Map.IterateAllF(l3L2IA(@lp_DoGetContainedFormSet));
 Result := l_FormSet;
//#UC END# *5559A45F0070_5559A3F601FD_impl*
end;//TvcmFormSetContainerRegistry.GetContainedFormSet

constructor TvcmFormSetContainerRegistry.Create;
//#UC START# *5559A5EB0130_5559A3F601FD_var*
//#UC END# *5559A5EB0130_5559A3F601FD_var*
begin
//#UC START# *5559A5EB0130_5559A3F601FD_impl*
 inherited;
 f_Map := TvcmFormSetContainerMap.Create;
//#UC END# *5559A5EB0130_5559A3F601FD_impl*
end;//TvcmFormSetContainerRegistry.Create

procedure TvcmFormSetContainerRegistry.RegisterFormSet(const aFormSet: IvcmFormSet;
 const aContainer: IvcmContainer);
//#UC START# *5559A6060079_5559A3F601FD_var*

 procedure lp_UpdateFormSetContainer;
 var
  l_Index: Integer;
 begin
  for l_Index := 0 to Pred(f_Map.Count) do
   if (f_Map.Items[l_Index].rFormSet = Pointer(aFormSet)) then
   begin
    f_Map.Items[l_Index] := TvcmFormSetContainerMapItem_C(aFormSet, aContainer);
    Break;
   end;
 end;

//#UC END# *5559A6060079_5559A3F601FD_var*
begin
//#UC START# *5559A6060079_5559A3F601FD_impl*
 if (GetFormSetContainer(aFormSet) = nil) then
  f_Map.Add(TvcmFormSetContainerMapItem_C(aFormSet, aContainer))
 else
  lp_UpdateFormSetContainer;
//#UC END# *5559A6060079_5559A3F601FD_impl*
end;//TvcmFormSetContainerRegistry.RegisterFormSet

procedure TvcmFormSetContainerRegistry.UnregisterFormSet(const aFormSet: IvcmFormSet);
//#UC START# *5559A62F028B_5559A3F601FD_var*
var
 l_Index: Integer;
 l_FormSet: IvcmFormSet;
//#UC END# *5559A62F028B_5559A3F601FD_var*
begin
//#UC START# *5559A62F028B_5559A3F601FD_impl*
 for l_Index := Pred(f_Map.Count) downto 0 do
 begin
  l_FormSet := IvcmFormSet(f_Map[l_Index].rFormSet);
  if (l_FormSet <> nil) then
   if l3IEQ(l_FormSet, aFormSet) then
   begin
    f_Map.Delete(l_Index);
    Break;
   end;
 end; 
//#UC END# *5559A62F028B_5559A3F601FD_impl*
end;//TvcmFormSetContainerRegistry.UnregisterFormSet

function TvcmFormSetContainerRegistry.GetFormSetCount(const aContainer: IvcmContainer): Integer;
//#UC START# *55E5816E00D5_5559A3F601FD_var*
var
 l_Index: Integer;
 l_Container: IvcmContainer;
//#UC END# *55E5816E00D5_5559A3F601FD_var*
begin
//#UC START# *55E5816E00D5_5559A3F601FD_impl*
 Result := 0;
 l_Container := nil;
 for l_Index := 0 to Pred(f_Map.Count) do
 begin
  l_Container := IvcmContainer(f_Map[l_Index].rContainer);
  if (l_Container <> nil) then
   if l3IEQ(l_Container, aContainer) then
    Inc(Result);
 end;
//#UC END# *55E5816E00D5_5559A3F601FD_impl*
end;//TvcmFormSetContainerRegistry.GetFormSetCount

procedure TvcmFormSetContainerRegistry.UnregisterContainer(const aContainer: IvcmContainer);
//#UC START# *55E949D10216_5559A3F601FD_var*
var
 l_Index: Integer;
 l_Container: IvcmContainer;
//#UC END# *55E949D10216_5559A3F601FD_var*
begin
//#UC START# *55E949D10216_5559A3F601FD_impl*
 for l_Index := Pred(f_Map.Count) downto 0 do
 begin
  l_Container := IvcmContainer(f_Map[l_Index].rContainer);
  if (l_Container <> nil) then
   if l3IEQ(l_Container, aContainer) then
    f_Map.Delete(l_Index);
 end;
//#UC END# *55E949D10216_5559A3F601FD_impl*
end;//TvcmFormSetContainerRegistry.UnregisterContainer

class function TvcmFormSetContainerRegistry.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmFormSetContainerRegistry <> nil;
end;//TvcmFormSetContainerRegistry.Exists

class function TvcmFormSetContainerRegistry.Instance: TvcmFormSetContainerRegistry;
 {* Метод получения экземпляра синглетона TvcmFormSetContainerRegistry }
begin
 if (g_TvcmFormSetContainerRegistry = nil) then
 begin
  l3System.AddExitProc(TvcmFormSetContainerRegistryFree);
  g_TvcmFormSetContainerRegistry := Create;
 end;
 Result := g_TvcmFormSetContainerRegistry;
end;//TvcmFormSetContainerRegistry.Instance

procedure TvcmFormSetContainerRegistry.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5559A3F601FD_var*
//#UC END# *479731C50290_5559A3F601FD_var*
begin
//#UC START# *479731C50290_5559A3F601FD_impl*
 FreeAndNil(f_Map);
 inherited;
//#UC END# *479731C50290_5559A3F601FD_impl*
end;//TvcmFormSetContainerRegistry.Cleanup
{$IfEnd} // NOT Defined(NoVCM)

end.
