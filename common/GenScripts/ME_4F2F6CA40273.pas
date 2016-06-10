unit evCellsCharOffsets;
 {* работа со смещени€ми €чеек }

// ћодуль: "w:\common\components\gui\Garant\Everest\evCellsCharOffsets.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "TevCellsCharOffsets" MUID: (4F2F6CA40273)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , evOneCharLongIntList
 , evEditorInterfaces
 , edCellTypesList
;

type
 TevCellsCharOffsets = class(Tl3ProtoObject)
  {* работа со смещени€ми €чеек }
  private
   f_Offsets: TevOneCharLongIntList;
    {* —мещени€ €чеек }
   f_Widths: TevOneCharLongIntList;
    {* Ўирина €чеек по этому смещению }
   f_Width: Integer;
    {* “екуща€ ширина €чейки }
   f_Offset: Integer;
    {* “екущее смещение }
   f_Index: Integer;
   f_UsingCount: Integer;
  private
   procedure CheckList;
  protected
   procedure Cleanup; override;
    {* ‘ункци€ очистки полей объекта. }
  public
   procedure AddCellWidthAndRecalc;
   procedure Clear;
   function FindOffset(const aOffsetList: TevCellsCharOffsets;
    var anIndex: Integer): Boolean; overload;
   function FindOffset(anOffset: Integer;
    var anIndex: Integer): Boolean; overload;
   function LastWidth: Integer;
   function PrevWidth: Integer;
   function GetNextOffset: Integer;
   procedure SetCurrent(anIndex: Integer);
   function GetOffset: Integer;
   procedure SetWidth(aWidth: Integer);
   function GetWidth: Integer;
   procedure UpdateWidth(anIndex: Integer;
    aDelta: Integer);
   function Equals(const anIterator: IedCellsIterator): Boolean; overload;
   procedure CopyData(const aData: TevCellsCharOffsets;
    const anIterator: IedCellsIterator);
   function GetRowWidth: Integer;
   procedure AlignByPrevious(const aData: TevCellsCharOffsets);
   function Equals(const anIterator: IedCellsIterator;
    aForTempate: Boolean): Boolean; overload;
   procedure IncUsingCount;
   function GetWidthByIndex(anIndex: Integer): Integer;
   function GetOffsetByIndex(anIndex: Integer): Integer;
   function GetCount: Integer;
   procedure AlignByOffset(anOffset: Integer;
    anIndex: Integer;
    aCellTypeList: TedCellTypesList);
 end;//TevCellsCharOffsets

implementation

uses
 l3ImplUses
 , SysUtils
 , l3UnitsTools
 {$If Defined(k2ForEditor)}
 , evTableCellUtils
 {$IfEnd} // Defined(k2ForEditor)
 , evExcept
;

procedure TevCellsCharOffsets.AddCellWidthAndRecalc;
//#UC START# *4F2F6D94002E_4F2F6CA40273_var*
//#UC END# *4F2F6D94002E_4F2F6CA40273_var*
begin
//#UC START# *4F2F6D94002E_4F2F6CA40273_impl*
 CheckList;
 f_Offsets.Add(f_Offset);
 f_Widths.Add(f_Width);
 Inc(f_Offset, f_Width);
//#UC END# *4F2F6D94002E_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.AddCellWidthAndRecalc

procedure TevCellsCharOffsets.Clear;
//#UC START# *4F2F6DAB0114_4F2F6CA40273_var*
//#UC END# *4F2F6DAB0114_4F2F6CA40273_var*
begin
//#UC START# *4F2F6DAB0114_4F2F6CA40273_impl*
 if (f_Offsets <> nil) then
 begin
  f_Offsets.Clear;
  f_Widths.Clear;
  f_Offset := 0;
  f_Width := 0;
  f_Index := 0;
  f_UsingCount := 0;
 end; // if (f_Offsets <> nil) then
//#UC END# *4F2F6DAB0114_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.Clear

function TevCellsCharOffsets.FindOffset(const aOffsetList: TevCellsCharOffsets;
 var anIndex: Integer): Boolean;
//#UC START# *4F2F6DC40150_4F2F6CA40273_var*
//#UC END# *4F2F6DC40150_4F2F6CA40273_var*
begin
//#UC START# *4F2F6DC40150_4F2F6CA40273_impl*
 Result := f_Offsets <> nil;
 if Result then
 begin
  Result := f_Offsets.FindData(aOffsetList.f_Offset, anIndex);
  if Result then
  begin
   f_Width := f_Widths[anIndex];
   f_Offset := f_Offsets[anIndex];
  end; // if Result then
 end; // if Result then
//#UC END# *4F2F6DC40150_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.FindOffset

