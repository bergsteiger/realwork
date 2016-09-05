unit evCellsOffsetsPair;

// Модуль: "w:\common\components\gui\Garant\Everest\evCellsOffsetsPair.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevCellsOffsetsPair" MUID: (4F2F6F750263)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , evCellsCharOffsets
 , edCellTypesList
 , evEditorInterfacesTypes
 , evEditorInterfaces
;

type
 TedCellPosType = (
  ed_cpNone
  , ed_cpLast
  , ed_cpIgnoreLast
 );//TedCellPosType

 TevCellsOffsetsPair = class(Tl3ProtoObject)
  private
   f_FoundUpper: Boolean;
   f_OldOffset: TevCellsCharOffsets;
   f_NewOffset: TevCellsCharOffsets;
   f_CellsType: TedCellTypesList;
    {* Массив с типами содержимого ячеек. }
   f_RowType: TedRowType;
  private
   function CompareWidth(const aOffsetList: TevCellsOffsetsPair;
    var l_Delta: Integer): Integer;
   function FindUpper(const aOffsetList: TevCellsOffsetsPair;
    var l_Delta: Integer): Boolean;
   function FindLower(const aOffsetList: TevCellsOffsetsPair;
    var anIndex: Integer;
    var aDelta: Integer): Boolean;
   procedure UpdateNewWidth(anIndex: Integer;
    aDelta: Integer);
   function FindOffset(const aOffsetList: TevCellsOffsetsPair): Boolean;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
   procedure Clear;
   procedure AddCellWidthAndRecalc;
   function GetOffset(aNew: Boolean): Integer;
   function GetWidth(aNew: Boolean): Integer;
   function LastNewWidth: Integer;
   function PrevNewWidth: Integer;
   procedure SetWidthPair(aNewWidth: Integer;
    aOldWidth: Integer);
   function GetNextOffset(aNew: Boolean): Integer;
   function EqualCells(const anIterator: IedCellsIterator): Boolean;
   function GetRowWidth(aNew: Boolean): Integer;
   procedure CheckCurrentRow(aList: TevCellsOffsetsPair;
    aNewWidth: Integer;
    anOldCellWidth: Integer;
    aPrevRowWidth: Integer;
    aCelPosl: TedCellPosType;
    out aNeedBreak: Boolean);
   procedure AlignByPrevious(const aData: TevCellsOffsetsPair);
   procedure CopyData(aData: TevCellsCharOffsets;
    const anIterator: IedCellsIterator); overload;
   procedure CopyData(const aData: TevCellsOffsetsPair;
    const anIterator: IedCellsIterator); overload;
   procedure CheckPrevAlignment(const aPrev: TevCellsOffsetsPair);
  public
   property CellsType: TedCellTypesList
    read f_CellsType
    write f_CellsType;
    {* Массив с типами содержимого ячеек. }
   property RowType: TedRowType
    read f_RowType
    write f_RowType;
 end;//TevCellsOffsetsPair

implementation

uses
 l3ImplUses
 , l3UnitsTools
 , SysUtils
 //#UC START# *4F2F6F750263impl_uses*
 //#UC END# *4F2F6F750263impl_uses*
;

constructor TevCellsOffsetsPair.Create;
//#UC START# *4F2F7030001E_4F2F6F750263_var*
//#UC END# *4F2F7030001E_4F2F6F750263_var*
begin
//#UC START# *4F2F7030001E_4F2F6F750263_impl*
 inherited Create;
 f_RowType := ed_rtNull;
 f_OldOffset := TevCellsCharOffsets.Create;
 f_NewOffset := TevCellsCharOffsets.Create;
//#UC END# *4F2F7030001E_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.Create

procedure TevCellsOffsetsPair.Clear;
//#UC START# *4F2F704A01F8_4F2F6F750263_var*
//#UC END# *4F2F704A01F8_4F2F6F750263_var*
begin
//#UC START# *4F2F704A01F8_4F2F6F750263_impl*
 if f_NewOffset <> nil then
  f_NewOffset.Clear;
 if (f_OldOffset <> nil) then
  f_OldOffset.Clear;
 f_FoundUpper := False;
//#UC END# *4F2F704A01F8_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.Clear

procedure TevCellsOffsetsPair.AddCellWidthAndRecalc;
//#UC START# *4F2F70660228_4F2F6F750263_var*
//#UC END# *4F2F70660228_4F2F6F750263_var*
begin
//#UC START# *4F2F70660228_4F2F6F750263_impl*
 f_OldOffset.AddCellWidthAndRecalc;
 f_NewOffset.AddCellWidthAndRecalc;
//#UC END# *4F2F70660228_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.AddCellWidthAndRecalc

