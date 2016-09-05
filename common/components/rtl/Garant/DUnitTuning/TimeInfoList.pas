unit TimeInfoList;
 {* Список замеров времени }

// Модуль: "w:\common\components\rtl\Garant\DUnitTuning\TimeInfoList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TTimeInfoList" MUID: (4B2F5BB102A4)

{$Include w:\common\components\rtl\Garant\DUnitTuning\tfwDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
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
 PTimeInfo = ^TTimeInfo;

 TTimeInfoName = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rSubName: AnsiString;
   rName: AnsiString;
  public
   function Compare(const aName: TTimeInfoName): Integer;
 end;//TTimeInfoName

 {$Define l3Items_NeedsAssignItem}

 TTimeInfo = {$IfDef XE4}record{$Else}object{$EndIf}
  {* Информация о замере времени }
  public
   rDate: TDateTime;
   rTime: Cardinal;
   rID: TTimeInfoName;
  public
   function Compare(const aInfo: TTimeInfo): Integer;
   function EQ(const aInfo: TTimeInfo): Boolean;
 end;//TTimeInfo

 _ItemType_ = TTimeInfo;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}
 TTimeInfoList = class(_l3RecordWithEQList_)
  {* Список замеров времени }
  public
   procedure DeleteOld(aDateDelta: Integer);
    {* Удаляет старые замеры }
   procedure Compact(aCount: Integer);
    {* Минимизирует число замеров в графике до указанного числа }
 end;//TTimeInfoList

function TTimeInfo_C(aDate: TDateTime;
 const aName: AnsiString;
 aTime: Cardinal;
 const aSubName: AnsiString): TTimeInfo; overload;
function TTimeInfo_C(const aName: AnsiString;
 aTime: Cardinal): TTimeInfo; overload;
function TTimeInfo_C(aDate: TDateTime;
 const aName: AnsiString;
 aTime: Cardinal): TTimeInfo; overload;
function TTimeInfo_C(const aName: AnsiString;
 aTime: Cardinal;
 const aSubName: AnsiString): TTimeInfo; overload;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *4B2F5BB102A4impl_uses*
 //#UC END# *4B2F5BB102A4impl_uses*
;

function TTimeInfo_C(aDate: TDateTime;
 const aName: AnsiString;
 aTime: Cardinal;
 const aSubName: AnsiString): TTimeInfo;
//#UC START# *4B6C40530304_4B2F565002FD_var*
//#UC END# *4B6C40530304_4B2F565002FD_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4B6C40530304_4B2F565002FD_impl*
 Result.rDate := aDate;
 Result.rID.rName := Trim(aName);
 Result.rTime := aTime;
 if (aSubName = '') then
  Result.rID.rSubName := 'Time'
 else
  Result.rID.rSubName := Trim(aSubName);
//#UC END# *4B6C40530304_4B2F565002FD_impl*
end;//TTimeInfo_C

function TTimeInfo_C(const aName: AnsiString;
 aTime: Cardinal): TTimeInfo;
//#UC START# *4B2F582A0382_4B2F565002FD_var*
//#UC END# *4B2F582A0382_4B2F565002FD_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4B2F582A0382_4B2F565002FD_impl*
 Result := TTimeInfo_C(Date, aName, aTime);
//#UC END# *4B2F582A0382_4B2F565002FD_impl*
end;//TTimeInfo_C

function TTimeInfo_C(aDate: TDateTime;
 const aName: AnsiString;
 aTime: Cardinal): TTimeInfo;
//#UC START# *4B588AFA0000_4B2F565002FD_var*
//#UC END# *4B588AFA0000_4B2F565002FD_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4B588AFA0000_4B2F565002FD_impl*
 Result := TTimeInfo_C(aDate, aName, aTime, '');
//#UC END# *4B588AFA0000_4B2F565002FD_impl*
end;//TTimeInfo_C

function TTimeInfo_C(const aName: AnsiString;
 aTime: Cardinal;
 const aSubName: AnsiString): TTimeInfo;
//#UC START# *4B58926401DE_4B2F565002FD_var*
//#UC END# *4B58926401DE_4B2F565002FD_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4B58926401DE_4B2F565002FD_impl*
 Result := TTimeInfo_C(Date, aName, aTime, aSubName);
//#UC END# *4B58926401DE_4B2F565002FD_impl*
end;//TTimeInfo_C

function TTimeInfoName.Compare(const aName: TTimeInfoName): Integer;
//#UC START# *4B6C348B023F_4B6BF212005D_var*
//#UC END# *4B6C348B023F_4B6BF212005D_var*
begin
//#UC START# *4B6C348B023F_4B6BF212005D_impl*
 Result := CompareStr(rName, aName.rName);
 if (Result = 0) then
  Result := CompareStr(rSubName, aName.rSubName);
//#UC END# *4B6C348B023F_4B6BF212005D_impl*
end;//TTimeInfoName.Compare

function TTimeInfo.Compare(const aInfo: TTimeInfo): Integer;
//#UC START# *4B2F57280040_4B2F565002FD_var*
//#UC END# *4B2F57280040_4B2F565002FD_var*
begin
//#UC START# *4B2F57280040_4B2F565002FD_impl*
 Result := rID.Compare(aInfo.rID);
 if (Result = 0) then
 begin
  if (rDate < aInfo.rDate) then
   Result := -1
  else
  if (rDate > aInfo.rDate) then
   Result := +1;
 end;//Result = 0
