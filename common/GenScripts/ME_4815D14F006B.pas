unit nevRootFormatInfoListPrim;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevRootFormatInfoListPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevRootFormatInfo
 , nevBase
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TnevRootFormatInfo;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TnevRootFormatInfoListPrim = class(_l3UncomparabeObjectRefList_)
  public
   class function CompareViews(const A: InevViewMetrics;
    const B: InevViewMetrics): Integer;
 end;//TnevRootFormatInfoListPrim

implementation

uses
 l3ImplUses
 , evdStyles
 , evdTypes
 , m2MemLib
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4815D14F006B_var*
//#UC END# *47B2C42A0163_4815D14F006B_var*
begin
//#UC START# *47B2C42A0163_4815D14F006B_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4815D14F006B_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4815D14F006B_var*
//#UC END# *47B99D4503A2_4815D14F006B_var*
begin
//#UC START# *47B99D4503A2_4815D14F006B_impl*
 Result := CI.rA.LimitWidth - CI.rB.LimitWidth;
 if (Result = 0) then
  Result := TnevRootFormatInfoListPrim.CompareViews(CI.rA.Metrics, CI.rB.Metrics);
//#UC END# *47B99D4503A2_4815D14F006B_impl*
end;//CompareExistingItems

type _Instance_R_ = TnevRootFormatInfoListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

class function TnevRootFormatInfoListPrim.CompareViews(const A: InevViewMetrics;
 const B: InevViewMetrics): Integer;
//#UC START# *482170A40347_4815D14F006B_var*
var
// l_I1 : Int64;
// l_S1 : TevStandardStyles absolute l_I1;
// l_I2 : Int64;
// l_S2 : TevStandardStyles absolute l_I2;

 l_S1 : TevStandardStyles;
 l_S2 : TevStandardStyles;

 l_S3 : TevNormalSegLayerHandleSet;
 l_I3 : Byte absolute l_S3;
 l_S4 : TevNormalSegLayerHandleSet;
 l_I4 : Byte absolute l_S4;
//#UC END# *482170A40347_4815D14F006B_var*
begin
//#UC START# *482170A40347_4815D14F006B_impl*
 Result := Ord(A.ShowSpecial) - Ord(B.ShowSpecial);
 if (Result = 0) then
  Result := Ord(A.IsWebStyle) - Ord(B.IsWebStyle);
 if (Result = 0) then
  Result := Ord(A.AllowRubberTables) - Ord(B.AllowRubberTables);
 if (Result = 0) then
  Result := Ord(A.ShowDocumentParts) - Ord(B.ShowDocumentParts);
 if (Result = 0) then
  Result := A.InfoCanvas.PixelsPerInchX - B.InfoCanvas.PixelsPerInchX;
 if (Result = 0) then
  Result := A.FormatCanvas.PixelsPerInchX - B.FormatCanvas.PixelsPerInchX;
 if (Result = 0) then
 begin
  l_S3 := A.ExcludeSuper;
  l_S4 := B.ExcludeSuper;
  Result := l_I3 - l_I4;
  Assert(SizeOf(l_S3) <= SizeOf(l_I3));
 end; // if (Result = 0) then
 if (Result = 0) then
 begin
//  l_I1 := 0;
//  l_I2 := 0;
  l_S1 := A.HiddenStyles;
  l_S2 := B.HiddenStyles;
  Result := m2MEMCompare(@l_S1, @l_S2, SizeOf(l_S1));
//  Result := l_I1 - l_I2;
//  Assert(SizeOf(l_S1) <= SizeOf(l_I1));
 end;//Result = 0
 if (Result = 0) AND A.IsWebStyle then
  Result := A.Extent.Y - B.Extent.Y;
//#UC END# *482170A40347_4815D14F006B_impl*
end;//TnevRootFormatInfoListPrim.CompareViews

end.
