unit nsContextFilterEventDataList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsContextFilterEventDataList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsContextFilterEventDataList" MUID: (4B1662CC011E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 TnsContextFilterData = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rHandle: Integer;
   rContext: Il3CString;
  public
   function EQ(const aB: TnsContextFilterData): Boolean;
 end;//TnsContextFilterData

 _ItemType_ = TnsContextFilterData;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}
 TnsContextFilterEventDataList = class(_l3RecordWithEQList_)
 end;//TnsContextFilterEventDataList

function TnsContextFilterData_C(aHandle: Integer;
 const aContext: Il3CString): TnsContextFilterData;

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *4B1662CC011Eimpl_uses*
 //#UC END# *4B1662CC011Eimpl_uses*
;

function TnsContextFilterData_C(aHandle: Integer;
 const aContext: Il3CString): TnsContextFilterData;
//#UC START# *4B1663ED0181_4B16636E01DF_var*
//#UC END# *4B1663ED0181_4B16636E01DF_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4B1663ED0181_4B16636E01DF_impl*
 Result.rHandle := aHandle;
 Result.rContext := aContext;
//#UC END# *4B1663ED0181_4B16636E01DF_impl*
end;//TnsContextFilterData_C

function TnsContextFilterData.EQ(const aB: TnsContextFilterData): Boolean;
//#UC START# *4B16641C031A_4B16636E01DF_var*
//#UC END# *4B16641C031A_4B16636E01DF_var*
begin
//#UC START# *4B16641C031A_4B16636E01DF_impl*
 Result := rHandle = aB.rHandle;
//#UC END# *4B16641C031A_4B16636E01DF_impl*
end;//TnsContextFilterData.EQ

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4B1662CC011E_var*
//#UC END# *47B2C42A0163_4B1662CC011E_var*
begin
//#UC START# *47B2C42A0163_4B1662CC011E_impl*
 Assert(False);
//#UC END# *47B2C42A0163_4B1662CC011E_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4B1662CC011E_var*
//#UC END# *47B99D4503A2_4B1662CC011E_var*
begin
//#UC START# *47B99D4503A2_4B1662CC011E_impl*
 Result := CI.rA.rHandle - CI.rB.rHandle;
//#UC END# *47B99D4503A2_4B1662CC011E_impl*
end;//CompareExistingItems

type _Instance_R_ = TnsContextFilterEventDataList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}

end.