function TevCellsCharOffsets.FindOffset(anOffset: Integer;
 var anIndex: Integer): Boolean;
//#UC START# *4F2F6DEE0354_4F2F6CA40273_var*
//#UC END# *4F2F6DEE0354_4F2F6CA40273_var*
begin
//#UC START# *4F2F6DEE0354_4F2F6CA40273_impl*
 Result := f_Offsets <> nil;
 if Result then
 begin
  Result := f_Offsets.FindData(anOffset, anIndex);
  if Result then
  begin
   f_Width := f_Widths[anIndex];
   f_Offset := f_Offsets[anIndex];
  end; // if Result then
 end; // if Result then
//#UC END# *4F2F6DEE0354_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.FindOffset

function TevCellsCharOffsets.LastWidth: Integer;
//#UC START# *4F2F6E25013C_4F2F6CA40273_var*
//#UC END# *4F2F6E25013C_4F2F6CA40273_var*
begin
//#UC START# *4F2F6E25013C_4F2F6CA40273_impl*
 f_Index := f_Widths.Count;
 Result := PrevWidth;
//#UC END# *4F2F6E25013C_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.LastWidth

function TevCellsCharOffsets.PrevWidth: Integer;
//#UC START# *4F2F6E47025D_4F2F6CA40273_var*
//#UC END# *4F2F6E47025D_4F2F6CA40273_var*
begin
//#UC START# *4F2F6E47025D_4F2F6CA40273_impl*
 Dec(f_Index);
 if f_Index >= 0 then
  Result := f_Widths[f_Index]
 else
  Result := 0;
//#UC END# *4F2F6E47025D_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.PrevWidth

function TevCellsCharOffsets.GetNextOffset: Integer;
//#UC START# *4F2F6E6301E4_4F2F6CA40273_var*
//#UC END# *4F2F6E6301E4_4F2F6CA40273_var*
begin
//#UC START# *4F2F6E6301E4_4F2F6CA40273_impl*
 Result := f_Offset + f_Width;
//#UC END# *4F2F6E6301E4_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.GetNextOffset

procedure TevCellsCharOffsets.SetCurrent(anIndex: Integer);
//#UC START# *4F2F6E8500D5_4F2F6CA40273_var*
//#UC END# *4F2F6E8500D5_4F2F6CA40273_var*
begin
//#UC START# *4F2F6E8500D5_4F2F6CA40273_impl*
 f_Width := f_Widths[anIndex];
 f_Offset := f_Offsets[anIndex];
//#UC END# *4F2F6E8500D5_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.SetCurrent

function TevCellsCharOffsets.GetOffset: Integer;
//#UC START# *4F2F6EAB0342_4F2F6CA40273_var*
//#UC END# *4F2F6EAB0342_4F2F6CA40273_var*
begin
//#UC START# *4F2F6EAB0342_4F2F6CA40273_impl*
 Result := f_Offset;
//#UC END# *4F2F6EAB0342_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.GetOffset

procedure TevCellsCharOffsets.SetWidth(aWidth: Integer);
//#UC START# *4F2F6EC7021E_4F2F6CA40273_var*
//#UC END# *4F2F6EC7021E_4F2F6CA40273_var*
begin
//#UC START# *4F2F6EC7021E_4F2F6CA40273_impl*
 f_Width := aWidth;
//#UC END# *4F2F6EC7021E_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.SetWidth

function TevCellsCharOffsets.GetWidth: Integer;
//#UC START# *4F2F6EE10292_4F2F6CA40273_var*
//#UC END# *4F2F6EE10292_4F2F6CA40273_var*
begin
//#UC START# *4F2F6EE10292_4F2F6CA40273_impl*
 Result := f_Width;
//#UC END# *4F2F6EE10292_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.GetWidth

procedure TevCellsCharOffsets.UpdateWidth(anIndex: Integer;
 aDelta: Integer);
//#UC START# *4F2F6EFA02E7_4F2F6CA40273_var*
//#UC END# *4F2F6EFA02E7_4F2F6CA40273_var*
begin
//#UC START# *4F2F6EFA02E7_4F2F6CA40273_impl*
 if anIndex = -1 then
 begin
  f_Offset := f_Offset + aDelta;
  f_Widths.Last := f_Widths.Last + aDelta;
 end // if anIndex = -1 then
 else
  f_Widths[anIndex] := f_Widths[anIndex] + aDelta;
//#UC END# *4F2F6EFA02E7_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.UpdateWidth

function TevCellsCharOffsets.Equals(const anIterator: IedCellsIterator): Boolean;
//#UC START# *4F2FC2F502F6_4F2F6CA40273_var*
const
 cnTooBigCellWidth = 1000000;
var
 i        : Integer;
 l_Cell   : IedCell;
 l_Delta  : Integer;
 l_Result : Boolean;
