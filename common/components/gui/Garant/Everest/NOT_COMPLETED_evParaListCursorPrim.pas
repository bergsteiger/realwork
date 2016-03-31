unit NOT_COMPLETED_evParaListCursorPrim;
 {* Курсор для списка параграфов }

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_evParaListCursorPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevParaListCursorPrim" MUID: (4A3A237A01C0)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evParaCursor
 , nevTools
 , nevBase
 , l3Variant
 , l3IID
 , k2Interfaces
 , l3Core
 , l3Interfaces
 , nevParaListAnchorModifyTypes
;

type
 PevParaListCursor = ^TevParaListCursorPrim;

 _nevParaListTool_Parent_ = TevParaCursor;
 {$Include w:\common\components\gui\Garant\Everest\new\nevParaListTool.imp.pas}
 _nevParaListViewBounds_Parent_ = _nevParaListTool_;
 {$Include w:\common\components\gui\Garant\Everest\nevParaListViewBounds.imp.pas}
 _nevParaListAnchorModify_Parent_ = _nevParaListViewBounds_;
 {$Include w:\common\components\gui\Garant\Everest\nevParaListAnchorModify.imp.pas}
 TevParaListCursorPrim = class(_nevParaListAnchorModify_)
  {* Курсор для списка параграфов }
  private
   f_Child: InevBasePoint;
  protected
   procedure ParaChanged;
   function NeedGotoHidden(aCode: Integer;
    const aFI: TnevFormatInfoPrim): Boolean; virtual;
    {* Нужно ли переходить на невидимую строку. }
   function CheckFirst(aChildPID: Integer): Boolean; virtual;
   function CanRedraw: Boolean; virtual;
    {* Можно ли перисовывать, чтобы найти правильную мапу. }
   procedure SetPID(aValue: Integer); override;
   function GetPID: Integer; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoFire(const anEvent: Tk2Event;
    const anOp: Ik2Op); override;
   procedure SetInner(const aValue: InevBasePoint); override;
   function DoJoinWith(const aView: InevView;
    aSecondPara: Tl3Variant;
    const anOp: InevOp;
    MoveSubs: Boolean): Integer; override;
   function DoSplit(const aView: InevView;
    aFlags: TnevInsertStringFlags;
    const anOp: InevOp): Il3TagRef; override;
   function DoJoinWithNext(const aView: InevView;
    const anOp: InevOp): Boolean; override;
   procedure DoSetEntryPoint(aValue: Integer;
    const anOp: IevCursorContext = nil); override;
   function DoMovePrim(const aView: InevView;
    aCode: Integer;
    const anOp: InevOp;
    aCount: Integer): TnevMoveResult; override;
   function DoProcessMessage(const aView: InevControlView;
    var aMessage: TMessage;
    aTime: Cardinal): Boolean; override;
   function GetNeedWindowsCaret: Boolean; override;
   function GetAtStart: Boolean; override;
   function GetAtEnd(const aView: InevView): Boolean; override;
   procedure DoCheckPos(const anOp: InevOp); override;
   function GetVertPosition(const aView: InevView;
    aMap: TnevFormatInfoPrim): TnevParaIndex; override;
   function GetDeltaX(const aView: InevView;
    const aMap: InevMap): Integer; override;
   function DoCompare(const aPoint: InevBasePoint): Integer; override;
   function GetInner: InevBasePoint; override;
   function DoGetBlockLength: Integer; override;
   function DoChangeParam(const aView: InevView;
    const aMarker: IevMarker;
    aValue: Integer;
    const anOp: InevOp): Boolean; override;
   function DoDeleteHyperlink(const anOpPack: InevOp): Boolean; override;
   function DoInsertBreak(const aView: InevView;
    aDrawLines: Boolean;
    const anOp: InevOp): Boolean; override;
   function DoAddIndentMarker(const aView: InevView;
    aValue: Integer;
    const anOpPack: InevOp): Boolean; override;
   function DoDeleteIndentMarker(const aView: InevView;
    const anOpPack: InevOp): Boolean; override;
   function DoInsertString(const aView: InevView;
    const aString: Il3CString;
    const anOp: InevOp;
    InsertMode: Boolean;
    aFlags: TnevInsertStringFlags): Boolean; override;
   function DoDeleteString(const aView: InevView;
    aCount: Integer;
    const anOp: InevOp;
    aFlags: TnevInsertStringFlags): Boolean; override;
   function DoSetAtom(const aView: InevView;
    anIndex: Cardinal;
    pSource: Tl3Variant;
    const anOp: InevOp): Boolean; override;
   function DoDeleteChar(const aView: InevView;
    aDrawLines: Boolean;
    const anOp: InevOp): Boolean; override;
   function pm_GetHasInner: Boolean; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   function DoPartiallyVisible(const aView: InevView;
    const aPoint: InevBasePoint;
    aMap: TnevFormatInfoPrim): Boolean; override;
  public
   procedure OffsetPID(Delta: Integer;
    const Context: InevOp);
   procedure ChangePointByPara(const aView: InevView;
    const anOpPack: InevOp;
    const aPara: InevPara); virtual;
 end;//TevParaListCursorPrim
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , k2TagGen
 , nevNavigation
 , evOp
 , nevFacade
 , Block_Const
 , Para_Const
 , ParaList_Const
 , evCursorConst
 , k2Base
 , k2Tags
 , l3Units
 {$If Defined(k2ForEditor)}
 , evCursorTools
 {$IfEnd} // Defined(k2ForEditor)
 , ControlPara_Const
 , SysUtils
 , l3MinMax
 , Table_Const
;

type _Instance_R_ = TevParaListCursorPrim;

{$Include w:\common\components\gui\Garant\Everest\new\nevParaListTool.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\nevParaListViewBounds.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\nevParaListAnchorModify.imp.pas}

procedure TevParaListCursorPrim.OffsetPID(Delta: Integer;
 const Context: InevOp);
