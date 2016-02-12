unit evTableCursorPair;
 {* ¬ыделение дл€ таблицы. }

// ћодуль: "w:\common\components\gui\Garant\Everest\evTableCursorPair.pas"
// —тереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evParaListCursorPair
 , nevTools
 , l3Variant
 , nevBase
 , k2Interfaces
;

type
 _DeletingRowCorrector_Parent_ = TevParaListCursorPair;
 {$Include w:\common\components\gui\Garant\Everest\DeletingRowCorrector.imp.pas}
 _CheckWidthInDeletingColumn_Parent_ = _DeletingRowCorrector_;
 {$Include w:\common\components\gui\Garant\Everest\CheckWidthInDeletingColumn.imp.pas}
 TevTableCursorPair = class(_CheckWidthInDeletingColumn_, IevTableRange)
  {* ¬ыделение дл€ таблицы. }
  private
   f_StartOffset: LongInt;
   f_FinishOffset: LongInt;
  private
   function GetRowBlock(const aView: InevView;
    aRow: Tl3Variant;
    aStartOffset: LongInt;
    aFinishOffset: LongInt;
    out theBlock: InevRange): Boolean;
    {* получить блок выделени€ дл€ строки таблицы. }
  protected
   function GetRangeOffsets(out theStartOffset: Integer;
    out theFinishOffset: Integer): Boolean;
    {* возвращает горизонтальные границы диапазона выделени€. }
   function GetRangeBorders(out theStartRow: Integer;
    out theFinishRow: Integer;
    out theStartOffset: Integer;
    out theFinishOffset: Integer): Boolean;
    {* возвращает границы диапазона выделени€. }
   function Offset2Cells(aRow: Tl3Variant;
    aStartOffset: Integer;
    aFinishOffset: Integer;
    out theStartCell: Integer;
    out theFinishCell: Integer): Boolean;
    {* получить индексы дл€ €чеек aRow дл€ смещений (aStartOffset, aFinishOffset). }
   function DoChangeParam(const aView: InevView;
    const aMarker: IevMarker;
    aValue: Integer;
    const anOp: InevOp): Boolean; override;
   function GetParaBlockBordersPrim(const aChildPara: InevPara;
    aPID: LongInt;
    out cParaStart: InevBasePoint;
    out cParaFinish: InevBasePoint): Boolean; override;
   procedure DoStore(const aView: InevView;
    const G: Ik2TagGenerator;
    aFlags: TevStoreFlags); override;
   {$If Defined(evNeedEditableCursors)}
   function DoDelete(const aView: InevView;
    const anOpPack: InevOp = nil;
    aMode: TevClearMode = nevTools.ev_cmAll;
    const aPara: InevPara = nil): Boolean; override;
   {$IfEnd} // Defined(evNeedEditableCursors)
   {$If Defined(k2ForEditor)}
   function GetStartOffset: Integer; override;
   {$IfEnd} // Defined(k2ForEditor)
  public
   procedure DoInit(const aStart: InevBasePoint;
    const aFinish: InevBasePoint;
    aSharp: Boolean); override;
 end;//TevTableCursorPair
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , evOp
 , evInternalInterfaces
 , k2OpMisc
 , evConst
 , l3MinMax
 , l3Base
 , evdInterfaces
 , nevFacade
 , k2Tags
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 , evdTypes
 , l3LongintList
 , SysUtils
 , k2Base
 {$If Defined(k2ForEditor)}
 , evTableCellUtils
 {$IfEnd} // Defined(k2ForEditor)
;

{$Include w:\common\components\gui\Garant\Everest\DeletingRowCorrector.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\CheckWidthInDeletingColumn.imp.pas}

function TevTableCursorPair.GetRowBlock(const aView: InevView;
 aRow: Tl3Variant;
 aStartOffset: LongInt;
 aFinishOffset: LongInt;
 out theBlock: InevRange): Boolean;
 {* получить блок выделени€ дл€ строки таблицы. }
//#UC START# *5108DA2B030A_5108D3850245_var*
var
 l_Start        : InevPoint;
 l_Finish       : InevPoint;
 l_StartColumn  : LongInt;
 l_FinishColumn : LongInt;
 l_Para         : InevPara;
