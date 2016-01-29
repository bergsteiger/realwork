unit evRowDataList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evRowDataList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::CellUtils::TevRowDataList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evEditorInterfaces,
  l3ProtoDataContainer,
  evCellInfoList,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = TevCellInfoList;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TevRowDataList = class(_l3UncomparabeObjectRefList_)
 public
 // public methods
   procedure AddCellInfo(const aCellIterator: IedCellsIterator);
 end;//TevRowDataList

implementation

uses
  evCellInfo,
  evTableCellUtils,
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TevRowDataList

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_516D1D2B0058_var*
//#UC END# *47B2C42A0163_516D1D2B0058_var*
begin
//#UC START# *47B2C42A0163_516D1D2B0058_impl*
 Assert(False);
//#UC END# *47B2C42A0163_516D1D2B0058_impl*
end;//AssignItem

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_516D1D2B0058_var*
//#UC END# *47B99D4503A2_516D1D2B0058_var*
begin
//#UC START# *47B99D4503A2_516D1D2B0058_impl*
 Result := -1;
 Assert(False);
//#UC END# *47B99D4503A2_516D1D2B0058_impl*
end;//CompareExistingItems

type _Instance_R_ = TevRowDataList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

// start class TevRowDataList

procedure TevRowDataList.AddCellInfo(const aCellIterator: IedCellsIterator);
//#UC START# *516D390E0162_516D1D2B0058_var*
var
 l_CellInfo  : TevCellInfo;
 l_CellsList : TevCellInfoList;

 procedure lp_CheckUpBoundary;
 var
  i                 : Integer;
  l_PrevList        : TevCellInfoList;
  l_LeftOffset      : Integer;
  l_RightOffset     : Integer;
  l_PrevCellInfo    : TevCellInfo;
  l_PrevLeftOffset  : Integer;
  l_PrevRightOffset : Integer;
 begin
  if Count > 1 then
  begin
   l_LeftOffset := l_CellsList.GetOffset(l_CellInfo);
   l_RightOffset := l_LeftOffset + l_CellInfo.OldWidth;
   l_PrevList := Items[Count - 2];
   l_PrevLeftOffset := 0;
   for i := 0 to l_PrevList.Count - 1 do
   begin
    l_PrevCellInfo := l_PrevList[i];
    l_PrevRightOffset := l_PrevLeftOffset + l_PrevCellInfo.OldWidth;
    if evEqualOffset(l_LeftOffset, l_PrevLeftOffset) then
     if evEqualOffset(l_RightOffset, l_PrevRightOffset) then
     begin
      l_CellInfo.UpdateBoundaryType(ed_bcEqual, True);
      l_PrevCellInfo.UpdateBoundaryType(ed_bcEqual, False);
     end // if evEqualOffset(l_RightOffset, l_RightOffset) then
     else
     begin
      l_CellInfo.UpdateBoundaryType(ed_bcLeftEqual, True);
      l_PrevCellInfo.UpdateBoundaryType(ed_bcLeftEqual, False);
     end
    else
     if evEqualOffset(l_RightOffset, l_PrevRightOffset) then
     begin
      l_CellInfo.UpdateBoundaryType(ed_bcRightEqual, True);
      l_PrevCellInfo.UpdateBoundaryType(ed_bcRightEqual, False);
     end;
    l_PrevLeftOffset := l_PrevRightOffset;
   end; // for i := 0 to l_PrevList.Count - 1 do
  end; // if Count > 1 then
 end;

var
 l_Cell: IedCell;
//#UC END# *516D390E0162_516D1D2B0058_var*
begin
//#UC START# *516D390E0162_516D1D2B0058_impl*
 l_Cell := aCellIterator.First(False);
 l_CellsList := TevCellInfoList.Create;
 Add(l_CellsList);
 while l_Cell <> nil do
 begin
  l_CellInfo := TevCellInfo.Create(l_CellsList.Count, l_Cell);
  l_CellsList.Add(l_CellInfo);
  l_Cell := aCellIterator.Next;
 end; // while l_Cell <> nil do
//#UC END# *516D390E0162_516D1D2B0058_impl*
end;//TevRowDataList.AddCellInfo

end.