//#UC START# *4A3A37E003BB_4A3A237A01C0_var*
var
 l_CursorContext: IevCursorContext;

 procedure DoOffset;
 begin//DoOffset
  SetEntryPointPrim(Position + Delta, l_CursorContext);
 end;//DoOffset
                                                                 
var
 l_PID : Integer;
//#UC END# *4A3A37E003BB_4A3A237A01C0_var*
begin
//#UC START# *4A3A37E003BB_4A3A237A01C0_impl*
 Supports(Context, IevCursorContext, l_CursorContext);
 if HasInner then
 begin
  l_PID := Self.GetInner.Obj.PID;
  if (l_PID < 0) then
  // - учитываем что дочерний парараф мог быть и удалён, значит нельзя просто так сдвигать
   SetEntryPoint(Position + Delta, l_CursorContext)
  else
   if CheckFirst(l_PID) then
    SetEntryPoint(Position + Delta, l_CursorContext)
   else
    DoOffset;
 end//HasInner
 else
  DoOffset;
 try
  Assert(not HasInner OR
         (
          ((Self.GetInner.Obj.PID = Pred(Position)) AND
                           // ^ - тут нельзя использовать l_PID, т.к. он мог и поменяться
           (Self.GetInner.Obj.AsObject.Box.IsSame(ParaX.ToList.Obj[Pred(Position)].AsObject)))
         ));
 except
  SetEntryPoint(Position + Delta, l_CursorContext);
  // http://mdp.garant.ru/pages/viewpage.action?pageId=265391680
  // что-то с ИСКРИВЛЕНИЕМ ПРОСТРАНСТВА пошло поперёк борозды
  {$IF Defined(InsiderTest) and Defined(Archi)}
  raise;
  {$IFEND}
 end;//try..except
 ParaChanged;
 if HasInner then Refresh;
//#UC END# *4A3A37E003BB_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.OffsetPID

procedure TevParaListCursorPrim.ParaChanged;
var l_Listener: InevPointListener;
//#UC START# *4A3A39CA022C_4A3A237A01C0_var*
//#UC END# *4A3A39CA022C_4A3A237A01C0_var*
begin
//#UC START# *4A3A39CA022C_4A3A237A01C0_impl*
 l_Listener := pm_GetListener;
 if (l_Listener <> nil) then
 begin
  l_Listener.ParaChanged(Self);
  if not HasInner then
   Refresh;
 end;//l_Listener <> nil
//#UC END# *4A3A39CA022C_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.ParaChanged

function TevParaListCursorPrim.NeedGotoHidden(aCode: Integer;
 const aFI: TnevFormatInfoPrim): Boolean;
 {* Нужно ли переходить на невидимую строку. }
//#UC START# *4F50B34C0260_4A3A237A01C0_var*
//#UC END# *4F50B34C0260_4A3A237A01C0_var*
begin
//#UC START# *4F50B34C0260_4A3A237A01C0_impl*
 Result := False;
//#UC END# *4F50B34C0260_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.NeedGotoHidden

function TevParaListCursorPrim.CheckFirst(aChildPID: Integer): Boolean;
//#UC START# *4FFC353A03C4_4A3A237A01C0_var*
//#UC END# *4FFC353A03C4_4A3A237A01C0_var*
begin
//#UC START# *4FFC353A03C4_4A3A237A01C0_impl*
 Result := False;
//#UC END# *4FFC353A03C4_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.CheckFirst

function TevParaListCursorPrim.CanRedraw: Boolean;
 {* Можно ли перисовывать, чтобы найти правильную мапу. }
//#UC START# *4C495DAA024B_4A3A237A01C0_var*
//#UC END# *4C495DAA024B_4A3A237A01C0_var*
begin
//#UC START# *4C495DAA024B_4A3A237A01C0_impl*
 Result := True;
//#UC END# *4C495DAA024B_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.CanRedraw

procedure TevParaListCursorPrim.ChangePointByPara(const aView: InevView;
 const anOpPack: InevOp;
 const aPara: InevPara);
//#UC START# *4D5D161A030C_4A3A237A01C0_var*
//#UC END# *4D5D161A030C_4A3A237A01C0_var*
begin
//#UC START# *4D5D161A030C_4A3A237A01C0_impl*
//#UC END# *4D5D161A030C_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.ChangePointByPara

procedure TevParaListCursorPrim.SetPID(aValue: Integer);
//#UC START# *4B1D16510174_4A3A237A01C0_var*
//#UC END# *4B1D16510174_4A3A237A01C0_var*
begin
//#UC START# *4B1D16510174_4A3A237A01C0_impl*
 SetEntryPoint(aValue + 1);
//#UC END# *4B1D16510174_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.SetPID

function TevParaListCursorPrim.GetPID: Integer;
//#UC START# *4B1D1957015A_4A3A237A01C0_var*
//#UC END# *4B1D1957015A_4A3A237A01C0_var*
begin
//#UC START# *4B1D1957015A_4A3A237A01C0_impl*
 Result := Position - 1;
//#UC END# *4B1D1957015A_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.GetPID

procedure TevParaListCursorPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A3A237A01C0_var*
//#UC END# *479731C50290_4A3A237A01C0_var*
begin
//#UC START# *479731C50290_4A3A237A01C0_impl*
 if (f_Child <> nil) then
  f_Child.Outer := nil;
 f_Child := nil;
 inherited;
//#UC END# *479731C50290_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.Cleanup

procedure TevParaListCursorPrim.DoFire(const anEvent: Tk2Event;
 const anOp: Ik2Op);
//#UC START# *48CF73CE00B5_4A3A237A01C0_var*
var
 l_PID : Integer;
 l_PC  : Integer;  
