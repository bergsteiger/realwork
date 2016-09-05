unit ddTableRow;

// Модуль: "w:\common\components\rtl\Garant\dd\ddTableRow.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddTableRow" MUID: (4FACE1370377)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddDocumentAtom
 , ddCellList
 , ddCellsPropertyList
 , ddRowProperty
 , ddTableCell
 , ddCellProperty
 , ddTypes
 , ddCustomDestination
 , k2Interfaces
 , l3ProtoObject
;

type
 TddTableRow = class(TddDocumentAtom)
  private
   f_CellList: TddCellList;
   f_CellProps: TddCellsPropertyList;
   f_TAP: TddRowProperty;
   f_RTFLikeWidth: Boolean;
   f_CellPropsCompleate: Boolean;
   f_HasMerged: Boolean;
   f_CurColumn: Integer;
  private
   procedure DoApplyCellProps(aCellProps: TddCellsPropertyList);
  protected
   procedure pm_SetTAP(aValue: TddRowProperty);
   function pm_GetLastCell: TddTableCell;
   function pm_GetLastCellProperty: TddCellProperty; virtual;
   function pm_GetCellWidthBySpan(anIndex: Integer): Integer;
   function pm_GetCellCountBySpan: Integer;
   function pm_GetCellWidth(anIndex: Integer): Integer;
   procedure pm_SetCellWidth(anIndex: Integer;
    aValue: Integer);
   function pm_GetCellSpan(anIndex: Integer): Integer;
   function pm_GetCellCount: Integer;
   function pm_GetCells(anIndex: Integer): TddTableCell;
   function pm_GetCellPropBySpan(anIndex: Integer): TddCellProperty;
   function pm_GetCellPropByPos(aPos: Integer): TddCellProperty;
   function pm_GetCellByPos(aPos: Integer): TddTableCell; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetEmpty: Boolean; override;
   procedure DoClose; override;
  public
   procedure AddCell(aCell: TddTableCell);
   procedure AddCellAndPara(const OnlyCell: Boolean = False);
   procedure AddEmptyCell;
   procedure AddCellProp(aCellProps: TddCellProperty;
    aClearBorder: TddClearBoder);
   procedure ApplyCellProps;
   function CellIndexBySpan(anIndex: Integer): Integer;
   procedure ClearCellProps;
   procedure DeleteCell(anIndex: Integer);
   function GetLastNonClosedCell: TddTableCell;
   procedure CloneCell(aCellProp: TddCellProperty);
   function GetLastNonClosedCellOrAddNew: TddTableCell;
    {* Проверяет не закрыта ли предыдущая ячейка, а если закрыта открывает новую. }
   function IsCellPropsInit: Boolean;
   procedure ApplyExternalCellPropsDef(aRow: TddTableRow);
   procedure ApplyCellProperty(aCEP: TddCellProperty);
   procedure SetVMerged2LastCell(aFirst: Boolean);
   function InsertCell(anIndex: Integer): TddTableCell;
   function CellIndex(aCell: TddTableCell): Integer;
   procedure IncCurrColumn;
   procedure DecCurrColumn;
   procedure Write2Generator(const Generator: Ik2TagGenerator;
    aNeedProcessRow: Boolean;
    LiteVersion: TddLiteVersion); override;
   procedure Clear; override;
   constructor Create(aDetination: TddCustomDestination); override;
   function IsRow: Boolean; override;
   function GetLastPara: TddDocumentAtom; override;
   procedure Assign(const aDocAtomObj: Tl3ProtoObject); override;
  public
   property TAP: TddRowProperty
    read f_TAP
    write pm_SetTAP;
   property RTFLikeWidth: Boolean
    read f_RTFLikeWidth
    write f_RTFLikeWidth;
   property LastCell: TddTableCell
    read pm_GetLastCell;
   property LastCellProperty: TddCellProperty
    read pm_GetLastCellProperty;
   property CellWidthBySpan[anIndex: Integer]: Integer
    read pm_GetCellWidthBySpan;
   property CellCountBySpan: Integer
    read pm_GetCellCountBySpan;
   property CellWidth[anIndex: Integer]: Integer
    read pm_GetCellWidth
    write pm_SetCellWidth;
   property CellSpan[anIndex: Integer]: Integer
    read pm_GetCellSpan;
   property CellCount: Integer
    read pm_GetCellCount;
   property Cells[anIndex: Integer]: TddTableCell
    read pm_GetCells;
    default;
   property CellPropBySpan[anIndex: Integer]: TddCellProperty
    read pm_GetCellPropBySpan;
   property CellPropByPos[aPos: Integer]: TddCellProperty
    read pm_GetCellPropByPos;
   property CellByPos[aPos: Integer]: TddTableCell
    read pm_GetCellByPos;
   property CellPropsCompleate: Boolean
    read f_CellPropsCompleate
    write f_CellPropsCompleate;
   property HasMerged: Boolean
    read f_HasMerged;
   property CurColumn: Integer
    read f_CurColumn
    write f_CurColumn;
 end;//TddTableRow

implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
 , l3Math
 , RTFtypes
 , evdFrame_Const
 , ddTable
 , l3Const
 , ddTextParagraph
 , Math
 , ddBase
 , ddEVDTypesSupport
 //#UC START# *4FACE1370377impl_uses*
 //#UC END# *4FACE1370377impl_uses*
;

procedure TddTableRow.pm_SetTAP(aValue: TddRowProperty);
//#UC START# *518A479603CD_4FACE1370377set_var*
//#UC END# *518A479603CD_4FACE1370377set_var*
begin
//#UC START# *518A479603CD_4FACE1370377set_impl*
 f_TAP.AssignFrom(aValue);
//#UC END# *518A479603CD_4FACE1370377set_impl*
end;//TddTableRow.pm_SetTAP

function TddTableRow.pm_GetLastCell: TddTableCell;
//#UC START# *518A4B370328_4FACE1370377get_var*
//#UC END# *518A4B370328_4FACE1370377get_var*
begin
//#UC START# *518A4B370328_4FACE1370377get_impl*
 if f_CellList.Count = 0 then
  Result := nil //AddCellAndPara;
 else
  Result := f_CellList.Last;
//#UC END# *518A4B370328_4FACE1370377get_impl*
end;//TddTableRow.pm_GetLastCell

function TddTableRow.pm_GetLastCellProperty: TddCellProperty;
//#UC START# *518A4B72006B_4FACE1370377get_var*
//#UC END# *518A4B72006B_4FACE1370377get_var*
begin
//#UC START# *518A4B72006B_4FACE1370377get_impl*
 if LastCell = nil then
  AddCellAndPara;
 Result:= LastCell.Props;
//#UC END# *518A4B72006B_4FACE1370377get_impl*
end;//TddTableRow.pm_GetLastCellProperty

function TddTableRow.pm_GetCellWidthBySpan(anIndex: Integer): Integer;
//#UC START# *518A4BB402CE_4FACE1370377get_var*
var
 l_CellIndex: Integer;
//#UC END# *518A4BB402CE_4FACE1370377get_var*
begin
//#UC START# *518A4BB402CE_4FACE1370377get_impl*
 Result := 0;
 l_CellIndex := CellIndexBySpan(anIndex);
 if l_CellIndex > -1 then
  Result := CellWidth[l_CellIndex] div CellSpan[l_CellIndex];
//#UC END# *518A4BB402CE_4FACE1370377get_impl*
end;//TddTableRow.pm_GetCellWidthBySpan

function TddTableRow.pm_GetCellCountBySpan: Integer;
//#UC START# *518A4C320198_4FACE1370377get_var*
var
 i: Integer;
//#UC END# *518A4C320198_4FACE1370377get_var*
begin
//#UC START# *518A4C320198_4FACE1370377get_impl*
 Result := 0;
 for i := 0 to CellCount - 1 do
  Inc(Result, CellSpan[i]);
//#UC END# *518A4C320198_4FACE1370377get_impl*
end;//TddTableRow.pm_GetCellCountBySpan

function TddTableRow.pm_GetCellWidth(anIndex: Integer): Integer;
//#UC START# *518A4C67024C_4FACE1370377get_var*
//#UC END# *518A4C67024C_4FACE1370377get_var*
begin
//#UC START# *518A4C67024C_4FACE1370377get_impl*
 Result := Cells[anIndex].Props.CellOffset;
//#UC END# *518A4C67024C_4FACE1370377get_impl*
end;//TddTableRow.pm_GetCellWidth

procedure TddTableRow.pm_SetCellWidth(anIndex: Integer;
 aValue: Integer);
//#UC START# *518A4C67024C_4FACE1370377set_var*
//#UC END# *518A4C67024C_4FACE1370377set_var*
begin
//#UC START# *518A4C67024C_4FACE1370377set_impl*
 Cells[anIndex].Props.CellOffset:= aValue;
//#UC END# *518A4C67024C_4FACE1370377set_impl*
end;//TddTableRow.pm_SetCellWidth

function TddTableRow.pm_GetCellSpan(anIndex: Integer): Integer;
//#UC START# *518A4CA40030_4FACE1370377get_var*
//#UC END# *518A4CA40030_4FACE1370377get_var*
begin
//#UC START# *518A4CA40030_4FACE1370377get_impl*
 Result := Cells[anIndex].Props.CellSpan;
//#UC END# *518A4CA40030_4FACE1370377get_impl*
end;//TddTableRow.pm_GetCellSpan