function TevCellsOffsetsPair.GetOffset(aNew: Boolean): Integer;
//#UC START# *4F2F708E0299_4F2F6F750263_var*
//#UC END# *4F2F708E0299_4F2F6F750263_var*
begin
//#UC START# *4F2F708E0299_4F2F6F750263_impl*
 if aNew then
  Result := f_NewOffset.GetOffset
 else
  Result := f_OldOffset.GetOffset
//#UC END# *4F2F708E0299_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.GetOffset

function TevCellsOffsetsPair.GetWidth(aNew: Boolean): Integer;
//#UC START# *4F2F70B6006A_4F2F6F750263_var*
//#UC END# *4F2F70B6006A_4F2F6F750263_var*
begin
//#UC START# *4F2F70B6006A_4F2F6F750263_impl*
 if aNew then
  Result := f_NewOffset.GetWidth
 else
  Result := f_OldOffset.GetWidth
//#UC END# *4F2F70B6006A_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.GetWidth

function TevCellsOffsetsPair.LastNewWidth: Integer;
//#UC START# *4F2F70EB0222_4F2F6F750263_var*
//#UC END# *4F2F70EB0222_4F2F6F750263_var*
begin
//#UC START# *4F2F70EB0222_4F2F6F750263_impl*
 Result := f_NewOffset.LastWidth;
//#UC END# *4F2F70EB0222_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.LastNewWidth

function TevCellsOffsetsPair.PrevNewWidth: Integer;
//#UC START# *4F2F710D00D6_4F2F6F750263_var*
//#UC END# *4F2F710D00D6_4F2F6F750263_var*
begin
//#UC START# *4F2F710D00D6_4F2F6F750263_impl*
 Result := f_NewOffset.PrevWidth;
//#UC END# *4F2F710D00D6_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.PrevNewWidth

procedure TevCellsOffsetsPair.SetWidthPair(aNewWidth: Integer;
 aOldWidth: Integer);
//#UC START# *4F2F712F0179_4F2F6F750263_var*
//#UC END# *4F2F712F0179_4F2F6F750263_var*
begin
//#UC START# *4F2F712F0179_4F2F6F750263_impl*
 f_OldOffset.SetWidth(aOldWidth);
 f_NewOffset.SetWidth(aNewWidth);
//#UC END# *4F2F712F0179_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.SetWidthPair

function TevCellsOffsetsPair.CompareWidth(const aOffsetList: TevCellsOffsetsPair;
 var l_Delta: Integer): Integer;
//#UC START# *4F2F719C01AF_4F2F6F750263_var*
//#UC END# *4F2F719C01AF_4F2F6F750263_var*
begin
//#UC START# *4F2F719C01AF_4F2F6F750263_impl*
 Result := f_OldOffset.GetWidth - aOffsetList.f_OldOffset.GetWidth;
 l_Delta := f_NewOffset.GetWidth - aOffsetList.f_NewOffset.GetWidth;
 if Abs(Result) < evCellWidthEpsilon then
  Result := 0;
 f_FoundUpper := Result > 0; 
//#UC END# *4F2F719C01AF_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.CompareWidth

function TevCellsOffsetsPair.FindUpper(const aOffsetList: TevCellsOffsetsPair;
 var l_Delta: Integer): Boolean;
//#UC START# *4F2F71C0015D_4F2F6F750263_var*
//#UC END# *4F2F71C0015D_4F2F6F750263_var*
begin
//#UC START# *4F2F71C0015D_4F2F6F750263_impl*
 l_Delta := GetNextOffset(True) - aOffsetList.GetOffset(True);
 Result := f_FoundUpper and
           (Abs((aOffsetList.GetNextOffset(False) - GetOffset(False)) - GetWidth(False)) < evCellWidthEpsilon);
//#UC END# *4F2F71C0015D_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.FindUpper

function TevCellsOffsetsPair.FindLower(const aOffsetList: TevCellsOffsetsPair;
 var anIndex: Integer;
 var aDelta: Integer): Boolean;
//#UC START# *4F2F71EF028D_4F2F6F750263_var*
var
 l_Offset : Integer; 
//#UC END# *4F2F71EF028D_4F2F6F750263_var*
begin
//#UC START# *4F2F71EF028D_4F2F6F750263_impl*
 l_Offset := aOffsetList.f_OldOffset.GetNextOffset;
 Result := f_OldOffset.FindOffset(l_Offset, anIndex);
 if Result then
 begin
  Dec(anIndex);
  f_NewOffset.SetCurrent(anIndex);
  l_Offset := aOffsetList.GetNextOffset(True);
  aDelta := l_Offset - GetNextOffset(True);
  //Result := Abs(aDelta) >= evCellWidthEpsilon;
 end; // if Result then
