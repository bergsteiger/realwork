unit vcmFormSetFormItemList;

// Модуль: "w:\common\components\gui\Garant\VCM\vcmFormSetFormItemList.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmBaseTypes
 , vcmUserControls
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 TvcmFormSetFormItemDescr = object
  public
   rZoneType: TvcmZoneType;
   rFormID: TvcmFormID;
   rUserType: TvcmUserType;
   rSubUserType: TvcmUserType;
  public
   function EQ(const anOther: TvcmFormSetFormItemDescr): Boolean;
   function Compare(const anOther: TvcmFormSetFormItemDescr): Integer;
 end;//TvcmFormSetFormItemDescr

 TvcmFormSetFormItem = object
  public
   rNeedMake: TvcmNeedMakeDS;
   rKey: TvcmFormSetFormItemDescr;
  public
   function EQ(const anOther: TvcmFormSetFormItem): Boolean;
   function Compare(const anOther: TvcmFormSetFormItem): Integer;
 end;//TvcmFormSetFormItem

 _ItemType_ = TvcmFormSetFormItem;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}
 TvcmFormSetFormList = class(_l3RecordWithEQList_)
  private
   function GetFormIndex(const aFormDescr: TvcmFormSetFormItemDescr): Integer;
  protected
   function pm_GetNeedMakeDS(const Index: TvcmFormSetFormItemDescr): TvcmNeedMakeDS; virtual;
   procedure pm_SetNeedMakeDS(const Index: TvcmFormSetFormItemDescr;
    aValue: TvcmNeedMakeDS); virtual;
  public
   procedure SetIfNeedMakeNo(const aForm: TvcmFormSetFormItemDescr;
    aValue: TvcmNeedMakeDS);
   function Add(const anItem: _ItemType_): Integer; override;
    {* Добавляет элемент списка. }
   constructor Create; override;
  public
   property NeedMakeDS[const Index: TvcmFormSetFormItemDescr]: TvcmNeedMakeDS
    read pm_GetNeedMakeDS
    write pm_SetNeedMakeDS;
 end;//TvcmFormSetFormList

function TvcmFormSetFormItemDescr_C(const aFormID: TvcmFormID;
 aZoneType: TvcmZoneType;
 aUserType: TvcmUserType;
 aSubUserType: TvcmUserType = vcm_utAny): TvcmFormSetFormItemDescr;
function TvcmFormSetFormItem_C(const aKey: TvcmFormSetFormItemDescr;
 aNeedMake: TvcmNeedMakeDS = vcm_nmNo): TvcmFormSetFormItem;
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function TvcmFormSetFormItemDescr_C(const aFormID: TvcmFormID;
 aZoneType: TvcmZoneType;
 aUserType: TvcmUserType;
 aSubUserType: TvcmUserType = vcm_utAny): TvcmFormSetFormItemDescr;
//#UC START# *528B525300DE_5289C7D4012A_var*
//#UC END# *528B525300DE_5289C7D4012A_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *528B525300DE_5289C7D4012A_impl*
 Result.rFormID := aFormID;
 Result.rZoneType := aZoneType;
 Result.rUserType := aUserType;
 Result.rSubUserType := aSubUserType;
//#UC END# *528B525300DE_5289C7D4012A_impl*
end;//TvcmFormSetFormItemDescr_C

function TvcmFormSetFormItem_C(const aKey: TvcmFormSetFormItemDescr;
 aNeedMake: TvcmNeedMakeDS = vcm_nmNo): TvcmFormSetFormItem;
//#UC START# *528B51C0030E_5289CA7803D8_var*
//#UC END# *528B51C0030E_5289CA7803D8_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *528B51C0030E_5289CA7803D8_impl*
 Result.rKey := aKey;
 Result.rNeedMake := aNeedMake;
//#UC END# *528B51C0030E_5289CA7803D8_impl*
end;//TvcmFormSetFormItem_C