function TddTableRow.pm_GetCellCount: Integer;
//#UC START# *518A4CFA00C4_4FACE1370377get_var*
//#UC END# *518A4CFA00C4_4FACE1370377get_var*
begin
//#UC START# *518A4CFA00C4_4FACE1370377get_impl*
 if (Self <> nil) AND (f_CellList <> nil) then
  Result := f_CellList.Count
 else
  Result := 0;
//#UC END# *518A4CFA00C4_4FACE1370377get_impl*
end;//TddTableRow.pm_GetCellCount

function TddTableRow.pm_GetCells(anIndex: Integer): TddTableCell;
//#UC START# *518A4D6A039D_4FACE1370377get_var*
//#UC END# *518A4D6A039D_4FACE1370377get_var*
begin
//#UC START# *518A4D6A039D_4FACE1370377get_impl*
 if (anIndex >= 0) and (anIndex < f_CellList.Count) then
  Result := f_CellList.Items[anIndex]
 else 
  Result := nil;
//#UC END# *518A4D6A039D_4FACE1370377get_impl*
end;//TddTableRow.pm_GetCells

function TddTableRow.pm_GetCellPropBySpan(anIndex: Integer): TddCellProperty;
//#UC START# *518A4DE0032A_4FACE1370377get_var*
var
 l_CellIndex: Integer;
//#UC END# *518A4DE0032A_4FACE1370377get_var*
begin
//#UC START# *518A4DE0032A_4FACE1370377get_impl*
 Result := nil;
 l_CellIndex := CellIndexBySpan(anIndex);
 if l_CellIndex > -1 then
  Result := Cells[l_CellIndex].Props;
//#UC END# *518A4DE0032A_4FACE1370377get_impl*
end;//TddTableRow.pm_GetCellPropBySpan

function TddTableRow.pm_GetCellPropByPos(aPos: Integer): TddCellProperty;
//#UC START# *518A4E390255_4FACE1370377get_var*
var
 i       : Integer;
 l_Prev  : Integer;
 l_Count : Integer;
 l_Width : Integer;
 l_Delta : Integer;
//#UC END# *518A4E390255_4FACE1370377get_var*
begin
//#UC START# *518A4E390255_4FACE1370377get_impl*
 l_Width := 0;
 l_Prev := -1;
 Result := nil;
 l_Count := f_CellList.Count - 1;
 for i := 0 to l_Count do
 begin
  if (i > 0) and RTFLikeWidth then
   l_Delta := Cells[i].Props.CellOffset - Cells[Pred(i)].Props.CellOffset
  else
   l_Delta := Cells[i].Props.CellOffset;
  if (l_Prev > - 1) then
   if aPos = (l_Delta + l_Width) then
   begin
    l_Prev := i;
    Break;
   end // if (aPos = l_Width) then
   else
    Break
  else
   if (aPos > l_Width) and (aPos <= (l_Width + l3MulDiv(l_Delta, 105, 100))) then
    l_Prev := i;
   Inc(l_Width, l_Delta);
 end; // for i := 0 to f_CellList.Hi do
 if (l_Prev > - 1) then
 begin
  Result := Cells[l_Prev].Props;
  Result.Index := l_Prev;
 end; // if (l_Prev > - 1) then
//#UC END# *518A4E390255_4FACE1370377get_impl*
end;//TddTableRow.pm_GetCellPropByPos

function TddTableRow.pm_GetCellByPos(aPos: Integer): TddTableCell;
//#UC START# *5190964701FB_4FACE1370377get_var*
var
 i: Integer;
 Delta: LongInt;
//#UC END# *5190964701FB_4FACE1370377get_var*
begin
//#UC START# *5190964701FB_4FACE1370377get_impl*
 Result := nil;
 for i := 0 to f_CellList.Hi do
 begin
  if i > 0 then
   Delta := Cells[Pred(i)].Props.CellOffset
  else
   Delta := 0;
  if InRange(aPos, Delta, Cells[i].Props.CellOffset) then
  begin
   Result := Cells[i];
   Break;
  end; // InRange
 end; // for i
//#UC END# *5190964701FB_4FACE1370377get_impl*
end;//TddTableRow.pm_GetCellByPos

procedure TddTableRow.AddCell(aCell: TddTableCell);
//#UC START# *518A4EF70329_4FACE1370377_var*
//#UC END# *518A4EF70329_4FACE1370377_var*
begin
//#UC START# *518A4EF70329_4FACE1370377_impl*
 aCell.anIndex := f_CellList.Add(aCell);
//#UC END# *518A4EF70329_4FACE1370377_impl*
end;//TddTableRow.AddCell

procedure TddTableRow.AddCellAndPara(const OnlyCell: Boolean = False);
//#UC START# *518A4F30003C_4FACE1370377_var*
var
 l_Cell     : TddTableCell;
 l_Property : TddTextParagraph;
