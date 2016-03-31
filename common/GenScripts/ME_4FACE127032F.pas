unit ddTableCell;

// ������: "w:\common\components\rtl\Garant\dd\ddTableCell.pas"
// ���������: "SimpleClass"
// ������� ������: "TddTableCell" MUID: (4FACE127032F)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddDocumentAtom
 , ddCellProperty
 , ddTextParagraph
 , ddDocumentAtomList
 , k2Interfaces
 , ddTypes
 , ddCustomDestination
 , l3ProtoObject
;

type
 TddTableCell = class(TddDocumentAtom)
  private
   f_ParaList: TddDocumentAtomList;
   f_anIndex: Integer;
   f_Props: TddCellProperty;
  protected
   function pm_GetHi: Integer;
   function pm_GetCount: Integer;
   procedure pm_SetProps(aValue: TddCellProperty);
   function pm_GetLastTextPara: TddTextParagraph;
   function pm_GetItems(anIndex: Integer): TddDocumentAtom;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
  public
   procedure Delete(anIndex: Integer);
   procedure Add(aPara: TddDocumentAtom;
    anAssign2Last: Boolean = False);
   function AddParagraph: TddTextParagraph;
   function LastTableAtom: TddDocumentAtom;
    {* ���������� ��������� �������� ��������� �������. }
   function IsCellEmpty: Boolean;
   procedure Write2Generator(const Generator: Ik2TagGenerator;
    aNeedProcessRow: Boolean;
    LiteVersion: TddLiteVersion); override;
   procedure Clear; override;
   constructor Create(aDetination: TddCustomDestination); override;
   procedure Assign(const aDocAtomObj: Tl3ProtoObject); override;
  public
   property anIndex: Integer
    read f_anIndex
    write f_anIndex;
   property Hi: Integer
    read pm_GetHi;
   property Count: Integer
    read pm_GetCount;
   property Props: TddCellProperty
    read f_Props
    write pm_SetProps;
   property LastTextPara: TddTextParagraph
    read pm_GetLastTextPara;
   property Items[anIndex: Integer]: TddDocumentAtom
    read pm_GetItems;
 end;//TddTableCell

implementation

uses
 l3ImplUses
 , ddTableRow
 , SysUtils
 , ddTable
 , k2Tags
 , evdTypes
 , ddBase
;

function TddTableCell.pm_GetHi: Integer;
//#UC START# *518A2E3702C4_4FACE127032Fget_var*
//#UC END# *518A2E3702C4_4FACE127032Fget_var*
begin
//#UC START# *518A2E3702C4_4FACE127032Fget_impl*
 Result := f_ParaList.Hi;
//#UC END# *518A2E3702C4_4FACE127032Fget_impl*
end;//TddTableCell.pm_GetHi

function TddTableCell.pm_GetCount: Integer;
//#UC START# *518A2E710337_4FACE127032Fget_var*
//#UC END# *518A2E710337_4FACE127032Fget_var*
begin
//#UC START# *518A2E710337_4FACE127032Fget_impl*
  Result := f_ParaList.Count;
//#UC END# *518A2E710337_4FACE127032Fget_impl*
end;//TddTableCell.pm_GetCount

procedure TddTableCell.pm_SetProps(aValue: TddCellProperty);
//#UC START# *518A2EEC00C9_4FACE127032Fset_var*
//#UC END# *518A2EEC00C9_4FACE127032Fset_var*
begin
//#UC START# *518A2EEC00C9_4FACE127032Fset_impl*
 Assert(Self <> nil);
 Assert(f_Props <> nil);
 f_Props.Assign(aValue);
//#UC END# *518A2EEC00C9_4FACE127032Fset_impl*
end;//TddTableCell.pm_SetProps

function TddTableCell.pm_GetLastTextPara: TddTextParagraph;
//#UC START# *518A2F3D013C_4FACE127032Fget_var*
var
 i: Integer;
//#UC END# *518A2F3D013C_4FACE127032Fget_var*
begin
//#UC START# *518A2F3D013C_4FACE127032Fget_impl*
 Result := nil;
 i := Hi;
 while (Result = nil) and (i <> -1) do
 begin
  if Items[i] is TddTextParagraph then
   Result := TddTextParagraph(Items[i])
  else
   Dec(i);
 end;
 if Result = nil then
 begin
  AddParagraph;
  Result := pm_GetLastTextPara;
 end; 
//#UC END# *518A2F3D013C_4FACE127032Fget_impl*
end;//TddTableCell.pm_GetLastTextPara