//#UC END# *48CF73CE00B5_4A3A237A01C0_var*
begin
//#UC START# *48CF73CE00B5_4A3A237A01C0_impl*
 inherited;
 if (anOp = nil) OR not anOp.InUndo then
 // - т.к. никогда при Undo курсоры не модифицировались (они сами сохраняются)
  Case anEvent.ID of
   k2_eidChildrenInserted :
   begin
    if (anEvent.Len > 0) then
    begin
     l_PID := Position;                          
     if (l_PID <= 0) then
     begin
      SetEntryPoint(1, anOp);
      Self.GetInner.Move(nil, ev_ocTopLeft);
      // -шаманство для формирования цепочки детей
     end//l_PID <= 0
     else
     begin
      if (anEvent.Total = nev_piLast) then
       l_PC := ParaX.ParaCount
      else
       l_PC := anEvent.Total;
      if (l_PID > l_PC) then                                      
      begin
       SetEntryPoint(l_PC, anOp);
       Self.GetInner.Move(nil, ev_ocBottomRight);
       // -шаманство для формирования цепочки детей
      end//l_PID > l_PC
      else
      if (l_PID > anEvent.Point) then
      // - нестрогая проверка - т.к. посылается настоящий индекс, а не курсорный - который + 1
      {$IFNDEF Nemesis}
      //if not ((anEvent.Point = 0) and HasInner and GetInner.IsKindOf(k2_typBlock)) then // Вставлили блок, сформировали цепочку детей - позиция поменялась.
      // Закомментировано: http://mdp.garant.ru/pages/viewpage.action?pageId=447392400  
      {$ENDIF Nemesis}
       OffsetPID(+anEvent.Len, anOp);
     end;//l_PID <= 0
    end;//anEvent.Len > 0
   end;//k2_eidChildrenInserted
   k2_eidChildrenDeleted:
   begin
    l_PID := Pred(Position);
    if (anEvent.Point = l_PID) then
    begin
     if (anEvent.Total = nev_piLast) then
      l_PC := ParaX.ParaCount
     else
      l_PC := anEvent.Total;
     if (l_PID + 1 < l_PC) then
     begin
      Inc(l_PID);
      SetEntryPoint(Succ(l_PID), anOp);
      Self.GetInner.Move(nil, ev_ocTopLeft);
      // -шаманство для формирования цепочки детей
     end//l_PID + 1 < l_PC
     else
     begin
      Dec(l_PID);
      SetEntryPoint(Succ(l_PID), anOp);
      Self.GetInner.Move(nil, ev_ocBottomRight);
      // -шаманство для формирования цепочки детей
     end;//l_PID + 1 < l_PC
    end;//anEvent.Point = l_PID
   end;//k2_eidChildrenDeleted
  end;//Case anEvent.ID
//#UC END# *48CF73CE00B5_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoFire

procedure TevParaListCursorPrim.SetInner(const aValue: InevBasePoint);
//#UC START# *49DE40D30260_4A3A237A01C0_var*
var
 l_PID     : TnevParaIndex;
 l_Prev    : InevObject;
 l_Inn   : InevBasePoint;
 l_Listener : InevPointListener;
//#UC END# *49DE40D30260_4A3A237A01C0_var*
begin
//#UC START# *49DE40D30260_4A3A237A01C0_impl*
 if (f_Child <> aValue) then
 begin
  l_Listener := pm_GetListener;
  if (l_Listener <> nil) then
  begin
   if (f_Child = nil) then
    l_Prev := nev.NullPara
   else
   begin
    l_Inn := f_Child.MostInner;
    if (l_Inn = nil) then
     l_Prev := nev.NullPara
    else
     with l_Inn do
     begin
      l_Prev := Obj^;
      if NeedWindowsCaret AND not l_Prev.AsObject.IsKindOf(k2_typControlPara) then
       l_Prev := nev.NullPara;
     end;//l_Inn
   end;//f_Child = nil
  end;//l_Listener <> nil
  if (f_Child <> nil) then
  begin
   {$IfDef Nemesis}
   if (f_Child <> nil) AND (l_Listener <> nil) AND
      f_Child.AsObject.IsKindOf(k2_typParaList) then
    f_Child.AsObject.ForceStore;
   {$EndIf Nemesis}
   f_Child.Outer := nil;
  end;//f_Child <> nil
  if (aValue = nil) then
   f_Child := nil
  else
   f_Child := aValue;
  if (f_Child <> nil) then
  begin
   l_PID := Succ(f_Child.Obj.PID);
   if (l_PID <> Position) then
    SetEntryPointPrim(l_PID);
   f_Child.Outer := Self;
  end;//f_Child <> nil
  if (l_Listener <> nil) AND
     ((f_Child = nil) OR not f_Child.AsObject.IsSame(l_Prev.AsObject)) then
  begin
   if l_Prev.AsObject.IsValid then
    if l_Prev.AsObject.IsKindOf(k2_typControlPara) then
     l_Prev.OwnerObj.Invalidate([])
    else
     l_Prev.Invalidate([]);
   // - это чтобы рамку снять
   if (f_Child <> nil) then
   begin
    l_Inn := f_Child.MostInner;
    if l_Inn.AsObject.IsKindOf(k2_typControlPara) then
     f_Child.Obj.OwnerObj.Invalidate([])
    else
    if not l_Inn.NeedWindowsCaret then
     f_Child.Obj.Invalidate([]);
   end;//f_Child <> nil
   // - это чтобы рамку нарисовать
  end;//l_Listener <> nil..
 end;//f_Child <> aValue
//#UC END# *49DE40D30260_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.SetInner

function TevParaListCursorPrim.DoJoinWith(const aView: InevView;
 aSecondPara: Tl3Variant;
 const anOp: InevOp;
 MoveSubs: Boolean): Integer;
//#UC START# *49DEFB410161_4A3A237A01C0_var*
//#UC END# *49DEFB410161_4A3A237A01C0_var*
begin
//#UC START# *49DEFB410161_4A3A237A01C0_impl*
 if not Self.HasInner then
  Result := -1
 else
  Result := Self.GetInner.Text.Modify.JoinWith(aView, aSecondPara, anOp, MoveSubs);