//#UC END# *4F2FC2F502F6_4F2F6CA40273_var*
begin
//#UC START# *4F2FC2F502F6_4F2F6CA40273_impl*
 Result := False;
 Assert(f_Widths <> nil);
 l_Result := anIterator.CellsCount = f_Widths.Count;
 if l_Result then
 begin
  l_Cell := anIterator.First(False);
  l_Delta := 4 * evCellWidthEpsilon;
  for i := 0 to f_Widths.Count - 1 do
  begin
   l_Result := Abs(l_Cell.Width - f_Widths[i]) <= l_Delta;
   if not l_Result then
    l_Result := ((l_Cell.Width < evCellWidthEpsilon) or (l_Cell.Width > cnTooBigCellWidth)) and not l_Cell.IsEmptyCell;
   if not l_Result then Break;
   l_Cell := anIterator.Next;
  end; // for i := 0 to f_Widths.Count - 1 do
  if l_Result then
   Result := True;
 end; // if not l_Result then
//#UC END# *4F2FC2F502F6_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.Equals

procedure TevCellsCharOffsets.CopyData(const aData: TevCellsCharOffsets;
 const anIterator: IedCellsIterator);
//#UC START# *4F2FCECA004D_4F2F6CA40273_var*
var
 l_Cell   : IedCell;
 l_Offset : Integer;
//#UC END# *4F2FCECA004D_4F2F6CA40273_var*
begin
//#UC START# *4F2FCECA004D_4F2F6CA40273_impl*
 CheckList;
 if anIterator = nil then
 begin
  f_Widths.Assign(aData.f_Widths);
  f_Offsets.Assign(aData.f_Offsets);
 end // if anIterator = nil then
 else
 begin
  f_Widths.Capacity := anIterator.CellsCount;
  f_Offsets.Capacity := anIterator.CellsCount;
  l_Cell := anIterator.First(False);
  l_Offset := 0;
  while l_Cell <> nil do
  begin
   f_Widths.Add(l_Cell.Width);
   f_Offsets.Add(l_Offset);
   Inc(l_Offset, l_Cell.Width);
   l_Cell := anIterator.Next;
  end; // while l_Cell <> nil do
 end; // if anIterator = nil then
//#UC END# *4F2FCECA004D_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.CopyData

procedure TevCellsCharOffsets.CheckList;
//#UC START# *4F2FD1E202A4_4F2F6CA40273_var*
//#UC END# *4F2FD1E202A4_4F2F6CA40273_var*
begin
//#UC START# *4F2FD1E202A4_4F2F6CA40273_impl*
 if (f_Offsets = nil) then
  f_Offsets := TevOneCharLongIntList.Make;
 if (f_Widths = nil) then
  f_Widths := TevOneCharLongIntList.Make;
//#UC END# *4F2FD1E202A4_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.CheckList

function TevCellsCharOffsets.GetRowWidth: Integer;
//#UC START# *4FAB832701E6_4F2F6CA40273_var*
var
 i       : Integer;
 l_Count : Integer;
//#UC END# *4FAB832701E6_4F2F6CA40273_var*
begin
//#UC START# *4FAB832701E6_4F2F6CA40273_impl*
 Result := 0;
 l_Count := f_Widths.Count - 1;
 for i := 0 to l_Count do
 begin
  //if (i = l_Count) and (f_Widths[i] = evCellWidthEpsilon) then Break; // http://mdp.garant.ru/pages/viewpage.action?pageId=206078013
  Inc(Result, f_Widths[i]);
 end; // for i := 0 to l_Count do
//#UC END# *4FAB832701E6_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.GetRowWidth

procedure TevCellsCharOffsets.AlignByPrevious(const aData: TevCellsCharOffsets);
//#UC START# *4FC773170099_4F2F6CA40273_var*
var
 l_Index       : Integer;
 l_PrevIndex   : Integer;
 l_RowWidth    : Integer;
 l_RightIndent : Integer;
//#UC END# *4FC773170099_4F2F6CA40273_var*
begin
//#UC START# *4FC773170099_4F2F6CA40273_impl*
 l_Index := f_Widths.Count - 1;
 l_PrevIndex := aData.f_Widths.Count - 1;
 if l_Index <= l_PrevIndex then
 begin
  l_RowWidth := aData.GetRowWidth;
  while l_Index > 0 do
  begin
   f_Widths[l_Index] := aData.f_Widths[l_PrevIndex];
   Dec(l_RowWidth, f_Widths[l_Index]);
   Dec(l_Index);
   Dec(l_PrevIndex);
  end; // while l_Index > 0 do
  f_Widths[l_Index] := l_RowWidth;
 end; // if l_Index < aData.f_Widths.Count then
