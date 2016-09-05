unit daUserManagerUtils;

// Модуль: "w:\common\components\rtl\Garant\DA\daUserManagerUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "daUserManagerUtils" MUID: (5714CBFE00FA)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , daTypes
;

function GetRegionStringFromUserID(anID: TdaUserID;
 CropIfLocal: Boolean = True): AnsiString;
function ConcatRegionAndUserNames(const aRegionName: AnsiString;
 const aUserName: AnsiString): AnsiString; overload;
function ConcatRegionAndUserNames(anID: TdaUserID;
 const aUserName: AnsiString): AnsiString; overload;
function GetUserRegion(anUserID: TdaUserID): TdaRegionID;
function GetLocalUserID(anUserID: TdaUserID): TdaUserID;
 {* Отрезать ID региона от полного ID пользователя }
function CalcGlobalUserID(anUserID: TdaUserID;
 aRegionID: TdaRegionID): TdaUserID;

implementation

uses
 l3ImplUses
 , daDataProvider
 , daInterfaces
 //#UC START# *5714CBFE00FAimpl_uses*
 //#UC END# *5714CBFE00FAimpl_uses*
;

function GetRegionStringFromUserID(anID: TdaUserID;
 CropIfLocal: Boolean = True): AnsiString;
//#UC START# *5714CC1501B0_5714CBFE00FA_var*
var
 l_Region: TdaRegionID;
//#UC END# *5714CC1501B0_5714CBFE00FA_var*
begin
//#UC START# *5714CC1501B0_5714CBFE00FA_impl*
 Result := '';
 l_Region := GetUserRegion(anID);
 if (CropIfLocal and (l_Region = GlobalDataProvider.RegionID)) or (l_Region = $ff {спецрегион}) then
  Exit;
 Result := GlobalDataProvider.GetRegionName(l_Region);
//#UC END# *5714CC1501B0_5714CBFE00FA_impl*
end;//GetRegionStringFromUserID

function ConcatRegionAndUserNames(const aRegionName: AnsiString;
 const aUserName: AnsiString): AnsiString;
//#UC START# *5714CC980361_5714CBFE00FA_var*
//#UC END# *5714CC980361_5714CBFE00FA_var*
begin
//#UC START# *5714CC980361_5714CBFE00FA_impl*
 if aRegionName <> '' then
  Result := aRegionName + '.' + aUserName
 else
  Result := aUserName;
//#UC END# *5714CC980361_5714CBFE00FA_impl*
end;//ConcatRegionAndUserNames

function ConcatRegionAndUserNames(anID: TdaUserID;
 const aUserName: AnsiString): AnsiString;
//#UC START# *5714CD00006F_5714CBFE00FA_var*
//#UC END# *5714CD00006F_5714CBFE00FA_var*
begin
//#UC START# *5714CD00006F_5714CBFE00FA_impl*
 Result := ConcatRegionAndUserNames(GetRegionStringFromUserID(anID), aUserName);
//#UC END# *5714CD00006F_5714CBFE00FA_impl*
end;//ConcatRegionAndUserNames

function GetUserRegion(anUserID: TdaUserID): TdaRegionID;
//#UC START# *5715FBBC0249_5714CBFE00FA_var*
//#UC END# *5715FBBC0249_5714CBFE00FA_var*
begin
//#UC START# *5715FBBC0249_5714CBFE00FA_impl*
 Result := anUserID shr 24;
//#UC END# *5715FBBC0249_5714CBFE00FA_impl*
end;//GetUserRegion

function GetLocalUserID(anUserID: TdaUserID): TdaUserID;
 {* Отрезать ID региона от полного ID пользователя }
//#UC START# *5785F6D00275_5714CBFE00FA_var*
//#UC END# *5785F6D00275_5714CBFE00FA_var*
begin
//#UC START# *5785F6D00275_5714CBFE00FA_impl*
 Result := anUserID and cMaxUserID;
//#UC END# *5785F6D00275_5714CBFE00FA_impl*
end;//GetLocalUserID

function CalcGlobalUserID(anUserID: TdaUserID;
 aRegionID: TdaRegionID): TdaUserID;
//#UC START# *578617D303D9_5714CBFE00FA_var*
//#UC END# *578617D303D9_5714CBFE00FA_var*
begin
//#UC START# *578617D303D9_5714CBFE00FA_impl*
 Assert(GetUserRegion(anUserID) = 0);
 Result := anUserID or (aRegionID shl 24);
//#UC END# *578617D303D9_5714CBFE00FA_impl*
end;//CalcGlobalUserID

end.
