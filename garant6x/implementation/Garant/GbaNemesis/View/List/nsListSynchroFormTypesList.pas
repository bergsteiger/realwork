unit nsListSynchroFormTypesList;

{$Include ..\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmUserControls,
  l3ProtoDataContainer,
  vcmBaseTypes,
  l3Memory,
  l3Interfaces,
  l3Types,
  l3Core,
  l3Except,
  Classes,
  vcmFormSetFormItemList,
  WorkWithListInterfaces
  ;

type
 PnsSynchroFormItem = ^TnsSynchroFormItem; 
 TnsSynchroFormItem = {$IfDef XE4}record{$Else}object{$EndIf}
 { мапа идентификаторов форм и зон синхронного просмотра для списка }
 public
   rKey : TvcmFormSetFormItemDescr;
   rArea : TList_SynchroView_Areas;
 public
   function EQ(const anOther: TnsSynchroFormItem): Boolean;
   function Compare(const anOther: TnsSynchroFormItem): Integer;
 end;//TvcmFormSetFormItem

 _ItemType_ = TnsSynchroFormItem;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}
 TnsSynchroFormList = class(_l3RecordWithEQList_)
 private
 // private methods
   function GetFormIndex(const aFormDescr: TvcmFormSetFormItemDescr): Integer;
 protected
 // property methods
   function pm_GetFormArea(const Index: TvcmFormSetFormItemDescr): TList_SynchroView_Areas; virtual;
   function pm_GetForm(const Index: TList_SynchroView_Areas): TvcmFormSetFormItemDescr;
 public
 // overridden public methods
   constructor Create; override;
 public
 // public methods
 public
 // public properties
   property FormAreas[const Index: TvcmFormSetFormItemDescr]: TList_SynchroView_Areas
     read pm_GetFormArea;
   property Forms[const Index: TList_SynchroView_Areas]: TvcmFormSetFormItemDescr
     read pm_GetForm;
 end;//TnsSynchroFormList

function TnsSynchroFormItem_C(const aFormDescr: TvcmFormSetFormItemDescr;
     anArea: TList_SynchroView_Areas = sva_List_SynchroView_None): TnsSynchroFormItem;
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

function TnsSynchroFormItem.EQ(const anOther: TnsSynchroFormItem): Boolean;
begin
 Result := rKey.EQ(anOther.rKey) and (rArea = anOther.rArea);
end;

function TnsSynchroFormItem.Compare(const anOther: TnsSynchroFormItem): Integer;
begin
 Result := rKey.Compare(anOther.rKey);
end;

function TnsSynchroFormItem_C(const aFormDescr: TvcmFormSetFormItemDescr;
 anArea: TList_SynchroView_Areas = sva_List_SynchroView_None): TnsSynchroFormItem;
begin
 System.FillChar(Result, SizeOf(Result), 0);
 Result.rKey := aFormDescr;
 Result.rArea := anArea;
end;//TnsSynchroFormItem.C

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
begin
 Assert(False);
end;//AssignItem

function CompareExistingItems(const CI: CompareItemsRec): Integer;
begin
 Result := CI.rA.Compare(CI.rB^);
end;//CompareExistingItems

type _Instance_R_ = TnsSynchroFormList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}

// start class TnsSynchroFormList

function TnsSynchroFormList.GetFormIndex(const aFormDescr: TvcmFormSetFormItemDescr): Integer;

 function lp_FindItem(P: PItemType; Index: Integer): Boolean;
 begin
  if (P^.rKey.EQ(aFormDescr)) then
  begin
   GetFormIndex := Index;
   Result := False;
  end
  else
   Result := True;
 end;

begin
 Result := -1;
 IterateAllF(l3L2IA(@lp_FindItem));
end;

function TnsSynchroFormList.pm_GetFormArea(const Index: TvcmFormSetFormItemDescr): TList_SynchroView_Areas;
var
 l_ItemIndex: Integer;
begin
 Result := sva_List_SynchroView_None;
 l_ItemIndex := GetFormIndex(Index);
 if (l_ItemIndex <> -1) then
  Result := Items[l_ItemIndex].rArea;
end;

function TnsSynchroFormList.pm_GetForm(const Index: TList_SynchroView_Areas): TvcmFormSetFormItemDescr;

 function lp_FindItem(P: PItemType; aIndex: Integer): Boolean;
 begin
  if (P^.rArea = Index) then
  begin
   pm_GetForm := P^.rKey;
   Result := False;
  end
  else
   Result := True;
 end;//lp_FindItem

begin
 l3FillChar(Result, SizeOf(Result), 0);
 IterateAllF(l3L2IA(@lp_FindItem));
end;

constructor TnsSynchroFormList.Create;
begin
 inherited;
 Duplicates := l3_dupError;
 Sorted := true;
end;
{$IfEnd} //not NoVCM

end.