//#UC END# *4FC773170099_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.AlignByPrevious

function TevCellsCharOffsets.Equals(const anIterator: IedCellsIterator;
 aForTempate: Boolean): Boolean;
//#UC START# *50937BBB01BF_4F2F6CA40273_var*
var
 i        : Integer;
 l_Cell   : IedCell;
 l_Count  : Integer;
 l_Equal  : Integer;
 l_Result : Boolean;
//#UC END# *50937BBB01BF_4F2F6CA40273_var*
begin
//#UC START# *50937BBB01BF_4F2F6CA40273_impl*
 Result := False;
 l_Count := f_Widths.Count;
 l_Result := anIterator.CellsCount <> l_Count;
 if not l_Result then
 begin
  l_Cell := anIterator.First(False);
  l_Equal := 0;
  for i := 0 to l_Count - 1 do
  begin
   if (Abs(l_Cell.Width - f_Widths[i]) < l_Cell.Width div 2) then
    Inc(l_Equal);
   l_Cell := anIterator.Next;
  end; // for i := 0 to l_List.Count - 1 do
  l_Result := l_Equal >= l_Count div 2;
  if not aForTempate and not l_Result then
   l_Result := f_UsingCount > 1;
  if l_Result then
   Result := True;
 end; // if not l_Result then
//#UC END# *50937BBB01BF_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.Equals

procedure TevCellsCharOffsets.IncUsingCount;
//#UC START# *509383B202C4_4F2F6CA40273_var*
//#UC END# *509383B202C4_4F2F6CA40273_var*
begin
//#UC START# *509383B202C4_4F2F6CA40273_impl*
 Inc(f_UsingCount);
//#UC END# *509383B202C4_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.IncUsingCount

function TevCellsCharOffsets.GetWidthByIndex(anIndex: Integer): Integer;
//#UC START# *52F1EC8D0285_4F2F6CA40273_var*
//#UC END# *52F1EC8D0285_4F2F6CA40273_var*
begin
//#UC START# *52F1EC8D0285_4F2F6CA40273_impl*
  Result := f_Widths[anIndex];
//#UC END# *52F1EC8D0285_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.GetWidthByIndex

function TevCellsCharOffsets.GetOffsetByIndex(anIndex: Integer): Integer;
//#UC START# *52F1ECC0021F_4F2F6CA40273_var*
//#UC END# *52F1ECC0021F_4F2F6CA40273_var*
begin
//#UC START# *52F1ECC0021F_4F2F6CA40273_impl*
 Result := f_Offsets[anIndex];
//#UC END# *52F1ECC0021F_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.GetOffsetByIndex

function TevCellsCharOffsets.GetCount: Integer;
//#UC START# *52F1ECE3002C_4F2F6CA40273_var*
//#UC END# *52F1ECE3002C_4F2F6CA40273_var*
begin
//#UC START# *52F1ECE3002C_4F2F6CA40273_impl*
 Result := f_Offsets.Count;
//#UC END# *52F1ECE3002C_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.GetCount

procedure TevCellsCharOffsets.AlignByOffset(anOffset: Integer;
 anIndex: Integer;
 aCellTypeList: TedCellTypesList);
//#UC START# *52F1ED3803C8_4F2F6CA40273_var*
var
 i      : Integer;
 l_Delta: Integer;
//#UC END# *52F1ED3803C8_4F2F6CA40273_var*
begin
//#UC START# *52F1ED3803C8_4F2F6CA40273_impl*
 l_Delta := f_Offsets[anIndex] - anOffset;
 for i := anIndex - 1 downto 0 do
  if aCellTypeList[i] = ed_ctEmptyAndNotFramed then
  begin
   f_Widths[i] := f_Widths[i] - l_Delta;
   f_Offsets[i + 1] := f_Offsets[i] + f_Widths[i];
   Break;
  end; // if aCellTypeList[i] = ed_EmptyAndNotFramed then
//#UC END# *52F1ED3803C8_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.AlignByOffset

procedure TevCellsCharOffsets.Cleanup;
 {* ‘ункци€ очистки полей объекта. }
//#UC START# *479731C50290_4F2F6CA40273_var*
//#UC END# *479731C50290_4F2F6CA40273_var*
begin
//#UC START# *479731C50290_4F2F6CA40273_impl*
 if f_Offsets <> nil then
  f_Offsets.Clear;
 FreeAndNil(f_Offsets);
 if f_Widths <> nil then
  f_Widths.Clear;
 FreeAndNil(f_Widths);
 f_UsingCount := 0;
 inherited;
//#UC END# *479731C50290_4F2F6CA40273_impl*
end;//TevCellsCharOffsets.Cleanup

end.
