unit evTableCursor;
 {* Курсор для таблицы. }

// Модуль: "w:\common\components\gui\Garant\Everest\evTableCursor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevTableCursor" MUID: (4EF9B84C0137)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evTableCursorPrim
 , nevTools
 , nevBase
;

type
 TevTableCursor = class(TevTableCursorPrim)
  {* Курсор для таблицы. }
  private
   f_Offset: LongInt;
    {* Запомненное смещение курсора в таблице. }
   f_Width: LongInt;
    {* Запомненная ширина ячейки. }
   f_InnerPID: Integer;
    {* Закешированный PID дочерней точки для использования после изменения. }
   f_IgnoreSetX: Boolean;
    {* Не использовать установку SetX. }
  private
   function CorrectPosition(const aView: InevView;
    aStart: Boolean): Boolean;
    {* Корректируем позицию. http://mdp.garant.ru/pages/viewpage.action?pageId=89096655&focusedCommentId=119474205#comment-119474205 }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   function DoMovePrim(const aView: InevView;
    aCode: Integer;
    const anOp: InevOp;
    aCount: Integer): TnevMoveResult; override;
   procedure DoAssignPointInt(const aView: InevView;
    const aPoint: InevBasePoint); override;
   function CanRedraw: Boolean; override;
    {* Можно ли перисовывать, чтобы найти правильную мапу. }
   function NeedGotoHidden(aCode: Integer;
    const aFI: TnevFormatInfoPrim): Boolean; override;
    {* Нужно ли переходить на невидимую строку. }
   function CheckFirst(aChildPID: Integer): Boolean; override;
   procedure DoCorrectMoveRight(const aView: InevView;
    const aPoint: InevBasePoint;
    const anOp: InevOp); override;
 end;//TevTableCursor
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , evOp
 , evdTypes
 , SysUtils
 , k2Tags
 //#UC START# *4EF9B84C0137impl_uses*
 //#UC END# *4EF9B84C0137impl_uses*
;