//#UC END# *518A4F30003C_4FACE1370377_var*
begin
//#UC START# *518A4F30003C_4FACE1370377_impl*
 l_Cell := TddTableCell.Create(f_Destination);
 try
  // Нужно ли добавить абзац
  if not OnlyCell then
  begin
   l_Property := TddTextParagraph.Create(f_Destination);
   try
    l_Property.PAP.InTable := True;
    l_Cell.Add(l_Property);
   finally
    FreeAndNil(l_Property);
   end;
  end; // not OnlyCell          
  AddCell(l_Cell);
 finally
  FreeAndNil(l_Cell);
 end;
//#UC END# *518A4F30003C_4FACE1370377_impl*
end;//TddTableRow.AddCellAndPara

procedure TddTableRow.AddEmptyCell;
//#UC START# *518A4F52010F_4FACE1370377_var*
var
 l_Cell: TddTableCell;
//#UC END# *518A4F52010F_4FACE1370377_var*
begin
//#UC START# *518A4F52010F_4FACE1370377_impl*
 l_Cell := TddTableCell.Create(f_Destination);
 try
  AddCell(l_Cell);
 finally
  FreeAndNil(l_Cell);
 end;
//#UC END# *518A4F52010F_4FACE1370377_impl*
end;//TddTableRow.AddEmptyCell

procedure TddTableRow.AddCellProp(aCellProps: TddCellProperty;
 aClearBorder: TddClearBoder);
//#UC START# *518A4F870014_4FACE1370377_var*
var
 l_CellProp: TddCellProperty;
//#UC END# *518A4F870014_4FACE1370377_var*
begin
//#UC START# *518A4F870014_4FACE1370377_impl*
 if f_CellPropsCompleate then
  ClearCellProps;
 l_CellProp := TddCellProperty.Create(aClearBorder);
 try
  l_CellProp.Assign(aCellProps);
  f_CellProps.Add(l_CellProp);
 finally
  FreeAndNil(l_CellProp);
 end;
//#UC END# *518A4F870014_4FACE1370377_impl*
end;//TddTableRow.AddCellProp

procedure TddTableRow.ApplyCellProps;
//#UC START# *518A4FB1034A_4FACE1370377_var*
//#UC END# *518A4FB1034A_4FACE1370377_var*
begin
//#UC START# *518A4FB1034A_4FACE1370377_impl*
 DoApplyCellProps(f_CellProps);
//#UC END# *518A4FB1034A_4FACE1370377_impl*
end;//TddTableRow.ApplyCellProps

function TddTableRow.CellIndexBySpan(anIndex: Integer): Integer;
//#UC START# *518A4FCE02FC_4FACE1370377_var*
var
 j           : Integer;
 l_SpanIndex : Integer;
 l_CellIndex : Integer;
//#UC END# *518A4FCE02FC_4FACE1370377_var*
begin
//#UC START# *518A4FCE02FC_4FACE1370377_impl*
 l_SpanIndex:= -1;
 l_CellIndex:= 0;
 Result:= -1;
 for l_CellIndex:= 0 to Pred(CellCount) do
 begin
  for j := 1 to CellSpan[l_CellIndex] do
  begin
   Inc(l_SpanIndex);
   if l_SpanIndex = anIndex then
   begin
    Result := l_CellIndex;
    Break;
   end;
  end;
 end; // while
 if Result = -1 then
 begin
  l_SpanIndex := -1;
  l_CellIndex := 0;
  Result:= -1;
  for l_CellIndex := 0 to Pred(CellCount) do
   for j := 1 to CellSpan[l_CellIndex] do
   begin
    Inc(l_SpanIndex);
    if l_SpanIndex = anIndex then
    begin
     Result := l_CellIndex;
     Break;
    end; // if l_SpanIndex = anIndex then
   end; // for j := 1 to CellSpan[l_CellIndex] do
 end; // if Result = -1 then
//#UC END# *518A4FCE02FC_4FACE1370377_impl*
end;//TddTableRow.CellIndexBySpan

procedure TddTableRow.ClearCellProps;
//#UC START# *518A4FF703E6_4FACE1370377_var*
//#UC END# *518A4FF703E6_4FACE1370377_var*
begin
//#UC START# *518A4FF703E6_4FACE1370377_impl*
 f_CellProps.Clear;
 f_CellPropsCompleate := False;
//#UC END# *518A4FF703E6_4FACE1370377_impl*
end;//TddTableRow.ClearCellProps

procedure TddTableRow.DeleteCell(anIndex: Integer);
//#UC START# *518A501003AE_4FACE1370377_var*
var
 l_CP: TddCellProperty;