//#UC END# *4B2F57280040_4B2F565002FD_impl*
end;//TTimeInfo.Compare

function TTimeInfo.EQ(const aInfo: TTimeInfo): Boolean;
//#UC START# *4B2FAB480293_4B2F565002FD_var*
//#UC END# *4B2FAB480293_4B2F565002FD_var*
begin
//#UC START# *4B2FAB480293_4B2F565002FD_impl*
 Result := (Compare(aInfo) = 0) AND (rTime = aInfo.rTime);
//#UC END# *4B2FAB480293_4B2F565002FD_impl*
end;//TTimeInfo.EQ

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4B2F5BB102A4_var*
var
 l_Time : Int64;
//#UC END# *47B2C42A0163_4B2F5BB102A4_var*
begin
//#UC START# *47B2C42A0163_4B2F5BB102A4_impl*
 l_Time := Int64(aTo.rTime) + Int64(aFrom.rTime);
 l_Time := l_Time div 2;
 PTimeInfo(@aTo)^ := aFrom;
 PTimeInfo(@aTo)^.rTime := l_Time;
//#UC END# *47B2C42A0163_4B2F5BB102A4_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4B2F5BB102A4_var*
//#UC END# *47B99D4503A2_4B2F5BB102A4_var*
begin
//#UC START# *47B99D4503A2_4B2F5BB102A4_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := CI.rA.Compare(CI.rB^);
//#UC END# *47B99D4503A2_4B2F5BB102A4_impl*
end;//CompareExistingItems

type _Instance_R_ = TTimeInfoList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}

procedure TTimeInfoList.DeleteOld(aDateDelta: Integer);
 {* Удаляет старые замеры }
var l_Name: TTimeInfoName;
var l_i: Integer;
var l_j: Integer;
var l_SeriesCount: Integer;
var l_C: Integer;
var l_MaxDate: TDateTime;
//#UC START# *4B7AA321023D_4B2F5BB102A4_var*
//#UC END# *4B7AA321023D_4B2F5BB102A4_var*
begin
//#UC START# *4B7AA321023D_4B2F5BB102A4_impl*
 l_C := Pred(Count);
 l_i := 0;
 while (l_i <= l_C) do
 begin
  with Items[l_i] do
  begin
   l_Name := rID;
   l_MaxDate := rDate;
  end;//with Items[l_i]
  l_SeriesCount := 1;
  for l_j := l_i + 1 to l_C do
  begin
   with Items[l_j] do
   if (rID.Compare(l_Name) = 0) then
   begin
    Inc(l_SeriesCount);
    if (l_MaxDate < rDate) then
     l_MaxDate := rDate; 
   end//rID.Compare(l_Name) = 0
   else
    break; 
  end;//for l_j
  if (Date - l_MaxDate > aDateDelta) then
  begin
   while (l_SeriesCount > 0) do
   begin
    l3System.Str2Log(Format('Deleting old %s : %s', [l_Name.rName, l_Name.rSubName]));
    Delete(l_i);
    Dec(l_SeriesCount);
    Dec(l_C);
   end;//l_SeriesCount > aCount
  end;//Date - l_MaxDate > aDateDelta
  Inc(l_i, l_SeriesCount);
 end;//while (i <= l_C)
//#UC END# *4B7AA321023D_4B2F5BB102A4_impl*
end;//TTimeInfoList.DeleteOld

procedure TTimeInfoList.Compact(aCount: Integer);
 {* Минимизирует число замеров в графике до указанного числа }
var l_Name: TTimeInfoName;
 {* Имя текущего замера }
var l_i: Integer;
var l_j: Integer;
var l_C: Integer;
var l_SeriesCount: Integer;
//#UC START# *4B7A98A10031_4B2F5BB102A4_var*
//#UC END# *4B7A98A10031_4B2F5BB102A4_var*
begin
//#UC START# *4B7A98A10031_4B2F5BB102A4_impl*
 l_C := Pred(Count);
 l_i := 0;
 while (l_i <= l_C) do
 begin
  l_Name := Items[l_i].rID;
  l_SeriesCount := 1;
  for l_j := l_i + 1 to l_C do
  begin
   if (Items[l_j].rID.Compare(l_Name) = 0) then
    Inc(l_SeriesCount)
   else
    break; 
  end;//for l_j
  if (l_SeriesCount > aCount) then
  begin
   //l3System.Str2Log(Format('Before compacting %s : %s', [l_Name.rName, l_Name.rSubName]));
   //l3System.Str2Log(Format('Series count %d : requested count %d', [l_SeriesCount, aCount]));
   while (l_SeriesCount > aCount) do
   begin
    //l3System.Str2Log(Format('Compacting %s : %s', [l_Name.rName, l_Name.rSubName]));
    Delete(l_i);
    Dec(l_SeriesCount);
    Dec(l_C);
   end;//l_SeriesCount > aCount
   //l3System.Str2Log(Format('Series count %d', [l_SeriesCount]));
  end;//l_SeriesCount > aCount
  Inc(l_i, l_SeriesCount);
 end;//while (i <= l_C)
//#UC END# *4B7A98A10031_4B2F5BB102A4_impl*
end;//TTimeInfoList.Compact
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

end.