//#UC END# *5108DA2B030A_5108D3850245_var*
begin
//#UC START# *5108DA2B030A_5108D3850245_impl*
 if Offset2Cells(aRow,
                 aStartOffset, aFinishOffset,
                 l_StartColumn, l_FinishColumn) then
 begin
  Result := true;
  if aRow.QT(InevPara, l_Para) then
   try
    l_Start := l_Para.MakePoint;
    try
     l_Start.SetEntryPoint(Succ(l_StartColumn));
     l_Start.Inner.Move(aView, ev_ocTopLeft);
     l_Finish := l_Para.MakePoint;
     try
      l_Finish.SetEntryPoint(Succ(l_FinishColumn));
      l_Finish.Inner.Move(aView, ev_ocBottomRight);
      theBlock := l_Para.Range(l_Start, l_Finish);
     finally
      l_Finish := nil;
     end;//try..finally
    finally
     l_Start := nil;
    end;//try..finally
   finally
    l_Para := nil;
   end;//try..finally
 end//Offset2Cells..
 else
  Result := false;
//#UC END# *5108DA2B030A_5108D3850245_impl*
end;//TevTableCursorPair.GetRowBlock

function TevTableCursorPair.GetRangeOffsets(out theStartOffset: Integer;
 out theFinishOffset: Integer): Boolean;
 {* возвращает горизонтальные границы диапазона выделени€. }
//#UC START# *47C7DB5401D7_5108D3850245_var*
//#UC END# *47C7DB5401D7_5108D3850245_var*
begin
//#UC START# *47C7DB5401D7_5108D3850245_impl*
 Result := True;
 theStartOffset := f_StartOffset;
 theFinishOffset := f_FinishOffset;
//#UC END# *47C7DB5401D7_5108D3850245_impl*
end;//TevTableCursorPair.GetRangeOffsets

function TevTableCursorPair.GetRangeBorders(out theStartRow: Integer;
 out theFinishRow: Integer;
 out theStartOffset: Integer;
 out theFinishOffset: Integer): Boolean;
 {* возвращает границы диапазона выделени€. }
//#UC START# *47C7DB7403D1_5108D3850245_var*
//#UC END# *47C7DB7403D1_5108D3850245_var*
begin
//#UC START# *47C7DB7403D1_5108D3850245_impl*
 Result := True;
 theStartRow := Pred(f_B.rStart);
 theFinishRow := Pred(f_B.rFinish);
 theStartOffset := f_StartOffset;
 theFinishOffset := f_FinishOffset;
//#UC END# *47C7DB7403D1_5108D3850245_impl*
end;//TevTableCursorPair.GetRangeBorders

function TevTableCursorPair.Offset2Cells(aRow: Tl3Variant;
 aStartOffset: Integer;
 aFinishOffset: Integer;
 out theStartCell: Integer;
 out theFinishCell: Integer): Boolean;
 {* получить индексы дл€ €чеек aRow дл€ смещений (aStartOffset, aFinishOffset). }
//#UC START# *47C7DBA00306_5108D3850245_var*
var
 l_Row : InevParaList;  
//#UC END# *47C7DBA00306_5108D3850245_var*
begin
//#UC START# *47C7DBA00306_5108D3850245_impl*
 Result := True;
 if not aRow.QT(InevParaList, l_Row) then
  Assert(False);
 with (l_Row As InevTableRow) do
 begin
  theStartCell := FindCell(aStartOffset, 0);
  theFinishCell := FindCell(aFinishOffset, 0);
 end;//with (l_Row As InevTableRow)
//#UC END# *47C7DBA00306_5108D3850245_impl*
end;//TevTableCursorPair.Offset2Cells

function TevTableCursorPair.DoChangeParam(const aView: InevView;
 const aMarker: IevMarker;
 aValue: Integer;
 const anOp: InevOp): Boolean;
//#UC START# *4A29465701BC_5108D3850245_var*
var
 l_ParamTool : IevChangeParamTool;