//#UC END# *49DEFB410161_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoJoinWith

function TevParaListCursorPrim.DoSplit(const aView: InevView;
 aFlags: TnevInsertStringFlags;
 const anOp: InevOp): Il3TagRef;
//#UC START# *49DEFB770015_4A3A237A01C0_var*
//#UC END# *49DEFB770015_4A3A237A01C0_var*
begin
//#UC START# *49DEFB770015_4A3A237A01C0_impl*
 if not Self.HasInner then
  Result := Tl3NullTag.Instance
 else
  Result := Self.GetInner.Text.Modify.Split(aView, aFlags, anOp);
//#UC END# *49DEFB770015_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoSplit

function TevParaListCursorPrim.DoJoinWithNext(const aView: InevView;
 const anOp: InevOp): Boolean;
//#UC START# *49DF4C6E0101_4A3A237A01C0_var*
//#UC END# *49DF4C6E0101_4A3A237A01C0_var*
begin
//#UC START# *49DF4C6E0101_4A3A237A01C0_impl*
 if not Self.HasInner then
  Result := false
 else
  Result := Self.GetInner.Text.Modify.JoinWithNext(aView, anOp);  
//#UC END# *49DF4C6E0101_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoJoinWithNext

procedure TevParaListCursorPrim.DoSetEntryPoint(aValue: Integer;
 const anOp: IevCursorContext = nil);
//#UC START# *49E3126B030A_4A3A237A01C0_var*
var
 l_PC : Integer;
//#UC END# *49E3126B030A_4A3A237A01C0_var*
begin
//#UC START# *49E3126B030A_4A3A237A01C0_impl*
 if not TagInst.IsValid then
  Exit;
 if (anOp <> nil) then
  anOp.RecordCursor(Self);
 l_PC := ParaX.ParaCount;
 if (aValue = 0) then
  aValue := 1
 else
 if (aValue = High(Integer)) then
  aValue := l_PC
 else
 if (aValue = ev_cpNull) then
  aValue := 0;
 SetEntryPointPrim(aValue, anOp);
 if (aValue <> ev_cpTop) AND (Position >= 1) AND (Position <= l_PC) then
  Self.SetInner(ParaX[Pred(Position)].MakePoint(Self))
 else
  Self.SetInner(nil);
 ParaChanged;
//#UC END# *49E3126B030A_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoSetEntryPoint

function TevParaListCursorPrim.DoMovePrim(const aView: InevView;
 aCode: Integer;
 const anOp: InevOp;
 aCount: Integer): TnevMoveResult;
//#UC START# *49E31657038E_4A3A237A01C0_var*
  
var
 l_HOfs : Integer;
 
 procedure SetXOfs(anUp: Boolean);
 var
  l_Map : InevMap;
  l_MI  : InevBasePoint;
  l_LP  : InevLeafPoint;
  l_CV  : InevControlView;
 begin//SetXOfs
  l_MI := Self.pm_GetMostInner;
  l_Map := aView.MapByPoint(l_MI);
  if CanRedraw and (l_Map = nil) and (l_MI.Obj.OverlapType < otLower) then
  begin
   if (pm_GetListener <> nil) then
   // - типа к окну не привязаны, ну и нефига и дёргаться
   // http://mdp.garant.ru/pages/viewpage.action?pageId=255958998
    if Supports(aView, InevControlView, l_CV) then
     try
      l_CV.Control.View.MakePointVisible(Self.PointToParentByLevel(MaxInt));
      l_CV.Control.ForceRepaint;
      l_Map := aView.MapByPoint(l_MI);
     finally
      l_CV := nil;
     end//try..finally
  end; // if (l_Map = nil) then
  if (l_Map <> nil) then
  begin
   l_LP := l_MI.AsLeaf;
   if (l_LP <> nil) then
   begin
    if anUp then
     l_LP.InitPointByPt(aView, l3Point(l_HOfs, l_Map.Bounds.Bottom),
                        l_Map)
    else
     l_LP.InitPointByPt(aView, l3Point(l_HOfs, 0),
                        l_Map);
   end;//l_LP <> nil
  end;//l_Map <> nil
 end;//SetXOfs

 function CheckMostInnerHidden: Boolean;
 var
  l_Inn     : InevBasePoint;
  l_MostInner : InevBasePoint;
  l_FI        : TnevFormatInfoPrim;
 begin
  Result := false;
  l_Inn := Self.GetInner;
  l_MostInner := Self.pm_GetMostInner;
  if (l_Inn <> l_MostInner) then
  begin
   l_FI := aView.FormatInfoByPoint(l_MostInner);
   if (l_FI <> nil) then
   // иначе падал тест K234363360
    if l_FI.IsHidden(false, true) then
    begin
     Result := true;
     l_MostInner.DoMove(aView, aCode, anOp, aCount);
    end;//l_MostInner.Obj.IsHidden..
  end;//l_Inn <> l_MostInner
 end;

var
 l_DY         : Integer;
 l_PID        : Integer;
 l_Ctx        : IevCursorContext;
 l_IsVertical : Boolean;
 l_Map        : InevMap;
 l_MI         : InevBasePoint;
 l_FI         : TnevFormatInfoPrim;