function TvcmFormSetFormItemDescr.EQ(const anOther: TvcmFormSetFormItemDescr): Boolean;
//#UC START# *5289CC6003B0_5289C7D4012A_var*
//#UC END# *5289CC6003B0_5289C7D4012A_var*
begin
//#UC START# *5289CC6003B0_5289C7D4012A_impl*
 Result := (Self.rZoneType = anOther.rZoneType) AND (Self.rFormID.EQ(anOther.rFormID)) AND
  (Self.rUserType = anOther.rUserType) AND
   ((Self.rSubUserType = anOther.rSubUserType) or
    ((Self.rSubUserType = 0) and (anOther.rSubUserType = vcm_utAny)) or
    ((Self.rSubUserType = vcm_utAny) and (anOther.rSubUserType = 0)));
//#UC END# *5289CC6003B0_5289C7D4012A_impl*
end;//TvcmFormSetFormItemDescr.EQ

function TvcmFormSetFormItemDescr.Compare(const anOther: TvcmFormSetFormItemDescr): Integer;
//#UC START# *5289CC9F0130_5289C7D4012A_var*
var
 l_UT: Integer;
 l_SubUT: Integer;
 l_ZT: Integer;
 l_Name: Integer;
 l_ID: Integer;
//#UC END# *5289CC9F0130_5289C7D4012A_var*
begin
//#UC START# *5289CC9F0130_5289C7D4012A_impl*
 l_UT := Self.rUserType - anOther.rUserType;
 l_Name := AnsiCompareStr(Self.rFormID.rName, anOther.rFormID.rName);
 l_ZT := Ord(Self.rZoneType) - Ord(anOther.rZoneType);
 l_ID := Self.rFormID.rID - anOther.rFormID.rID;
 l_SubUT := Self.rSubUserType - anOther.rUserType;
 Result := 0;
 if (l_UT < 0) or (l_Name < 0) or (l_ZT < 0) or (l_ID < 0) or (l_SubUT < 0) then
  Result := -1
 else
 if (l_UT > 0) or (l_Name > 0) or (l_ZT > 0) or (l_ID > 0) or (l_SubUT > 0) then
  Result := 1;
//#UC END# *5289CC9F0130_5289C7D4012A_impl*
end;//TvcmFormSetFormItemDescr.Compare

function TvcmFormSetFormItem.EQ(const anOther: TvcmFormSetFormItem): Boolean;
//#UC START# *5289CD300046_5289CA7803D8_var*
//#UC END# *5289CD300046_5289CA7803D8_var*
begin
//#UC START# *5289CD300046_5289CA7803D8_impl*
 // Сравниваем ключи и значения, иначе не проходит присовение Item'ов
 Result := (Self.rKey.EQ(anOther.rKey)) AND (Self.rNeedMake = anOther.rNeedMake);
//#UC END# *5289CD300046_5289CA7803D8_impl*
end;//TvcmFormSetFormItem.EQ

function TvcmFormSetFormItem.Compare(const anOther: TvcmFormSetFormItem): Integer;
//#UC START# *5289CD3602F8_5289CA7803D8_var*
//#UC END# *5289CD3602F8_5289CA7803D8_var*
begin
//#UC START# *5289CD3602F8_5289CA7803D8_impl*
 Result := Self.rKey.Compare(anOther.rKey);
 if (Result = 0) then
  Result := Ord(Self.rNeedMake) - Ord(anOther.rNeedMake);
//#UC END# *5289CD3602F8_5289CA7803D8_impl*
end;//TvcmFormSetFormItem.Compare

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5289CD8F0001_var*
//#UC END# *47B2C42A0163_5289CD8F0001_var*
begin
//#UC START# *47B2C42A0163_5289CD8F0001_impl*
 Assert(False);
//#UC END# *47B2C42A0163_5289CD8F0001_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_5289CD8F0001_var*
//#UC END# *47B99D4503A2_5289CD8F0001_var*
begin
//#UC START# *47B99D4503A2_5289CD8F0001_impl*
 Result := CI.rA.Compare(CI.rB^);
//#UC END# *47B99D4503A2_5289CD8F0001_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmFormSetFormList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}

function TvcmFormSetFormList.pm_GetNeedMakeDS(const Index: TvcmFormSetFormItemDescr): TvcmNeedMakeDS;
//#UC START# *528DB25B023B_5289CD8F0001get_var*
var
 l_ItemIndex: Integer;