//#UC END# *518A501003AE_4FACE1370377_var*
begin
//#UC START# *518A501003AE_4FACE1370377_impl*
 l_CP := Cells[anIndex].Props;
 if (l_CP <> nil) and (CellCount > 1) then
 begin
  if anIndex > 0 then
  begin
   Cells[anIndex].Props.Border.Frames[bpLeft].Assign(Cells[anIndex - 1].Props.Border.Frames[bpLeft]);
   Cells[anIndex - 1].Props.Assign(Cells[anIndex].Props);
  end // if anIndex > 0 then
  else
   Cells[anIndex + 1].Props.Border.Frames[bpLeft].Assign(Cells[anIndex].Props.Border.Frames[bpLeft]);
  f_CellList.Delete(anIndex);
 end; // if (l_CP <> nil) and (CellCount > 1) then
//#UC END# *518A501003AE_4FACE1370377_impl*
end;//TddTableRow.DeleteCell

function TddTableRow.GetLastNonClosedCell: TddTableCell;
//#UC START# *51960AF50141_4FACE1370377_var*
//#UC END# *51960AF50141_4FACE1370377_var*
begin
//#UC START# *51960AF50141_4FACE1370377_impl*
 Result := pm_GetLastCell;
 if (Result <> nil) and Result.Closed then
  Result := nil;
//#UC END# *51960AF50141_4FACE1370377_impl*
end;//TddTableRow.GetLastNonClosedCell

procedure TddTableRow.CloneCell(aCellProp: TddCellProperty);
//#UC START# *519C8B33037C_4FACE1370377_var*
//#UC END# *519C8B33037C_4FACE1370377_var*
begin
//#UC START# *519C8B33037C_4FACE1370377_impl*
 AddCellAndPara;
 LastCellProperty.RowSpan:= Pred(aCellProp.RowSpan);
 LastCellProperty.CellSpan:= aCellProp.CellSpan;
 LastCellProperty.CellOffset:= aCellProp.CellOffset;
 // Нельзя так присваивать рамки!
 LastCellProperty.Border.AssignFrom(aCellProp.Border);
 LastCellProperty.VMerged:= True;
//#UC END# *519C8B33037C_4FACE1370377_impl*
end;//TddTableRow.CloneCell

function TddTableRow.GetLastNonClosedCellOrAddNew: TddTableCell;
 {* Проверяет не закрыта ли предыдущая ячейка, а если закрыта открывает новую. }
//#UC START# *519C95060331_4FACE1370377_var*
//#UC END# *519C95060331_4FACE1370377_var*
begin
//#UC START# *519C95060331_4FACE1370377_impl*
 Result := LastCell;
 if (Result = nil) or Result.Closed then
 begin
  AddCellAndPara(True);
  Result := LastCell;
 end; //if l_OutCell.Closed then
//#UC END# *519C95060331_4FACE1370377_impl*
end;//TddTableRow.GetLastNonClosedCellOrAddNew

function TddTableRow.IsCellPropsInit: Boolean;
//#UC START# *51E64E830070_4FACE1370377_var*
//#UC END# *51E64E830070_4FACE1370377_var*
begin
//#UC START# *51E64E830070_4FACE1370377_impl*
 Result := f_CellProps.Count > 0;
//#UC END# *51E64E830070_4FACE1370377_impl*
end;//TddTableRow.IsCellPropsInit

procedure TddTableRow.ApplyExternalCellPropsDef(aRow: TddTableRow);
//#UC START# *51E64F4B039E_4FACE1370377_var*
//#UC END# *51E64F4B039E_4FACE1370377_var*
begin
//#UC START# *51E64F4B039E_4FACE1370377_impl*
 if aRow <> nil then
  DoApplyCellProps(aRow.f_CellProps);
//#UC END# *51E64F4B039E_4FACE1370377_impl*
end;//TddTableRow.ApplyExternalCellPropsDef

procedure TddTableRow.DoApplyCellProps(aCellProps: TddCellsPropertyList);
//#UC START# *51E657D90184_4FACE1370377_var*
var
 i           : Integer;
 l_Cell      : TddTableCell;
 l_Count     : Integer;
 l_CellCount : Integer;
//#UC END# *51E657D90184_4FACE1370377_var*
begin
//#UC START# *51E657D90184_4FACE1370377_impl*
 l_Count := aCellProps.Count - 1;
 l_CellCount := f_CellList.Count - 1;
 for i := 0 to l_Count do
 begin
  l_Cell := Cells[i];
  if l_Cell = nil then Break;
  l_Cell.Props := aCellProps[i];
 end; // for i := 0 to aCellProps.Hi do
 if l_Count < l_CellCount then
  for i := l_Count + 1 to l_CellCount do
  begin
   l_Cell := Cells[i];
   if i > 0 then
    l_Cell.Props.CellOffset := l_Cell.Props.CellOffset + Cells[i - 1].Props.CellOffset;
  end; // for i := 0 to aCellProps.Hi do