//#UC END# *49E31657038E_4A3A237A01C0_var*
begin
//#UC START# *49E31657038E_4A3A237A01C0_impl*
 CheckPos(anOp);
 // - избавляемся от рассинхронизации позиции курсора и дочернего параграяа.
 //   заплатка конечно. Луше найти откуда сверху ноги растут. Но пока - так. 
 Result := inherited DoMovePrim(aView, aCode, anOp, aCount);
 if (Result = ev_dcDoneOk) then Exit;
 l_IsVertical := ParaX.IsVertical;
 Supports(anOp, IevCursorContext, l_Ctx);
 case aCode of
  ev_ocParaUp,   ev_ocParaLeft,
  ev_ocParaDown, ev_ocParaRight,
  ev_ocNextPara,
  ev_ocPrevParaBottomRight, ev_ocNextParaTopLeft,
  ev_ocPrevParaBottomRightInThisBlock,
  ev_ocParaDownWithEmptyRow:
  begin
   // =====================================
   // Запоминаем горизонтальную позицию:
   l_HOfs := 0;
   if (aCode = ev_ocParaDown) OR (aCode = ev_ocParaUp) OR (aCode = ev_ocParaDownWithEmptyRow) then
   begin
    if (aView <> nil) then
    begin
     l_MI := Self.pm_GetMostInner;
     l_Map := aView.MapByPoint(l_MI);
     if (l_Map <> nil) then
     begin
      l_HOfs := l_MI.ViewBounds(aView, l_Map).Left;
     end;//l_Map <> nil
    end;//aView <> nil
   end;//aCode = ev_ocParaDown..
   // =====================================
   case aCode of
    ev_ocParaUp, ev_ocParaLeft, ev_ocPrevParaBottomRight,
    ev_ocPrevParaBottomRightInThisBlock :
     l_DY := -1;
    ev_ocParaDown, ev_ocParaRight, ev_ocNextParaTopLeft,
    ev_ocNextPara, ev_ocParaDownWithEmptyRow :
     l_DY := 1;
    else
     l_DY := 0;
   end;//case aCode
   while True do
   begin
    Result := ev_dcNotDone;
    l_PID := Position;
{   if not(not l_IsVertical AND
       ((aCode = ev_ocParaUp) OR (aCode = ev_ocParaDown))) then begin}
    if (aCode = ev_ocPrevParaBottomRight) OR (aCode = ev_ocNextParaTopLeft) OR
       (aCode = ev_ocPrevParaBottomRightInThisBlock) OR
       { - Направление смещения зависит от направления параграфа. }
       l_IsVertical OR ((aCode = ev_ocParaLeft) OR (aCode = ev_ocParaRight)) then
     { - Или параграф вертикальный или смещаемся по горизонтали. }
    begin
     Inc(l_PID, l_DY);
     if (l_PID > 0) AND (l_PID <= ParaX.ParaCount) then
     begin
      SetEntryPoint(l_PID, l_Ctx);
      if Self.HasInner then
       case aCode of
        ev_ocPrevParaBottomRight :
         Self.GetInner.Move(aView, ev_ocBottomRight, anOp);
        ev_ocPrevParaBottomRightInThisBlock :
         Self.SetInner(nil);
        ev_ocNextParaTopLeft :
         Self.GetInner.Move(aView, ev_ocTopLeft, anOp);
        ev_ocParaLeft  :
         Self.GetInner.Move(aView, ev_ocBottomRight, anOp);
        ev_ocParaRight :
         Self.GetInner.Move(aView, ev_ocTopLeft, anOp);
        ev_ocParaUp    :
        begin
         Self.GetInner.Move(aView, ev_ocBottomRight, anOp);
         // V - в Немезисе поймали из-за этого: http://mdp.garant.ru/pages/viewpage.action?pageId=346754249&focusedCommentId=351210866#comment-351210866
         // V - и в Арчи тоже: http://mdp.garant.ru/pages/viewpage.action?pageId=358976702
         if aView <> nil then
          SetXOfs(true);
         // - восстанавливаем горизонтальную позицию
        end;//ev_ocParaUp
        ev_ocParaDown,
        ev_ocNextPara,
        ev_ocParaDownWithEmptyRow :
        begin
         Self.GetInner.Move(aView, ev_ocTopLeft, anOp);
         {$IFDEF Nemesis}
         // ^ - в Немезисе поймали из-за этого: http://mdp.garant.ru/pages/viewpage.action?pageId=346754249&focusedCommentId=351210866#comment-351210866
          if aView <> nil then
         {$ENDIF Nemesis}
          SetXOfs(false);
         // - восстанавливаем горизонтальную позицию
        end;//ev_ocParaDown
       end;//сase aCode
      Result := ev_dcDoneOk;
     end//l_PID > 0
     else
     if (aCode = ev_ocPrevParaBottomRightInThisBlock) then
     begin
      with TagInst.Owner do
       if IsKindOf(k2_typBlock) OR not IsKindOf(k2_typPara) then
       begin
        SetEntryPoint(ev_cpNull, l_Ctx);
        Result := ev_dcDoneOk;
       end;//TagInst.IsKindOf(k2_typBlock)
     end;//aCode = ev_ocPrevParaBottomRightInThisBlock
    end;//aCode..
    if (Result <> ev_dcDoneOk) then
     Break;
    if not Self.HasInner then
     Break;
    if (aView = nil) then
     Exit;
    if CheckMostInnerHidden then
     Exit;
    l_FI := aView.FormatInfoByPoint(Self.GetInner);
    if (l_FI = nil) then // http://mdp.garant.ru/pages/viewpage.action?pageId=509688505
     Break
    else
     // иначе падал тест K234363360
     if l_FI.IsHidden(false, true) then
     begin
      if NeedGotoHidden(aCode, l_FI) then
       Exit
     end
     else
      Exit
   end;//while True do
   if (Result <> ev_dcDoneOk) then
   begin
    if (Self.pm_GetParentPoint <> nil) then
    begin
     Use;
     // - защищаем себя от потери ссылки
     try
      Result := Self.pm_GetParentPoint.DoMove(aView, aCode, anOp, aCount);
     finally
      Free;
     end;//try..finally
    end//Self.pm_GetParentPoint <> nil
    else
    begin
     Result := ev_dcDoneFail;
     Exit;
     {* - По последним веяниям наверное не стоит поднимать Exception, так как
          Result и так равно False - можно по этому догадаться о неуспехе 
          операции. }
    end;//ParentPoint <> nil
   end;//Result <> ev_dcDoneOk
  end;//ev_ocParaUp,   ev_ocParaLeft,
 end;//case aCode..
 if (Result = ev_dcNotDone) AND Self.HasInner AND
    ((aView = nil) OR
    not aView.FormatInfoByPoint(Self.GetInner).IsHidden(false, true)) then
  Result := Self.GetInner.DoMove(aView, aCode, anOp, aCount);
 if (Result = ev_dcNotDone) then
 begin
  case aCode of
   ev_ocLineDown  :
    Result := DoMove(aView, ev_ocParaDown, anOp, aCount);
   ev_ocLineUp    :
    Result := DoMove(aView, ev_ocParaUp, anOp, aCount);
   ev_ocCharLeft,
   ev_ocPrevCharForDelete,
   ev_ocWordLeft  :
    Result := DoMove(aView, ev_ocParaLeft, anOp, aCount);
   ev_ocCharRight,
   ev_ocWordRight :
    Result := DoMove(aView, ev_ocParaRight, anOp, aCount);
   ev_ocMakeChildChain:
    if (f_Child = nil) then
    begin
     with ParaX do
      if (ChildrenCount <= 0) then
       Result := ev_dcDoneFail
      else
       with Para[0] do
        if IsValid then
        begin
         Self.Position := 0;
         if (f_Child <> nil) then
         begin
          Result := ev_dcDoneOk;
          f_Child.Move(aView, aCode);
         end//f_Child <> nil
         else 
          Result := ev_dcDoneFail
        end//IsValid
        else
         Result := ev_dcDoneFail;
    end//f_Child = nil
    else
     Result := DoMove(aView, ev_ocTopLeft, anOp, aCount);
  end;//сase aCode
  if (Result = ev_dcDoneOk) then
   Refresh;
 end;//Result = ev_dcNotDone