//#UC END# *528DB25B023B_5289CD8F0001get_var*
begin
//#UC START# *528DB25B023B_5289CD8F0001get_impl*
 Result := vcm_nmNo;
 l_ItemIndex := GetFormIndex(Index);
 if (l_ItemIndex <> -1) then
  Result := Items[l_ItemIndex].rNeedMake;
//#UC END# *528DB25B023B_5289CD8F0001get_impl*
end;//TvcmFormSetFormList.pm_GetNeedMakeDS

procedure TvcmFormSetFormList.pm_SetNeedMakeDS(const Index: TvcmFormSetFormItemDescr;
 aValue: TvcmNeedMakeDS);
//#UC START# *528DB25B023B_5289CD8F0001set_var*
var
 l_ItemIndex: Integer;
 l_Item: TvcmFormSetFormItem;
//#UC END# *528DB25B023B_5289CD8F0001set_var*
begin
//#UC START# *528DB25B023B_5289CD8F0001set_impl*
 l_ItemIndex := GetFormIndex(Index);
 if (l_ItemIndex <> -1) then
 begin
  l_Item := Items[l_ItemIndex];
  l_Item.rNeedMake := aValue;
  Items[l_ItemIndex] := l_Item;
  Assert(Items[l_ItemIndex].rNeedMake = aValue);
 end;
//#UC END# *528DB25B023B_5289CD8F0001set_impl*
end;//TvcmFormSetFormList.pm_SetNeedMakeDS

function TvcmFormSetFormList.GetFormIndex(const aFormDescr: TvcmFormSetFormItemDescr): Integer;
//#UC START# *528DB44C02D7_5289CD8F0001_var*

 function lp_FindItem(P: PItemType; Index: Integer): Boolean;
 begin
  if (P^.rKey.EQ(aFormDescr)) then
  begin
   GetFormIndex := Index;
   Result := False;
  end//if (P^.rKey.EQ(aFormDescr))
  else
   Result := True;
 end;//lp_FindItem

//#UC END# *528DB44C02D7_5289CD8F0001_var*
begin
//#UC START# *528DB44C02D7_5289CD8F0001_impl*
 Result := -1;
 IterateAllF(l3L2IA(@lp_FindItem));
//#UC END# *528DB44C02D7_5289CD8F0001_impl*
end;//TvcmFormSetFormList.GetFormIndex

procedure TvcmFormSetFormList.SetIfNeedMakeNo(const aForm: TvcmFormSetFormItemDescr;
 aValue: TvcmNeedMakeDS);
//#UC START# *529845780295_5289CD8F0001_var*
//#UC END# *529845780295_5289CD8F0001_var*
begin
//#UC START# *529845780295_5289CD8F0001_impl*
 if pm_GetNeedMakeDS(aForm) = vcm_nmNo then
  pm_SetNeedMakeDS(aForm, aValue);
//#UC END# *529845780295_5289CD8F0001_impl*
end;//TvcmFormSetFormList.SetIfNeedMakeNo

function TvcmFormSetFormList.Add(const anItem: _ItemType_): Integer;
 {* Добавляет элемент списка. }
//#UC START# *47A750E70096_5289CD8F0001_var*
//#UC END# *47A750E70096_5289CD8F0001_var*
begin
//#UC START# *47A750E70096_5289CD8F0001_impl*
 // В EQ сравниваем по ключам и rNeedMake, поэтому два Item'a с разными
 // rNeedMake могли бы добавиться - проверяем здесь по ключу
 if (GetFormIndex(anItem.rKey) = -1) then
  Result := inherited Add(anItem)
 else
  Assert(False);         
//#UC END# *47A750E70096_5289CD8F0001_impl*
end;//TvcmFormSetFormList.Add

constructor TvcmFormSetFormList.Create;
//#UC START# *47B9866E034D_5289CD8F0001_var*
//#UC END# *47B9866E034D_5289CD8F0001_var*
begin
//#UC START# *47B9866E034D_5289CD8F0001_impl*
 inherited;
 Duplicates := l3_dupError;
 Sorted := true;
//#UC END# *47B9866E034D_5289CD8F0001_impl*
end;//TvcmFormSetFormList.Create
{$IfEnd} // NOT Defined(NoVCM)

end.