//#UC END# *4F2F71EF028D_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.FindLower

procedure TevCellsOffsetsPair.UpdateNewWidth(anIndex: Integer;
 aDelta: Integer);
//#UC START# *4F2F7226039B_4F2F6F750263_var*
//#UC END# *4F2F7226039B_4F2F6F750263_var*
begin
//#UC START# *4F2F7226039B_4F2F6F750263_impl*
 f_NewOffset.UpdateWidth(anIndex, aDelta);
//#UC END# *4F2F7226039B_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.UpdateNewWidth

function TevCellsOffsetsPair.GetNextOffset(aNew: Boolean): Integer;
//#UC START# *4F2F7268015A_4F2F6F750263_var*
//#UC END# *4F2F7268015A_4F2F6F750263_var*
begin
//#UC START# *4F2F7268015A_4F2F6F750263_impl*
 if aNew then
  Result := f_NewOffset.GetNextOffset
 else
  Result := f_OldOffset.GetNextOffset
//#UC END# *4F2F7268015A_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.GetNextOffset

function TevCellsOffsetsPair.EqualCells(const anIterator: IedCellsIterator): Boolean;
//#UC START# *4F2FABC40294_4F2F6F750263_var*
//#UC END# *4F2FABC40294_4F2F6F750263_var*
begin
//#UC START# *4F2FABC40294_4F2F6F750263_impl*
 Result := f_OldOffset.Equals(anIterator);
//#UC END# *4F2FABC40294_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.EqualCells

function TevCellsOffsetsPair.GetRowWidth(aNew: Boolean): Integer;
//#UC START# *4FAB83530326_4F2F6F750263_var*
//#UC END# *4FAB83530326_4F2F6F750263_var*
begin
//#UC START# *4FAB83530326_4F2F6F750263_impl*
 if aNew then
  Result := f_NewOffset.GetRowWidth
 else
  Result := f_OldOffset.GetRowWidth;
//#UC END# *4FAB83530326_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.GetRowWidth

procedure TevCellsOffsetsPair.CheckCurrentRow(aList: TevCellsOffsetsPair;
 aNewWidth: Integer;
 anOldCellWidth: Integer;
 aPrevRowWidth: Integer;
 aCelPosl: TedCellPosType;
 out aNeedBreak: Boolean);
//#UC START# *4FC5F3CF0017_4F2F6F750263_var*
var
 l_Delta: Integer;

 procedure lp_CorrectUpper(anOnlyPositive: Boolean);
 begin
  aList.AddCellWidthAndRecalc;
  l_Delta := aList.GetOffset(True) - aPrevRowWidth;
  if not anOnlyPositive or (l_Delta > 0) then
   UpdateNewWidth(-1, l_Delta);
  aNeedBreak := True;
 end;

var
 l_Index   : Integer;
 l_Compare : Integer;
//#UC END# *4FC5F3CF0017_4F2F6F750263_var*
begin
//#UC START# *4FC5F3CF0017_4F2F6F750263_impl*
 aNeedBreak := False;
 if FindUpper(aList, l_Delta) then
 begin
  if (l_Delta > 0) then
   if (aList.RowType = ed_rtChessTableRow) and (aCelPosl = ed_cpLast) then
    lp_CorrectUpper(False)
   else
    aList.SetWidthPair(l_Delta, anOldCellWidth)
 end // if l_PrevWidthList.FindUpper(aList, l_Delta) then
 else
  if FindOffset(aList) then
  begin
   l_Compare := CompareWidth(aList, l_Delta);
   if l_Compare = 0 then
   begin
    if l_Delta <> 0 then
     aList.SetWidthPair(aNewWidth + l_Delta, anOldCellWidth);
   end // if l_Compare = 0 then
   else
    if l_Compare < 0 then // возможно охватывающая ячейка...
     if aCelPosl > ed_cpNone then
     begin
      if aCelPosl = ed_cpLast then
       lp_CorrectUpper(True)
     end // if l_Cell = nil then
     else
      if FindLower(aList, l_Index, l_Delta) then
       aList.SetWidthPair(aNewWidth - l_Delta, anOldCellWidth)
  end; // if FindOffset(aList) then
//#UC END# *4FC5F3CF0017_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.CheckCurrentRow

function TevCellsOffsetsPair.FindOffset(const aOffsetList: TevCellsOffsetsPair): Boolean;
//#UC START# *4F2F716F0249_4F2F6F750263_var*
var
 l_Index: Integer;