//#UC END# *49E31657038E_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoMovePrim

function TevParaListCursorPrim.DoProcessMessage(const aView: InevControlView;
 var aMessage: TMessage;
 aTime: Cardinal): Boolean;
//#UC START# *49E343F60057_4A3A237A01C0_var*
//#UC END# *49E343F60057_4A3A237A01C0_var*
begin
//#UC START# *49E343F60057_4A3A237A01C0_impl*
 if (f_Child = nil) or f_Child.AfterEnd or f_Child.BeforeStart then
  Result := false
 else
  Result := f_Child.ProcessMessage(aView, aMessage, aTime);
 if not Result then
  Result := inherited DoProcessMessage(aView, aMessage, aTime);
//#UC END# *49E343F60057_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoProcessMessage

function TevParaListCursorPrim.GetNeedWindowsCaret: Boolean;
//#UC START# *49E34A6301AC_4A3A237A01C0_var*
//#UC END# *49E34A6301AC_4A3A237A01C0_var*
begin
//#UC START# *49E34A6301AC_4A3A237A01C0_impl*
 Result := Self.HasInner AND Self.GetInner.NeedWindowsCaret;
//#UC END# *49E34A6301AC_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.GetNeedWindowsCaret

function TevParaListCursorPrim.GetAtStart: Boolean;
//#UC START# *49E34DCB014D_4A3A237A01C0_var*
//#UC END# *49E34DCB014D_4A3A237A01C0_var*
begin
//#UC START# *49E34DCB014D_4A3A237A01C0_impl*
 Result := (Position <= 1) AND (not Self.HasInner OR Self.GetInner.AtStart);
//#UC END# *49E34DCB014D_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.GetAtStart

function TevParaListCursorPrim.GetAtEnd(const aView: InevView): Boolean;
//#UC START# *49E34DFB0259_4A3A237A01C0_var*
//#UC END# *49E34DFB0259_4A3A237A01C0_var*
begin
//#UC START# *49E34DFB0259_4A3A237A01C0_impl*
 Result := (Position >= GetBlockLength) AND (not Self.HasInner OR Self.GetInner.AtEnd(aView));
//#UC END# *49E34DFB0259_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.GetAtEnd

procedure TevParaListCursorPrim.DoCheckPos(const anOp: InevOp);
//#UC START# *49E34E9802B6_4A3A237A01C0_var*
var
 l_In  : InevBasePoint;
 l_Pos : Integer;
 l_PID : Integer;
//#UC END# *49E34E9802B6_4A3A237A01C0_var*
begin
//#UC START# *49E34E9802B6_4A3A237A01C0_impl*
 inherited;
 l_In := Self.GetInner;
 if (l_In <> nil) then
 begin
  l_Pos := Position - 1;
  l_PID := l_In.Obj.PID;
  if (l_PID >= 0) then
  begin
   if (l_Pos <> l_PID) then
    OffsetPID(l_PID - l_Pos, anOp);
  end//l_PID >= 0
  else
   Self.SetInner(nil);
 end;//l_In <> nil
//#UC END# *49E34E9802B6_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoCheckPos

function TevParaListCursorPrim.GetVertPosition(const aView: InevView;
 aMap: TnevFormatInfoPrim): TnevParaIndex;
//#UC START# *49E34EDF0207_4A3A237A01C0_var*
//#UC END# *49E34EDF0207_4A3A237A01C0_var*
begin
//#UC START# *49E34EDF0207_4A3A237A01C0_impl*
 Result := Pred(Position);
//#UC END# *49E34EDF0207_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.GetVertPosition

function TevParaListCursorPrim.GetDeltaX(const aView: InevView;
 const aMap: InevMap): Integer;
//#UC START# *49E3568201B9_4A3A237A01C0_var*
var
 l_Ow    : Tl3Variant;
 l_Child : InevBasePoint;
 l_Obj   : InevObject;