//#UC END# *4A29465701BC_5108D3850245_var*
begin
//#UC START# *4A29465701BC_5108D3850245_impl*
 if QT(IevChangeParamTool, l_ParamTool, k2Proc(anOp)) then
  try
   if l_ParamTool.ChangeParam(aMarker, aValue, anOp, true, Pred(f_B.rStart), Pred(f_B.rFinish)) then
    Result := true
   else
    Result := inherited DoChangeParam(aView, aMarker, aValue, anOp);
  finally
   l_ParamTool := nil;
  end//try..finally
 else
  Result := inherited DoChangeParam(aView, aMarker, aValue, anOp);
//#UC END# *4A29465701BC_5108D3850245_impl*
end;//TevTableCursorPair.DoChangeParam

function TevTableCursorPair.GetParaBlockBordersPrim(const aChildPara: InevPara;
 aPID: LongInt;
 out cParaStart: InevBasePoint;
 out cParaFinish: InevBasePoint): Boolean;
//#UC START# *5108D4820232_5108D3850245_var*

 procedure MakeBorder(const aTemplate : InevBasePoint;
                      aBorder         : LongInt;
                      aOffset         : LongInt;
                      out theBorder   : InevBasePoint;
                      aRight          : Boolean);

  procedure lp_ParaBorder;
  var
   l_Border : InevPoint;
   l_PID    : LongInt;
  begin
   l_Border := aChildPara.MakePoint(aTemplate.ParentPoint);
   try
    with l_Border do
    begin
     l_PID := (ParaX.Para[aPID - 1] As InevTableRow).FindCell(aOffset, 0, aRight);
     SetEntryPointPrim(l_PID + 1);
    end;//with l_Border
    theBorder := l_Border;
   finally
    l_Border := nil;
   end;//try..finally
  end;

 begin
  if (aTemplate = nil) then
   theBorder := nil
  else
  if (aPID = aBorder) AND
          ((f_B.rStart = f_B.rFinish) OR Sharp) then
   // - если это f_BS = f_BF - получитс€ недоделанна€ возможность нецелого выделени€ €чеек (всегда)
  begin
   if aTemplate.Obj.PID = aChildPara.PID then
    theBorder := aTemplate
   else
    lp_ParaBorder; //  остыль: http://mdp.garant.ru/pages/viewpage.action?pageId=541102839
  end
  else
   lp_ParaBorder;
 end;

//#UC END# *5108D4820232_5108D3850245_var*
begin
//#UC START# *5108D4820232_5108D3850245_impl*
 Result := (aPID >= f_B.rStart) AND (aPID <= f_B.rFinish);
 if Result then
 begin
  MakeBorder(f_ChildStart, f_B.rStart, f_StartOffset, cParaStart, False);
  MakeBorder(f_ChildFinish, f_B.rFinish, f_FinishOffset, cParaFinish, True);
 end
 else
 begin
  cParaStart := nil;
  cParaFinish := nil;
 end;//Result
//#UC END# *5108D4820232_5108D3850245_impl*
end;//TevTableCursorPair.GetParaBlockBordersPrim

procedure TevTableCursorPair.DoInit(const aStart: InevBasePoint;
 const aFinish: InevBasePoint;
 aSharp: Boolean);
//#UC START# *5108D53B0312_5108D3850245_var*
var
 l_Child : InevBasePoint;
 l_Start : Boolean;
 l_Offset: Integer;
//#UC END# *5108D53B0312_5108D3850245_var*
begin
//#UC START# *5108D53B0312_5108D3850245_impl*
 inherited;
 l_Start := False;
 if (f_ChildStart = nil) then
  f_StartOffset := 0
 else
  with f_ChildStart do
  begin
   l_Child := Inner;
   if (l_Child = nil) then
    f_StartOffset := 0
   else
   begin
    f_StartOffset := f_ChildStart.Inner.Obj.OffsetX + evEpsilon;
    l_Start := f_ChildStart.Obj.PID = 0;
   end;
  end;//with f_ChildStart do
 if f_ChildFinish = nil then
  f_FinishOffset := High(LongInt)
 else                                     
 begin
  with f_ChildFinish do
  begin
   l_Child := Inner;
   if (l_Child = nil) then
    f_FinishOffset := High(LongInt)
   else
    with f_ChildFinish.Inner.Obj^ do
    begin
     if l_Start then
     begin
      l_Offset := OffsetX;
      if (Abs(f_StartOffset - l_Offset) <= evEpsilon) and (f_ChildFinish.AsObject.ChildrenCount > 1) then
       f_FinishOffset := l_Offset + Min(IntA[k2_tiWidth], f_ChildStart.Inner.Obj.AsObject.IntA[k2_tiWidth])
      else
       f_FinishOffset := l_Offset + IntA[k2_tiWidth];
     end // if l_Start then
     else
      f_FinishOffset := OffsetX + IntA[k2_tiWidth];
    end;
  end;//f_ChildFinish.Inner.Obj.Shape
 end;//f_ChildFinish = nil
 if (f_StartOffset > f_FinishOffset) then
  l3Swap(f_FinishOffset, f_StartOffset, SizeOf(f_FinishOffset));