//#UC END# *51E657D90184_4FACE1370377_impl*
end;//TddTableRow.DoApplyCellProps

procedure TddTableRow.ApplyCellProperty(aCEP: TddCellProperty);
//#UC START# *5236E3050196_4FACE1370377_var*
var
 i      : Integer;
 l_Cell : TddTableCell;
//#UC END# *5236E3050196_4FACE1370377_var*
begin
//#UC START# *5236E3050196_4FACE1370377_impl*
 for i := 0 to f_CellList.Count - 1 do
 begin
  l_Cell := Cells[i];
  l_Cell.Props := aCEP;
 end; // for i := 0 to f_CellList.Hi do
//#UC END# *5236E3050196_4FACE1370377_impl*
end;//TddTableRow.ApplyCellProperty

procedure TddTableRow.SetVMerged2LastCell(aFirst: Boolean);
//#UC START# *54EC68190248_4FACE1370377_var*
//#UC END# *54EC68190248_4FACE1370377_var*
begin
//#UC START# *54EC68190248_4FACE1370377_impl*
 if aFirst then
  LastCell.Props.VMergeFirst := True
 else
  LastCell.Props.VMerged := True;
 f_HasMerged := True;
//#UC END# *54EC68190248_4FACE1370377_impl*
end;//TddTableRow.SetVMerged2LastCell

function TddTableRow.InsertCell(anIndex: Integer): TddTableCell;
//#UC START# *56BD92CC03B8_4FACE1370377_var*
var
 l_Cell: TddTableCell;
//#UC END# *56BD92CC03B8_4FACE1370377_var*
begin
//#UC START# *56BD92CC03B8_4FACE1370377_impl*
 l_Cell := TddTableCell.Create(f_Destination);
 try
  f_CellList.Insert(anIndex, l_Cell);
  Result := l_Cell;
 finally
  FreeAndNil(l_Cell);
 end;
//#UC END# *56BD92CC03B8_4FACE1370377_impl*
end;//TddTableRow.InsertCell

function TddTableRow.CellIndex(aCell: TddTableCell): Integer;
//#UC START# *56C56DDB01F7_4FACE1370377_var*
//#UC END# *56C56DDB01F7_4FACE1370377_var*
begin
//#UC START# *56C56DDB01F7_4FACE1370377_impl*
 Result := f_CellList.IndexOf(aCell);
//#UC END# *56C56DDB01F7_4FACE1370377_impl*
end;//TddTableRow.CellIndex

procedure TddTableRow.IncCurrColumn;
//#UC START# *572C73B200DC_4FACE1370377_var*
//#UC END# *572C73B200DC_4FACE1370377_var*
begin
//#UC START# *572C73B200DC_4FACE1370377_impl*
 Inc(f_CurColumn);
//#UC END# *572C73B200DC_4FACE1370377_impl*
end;//TddTableRow.IncCurrColumn

procedure TddTableRow.DecCurrColumn;
//#UC START# *572C73CE03CB_4FACE1370377_var*
//#UC END# *572C73CE03CB_4FACE1370377_var*
begin
//#UC START# *572C73CE03CB_4FACE1370377_impl*
 Dec(f_CurColumn);
//#UC END# *572C73CE03CB_4FACE1370377_impl*
end;//TddTableRow.DecCurrColumn

procedure TddTableRow.Write2Generator(const Generator: Ik2TagGenerator;
 aNeedProcessRow: Boolean;
 LiteVersion: TddLiteVersion);
//#UC START# *518A504F00F5_4FACE1370377_var*
var
 i     : Integer;
 l_Cell: TddTableCell;

 procedure lp_ChecktrwWidthB;
 var
  l_Para  : TddDocumentAtom;
  l_Index : Integer;
 begin
  if (i = 0) and (TAP.trwWidthB > 0) then
   for l_Index := 0 to l_Cell.Count - 1 do
   begin
    l_Para := l_Cell.Items[i];
    if l_Para.IsTextPara then
     (l_Para as TddTextParagraph).PAP.xaFirst := TAP.trwWidthB;
   end; // for i := 0 to l_Cell.Count - 1 do
 end;

 function lp_CalcCellWidth(const aCell: TddTableCell; aIndex: Integer): Integer;
 var
  l_Delta: Integer;
 begin
  Result := 0;
  if (aIndex > 0) then
   l_Delta := CellWidth[aIndex - 1]
  else
  begin
   l_Delta := TAP.Left - TAP.trwWidthB;
   if l_Delta > aCell.Props.CellOffset then
    l_Delta := 0;
  end;
  if (aCell.Props.CellOffset <= 0) and (aCell.Props.CellWidth > 0) then
   Result := aCell.Props.CellWidth
  else
   Result := aCell.Props.CellOffset - l_Delta;
 end;

