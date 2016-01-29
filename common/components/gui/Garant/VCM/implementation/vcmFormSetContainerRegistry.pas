unit vcmFormSetContainerRegistry;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmFormSetContainerRegistry.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::Implementation::TvcmFormSetContainerRegistry
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmInterfaces,
  l3ProtoObject,
  l3ProtoDataContainer,
  l3Memory,
  l3Interfaces,
  l3Types,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmFormSetContainerMapItem = {$IfDef XE4}record{$Else}object{$EndIf}
 public
   rContainer : Pointer;
   rFormSet : Pointer;
 public
    function EQ(const anOther: TvcmFormSetContainerMapItem): Boolean;
 end;//TvcmFormSetContainerMapItem

  TvcmFormSetContainerMapIterator_ForEachF_Action = function (const anItem: IvcmFormSet): Boolean;
   {* Тип подитеративной функции для TvcmFormSetContainerMapIterator.ForEachF }

  TvcmFormSetContainerMapIterator_ForOneF_Action = function (const anItem: IvcmFormSet): Boolean;
   {* Тип подитеративной функции для TvcmFormSetContainerMapIterator.ForOneF }

(*
 TvcmFormSetContainerMapIterator = PureMixIn
   {iterator} procedure ForEachF(anAction: TvcmFormSetContainerMapIterator_ForEachF_Action;
    const aContainer: IvcmContainer);
   {iterator} procedure ForOneF(anAction: TvcmFormSetContainerMapIterator_ForOneF_Action;
    const aContainer: IvcmContainer;
    anIndex: Integer);
 end;//TvcmFormSetContainerMapIterator
*)

 PvcmFormSetContainerMapItem = ^TvcmFormSetContainerMapItem;

 _ItemType_ = TvcmFormSetContainerMapItem;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
{$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}
 TvcmFormSetContainerMap = class(_l3RecordWithEQList_)
 public
 // realized methods
   {iterator} procedure ForEachF(anAction: TvcmFormSetContainerMapIterator_ForEachF_Action;
    const aContainer: IvcmContainer);
   {iterator} procedure ForOneF(anAction: TvcmFormSetContainerMapIterator_ForOneF_Action;
    const aContainer: IvcmContainer;
    anIndex: Integer);
 end;//TvcmFormSetContainerMap

 TvcmFormSetContainerRegistry = class(Tl3ProtoObject)
 private
 // private fields
   f_Map : TvcmFormSetContainerMap;
    {* Поле для свойства Map}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   function GetFormSetContainer(const aFormSet: IvcmFormSet): IvcmContainer;
   function GetContainedFormSet(const aContainer: IvcmContainer): IvcmFormSet;
   constructor Create; reintroduce;
     {* Сигнатура метода Create }
   procedure RegisterFormSet(const aFormSet: IvcmFormSet;
     const aContainer: IvcmContainer);
   procedure UnregisterFormSet(const aFormSet: IvcmFormSet);
   function GetFormSetCount(const aContainer: IvcmContainer): Integer;
   procedure UnregisterContainer(const aContainer: IvcmContainer);
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // public properties
   property Map: TvcmFormSetContainerMap
     read f_Map;
 public
 // singleton factory method
   class function Instance: TvcmFormSetContainerRegistry;
    {- возвращает экземпляр синглетона. }
 end;//TvcmFormSetContainerRegistry
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TvcmFormSetContainerMapItem_C(const aFormSet: IvcmFormSet;
    const aContainer: IvcmContainer): TvcmFormSetContainerMapItem;
{$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
function L2TvcmFormSetContainerMapIteratorForEachFAction(anAction: pointer): TvcmFormSetContainerMapIterator_ForEachF_Action;
   {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для TvcmFormSetContainerMapIterator.ForEachF }
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
function L2TvcmFormSetContainerMapIteratorForOneFAction(anAction: pointer): TvcmFormSetContainerMapIterator_ForOneF_Action;
   {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для TvcmFormSetContainerMapIterator.ForOneF }
 {$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base {a},
  l3MinMax,
  RTLConsts,
  SysUtils,
  l3InterfacesMisc
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}


// start class TvcmFormSetContainerRegistry

var g_TvcmFormSetContainerRegistry : TvcmFormSetContainerRegistry = nil;

procedure TvcmFormSetContainerRegistryFree;
begin
 l3Free(g_TvcmFormSetContainerRegistry);
end;

class function TvcmFormSetContainerRegistry.Instance: TvcmFormSetContainerRegistry;
begin
 if (g_TvcmFormSetContainerRegistry = nil) then
 begin
  l3System.AddExitProc(TvcmFormSetContainerRegistryFree);
  g_TvcmFormSetContainerRegistry := Create;
 end;
 Result := g_TvcmFormSetContainerRegistry;
end;


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
// start class TvcmFormSetContainerMapItem

function TvcmFormSetContainerMapItem.EQ(const anOther: TvcmFormSetContainerMapItem): Boolean;
//#UC START# *5559A53B02B4_5559A50B0336_var*
//#UC END# *5559A53B02B4_5559A50B0336_var*
begin
//#UC START# *5559A53B02B4_5559A50B0336_impl*
 Result := (rFormSet = anOther.rFormSet) and (rContainer = anOther.rContainer);
//#UC END# *5559A53B02B4_5559A50B0336_impl*
end;//TvcmFormSetContainerMapItem.EQ

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
end;//TvcmFormSetContainerMapItem.C

// start class TvcmFormSetContainerMapIterator

function L2TvcmFormSetContainerMapIteratorForEachFAction(anAction: pointer): TvcmFormSetContainerMapIterator_ForEachF_Action;
 {-}
asm
 jmp l3LocalStub
end;//L2TvcmFormSetContainerMapIteratorForEachFAction

function L2TvcmFormSetContainerMapIteratorForOneFAction(anAction: pointer): TvcmFormSetContainerMapIterator_ForOneF_Action;
 {-}
asm
 jmp l3LocalStub
end;//L2TvcmFormSetContainerMapIteratorForOneFAction
// start class TvcmFormSetContainerMap

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5559A56501B4_var*
//#UC END# *47B2C42A0163_5559A56501B4_var*
begin
//#UC START# *47B2C42A0163_5559A56501B4_impl*
 Assert(False);
//#UC END# *47B2C42A0163_5559A56501B4_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_5559A56501B4_var*
//#UC END# *47B99D4503A2_5559A56501B4_var*
begin
//#UC START# *47B99D4503A2_5559A56501B4_impl*
 Assert(False);
//#UC END# *47B99D4503A2_5559A56501B4_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmFormSetContainerMap;

{$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}

// start class TvcmFormSetContainerMap

{iterator} procedure TvcmFormSetContainerMap.ForEachF(anAction: TvcmFormSetContainerMapIterator_ForEachF_Action;
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

{iterator} procedure TvcmFormSetContainerMap.ForOneF(anAction: TvcmFormSetContainerMapIterator_ForOneF_Action;
  const aContainer: IvcmContainer;
  anIndex: Integer);
//#UC START# *55E04CAE01EA_5559A56501B4_var*
//#UC END# *55E04CAE01EA_5559A56501B4_var*
begin
//#UC START# *55E04CAE01EA_5559A56501B4_impl*
// !!! Needs to be implemented !!!
//#UC END# *55E04CAE01EA_5559A56501B4_impl*
end;//TvcmFormSetContainerMap.ForOneF

class function TvcmFormSetContainerRegistry.Exists: Boolean;
 {-}
begin
 Result := g_TvcmFormSetContainerRegistry <> nil;
end;//TvcmFormSetContainerRegistry.Exists

procedure TvcmFormSetContainerRegistry.Cleanup;
//#UC START# *479731C50290_5559A3F601FD_var*
//#UC END# *479731C50290_5559A3F601FD_var*
begin
//#UC START# *479731C50290_5559A3F601FD_impl*
 FreeAndNil(f_Map);
 inherited;
//#UC END# *479731C50290_5559A3F601FD_impl*
end;//TvcmFormSetContainerRegistry.Cleanup

{$IfEnd} //not NoVCM

end.