//#UC END# *5108D53B0312_5108D3850245_impl*
end;//TevTableCursorPair.DoInit

procedure TevTableCursorPair.DoStore(const aView: InevView;
 const G: Ik2TagGenerator;
 aFlags: TevStoreFlags);
//#UC START# *5108D5CB0048_5108D3850245_var*
var
 CellBlock : InevRange;
 l_B       : TevPair;
 RowBlock  : InevRange;
//#UC END# *5108D5CB0048_5108D3850245_var*
begin
//#UC START# *5108D5CB0048_5108D3850245_impl*
 if Solid(aView) then
  inherited
 else
 begin
  l_B := Borders;
  if (l_B.rStart < l_B.rFinish) and not (evd_sfOnlyFirstCell in aFlags) then
   inherited // - выделено больше одного р€да
  else 
  begin
   RowBlock := GetChildSel(aView, Pred(l_B.rStart), False);
   try
    l_B := RowBlock.Borders;
    if (l_B.rStart < l_B.rFinish) and not (evd_sfOnlyFirstCell in aFlags) then
     inherited // - выделено больше одной €чейки
    else 
    begin
     CellBlock := RowBlock.GetChildSel(aView, Pred(l_B.rStart), False);
     try
      if CellBlock.Solid(aView) and not (evd_sfOnlyFirstCell in aFlags) then
       inherited
       // - сохран€ем всю €чейку
      else
       CellBlock.AsStorable.Store(aView, G, aFlags + [evd_sfChildrenOnly]);
       // - сохран€ем внутренние параграфы €чейки
     finally
      CellBlock := nil;
     end;//try..finally
    end;
   finally
    RowBlock := nil;
   end;//try..finally
  end;//l_B.rStart < l_B.rFinish
 end;//Solid 
//#UC END# *5108D5CB0048_5108D3850245_impl*
end;//TevTableCursorPair.DoStore

{$If Defined(evNeedEditableCursors)}
function TevTableCursorPair.DoDelete(const aView: InevView;
 const anOpPack: InevOp = nil;
 aMode: TevClearMode = nevTools.ev_cmAll;
 const aPara: InevPara = nil): Boolean;
//#UC START# *5108D66900C9_5108D3850245_var*
var
 l_Rows4Delete  : Tl3LongintList;
 l_DontCorrect  : Boolean;
 l_StartOffset  : LongInt;
 l_FinishOffset : LongInt;

  function DeleteColumns(aRow: Tl3Variant; Index: LongInt): Boolean; far;
  var
   l_Block : InevRange;
   l_Start : InevBasePoint;
   l_Finish: InevBasePoint;
  begin//DeleteColumns
   Result := true;
   if GetRowBlock(aView, aRow.AsObject,
                  l_StartOffset, l_FinishOffset, l_Block) then
    try
     l_Block.GetBorderPoints(l_Start, l_Finish);
     if l_DontCorrect or not Try2CorrectWidth(anOpPack, l_Start, l_Finish) then
      l_Block.Modify.Delete(aView, anOpPack, aMode, aPara);
     if evCanDeleteRow(aRow, True) then
     begin
      if l_Rows4Delete = nil then
       l_Rows4Delete := Tl3LongintList.Make;
      l_Rows4Delete.Add(Index);
     end; // if evCanDeleteRow(aRow) then
    finally
     l_Block := nil;
    end;//try..finally
  end;//DeleteColumns

  function DeleteText(aRow: Tl3Variant; Index: LongInt): Boolean; far;

   function _Delete(const aBlock: InevRange; anIndex: LongInt): Boolean;
   begin//_Delete
    Result := true;
    aBlock.Modify.Delete(aView, anOpPack, ev_cmKeepOne, aPara);
   end;//_Delete

  var
   l_Block  : InevRange;
  begin//DeleteText
   Result := true;
   if GetRowBlock(aView, aRow.AsObject,
                  l_StartOffset, l_FinishOffset, l_Block) then
    try
     l_Block.IterateF(evL2TSA(@_Delete));
    finally
     l_Block := nil;
    end;//try..finally
  end;//DeleteText