var
 l_Count: Integer;

 procedure lp_DeleteCell(anIndex: Integer);
 begin
  DeleteCell(anIndex);
  Dec(l_Count);
 end;

 procedure lp_CheckHead(const aCell: TddTableCell; anIndex: Integer);
 var
  l_Width   : Integer;
  l_LastCell: TddTableCell;
 begin
  if (l_Count = 1) and (anIndex = 0) and (aCell.Props.VMergeFirst or aCell.Props.VMerged) then
  begin
   l_LastCell := f_CellList[anIndex + 1];
   l_Width := lp_CalcCellWidth(l_LastCell, anIndex + 1);
   if (l_Width < ddGetMinimalCellWidth) and l_LastCell.IsCellEmpty then
   begin
    lp_DeleteCell(anIndex + 1);
    aCell.Props.CellOffset := aCell.Props.CellOffset + l_Width;
    aCell.Props.VMergeFirst := False;
    aCell.Props.VMerged := False;
   end; // if (l_Width < ddGetMinimalCellWidth) and l_LastCell.IsCellEmpty then
  end; // if (i = l_Count - 1) then
 end;

 function lp_OneLetter(aCell: TddTableCell): Boolean;
 var
  l_TextPara: TddTextParagraph;
 begin
  Result := False;
  if not Result then
   if (aCell.Count = 1) then
   begin
    l_TextPara := aCell.LastTextPara;
    if l_TextPara <> nil then
     Result := (l_TextPara.Text.Len = 1);
   end; // if (aCell.Count = 1) then
 end;

var
 l_Width    : Integer;
 l_OldWidth : Integer;
 l_NextWidth: Integer;
 l_PrevWidth: Integer;
//#UC END# *518A504F00F5_4FACE1370377_var*
begin
//#UC START# *518A504F00F5_4FACE1370377_impl*
 l_Count := f_CellList.Count - 1;
 if (l_Count = 0) and f_CellList[0].Props.VMerged then Exit;
 StartTableRow(Generator);
 try
  if LiteVersion = dd_lvNone then
   TAP.Border.Write2Generator(Generator);
  l_PrevWidth := 0;
  i := 0;
  while i <= l_Count do
  begin
   l_Cell := Cells[i];
   l_Width := lp_CalcCellWidth(l_Cell, i);
   if (l_Width < l3AlingDelta) or ((l_Width + l_PrevWidth) < 0) then
   //                               ^ - http://mdp.garant.ru/pages/viewpage.action?pageId=607532072
    if l_Cell.IsCellEmpty then
    begin
     Inc(l_PrevWidth, l_Width);
     lp_DeleteCell(i);
     Continue;
    end // if l_Cell.IsCellEmpty then
    else
     if (i < l_Count) and Cells[i + 1].IsCellEmpty then
     begin
      l_NextWidth := CellWidth[i + 1];
      if (l_NextWidth < 0) and (Cells[i + 1].Props.CellWidth > 0) then
       Inc(l_Width, Cells[i + 1].Props.CellWidth)
      else
       Inc(l_Width, l_NextWidth);
      if l_Width < 0 then
       l_Width := ddGetMinimalCellWidth;
      lp_DeleteCell(i + 1);
      if (l_Width < ddGetMinimalCellWidth) then
       if (((i + 1) < l_Count) and (Cells[i + 2].IsCellEmpty)) or lp_OneLetter(l_Cell) or (l_Width = 0) then
        Continue;
     end // if (i < l_Count) and CellWidth[i + 1].IsCellEmtpy then
     else
      l_Width := ddGetMinimalCellWidth;
   Inc(l_Width, l_PrevWidth);
   l_PrevWidth := 0;
   Assert(l_Width >= l3AlingDelta, Format('Очень узкая ячейка № %d в таблице: %d', [i, l_Width])); // Пускай лучше здесь валится, чем при отрисовке...
   l_OldWidth := l_Cell.Props.CellOffset;
   l_Cell.Props.CellOffset := l_Width;
   lp_CheckHead(l_Cell, i);
   try
    lp_ChecktrwWidthB;
    l_Cell.Write2Generator(Generator, aNeedProcessRow, LiteVersion);
    Inc(i);
   finally
    l_Cell.Props.CellOffset := l_OldWidth;
   end;
  end; {for i}
 finally
  Generator.Finish;
 end;
//#UC END# *518A504F00F5_4FACE1370377_impl*
end;//TddTableRow.Write2Generator

procedure TddTableRow.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4FACE1370377_var*
//#UC END# *479731C50290_4FACE1370377_var*
begin
//#UC START# *479731C50290_4FACE1370377_impl*
 f_HasMerged := False;
 FreeAndNil(f_CellProps);
 FreeAndNil(f_CellList);
 FreeAndNil(f_TAP);
 f_CellPropsCompleate := False;
 f_CurColumn := -1;
 inherited;