function TddTableCell.pm_GetItems(anIndex: Integer): TddDocumentAtom;
//#UC START# *518A328E02CF_4FACE127032Fget_var*
//#UC END# *518A328E02CF_4FACE127032Fget_var*
begin
//#UC START# *518A328E02CF_4FACE127032Fget_impl*
 Result := TddDocumentAtom(f_ParaList.Items[anIndex]);
//#UC END# *518A328E02CF_4FACE127032Fget_impl*
end;//TddTableCell.pm_GetItems

procedure TddTableCell.Delete(anIndex: Integer);
//#UC START# *518A3340021D_4FACE127032F_var*
//#UC END# *518A3340021D_4FACE127032F_var*
begin
//#UC START# *518A3340021D_4FACE127032F_impl*
 f_ParaList.Delete(anIndex);
//#UC END# *518A3340021D_4FACE127032F_impl*
end;//TddTableCell.Delete

procedure TddTableCell.Add(aPara: TddDocumentAtom;
 anAssign2Last: Boolean = False);
//#UC START# *518A338F0065_4FACE127032F_var*
//#UC END# *518A338F0065_4FACE127032F_var*
begin
//#UC START# *518A338F0065_4FACE127032F_impl*
 if aPara.IsTextPara then
  TddTextparagraph(aPara).PAP.InTable := True
 else
  if aPara.IsPicture then
  begin
   if anAssign2Last and not f_ParaList.Empty and f_ParaList.Last.IsPicture then
   begin
    f_ParaList.Last.Assign(aPara);
    Exit;
   end; // if aMove and not f_ParaList.Empty and f_ParaList.Last.IsPicture then
   TddTextparagraph(aPara).PAP.InTable := True;
  end; // if aPara.IsPicture then
 f_ParaList.Add(aPara);
//#UC END# *518A338F0065_4FACE127032F_impl*
end;//TddTableCell.Add

function TddTableCell.AddParagraph: TddTextParagraph;
//#UC START# *518A33AE0245_4FACE127032F_var*
var
 l_P: TddTextParagraph;
//#UC END# *518A33AE0245_4FACE127032F_var*
begin
//#UC START# *518A33AE0245_4FACE127032F_impl*
 l_P := TddTextParagraph.Create(f_Destination);
 try
  l_P.PAP.InTable := True;
  Add(l_P);
  Result := TddTextParagraph(f_ParaList.Last);
 finally
  FreeAndNil(l_P);
 end;
//#UC END# *518A33AE0245_4FACE127032F_impl*
end;//TddTableCell.AddParagraph

function TddTableCell.LastTableAtom: TddDocumentAtom;
 {* ���������� ��������� �������� ��������� �������. }
//#UC START# *519333B6005A_4FACE127032F_var*
var
 i: Integer;
//#UC END# *519333B6005A_4FACE127032F_var*
begin
//#UC START# *519333B6005A_4FACE127032F_impl*
 Result := nil;
 i := Hi;
 while (Result = nil) and (i <> -1) do
 begin
  if Items[i] is TddTable then
   Result := Items[i]
  else
   Dec(i);
 end; // while (Result = nil) and (i <> -1) do
//#UC END# *519333B6005A_4FACE127032F_impl*
end;//TddTableCell.LastTableAtom

function TddTableCell.IsCellEmpty: Boolean;
//#UC START# *525D141900DD_4FACE127032F_var*
var
 i        : Integer;
 l_DocAtom: TddDocumentAtom;
//#UC END# *525D141900DD_4FACE127032F_var*
begin
//#UC START# *525D141900DD_4FACE127032F_impl*
 Result := f_ParaList.Count = 0;
 if not Result then
  for i := 0 to f_ParaList.Count - 1 do
  begin
   l_DocAtom := f_ParaList[i];
   Result := l_DocAtom.Empty;
   if not Result then Break;
  end; // for i := 0 to f_ParaList.Count - 1 do
//#UC END# *525D141900DD_4FACE127032F_impl*
end;//TddTableCell.IsCellEmpty

procedure TddTableCell.Write2Generator(const Generator: Ik2TagGenerator;
 aNeedProcessRow: Boolean;
 LiteVersion: TddLiteVersion);
//#UC START# *518A504F00F5_4FACE127032F_var*
const
 cnMaxDiff = 40;
var
 j           : Integer;
 l_Item      : TddDocumentAtom;
 l_Table     : TddTable;
 l_NewWidth  : Integer;
 l_FirstWidth: Integer;