var
 i            : Integer;
 l_OnlyCell   : Boolean;
 l_ChildBlock : InevRange;
 l_CellBlock  : InevRange;
 l_RowB       : TevPair;
 l_ColumnB    : TevPair;
 l_CheckRow   : InevPara;
//#UC END# *5108D66900C9_5108D3850245_var*
begin
//#UC START# *5108D66900C9_5108D3850245_impl*
 l_OnlyCell := aMode = ev_cmClearFirstCell;
 l_DontCorrect := aMode <> ev_cmAll;
 aMode := ev_cmAll;
 l_RowB := Borders;
 l_Rows4Delete := nil;
 try
  SetWidth(High(Integer));
  l_ChildBlock := GetChildSel(aView, Pred(l_RowB.rStart), False);
  try
   if l_ChildBlock.Solid(aView) and not l_OnlyCell then
    {-выделена группа строк}
   begin
    if l_RowB.rFinish < ParaX.ParaCount then
     CheckRow(ParaX[l_RowB.rFinish], anOpPack);
    Result := inherited DoDelete(aView, anOpPack, aMode, aPara);
   end
   else
   begin
    l_ColumnB := l_ChildBlock.Borders;
    if ((l_RowB.rStart = l_RowB.rFinish) AND
       (l_ColumnB.rStart = l_ColumnB.rFinish)) or l_OnlyCell then
    begin
     {-выделена одна €чейка}
     l_CellBlock := l_ChildBlock.GetChildSel(aView, Pred(l_ColumnB.rStart), False);
     try
      l_CellBlock.Modify.Delete(aView, anOpPack, ev_cmKeepOne, aPara);
     finally
      l_CellBlock := nil;
     end;{try..finally}
    end//l_RowB.rStart = l_RowB.rFinish..
    else
    begin
     if GetRangeOffsets(l_StartOffset, l_FinishOffset) then
     begin
      if l_FinishOffset = High(Integer) then 
       SetWidth(High(Integer))
      else
       SetWidth(l_FinishOffset - l_StartOffset);
      if (l_RowB.rStart = 1) AND (l_RowB.rFinish = ParaX.ParaCount) then
      begin
       {-выделена группа столбцов}
       IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@DeleteColumns));
       if l_Rows4Delete <> nil then
       begin
        for i := l_Rows4Delete.Count - 1 downto 0 do
         ParaX.DeleteChild(l_Rows4Delete[i], anOpPack);
        FreeAndNil(l_Rows4Delete);
       end; // if l_Rows4Delete <> nil then
      end // if (l_RowB.rStart = 1) AND (l_RowB.rFinish = ParaX.ParaCount) then
      else
       {-выделен блок €чеек}
       IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@DeleteText));
     end;//GetRangeOffsets
    end;//l_StartRow = l_FinishRow
    Result := true;
   end;//ChildBlock.Solid
  finally
   l_ChildBlock := nil;
  end;//try..finally
 finally
  FreeAndNil(l_Rows4Delete);
 end;//try..finally 
//#UC END# *5108D66900C9_5108D3850245_impl*
end;//TevTableCursorPair.DoDelete
{$IfEnd} // Defined(evNeedEditableCursors)

{$If Defined(k2ForEditor)}
function TevTableCursorPair.GetStartOffset: Integer;
//#UC START# *52D50EFA0317_5108D3850245_var*
//#UC END# *52D50EFA0317_5108D3850245_var*
begin
//#UC START# *52D50EFA0317_5108D3850245_impl*
 Result := f_StartOffset;
//#UC END# *52D50EFA0317_5108D3850245_impl*
end;//TevTableCursorPair.GetStartOffset
{$IfEnd} // Defined(k2ForEditor)

{$IfEnd} // Defined(evUseVisibleCursors)
end.