function TevTableCursor.CorrectPosition(const aView: InevView;
 aStart: Boolean): Boolean;
 {* Корректируем позицию. http://mdp.garant.ru/pages/viewpage.action?pageId=89096655&focusedCommentId=119474205#comment-119474205 }
//#UC START# *4F50B310020B_4EF9B84C0137_var*
// Обсуждение: http://mdp.garant.ru/pages/viewpage.action?pageId=89096655&focusedCommentId=119474205#comment-119474205
var
 l_NewPoint     : InevBasePoint;
 l_NewTableCell : InevPara;
 l_ChildPoint   : InevPoint;
 l_TableRow     : InevParaList;
 l_ChildCursor  : InevBasePoint;
//#UC END# *4F50B310020B_4EF9B84C0137_var*
begin
//#UC START# *4F50B310020B_4EF9B84C0137_impl*
 Result := False;
 l_ChildCursor := Self.GetInner;
 if (l_ChildCursor = nil) then 
 begin
  Result := True;
  Exit;
 end // if (l_ChildCursor = nil) then
 else  
  l_TableRow := l_ChildCursor.Obj.AsPara.AsList;
 l_ChildCursor := l_ChildCursor.Inner;
 if (l_ChildCursor = nil) then 
 begin
  Result := True;
  Exit;
 end; //if (l_ChildCursor = nil) then
 if f_Offset = High(LongInt) then
  l_NewTableCell := l_TableRow.Para[l_TableRow.ParaCount - 1]
 else
  l_NewTableCell := l_TableRow.Para[(l_TableRow as InevTableRow).FindCell(f_Offset, f_Width, True)];
 if (l_NewTableCell <> nil) then
  if (l_NewTableCell.AsObject.IntA[k2_tiMergeStatus] <> Ord(ev_msContinue)) then
  begin
   l_NewPoint := l_NewTableCell.MakePoint;
   if aStart then
   begin
    l_ChildPoint := l_NewTableCell.AsList.Para[l_NewTableCell.AsList.ParaCount - 1].MakePoint;
    if (l_ChildPoint <> nil) then
     l_ChildPoint.SetAtEnd(aView, True);
   end//aStart
   else
   begin
    l_ChildPoint := l_NewTableCell.AsList.Para[0].MakePoint;
    if (l_ChildPoint <> nil) then
     l_ChildPoint.SetAtStart(aView, True);
   end;//aStart
   l_NewPoint.Inner := l_ChildPoint;
   if (l_NewPoint <> nil) then
    Self.GetInner.AssignPoint(aView, l_NewPoint.PointToParent);
   Result := True;
  end;//l_NewTableCell.IntA[k2_tiMergeStatus] <> Ord(ev_msContinue)
//#UC END# *4F50B310020B_4EF9B84C0137_impl*
end;//TevTableCursor.CorrectPosition

procedure TevTableCursor.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4EF9B84C0137_var*
//#UC END# *479731C50290_4EF9B84C0137_var*
begin
//#UC START# *479731C50290_4EF9B84C0137_impl*
 f_InnerPID := 0;
  f_IgnoreSetX := False;
 inherited;
//#UC END# *479731C50290_4EF9B84C0137_impl*
end;//TevTableCursor.Cleanup

procedure TevTableCursor.InitFields;
//#UC START# *47A042E100E2_4EF9B84C0137_var*
//#UC END# *47A042E100E2_4EF9B84C0137_var*
begin
//#UC START# *47A042E100E2_4EF9B84C0137_impl*
 f_InnerPID := 0;
 f_IgnoreSetX := False;
 inherited;
//#UC END# *47A042E100E2_4EF9B84C0137_impl*
end;//TevTableCursor.InitFields

function TevTableCursor.DoMovePrim(const aView: InevView;
 aCode: Integer;
 const anOp: InevOp;
 aCount: Integer): TnevMoveResult;
//#UC START# *49E31657038E_4EF9B84C0137_var*
var
 l_ChildCursor : InevBasePoint;

 function lp_IsNotContinueCell: Boolean;
 begin
  Result := True;
  l_ChildCursor := Self.GetInner;
  if (l_ChildCursor <> nil) then
  begin
   l_ChildCursor := l_ChildCursor.Inner;
   if (l_ChildCursor <> nil) then
    Result := (l_ChildCursor.Obj.AsObject.IntA[k2_tiMergeStatus] <> Ord(ev_msContinue));
  end; // if (l_ChildCursor <> nil) then
 end;

var
 l_MostInn       : InevBasePoint;
 l_Cell          : InevTableCell;
 l_OutOfTable    : Boolean;
 l_CursorContext : IevCursorContext;
//#UC END# *49E31657038E_4EF9B84C0137_var*
begin
//#UC START# *49E31657038E_4EF9B84C0137_impl*
 f_IgnoreSetX := False;
 if (aCode = ev_ocParaUp) or (aCode = ev_ocParaDown) or (aCode = ev_ocParaDownWithEmptyRow) then
 begin
  l_ChildCursor := Self.GetInner;
  if (l_ChildCursor <> nil) then
  begin
   l_ChildCursor := l_ChildCursor.Inner;
   if (l_ChildCursor <> nil) then
    with l_ChildCursor.Obj^ do
    begin
     f_Offset := OffsetX;
     f_Width := IntA[k2_tiWidth];
    end;//l_ChildCursor.Obj
  end;//if (aCode = ev_ocParaUp) or (aCode = ev_ocParaDown) then
 end//if (aCode = ev_ocParaUp) or (aCode = ev_ocParaDown) then
 else
  if (aCode = ev_ocBottomRight) then
  begin
   f_Offset := High(LongInt);
   f_Width := High(LongInt);
  end;
 l_OutOfTable := (aCode = ev_ocBottomRight) and not Self.HasInner;
 Result := inherited DoMovePrim(aView, aCode, anOp, aCount);
 case aCode of
  ev_ocBottomRight: if l_OutOfTable then
                    begin
                     l_ChildCursor := Self.GetInner;
                     if (l_ChildCursor = nil) then Exit; 
                     l_ChildCursor.SetEntryPoint(0);
                     if (Result = ev_dcDoneOk) then
                      if CorrectPosition(aView, True) then Exit;
                     Result := DoMove(aView, ev_ocParaUp, anOp, aCount); 
                    end; // if l_OutOfTable then
  ev_ocParaUp,
  ev_ocParaDown,
  ev_ocParaDownWithEmptyRow :
  begin
   f_IgnoreSetX := True;
   while (Result = ev_dcDoneOk) do
   begin
    if CorrectPosition(aView, aCode = ev_ocParaUp) then
    begin
     f_IgnoreSetX := False;
     Exit;
    end; // if CorrectPosition(aView, aCode = ev_ocParaUp) then
    Result := inherited DoMovePrim(aView, aCode, anOp, aCount);
   end;//while (Result = ev_dcDoneOk)
  end;//ev_ocParaUp..
  ev_ocParaLeft,
  ev_ocParaRight :
  begin
   if (Result <> ev_dcDoneOk) then Exit;
   if lp_IsNotContinueCell then Exit;
   if HasInner then
    f_InnerPID := GetInner.Obj.PID
   else
    f_InnerPID := 0;
   Result := DoMove(aView, ev_ocParaUp, anOp, aCount);
  end;//ev_ocParaLeft..
  ev_ocCharRight, 
  ev_ocWordRight : 
  begin
   if (Result <> ev_dcDoneOk) then Exit;
   l_MostInn := Self.pm_GetMostInner;
   if (l_MostInn <> nil) and l_MostInn.AtStart then
   begin
    if lp_IsNotContinueCell then Exit;
    Result := DoMove(aView, ev_ocParaUp, anOp, aCount);
    l_MostInn := Self.pm_GetMostInner;
    if (l_MostInn <> nil) then
     l_MostInn.SetAtStart(aView, True);
   end;//if (l_MostInn <> nil) and l_MostInn.AtEnd then
  end;//ev_ocCharLeft, ev_ocWordLeft 
  ev_ocCharLeft, 
  ev_ocWordLeft  : 
  begin
   if (Result <> ev_dcDoneOk) then Exit;
   l_MostInn := Self.pm_GetMostInner;
   if (l_MostInn <> nil) and l_MostInn.AtEnd(aView) then
   begin
    if lp_IsNotContinueCell then Exit;
    Result := DoMove(aView, ev_ocParaUp, anOp, aCount);
   end;//if (l_MostInn <> nil) and l_MostInn.AtEnd then
  end;//ev_ocCharLeft, ev_ocWordLeft
  ev_ocNextParaTopLeft:
  begin
   if (Result <> ev_dcDoneOk) then Exit;
   if lp_IsNotContinueCell then Exit;
   l_ChildCursor.AsObject.QT(InevTableCell, l_Cell);
   l_Cell := l_Cell.GetMergeHead;
   if l_Cell = nil then Exit;
   Supports(anOp, IevCursorContext, l_CursorContext);
   SetEntryPoint(l_Cell.OwnerPara.PID + 1, l_CursorContext);
   GetInner.Move(aView, ev_ocTopLeft, anOp);
  end;
 end;//case aCode
//#UC END# *49E31657038E_4EF9B84C0137_impl*
end;//TevTableCursor.DoMovePrim

procedure TevTableCursor.DoAssignPointInt(const aView: InevView;
 const aPoint: InevBasePoint);
//#UC START# *4BE284D00262_4EF9B84C0137_var*
var
 l_Inner : InevBasePoint;
 l_Cell  : InevBasePoint;
//#UC END# *4BE284D00262_4EF9B84C0137_var*
begin
//#UC START# *4BE284D00262_4EF9B84C0137_impl*
 l_Inner := aPoint.Inner;
 if (l_Inner <> nil) and l_Inner.HasBaseLine then
 begin
  l_Cell := l_Inner.InnerForChildThatNotAfterEnd(aView.FormatInfoByPoint(l_Inner), nev_itNone);
  if (l_Cell <> nil) then
  begin
   if not l_Cell.AsObject.Owner.IsSame(l_Inner.Obj^.AsObject) or (l_Inner.Inner = nil) then
   begin
    SetEntryPointPrim(l_Cell.Obj^.OwnerObj.PID);
    l_Inner := l_Cell.Obj^.OwnerObj.MakePoint(Self);
    SetInner(l_Inner);
    l_Inner.Inner := l_Cell.ClonePoint(aView).AsCursor(aView);
   end // if not l_Cell.Owner.IsSame(l_Inner.Obj^) then
   else
    inherited DoAssignPointInt(aView, aPoint);
  end // if (l_Cell <> nil) then
  else
   inherited DoAssignPointInt(aView, aPoint);
 end  // if (l_Inner <> nil) and l_Inner.HasBaseLine then
 else
  inherited DoAssignPointInt(aView, aPoint);
//#UC END# *4BE284D00262_4EF9B84C0137_impl*
end;//TevTableCursor.DoAssignPointInt

function TevTableCursor.CanRedraw: Boolean;
 {* Можно ли перисовывать, чтобы найти правильную мапу. }
//#UC START# *4C495DAA024B_4EF9B84C0137_var*
//#UC END# *4C495DAA024B_4EF9B84C0137_var*
begin
//#UC START# *4C495DAA024B_4EF9B84C0137_impl*
 Result := not f_IgnoreSetX;
//#UC END# *4C495DAA024B_4EF9B84C0137_impl*
end;//TevTableCursor.CanRedraw

function TevTableCursor.NeedGotoHidden(aCode: Integer;
 const aFI: TnevFormatInfoPrim): Boolean;
 {* Нужно ли переходить на невидимую строку. }
//#UC START# *4F50B34C0260_4EF9B84C0137_var*
//#UC END# *4F50B34C0260_4EF9B84C0137_var*
begin
//#UC START# *4F50B34C0260_4EF9B84C0137_impl*
 if aCode = ev_ocParaDownWithEmptyRow then
  Result := aFI.Obj.AsObject.ChildrenCount = 0
 else
  Result := inherited NeedGotoHidden(aCode, aFI);
//#UC END# *4F50B34C0260_4EF9B84C0137_impl*
end;//TevTableCursor.NeedGotoHidden

function TevTableCursor.CheckFirst(aChildPID: Integer): Boolean;
//#UC START# *4FFC353A03C4_4EF9B84C0137_var*
//#UC END# *4FFC353A03C4_4EF9B84C0137_var*
begin
//#UC START# *4FFC353A03C4_4EF9B84C0137_impl*
 Result := True;
//#UC END# *4FFC353A03C4_4EF9B84C0137_impl*
end;//TevTableCursor.CheckFirst

procedure TevTableCursor.DoCorrectMoveRight(const aView: InevView;
 const aPoint: InevBasePoint;
 const anOp: InevOp);
//#UC START# *50DAB0190074_4EF9B84C0137_var*
var
 l_Index: Integer;
 l_Point: InevBasePoint;
 l_Start: Integer;
//#UC END# *50DAB0190074_4EF9B84C0137_var*
begin
//#UC START# *50DAB0190074_4EF9B84C0137_impl*
 if (f_InnerPID > 0) and (aPoint.AsObject.IntA[k2_tiMergeStatus] = Ord(ev_msNone)) then
 begin
  l_Start := aPoint.ParentPoint.Obj.PID + 1;
  l_Point := aPoint;
  for l_Index := l_Start to f_InnerPID do
  begin
   if l_Point.AsObject.IntA[k2_tiMergeStatus] <> Ord(ev_msNone) then Break;
   l_Point.Move(aView, ev_ocParaDown, anOp);
   l_Point := Self.GetInner;
   l_Point := l_Point.Inner;
  end; // for l_Index := l_Start to f_InnerPID do
  f_InnerPID := 0;
 end; // if f_InnerPID > 0 then
//#UC END# *50DAB0190074_4EF9B84C0137_impl*
end;//TevTableCursor.DoCorrectMoveRight
{$IfEnd} // Defined(evUseVisibleCursors)

end.