//#UC END# *49E3568201B9_4A3A237A01C0_var*
begin
//#UC START# *49E3568201B9_4A3A237A01C0_impl*
 Assert(aMap <> nil);
 if (f_Child = nil) then
  Result := 0
 else
 begin
  l_Ow := f_Child.Obj^.AsObject.Owner;
  if not l_Ow.IsSame(ParaX.AsObject) then
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=255980313&focusedCommentId=259888626&#comment-259888626
  begin
   if l_Ow.Owner.IsSame(ParaX.AsObject) then
   begin
    l_Child := f_Child;
    if not l_Ow.QT(InevObject, l_Obj) then
     Assert(false);
    f_Child := l_Obj.MakePoint;
    f_Child.Inner := l_Child;
   end//l_Ow.Owner.IsSame(ParaX)
   else
   begin
    f_Child := nil;
    Result := 0;
    Exit;
   end;//l_Ow.Owner.IsSame(ParaX)
  end;//not l_Ow.IsSame(ParaX)
  Assert(f_Child.Obj^.AsObject.Owner.IsSame(ParaX.AsObject), 'http://mdp.garant.ru/pages/viewpage.action?pageId=255980313&focusedCommentId=259888626&#comment-259888626');
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=255980313&focusedCommentId=259888626&#comment-259888626
  Result := f_Child.DeltaX(aView, aMap.ReserveMap(f_Child.Obj^));
 end;//f_Child = nil
//#UC END# *49E3568201B9_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.GetDeltaX

function TevParaListCursorPrim.DoCompare(const aPoint: InevBasePoint): Integer;
//#UC START# *49E358670168_4A3A237A01C0_var*
//#UC END# *49E358670168_4A3A237A01C0_var*
begin
//#UC START# *49E358670168_4A3A237A01C0_impl*
 Result := inherited DoCompare(aPoint);
 if (Result = 0) then
 begin
  if Self.HasInner then
  begin
   // далее я правил, когда разбирался с изменением границы блока, но потом в этих изменениях
   // отпала необходимость, так что если из за них вылезут какие-то болты, то можно поправить обратно
   if not aPoint.HasInner then
    Result := +1
   else
    Result := Self.GetInner.Compare(aPoint.Inner);
  end//Self.HasInner
  else
  if aPoint.HasInner then
   Result := -1;
 end;//Result = 0
//#UC END# *49E358670168_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoCompare

function TevParaListCursorPrim.GetInner: InevBasePoint;
//#UC START# *49E35A0402DB_4A3A237A01C0_var*
//#UC END# *49E35A0402DB_4A3A237A01C0_var*
begin
//#UC START# *49E35A0402DB_4A3A237A01C0_impl*
 Result := f_Child;
//#UC END# *49E35A0402DB_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.GetInner

function TevParaListCursorPrim.DoGetBlockLength: Integer;
//#UC START# *49E3662D028E_4A3A237A01C0_var*
//#UC END# *49E3662D028E_4A3A237A01C0_var*
begin
//#UC START# *49E3662D028E_4A3A237A01C0_impl*
 Result := TagInst.ChildrenCount;
//#UC END# *49E3662D028E_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoGetBlockLength

function TevParaListCursorPrim.DoChangeParam(const aView: InevView;
 const aMarker: IevMarker;
 aValue: Integer;
 const anOp: InevOp): Boolean;
//#UC START# *4A29465701BC_4A3A237A01C0_var*
//#UC END# *4A29465701BC_4A3A237A01C0_var*
begin
//#UC START# *4A29465701BC_4A3A237A01C0_impl*
 Result := inherited DoChangeParam(aView, aMarker, aValue, anOp);
 if not Result AND Self.HasInner then
  Result := Self.GetInner.Formatting.Modify(aView).ChangeParam(aView, aMarker, aValue, anOp);
//#UC END# *4A29465701BC_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoChangeParam

function TevParaListCursorPrim.DoDeleteHyperlink(const anOpPack: InevOp): Boolean;
//#UC START# *4A38F52201BA_4A3A237A01C0_var*
//#UC END# *4A38F52201BA_4A3A237A01C0_var*
begin
//#UC START# *4A38F52201BA_4A3A237A01C0_impl*
 if not Self.HasInner then
  Result := false
 else
  Result := Self.GetInner.Formatting.Modify(nil).DeleteHyperlink(anOpPack);
//#UC END# *4A38F52201BA_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoDeleteHyperlink

function TevParaListCursorPrim.DoInsertBreak(const aView: InevView;
 aDrawLines: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *4A38F59B0234_4A3A237A01C0_var*
var
 l_Index : Integer;
//#UC END# *4A38F59B0234_4A3A237A01C0_var*
begin
//#UC START# *4A38F59B0234_4A3A237A01C0_impl*
 CheckPos(anOp);
 l_Index := Position;
 if not Self.HasInner then
  Result := false
 else
  Result := Self.GetInner.Text.Modify.InsertBreak(aView, aDrawLines, anOp);
 if not Result then
 begin
  if (l_Index <> Position) then
  // - позиция поменялась
   Result := true
  else
  if evInsertPara(anOp, Self, Tk2Type(TagInst.TagType).ArrayProp[k2_tiChildren].DefaultChildType.MakeTag.AsObject) then
  begin
   Move(aView, ev_ocParaDown, anOp);
   Result := true;
  end;//evInsertPara(..
 end;//not Result
//#UC END# *4A38F59B0234_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoInsertBreak

function TevParaListCursorPrim.DoAddIndentMarker(const aView: InevView;
 aValue: Integer;
 const anOpPack: InevOp): Boolean;
//#UC START# *4A38F69F0070_4A3A237A01C0_var*
//#UC END# *4A38F69F0070_4A3A237A01C0_var*
begin
//#UC START# *4A38F69F0070_4A3A237A01C0_impl*
 Result := inherited DoAddIndentMarker(aView, aValue, anOpPack);
 if not Result AND Self.HasInner then
  Result := Self.GetInner.Formatting.Modify(aView).AddIndentMarker(aView, aValue, anOpPack);
//#UC END# *4A38F69F0070_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoAddIndentMarker

function TevParaListCursorPrim.DoDeleteIndentMarker(const aView: InevView;
 const anOpPack: InevOp): Boolean;
//#UC START# *4A38F6CB003C_4A3A237A01C0_var*
//#UC END# *4A38F6CB003C_4A3A237A01C0_var*
begin
//#UC START# *4A38F6CB003C_4A3A237A01C0_impl*
 Result := inherited DoDeleteIndentMarker(aView, anOpPack);
 if not Result AND Self.HasInner then
  Result := Self.GetInner.Formatting.Modify(aView).DeleteIndentMarker(aView, anOpPack);
//#UC END# *4A38F6CB003C_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoDeleteIndentMarker

function TevParaListCursorPrim.DoInsertString(const aView: InevView;
 const aString: Il3CString;
 const anOp: InevOp;
 InsertMode: Boolean;
 aFlags: TnevInsertStringFlags): Boolean;
//#UC START# *4A38F71601D6_4A3A237A01C0_var*
//#UC END# *4A38F71601D6_4A3A237A01C0_var*
begin
//#UC START# *4A38F71601D6_4A3A237A01C0_impl*
 if not Self.HasInner then
  Result := false
 else
  Result := Self.GetInner.Text.Modify.InsertString(aView, aString, anOp, InsertMode, aFlags);
//#UC END# *4A38F71601D6_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoInsertString

function TevParaListCursorPrim.DoDeleteString(const aView: InevView;
 aCount: Integer;
 const anOp: InevOp;
 aFlags: TnevInsertStringFlags): Boolean;
//#UC START# *4A38F748002D_4A3A237A01C0_var*
//#UC END# *4A38F748002D_4A3A237A01C0_var*
begin
//#UC START# *4A38F748002D_4A3A237A01C0_impl*
 if not Self.HasInner then
  Result := false
 else
  Result := Self.GetInner.Text.Modify.DeleteString(aView, aCount, anOp, aFlags);
//#UC END# *4A38F748002D_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoDeleteString

function TevParaListCursorPrim.DoSetAtom(const aView: InevView;
 anIndex: Cardinal;
 pSource: Tl3Variant;
 const anOp: InevOp): Boolean;
//#UC START# *4A38F7A40373_4A3A237A01C0_var*
var
 l_Modify: InevDataFormattingModify;
//#UC END# *4A38F7A40373_4A3A237A01C0_var*
begin
//#UC START# *4A38F7A40373_4A3A237A01C0_impl*
 if not Self.HasInner then
  Result := false
 else
 begin
  l_Modify := Self.GetInner.Formatting.Modify(aView);
  // K-148018018
  // Если документ readonly, то Self.GetInner.Formatting.Modify(aView)
  // вернет nil. Возможно правильней тут проверять IsReadOnly
  // см. TeeTextParaCursor.InevDataFormatting_Modify
  if (l_Modify = nil) then
   Result := false
  else
   Result := l_Modify.SetAtom(aView, anIndex, pSource, anOp);
 end;
//#UC END# *4A38F7A40373_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoSetAtom

function TevParaListCursorPrim.DoDeleteChar(const aView: InevView;
 aDrawLines: Boolean;
 const anOp: InevOp): Boolean;
//#UC START# *4A38F7F5022C_4A3A237A01C0_var*
//#UC END# *4A38F7F5022C_4A3A237A01C0_var*
begin
//#UC START# *4A38F7F5022C_4A3A237A01C0_impl*
 if not Self.HasInner then
  Result := false
 else
 begin
  Result := Self.GetInner.Text.Modify.DeleteChar(aView, aDrawLines, anOp);
  if not Result then
   if (TagInst.ChildrenCount > 1) AND Self.GetInner.Text.CanBeDeleted then
    Result := evDeletePara(anOp, Self, [])
   else
    Result := true;
 end;//not Self.HasInner
//#UC END# *4A38F7F5022C_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoDeleteChar

function TevParaListCursorPrim.pm_GetHasInner: Boolean;
//#UC START# *4A3A2E170304_4A3A237A01C0get_var*
//#UC END# *4A3A2E170304_4A3A237A01C0get_var*
begin
//#UC START# *4A3A2E170304_4A3A237A01C0get_impl*
 Result := (f_Child <> nil);
//#UC END# *4A3A2E170304_4A3A237A01C0get_impl*
end;//TevParaListCursorPrim.pm_GetHasInner

function TevParaListCursorPrim.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_4A3A237A01C0_var*
//#UC END# *4A60B23E00C3_4A3A237A01C0_var*
begin
//#UC START# *4A60B23E00C3_4A3A237A01C0_impl*
 Result.SetOk;
 if IID.EQ(Ik2TagGeneratorWrap) then
 begin
  Assert(false);
  Result.SetNoInterface;
 end//IID.EQ(Ik2TagGeneratorWrap)
 else
 if IID.SomeOf([IevHyperlink, IevDrawLineTool]) AND
             Self.HasInner then
  Result := Tl3HResult_C(Self.GetInner.QueryInterface(IID.IID, Obj))
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.COMQueryInterface

function TevParaListCursorPrim.DoPartiallyVisible(const aView: InevView;
 const aPoint: InevBasePoint;
 aMap: TnevFormatInfoPrim): Boolean;
//#UC START# *4BBB10FB015B_4A3A237A01C0_var*
var
 l_Inner : InevBasePoint;
//#UC END# *4BBB10FB015B_4A3A237A01C0_var*
begin
//#UC START# *4BBB10FB015B_4A3A237A01C0_impl*
 Result := inherited DoPartiallyVisible(aView, aPoint, aMap);
 if HasInner and aPoint.HasInner and (aMap <> nil) then
 begin
  l_Inner := GetInner;
  Result := l_Inner.PartiallyVisible(aView, aPoint.Inner, aMap.InfoForChild(l_Inner.Obj^));
 end; // if HasInner and aPoint.HasInner then
//#UC END# *4BBB10FB015B_4A3A237A01C0_impl*
end;//TevParaListCursorPrim.DoPartiallyVisible
{$IfEnd} // Defined(evUseVisibleCursors)

end.