//#UC END# *4F2F716F0249_4F2F6F750263_var*
begin
//#UC START# *4F2F716F0249_4F2F6F750263_impl*
 Result := f_OldOffset <> nil;
 if Result then
 begin
  Result := f_OldOffset.FindOffset(aOffsetList.f_OldOffset, l_Index);
  if Result then
   f_NewOffset.SetCurrent(l_Index);
 end; // if Result then
//#UC END# *4F2F716F0249_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.FindOffset

procedure TevCellsOffsetsPair.AlignByPrevious(const aData: TevCellsOffsetsPair);
//#UC START# *4FC76FA7005D_4F2F6F750263_var*
//#UC END# *4FC76FA7005D_4F2F6F750263_var*
begin
//#UC START# *4FC76FA7005D_4F2F6F750263_impl*
 f_NewOffset.AlignByPrevious(aData.f_NewOffset);
//#UC END# *4FC76FA7005D_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.AlignByPrevious

procedure TevCellsOffsetsPair.CopyData(aData: TevCellsCharOffsets;
 const anIterator: IedCellsIterator);
//#UC START# *50925F0800F6_4F2F6F750263_var*
//#UC END# *50925F0800F6_4F2F6F750263_var*
begin
//#UC START# *50925F0800F6_4F2F6F750263_impl*
 f_OldOffset.CopyData(aData, anIterator);
 f_NewOffset.CopyData(aData, nil);
//#UC END# *50925F0800F6_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.CopyData

procedure TevCellsOffsetsPair.CopyData(const aData: TevCellsOffsetsPair;
 const anIterator: IedCellsIterator);
//#UC START# *528DED3F007E_4F2F6F750263_var*
//#UC END# *528DED3F007E_4F2F6F750263_var*
begin
//#UC START# *528DED3F007E_4F2F6F750263_impl*
 f_OldOffset.CopyData(aData.f_OldOffset, anIterator);
 f_NewOffset.CopyData(aData.f_NewOffset, nil);
//#UC END# *528DED3F007E_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.CopyData

procedure TevCellsOffsetsPair.CheckPrevAlignment(const aPrev: TevCellsOffsetsPair);
//#UC START# *52F1EFF800A6_4F2F6F750263_var*
var
 l_Index     : Integer;
 l_NeedAlign : Boolean;
 l_PrevIndex : Integer;
 l_PrevOffset: Integer;
//#UC END# *52F1EFF800A6_4F2F6F750263_var*
begin
//#UC START# *52F1EFF800A6_4F2F6F750263_impl*
 if (aPrev <> nil) and (aPrev.RowType = ed_rtSimpleCells) and (RowType = ed_rtSimpleCells) then
 begin
  l_Index := 0;
  while l_Index < f_OldOffset.GetCount do
  begin
   if f_CellsType[l_Index] <> ed_ctEmptyAndNotFramed then
   begin
    aPrev.f_OldOffset.FindOffset(f_OldOffset.GetOffsetByIndex(l_Index), l_PrevIndex);
    if (l_PrevIndex > -1) then
    begin
     l_PrevOffset := aPrev.f_NewOffset.GetOffsetByIndex(l_PrevIndex);
     if (aPrev.f_OldOffset.GetOffsetByIndex(l_PrevIndex) = f_OldOffset.GetOffsetByIndex(l_Index)) and
        (aPrev.CellsType[l_PrevIndex] <> ed_ctEmptyAndNotFramed) and
        (l_PrevOffset <> f_NewOffset.GetOffsetByIndex(l_Index)) then
     begin
      f_NewOffset.AlignByOffset(l_PrevOffset, l_Index, f_CellsType);
     end;
    end; // if (l_PrevIndex > -1) then
   end; // if f_CellsType[l_Index] <> ed_EmptyAndNotFramed then
   Inc(l_Index);
  end; // while l_Index < f_NewOffset.GetCount do
 end; // if (aPrev.RowType = ed_SimpleCells) and (RowType = ed_SimpleCells) then
//#UC END# *52F1EFF800A6_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.CheckPrevAlignment

procedure TevCellsOffsetsPair.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4F2F6F750263_var*
//#UC END# *479731C50290_4F2F6F750263_var*
begin
//#UC START# *479731C50290_4F2F6F750263_impl*
 if f_OldOffset <> nil then
  f_OldOffset.Clear;
 FreeAndNil(f_OldOffset);
 if f_NewOffset <> nil then
  f_NewOffset.Clear;
 FreeAndNil(f_NewOffset);
 if f_CellsType <> nil then
  f_CellsType.Clear;
 FreeAndNil(f_CellsType);
 f_RowType := ed_rtNull;
 inherited;
//#UC END# *479731C50290_4F2F6F750263_impl*
end;//TevCellsOffsetsPair.Cleanup

end.