//#UC END# *518A504F00F5_4FACE127032F_var*
begin
//#UC START# *518A504F00F5_4FACE127032F_impl*
 Generator.StartDefaultChild;
 try
  if Props.VMergeFirst then
   Generator.AddIntegerAtom(k2_tiMergeStatus, Ord(ev_msHead))
  else
   if Props.VMerged then
    Generator.AddIntegerAtom(k2_tiMergeStatus, Ord(ev_msContinue));
  if LiteVersion = dd_lvNone then
   if Props.PatternBackColor <> propUndefined then
    Generator.AddIntegerAtom(k2_tiBackColor, Props.PatternBackColor);
  Generator.AddIntegerAtom(k2_tiWidth, Props.CellOffset);
  if LiteVersion = dd_lvNone then
  begin
   Generator.AddIntegerAtom(k2_tiLeftIndent, Props.LeftPad);
   Generator.AddIntegerAtom(k2_tiRightIndent, Props.RightPad);
   Generator.AddIntegerAtom(k2_tiSpaceBefore, Props.TopPad);
   Generator.AddIntegerAtom(k2_tiSpaceAfter, Props.BottomPad);
  end; // if not LiteVersion then
  Props.Border.Write2Generator(Generator);
  Generator.AddIntegerAtom(k2_tiVerticalAligment, Ord(Props.CellJust));
  if not Props.VMerged then
  begin
   if Count = 0 then
    AddParagraph;
   for j := 0 to Hi do
   begin
    l_Item := Items[j];
    if l_Item.IsTable then
    begin
     l_NewWidth := Props.CellOffset - Props.LeftPad - Props.RightPad;
     if l_NewWidth < (ddGetMinimalCellWidth div 2) then Continue;
     l_Table := TddTable(l_Item);
     l_FirstWidth := l_Table.GetFirstRowWidth;
     if (l_FirstWidth div l_NewWidth) > cnMaxDiff then Continue;
     l_Table.AdjustWidth(l_NewWidth);
    end; // if (l_Item.AtomType = dd_docTable) then
    l_Item.Write2Generator(Generator, aNeedProcessRow, LiteVersion);
   end; // for j := 0 to Hi do
  end; // if not Props.VMerged then
 finally
  Generator.Finish;
 end;
//#UC END# *518A504F00F5_4FACE127032F_impl*
end;//TddTableCell.Write2Generator

procedure TddTableCell.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4FACE127032F_var*
//#UC END# *479731C50290_4FACE127032F_var*
begin
//#UC START# *479731C50290_4FACE127032F_impl*
 FreeAndNil(f_Props);
 FreeAndNil(f_ParaList);
 inherited;                                                                                 
//#UC END# *479731C50290_4FACE127032F_impl*
end;//TddTableCell.Cleanup

procedure TddTableCell.Clear;
//#UC START# *518A48F500CF_4FACE127032F_var*
//#UC END# *518A48F500CF_4FACE127032F_var*
begin
//#UC START# *518A48F500CF_4FACE127032F_impl*
 f_paraList.Clear;
 f_Props.Clear;
 Closed:= False;
//#UC END# *518A48F500CF_4FACE127032F_impl*
end;//TddTableCell.Clear

constructor TddTableCell.Create(aDetination: TddCustomDestination);
//#UC START# *51E91BA80051_4FACE127032F_var*
var
 l_ClearBorder: TddClearBoder;
//#UC END# *51E91BA80051_4FACE127032F_var*
begin
//#UC START# *51E91BA80051_4FACE127032F_impl*
 inherited Create(aDetination);
 f_ParaList := TddDocumentAtomList.Make;
 if aDetination = nil then
  l_ClearBorder := dd_cbClearFrame
 else
  l_ClearBorder := aDetination.GetClearBorderType;
 f_Props := TddCellProperty.Create(l_ClearBorder);
//#UC END# *51E91BA80051_4FACE127032F_impl*
end;//TddTableCell.Create

procedure TddTableCell.Assign(const aDocAtomObj: Tl3ProtoObject);
//#UC START# *528C8C2F02D9_4FACE127032F_var*
//#UC END# *528C8C2F02D9_4FACE127032F_var*
begin
//#UC START# *528C8C2F02D9_4FACE127032F_impl*
 if (aDocAtomObj Is TddTableCell) then
 begin
  f_ParaList.Assign(TddTableCell(aDocAtomObj).f_ParaList);
  f_Props.Assign(TddTableCell(aDocAtomObj).Props);
 end // if (Source Is TddTableCell) then
 else
  inherited Assign(aDocAtomObj);
//#UC END# *528C8C2F02D9_4FACE127032F_impl*
end;//TddTableCell.Assign

end.