//#UC END# *479731C50290_4FACE1370377_impl*
end;//TddTableRow.Cleanup

function TddTableRow.GetEmpty: Boolean;
//#UC START# *4A54E03B009A_4FACE1370377_var*
var
 i      : Integer;
 l_Empty: Boolean;
//#UC END# *4A54E03B009A_4FACE1370377_var*
begin
//#UC START# *4A54E03B009A_4FACE1370377_impl*
 Result := inherited GetEmpty;
 if not Result then
 begin
  l_Empty := True;
  for i := 0 to f_CellList.Count - 1 do
   if not f_CellList[i].IsCellEmpty then
   begin
    l_Empty := False;
    Break;
   end; // if not f_CellList[i].IsCellEmpty then
   Result := l_Empty;
 end; // if not Result then
//#UC END# *4A54E03B009A_4FACE1370377_impl*
end;//TddTableRow.GetEmpty

procedure TddTableRow.Clear;
//#UC START# *518A48F500CF_4FACE1370377_var*
//#UC END# *518A48F500CF_4FACE1370377_var*
begin
//#UC START# *518A48F500CF_4FACE1370377_impl*
 inherited;
 f_CurColumn := -1;
 f_HasMerged := False;
 f_TAP.Clear;
 ClearCellProps;
//f_CellList.Clear;
//#UC END# *518A48F500CF_4FACE1370377_impl*
end;//TddTableRow.Clear

procedure TddTableRow.DoClose;
//#UC START# *518A4950037A_4FACE1370377_var*
var
 i: Integer;
//#UC END# *518A4950037A_4FACE1370377_var*
begin
//#UC START# *518A4950037A_4FACE1370377_impl*
 for i := 0 to Pred(CellCount) do
  Cells[i].Closed:= True; 
//#UC END# *518A4950037A_4FACE1370377_impl*
end;//TddTableRow.DoClose

constructor TddTableRow.Create(aDetination: TddCustomDestination);
//#UC START# *51E91BA80051_4FACE1370377_var*
//#UC END# *51E91BA80051_4FACE1370377_var*
begin
//#UC START# *51E91BA80051_4FACE1370377_impl*
 inherited Create(aDetination);
 f_HasMerged := False;
 f_CellPropsCompleate := False;
 f_CellList := TddCellList.Make;
 f_TAP:= TddRowProperty.Create;
 f_RTFLikeWidth := False;
 f_CellProps := TddCellsPropertyList.Make;
 f_CurColumn := -1;
//#UC END# *51E91BA80051_4FACE1370377_impl*
end;//TddTableRow.Create

function TddTableRow.IsRow: Boolean;
//#UC START# *5268D6C802E0_4FACE1370377_var*
//#UC END# *5268D6C802E0_4FACE1370377_var*
begin
//#UC START# *5268D6C802E0_4FACE1370377_impl*
 Result := True;
//#UC END# *5268D6C802E0_4FACE1370377_impl*
end;//TddTableRow.IsRow

function TddTableRow.GetLastPara: TddDocumentAtom;
//#UC START# *5268DBC503E2_4FACE1370377_var*
//#UC END# *5268DBC503E2_4FACE1370377_var*
begin
//#UC START# *5268DBC503E2_4FACE1370377_impl*
 Result := LastCell.LastTextPara;
//#UC END# *5268DBC503E2_4FACE1370377_impl*
end;//TddTableRow.GetLastPara

procedure TddTableRow.Assign(const aDocAtomObj: Tl3ProtoObject);
//#UC START# *528C8C2F02D9_4FACE1370377_var*
var
 i: Integer;
 l_Cell: TddtableCell;
//#UC END# *528C8C2F02D9_4FACE1370377_var*
begin
//#UC START# *528C8C2F02D9_4FACE1370377_impl*
 if (aDocAtomObj Is TddTableRow) then
 begin
  f_TAP.AssignFrom(TddTableRow(aDocAtomObj).TAP);
  for i := 0 to TddTableRow(aDocAtomObj).f_CellList.Hi do
  begin
   l_Cell := TddTableCell.Create(f_Destination);
   try
    l_Cell.Assign(TddTableRow(aDocAtomObj)[i]);
    f_CellList.Add(l_Cell);
   finally
    FreeAndNil(l_Cell)
   end;
  end; // for i:= 0 to TddTableRow(aDocAtomObj).f_CellList.Hi do
 end // if (aDocAtomObj Is TddTableRow) then
 else
  inherited Assign(aDocAtomObj);
//#UC END# *528C8C2F02D9_4FACE1370377_impl*
end;//TddTableRow.Assign

end.
