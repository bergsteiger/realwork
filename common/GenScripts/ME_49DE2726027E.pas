{$IfNDef evCursor_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\evCursor.imp.pas"
// Стереотип: "Impurity"

{$Define evCursor_imp}

{$If Defined(evUseVisibleCursors)}
 _nevParentPointFactory_Parent_ = TevLocation;
 {$Include nevParentPointFactory.imp.pas}
 _nevParentPointFactoryEx_Parent_ = _nevParentPointFactory_;
 {$Include nevParentPointFactoryEx.imp.pas}
 _nevParentPointHolder_Parent_ = _nevParentPointFactoryEx_;
 {$Include nevParentPointHolder.imp.pas}
 _nevMostInner_Parent_ = _nevParentPointHolder_;
 {$Include nevMostInner.imp.pas}
 _nevDiff_Parent_ = _nevMostInner_;
 {$Include nevDiff.imp.pas}
 _evCursor_ = class(_nevDiff_)
  {* "Совсем базовый" курсор }
  private
   f_Position: TnevPosition;
    {* Поле для свойства Position }
  protected
   procedure pm_SetPosition(aValue: TnevPosition);
   function pm_GetAsLeaf: InevLeafPoint; virtual;
   function pm_GetShowCollapsed: Boolean; virtual;
   procedure pm_SetShowCollapsed(aValue: Boolean); virtual;
   function pm_GetLinkedPoint: InevLinkedPoint; virtual;
   function pm_GetListener: InevPointListener; virtual;
   procedure DoAssignPoint(const aView: InevView;
    const aPoint: InevBasePoint); virtual;
   procedure SetInner(const aValue: InevBasePoint); virtual;
   procedure DoSetEntryPoint(aValue: Integer;
    const anOp: IevCursorContext = nil); virtual;
   function IsLeaf: Boolean; virtual;
    {* Курсор от листьевого параграфа }
   function DoMovePrim(const aView: InevView;
    aCode: Integer;
    const anOp: InevOp;
    aCount: Integer): TnevMoveResult; virtual;
   procedure DoSetAtEnd(const aView: InevView;
    aValue: Boolean); virtual;
   function DoProcessMessage(const aView: InevControlView;
    var aMessage: TMessage;
    aTime: Cardinal): Boolean; virtual;
   function GetNeedWindowsCaret: Boolean; virtual;
   function GetAtStart: Boolean; virtual;
   function GetAtEnd(const aView: InevView): Boolean; virtual;
   procedure DoCheckPos(const anOp: InevOp); virtual;
   function GetVertPosition(const aView: InevView;
    aMap: TnevFormatInfoPrim): TnevParaIndex; virtual;
   function GetReadOnly: Boolean; virtual;
   function GetDeltaX(const aView: InevView;
    const aMap: InevMap): Integer; virtual;
   function DoCompare(const aPoint: InevBasePoint): Integer; virtual;
   function GetInner: InevBasePoint; virtual;
   procedure DoDisableListener; virtual;
   procedure DoEnableListener; virtual;
   procedure DoAssignPointInt(const aView: InevView;
    const aPoint: InevBasePoint); virtual;
   procedure Set_PositionW(aValue: TnevPosition);
   procedure SetParentPoint(const aValue: InevBasePoint); override;
   function DoJoinWith(const aView: InevView;
    aSecondPara: Tl3Variant;
    const anOp: InevOp;
    MoveSubs: Boolean): Integer; override;
   function DoSplit(const aView: InevView;
    aFlags: TnevInsertStringFlags;
    const anOp: InevOp): Il3TagRef; override;
   function DoJoinWithNext(const aView: InevView;
    const anOp: InevOp): Boolean; override;
   function GetRange: InevRange; override;
   function GetAsPoint: InevBasePoint; override;
   function GetCanBeDeleted: Boolean; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   procedure DoForceStore; override;
  public
   procedure DoSetEntryPointPrim(Value: Integer;
    const Context: IevCursorContext = nil); virtual;
   procedure AssignPoint(const aView: InevView;
    const aPoint: InevBasePoint);
   function DoMove(const aView: InevView;
    aCode: Integer;
    const anOp: InevOp;
    aCount: Integer): TnevMoveResult;
   function Move(const aView: InevView;
    aCode: Cardinal;
    const anOp: InevOp = nil;
    aCount: Integer = 1): Boolean;
   procedure Refresh;
   procedure SetEntryPointPrim(Value: Integer;
    const Context: IevCursorContext = nil);
   procedure SetEntryPoint(Value: Integer;
    const Context: IevCursorContext = nil); overload;
   procedure SetEntryPoint(aValue: Integer;
    const aContext: InevOp); overload;
   function ToBottomChild(const aView: InevView): InevBasePoint;
   procedure SetAtEnd(const aView: InevView;
    aValue: Boolean);
   procedure SetAtStart(const aView: InevView;
    aValue: Boolean);
   procedure DisableListener;
    {* Отключает нотификацию об изменении }
   procedure EnableListener;
    {* Включает нотификацию об изменении }
   class function StoreToOldCache: Boolean; override;
   procedure Assign(Source: Tk2ToolPrim); override;
  protected
   property AsLeaf: InevLeafPoint
    read pm_GetAsLeaf;
   property ShowCollapsed: Boolean
    read pm_GetShowCollapsed
    write pm_SetShowCollapsed;
   property LinkedPoint: InevLinkedPoint
    read pm_GetLinkedPoint;
   property Listener: InevPointListener
    read pm_GetListener;
  public
   property Position: TnevPosition
    read f_Position
    write pm_SetPosition;
    {* Позиция курсора }
 end;//_evCursor_

{$Else Defined(evUseVisibleCursors)}

_nevParentPointFactory_Parent_ = TevLocation;
{$Include nevParentPointFactory.imp.pas}
_nevParentPointFactoryEx_Parent_ = _nevParentPointFactory_;
{$Include nevParentPointFactoryEx.imp.pas}
_nevParentPointHolder_Parent_ = _nevParentPointFactoryEx_;
{$Include nevParentPointHolder.imp.pas}
_nevMostInner_Parent_ = _nevParentPointHolder_;
{$Include nevMostInner.imp.pas}
_nevDiff_Parent_ = _nevMostInner_;
{$Include nevDiff.imp.pas}
_evCursor_ = _nevDiff_;

{$IfEnd} // Defined(evUseVisibleCursors)
{$Else evCursor_imp}

{$IfNDef evCursor_imp_impl}

{$Define evCursor_imp_impl}

{$If Defined(evUseVisibleCursors)}
type _Instance_R_ = _evCursor_;

{$Include nevParentPointFactory.imp.pas}

{$Include nevParentPointFactoryEx.imp.pas}

{$Include nevParentPointHolder.imp.pas}

{$Include nevMostInner.imp.pas}

{$Include nevDiff.imp.pas}

procedure _evCursor_.pm_SetPosition(aValue: TnevPosition);
//#UC START# *49DEF7060313_49DE2726027Eset_var*
//#UC END# *49DEF7060313_49DE2726027Eset_var*
begin
//#UC START# *49DEF7060313_49DE2726027Eset_impl*
 SetEntryPoint(aValue);
//#UC END# *49DEF7060313_49DE2726027Eset_impl*
end;//_evCursor_.pm_SetPosition

function _evCursor_.pm_GetAsLeaf: InevLeafPoint;
//#UC START# *49DF741401DF_49DE2726027Eget_var*
//#UC END# *49DF741401DF_49DE2726027Eget_var*
begin
//#UC START# *49DF741401DF_49DE2726027Eget_impl*
 Result := nil;
//#UC END# *49DF741401DF_49DE2726027Eget_impl*
end;//_evCursor_.pm_GetAsLeaf

function _evCursor_.pm_GetShowCollapsed: Boolean;
//#UC START# *49E2F3E6036F_49DE2726027Eget_var*
//#UC END# *49E2F3E6036F_49DE2726027Eget_var*
begin
//#UC START# *49E2F3E6036F_49DE2726027Eget_impl*
 Result := true;
//#UC END# *49E2F3E6036F_49DE2726027Eget_impl*
end;//_evCursor_.pm_GetShowCollapsed

procedure _evCursor_.pm_SetShowCollapsed(aValue: Boolean);
//#UC START# *49E2F3E6036F_49DE2726027Eset_var*
//#UC END# *49E2F3E6036F_49DE2726027Eset_var*
begin
//#UC START# *49E2F3E6036F_49DE2726027Eset_impl*
 // - ничего не присваиваем
//#UC END# *49E2F3E6036F_49DE2726027Eset_impl*
end;//_evCursor_.pm_SetShowCollapsed

function _evCursor_.pm_GetLinkedPoint: InevLinkedPoint;
//#UC START# *49E2F6CE0055_49DE2726027Eget_var*
//#UC END# *49E2F6CE0055_49DE2726027Eget_var*
begin
//#UC START# *49E2F6CE0055_49DE2726027Eget_impl*
 Result := nil;
//#UC END# *49E2F6CE0055_49DE2726027Eget_impl*
end;//_evCursor_.pm_GetLinkedPoint

function _evCursor_.pm_GetListener: InevPointListener;
//#UC START# *49E3136001F0_49DE2726027Eget_var*
var
 l_P : InevBasePoint;
//#UC END# *49E3136001F0_49DE2726027Eget_var*
begin
//#UC START# *49E3136001F0_49DE2726027Eget_impl*
 l_P := Self.pm_GetParentPoint;
 Assert(not l3IEQ(Self, l_P));
 if (l_P = nil) then
  Result := nil
 else
 begin
  Assert(l_P.AsObject.IsValid);
  Result := l_P.Listener;
 end;//l_P = nil
//#UC END# *49E3136001F0_49DE2726027Eget_impl*
end;//_evCursor_.pm_GetListener

procedure _evCursor_.DoAssignPoint(const aView: InevView;
 const aPoint: InevBasePoint);
//#UC START# *49DE3CD8004F_49DE2726027E_var*
//#UC END# *49DE3CD8004F_49DE2726027E_var*
begin
//#UC START# *49DE3CD8004F_49DE2726027E_impl*
 if (aPoint <> nil) then
  Target := aPoint.Obj^.AsObject
 else
  Assert(false);
  // - это я в процесе перевода на модель на всякий случай вписал
 if (aPoint <> nil) then
 begin
  if (ParaX = nil) then
   ParaX := aPoint.Obj.AsPara
 end;//aPoint <> nil
 DoAssignPointInt(aView, aPoint);
 Refresh;
//#UC END# *49DE3CD8004F_49DE2726027E_impl*
end;//_evCursor_.DoAssignPoint

procedure _evCursor_.SetInner(const aValue: InevBasePoint);
//#UC START# *49DE40D30260_49DE2726027E_var*
//#UC END# *49DE40D30260_49DE2726027E_var*
begin
//#UC START# *49DE40D30260_49DE2726027E_impl*
 // - ничего не делаем
//#UC END# *49DE40D30260_49DE2726027E_impl*
end;//_evCursor_.SetInner

procedure _evCursor_.DoSetEntryPointPrim(Value: Integer;
 const Context: IevCursorContext = nil);
//#UC START# *49E2F8F80062_49DE2726027E_var*
//#UC END# *49E2F8F80062_49DE2726027E_var*
begin
//#UC START# *49E2F8F80062_49DE2726027E_impl*
 if (Value <> f_Position) then
 begin
  if (Context <> nil) then
   Context.RecordCursor(_Instance_R_(Self));
  Assert(Value >= 0); 
  f_Position := Value;
 end;//Value <> f_Position
//#UC END# *49E2F8F80062_49DE2726027E_impl*
end;//_evCursor_.DoSetEntryPointPrim

procedure _evCursor_.DoSetEntryPoint(aValue: Integer;
 const anOp: IevCursorContext = nil);
//#UC START# *49E3126B030A_49DE2726027E_var*
//#UC END# *49E3126B030A_49DE2726027E_var*
begin
//#UC START# *49E3126B030A_49DE2726027E_impl*
 SetEntryPointPrim(aValue, anOp);
 _Instance_R_(Self).Refresh;
 if IsLeaf then
  if not _Instance_R_(Self).NeedWindowsCaret then
   if (pm_GetListener <> nil) then
    ParaX.Invalidate([]);
  // - Это чтобы рамку нарисовать
//#UC END# *49E3126B030A_49DE2726027E_impl*
end;//_evCursor_.DoSetEntryPoint

function _evCursor_.IsLeaf: Boolean;
 {* Курсор от листьевого параграфа }
//#UC START# *49E3153B017D_49DE2726027E_var*
//#UC END# *49E3153B017D_49DE2726027E_var*
begin
//#UC START# *49E3153B017D_49DE2726027E_impl*
 Result := false;
//#UC END# *49E3153B017D_49DE2726027E_impl*
end;//_evCursor_.IsLeaf

function _evCursor_.DoMovePrim(const aView: InevView;
 aCode: Integer;
 const anOp: InevOp;
 aCount: Integer): TnevMoveResult;
//#UC START# *49E31657038E_49DE2726027E_var*
//#UC END# *49E31657038E_49DE2726027E_var*
begin
//#UC START# *49E31657038E_49DE2726027E_impl*
 Result := ev_dcNotDone;
//#UC END# *49E31657038E_49DE2726027E_impl*
end;//_evCursor_.DoMovePrim

procedure _evCursor_.DoSetAtEnd(const aView: InevView;
 aValue: Boolean);
//#UC START# *49E317B802F3_49DE2726027E_var*
//#UC END# *49E317B802F3_49DE2726027E_var*
begin
//#UC START# *49E317B802F3_49DE2726027E_impl*
 if aValue then
  _Instance_R_(Self).Move(aView, ev_ocBottomRightIgnoreMergedCell);
//#UC END# *49E317B802F3_49DE2726027E_impl*
end;//_evCursor_.DoSetAtEnd

function _evCursor_.DoProcessMessage(const aView: InevControlView;
 var aMessage: TMessage;
 aTime: Cardinal): Boolean;
//#UC START# *49E343F60057_49DE2726027E_var*
//#UC END# *49E343F60057_49DE2726027E_var*
begin
//#UC START# *49E343F60057_49DE2726027E_impl*
 Result := false;
//#UC END# *49E343F60057_49DE2726027E_impl*
end;//_evCursor_.DoProcessMessage

function _evCursor_.GetNeedWindowsCaret: Boolean;
//#UC START# *49E34A6301AC_49DE2726027E_var*
//#UC END# *49E34A6301AC_49DE2726027E_var*
begin
//#UC START# *49E34A6301AC_49DE2726027E_impl*
 Result := true;
//#UC END# *49E34A6301AC_49DE2726027E_impl*
end;//_evCursor_.GetNeedWindowsCaret

function _evCursor_.GetAtStart: Boolean;
//#UC START# *49E34DCB014D_49DE2726027E_var*
//#UC END# *49E34DCB014D_49DE2726027E_var*
begin
//#UC START# *49E34DCB014D_49DE2726027E_impl*
 Result := false;
//#UC END# *49E34DCB014D_49DE2726027E_impl*
end;//_evCursor_.GetAtStart

function _evCursor_.GetAtEnd(const aView: InevView): Boolean;
//#UC START# *49E34DFB0259_49DE2726027E_var*
//#UC END# *49E34DFB0259_49DE2726027E_var*
begin
//#UC START# *49E34DFB0259_49DE2726027E_impl*
 Result := false;
//#UC END# *49E34DFB0259_49DE2726027E_impl*
end;//_evCursor_.GetAtEnd

procedure _evCursor_.DoCheckPos(const anOp: InevOp);
//#UC START# *49E34E9802B6_49DE2726027E_var*
//#UC END# *49E34E9802B6_49DE2726027E_var*
begin
//#UC START# *49E34E9802B6_49DE2726027E_impl*
 // - ничего не делаем
//#UC END# *49E34E9802B6_49DE2726027E_impl*
end;//_evCursor_.DoCheckPos

function _evCursor_.GetVertPosition(const aView: InevView;
 aMap: TnevFormatInfoPrim): TnevParaIndex;
//#UC START# *49E34EDF0207_49DE2726027E_var*
//#UC END# *49E34EDF0207_49DE2726027E_var*
begin
//#UC START# *49E34EDF0207_49DE2726027E_impl*
 Result := Position;
//#UC END# *49E34EDF0207_49DE2726027E_impl*
end;//_evCursor_.GetVertPosition

function _evCursor_.GetReadOnly: Boolean;
//#UC START# *49E3520F0174_49DE2726027E_var*
//#UC END# *49E3520F0174_49DE2726027E_var*
begin
//#UC START# *49E3520F0174_49DE2726027E_impl*
 Result := false;
//#UC END# *49E3520F0174_49DE2726027E_impl*
end;//_evCursor_.GetReadOnly

function _evCursor_.GetDeltaX(const aView: InevView;
 const aMap: InevMap): Integer;
//#UC START# *49E3568201B9_49DE2726027E_var*
//#UC END# *49E3568201B9_49DE2726027E_var*
begin
//#UC START# *49E3568201B9_49DE2726027E_impl*
 Result := 0;
//#UC END# *49E3568201B9_49DE2726027E_impl*
end;//_evCursor_.GetDeltaX

function _evCursor_.DoCompare(const aPoint: InevBasePoint): Integer;
//#UC START# *49E358670168_49DE2726027E_var*
//#UC END# *49E358670168_49DE2726027E_var*
begin
//#UC START# *49E358670168_49DE2726027E_impl*
 if (aPoint = nil) then
  Result := 1
 else
 if not aPoint.Obj.AsObject.IsSame(ParaX.AsObject) then
  Result := 1
 else
  Result := (Position - aPoint.Position);
//#UC END# *49E358670168_49DE2726027E_impl*
end;//_evCursor_.DoCompare

function _evCursor_.GetInner: InevBasePoint;
//#UC START# *49E35A0402DB_49DE2726027E_var*
//#UC END# *49E35A0402DB_49DE2726027E_var*
begin
//#UC START# *49E35A0402DB_49DE2726027E_impl*
 Result := nil;
//#UC END# *49E35A0402DB_49DE2726027E_impl*
end;//_evCursor_.GetInner

procedure _evCursor_.DoDisableListener;
//#UC START# *4A4C86B202B2_49DE2726027E_var*
//#UC END# *4A4C86B202B2_49DE2726027E_var*
begin
//#UC START# *4A4C86B202B2_49DE2726027E_impl*
//#UC END# *4A4C86B202B2_49DE2726027E_impl*
end;//_evCursor_.DoDisableListener

procedure _evCursor_.DoEnableListener;
//#UC START# *4A4C86C103BF_49DE2726027E_var*
//#UC END# *4A4C86C103BF_49DE2726027E_var*
begin
//#UC START# *4A4C86C103BF_49DE2726027E_impl*
//#UC END# *4A4C86C103BF_49DE2726027E_impl*
end;//_evCursor_.DoEnableListener

procedure _evCursor_.DoAssignPointInt(const aView: InevView;
 const aPoint: InevBasePoint);
//#UC START# *4BE284D00262_49DE2726027E_var*
var
 l_CP : InevBasePoint;
//#UC END# *4BE284D00262_49DE2726027E_var*
begin
//#UC START# *4BE284D00262_49DE2726027E_impl*
 SetEntryPointPrim(aPoint.Position);
 l_CP := aPoint.Inner;
 if (l_CP = nil) then
 begin
  if aPoint.HasBaseLine then
  begin
   l_CP := aPoint.InnerForChildThatNotAfterEnd(aView.FormatInfoByPoint(aPoint), nev_itForDrawing);
   if l_CP = nil then
    SetInner(nil)
   else
    SetInner(l_CP.ClonePoint(aView).AsCursor(aView));
  end // if aPoint.HasBaseLine then
  else
   SetInner(nil)
 end
 else
  SetInner(l_CP.ClonePoint(aView).AsCursor(aView));
  // - AsCursor здесь нужен для того, чтобы преобразовать якорь к курсору
  //   т.к. якорь не обладает полной функциональностью курсора и в случае PageDown
  //   всё будет падать.
//#UC END# *4BE284D00262_49DE2726027E_impl*
end;//_evCursor_.DoAssignPointInt

procedure _evCursor_.AssignPoint(const aView: InevView;
 const aPoint: InevBasePoint);
//#UC START# *47C5C25C022F_49DE2726027E_var*
//#UC END# *47C5C25C022F_49DE2726027E_var*
begin
//#UC START# *47C5C25C022F_49DE2726027E_impl*
 DoAssignPoint(aView, aPoint);
//#UC END# *47C5C25C022F_49DE2726027E_impl*
end;//_evCursor_.AssignPoint

function _evCursor_.DoMove(const aView: InevView;
 aCode: Integer;
 const anOp: InevOp;
 aCount: Integer): TnevMoveResult;
//#UC START# *47C689E90006_49DE2726027E_var*
//#UC END# *47C689E90006_49DE2726027E_var*
begin
//#UC START# *47C689E90006_49DE2726027E_impl*
 if (TagInst = nil) then
  Result := ev_dcDoneFail
 else
  Result := DoMovePrim(aView, aCode, anOp, aCount);
//#UC END# *47C689E90006_49DE2726027E_impl*
end;//_evCursor_.DoMove

function _evCursor_.Move(const aView: InevView;
 aCode: Cardinal;
 const anOp: InevOp = nil;
 aCount: Integer = 1): Boolean;
//#UC START# *47C68A010279_49DE2726027E_var*
//#UC END# *47C68A010279_49DE2726027E_var*
begin
//#UC START# *47C68A010279_49DE2726027E_impl*
 Result := DoMove(aView, aCode, anOp, aCount) = ev_dcDoneOk;
//#UC END# *47C68A010279_49DE2726027E_impl*
end;//_evCursor_.Move

procedure _evCursor_.Refresh;
//#UC START# *47C68A0E01E9_49DE2726027E_var*
var
 l_Listener : InevPointListener;
//#UC END# *47C68A0E01E9_49DE2726027E_var*
begin
//#UC START# *47C68A0E01E9_49DE2726027E_impl*
 l_Listener := pm_GetListener;
 if (l_Listener <> nil) then
  l_Listener.CursorChanged(_Instance_R_(Self));
//#UC END# *47C68A0E01E9_49DE2726027E_impl*
end;//_evCursor_.Refresh

procedure _evCursor_.SetEntryPointPrim(Value: Integer;
 const Context: IevCursorContext = nil);
//#UC START# *47C68A160190_49DE2726027E_var*
//#UC END# *47C68A160190_49DE2726027E_var*
begin
//#UC START# *47C68A160190_49DE2726027E_impl*
 DoSetEntryPointPrim(Value, Context);
//#UC END# *47C68A160190_49DE2726027E_impl*
end;//_evCursor_.SetEntryPointPrim

procedure _evCursor_.SetEntryPoint(Value: Integer;
 const Context: IevCursorContext = nil);
//#UC START# *47C68A220200_49DE2726027E_var*
//#UC END# *47C68A220200_49DE2726027E_var*
begin
//#UC START# *47C68A220200_49DE2726027E_impl*
 DoSetEntryPoint(Value, Context);
//#UC END# *47C68A220200_49DE2726027E_impl*
end;//_evCursor_.SetEntryPoint

procedure _evCursor_.SetEntryPoint(aValue: Integer;
 const aContext: InevOp);
//#UC START# *47C68A2E00EC_49DE2726027E_var*
var
 l_CursorContext: IevCursorContext;
//#UC END# *47C68A2E00EC_49DE2726027E_var*
begin
//#UC START# *47C68A2E00EC_49DE2726027E_impl*
 if (aContext = nil) then
  SetEntryPoint(aValue)
 else
  if Supports(aContext, IevCursorContext, l_CursorContext) then
   SetEntryPoint(aValue, l_CursorContext)
  else
   SetEntryPoint(aValue);
//#UC END# *47C68A2E00EC_49DE2726027E_impl*
end;//_evCursor_.SetEntryPoint

function _evCursor_.ToBottomChild(const aView: InevView): InevBasePoint;
//#UC START# *47C68A42023A_49DE2726027E_var*
//#UC END# *47C68A42023A_49DE2726027E_var*
begin
//#UC START# *47C68A42023A_49DE2726027E_impl*
 Move(aView, ev_ocMakeChildChain);
 Result := _Instance_R_(Self).pm_GetMostInner;
//#UC END# *47C68A42023A_49DE2726027E_impl*
end;//_evCursor_.ToBottomChild

procedure _evCursor_.Set_PositionW(aValue: TnevPosition);
//#UC START# *47C68A520059_49DE2726027Eset_var*
//#UC END# *47C68A520059_49DE2726027Eset_var*
begin
//#UC START# *47C68A520059_49DE2726027Eset_impl*
 Position := aValue;
//#UC END# *47C68A520059_49DE2726027Eset_impl*
end;//_evCursor_.Set_PositionW

procedure _evCursor_.SetAtEnd(const aView: InevView;
 aValue: Boolean);
//#UC START# *4803044303DC_49DE2726027E_var*
//#UC END# *4803044303DC_49DE2726027E_var*
begin
//#UC START# *4803044303DC_49DE2726027E_impl*
 if (Self <> nil) then
  DoSetAtEnd(aView, aValue);
//#UC END# *4803044303DC_49DE2726027E_impl*
end;//_evCursor_.SetAtEnd

procedure _evCursor_.SetAtStart(const aView: InevView;
 aValue: Boolean);
//#UC START# *4803045B0109_49DE2726027E_var*
//#UC END# *4803045B0109_49DE2726027E_var*
begin
//#UC START# *4803045B0109_49DE2726027E_impl*
 if aValue then
  Move(aView, ev_ocTopLeft);
//#UC END# *4803045B0109_49DE2726027E_impl*
end;//_evCursor_.SetAtStart

procedure _evCursor_.DisableListener;
 {* Отключает нотификацию об изменении }
//#UC START# *4A4C856300DF_49DE2726027E_var*
//#UC END# *4A4C856300DF_49DE2726027E_var*
begin
//#UC START# *4A4C856300DF_49DE2726027E_impl*
 DoDisableListener;
//#UC END# *4A4C856300DF_49DE2726027E_impl*
end;//_evCursor_.DisableListener

procedure _evCursor_.EnableListener;
 {* Включает нотификацию об изменении }
//#UC START# *4A4C8581014B_49DE2726027E_var*
//#UC END# *4A4C8581014B_49DE2726027E_var*
begin
//#UC START# *4A4C8581014B_49DE2726027E_impl*
 DoEnableListener;
//#UC END# *4A4C8581014B_49DE2726027E_impl*
end;//_evCursor_.EnableListener

procedure _evCursor_.SetParentPoint(const aValue: InevBasePoint);
//#UC START# *49DE1C6903E1_49DE2726027E_var*
var
 l_Parent : InevBasePoint;
 l_List   : InevParaList;
 l_Pos    : Integer;
//#UC END# *49DE1C6903E1_49DE2726027E_var*
begin
//#UC START# *49DE1C6903E1_49DE2726027E_impl*
 inherited;
 if (ParaX = nil) then
 begin
  l_Parent := Self.pm_GetParentPoint;
  if (l_Parent <> nil) then
  begin
   if l_Parent.Obj.IsList then
    try
     l_List := l_Parent.Obj.AsPara.AsList;
     l_Pos := Pred(l_Parent.Position);
     if (l_Pos >= 0) AND (l_Pos < l_List.ParaCount) then
      ParaX := l_List[l_Pos];
    finally
     l_List := nil;
    end;//try..finally
  end;//l_Parent <> nil
 end;//ParaX = nil
//#UC END# *49DE1C6903E1_49DE2726027E_impl*
end;//_evCursor_.SetParentPoint

function _evCursor_.DoJoinWith(const aView: InevView;
 aSecondPara: Tl3Variant;
 const anOp: InevOp;
 MoveSubs: Boolean): Integer;
//#UC START# *49DEFB410161_49DE2726027E_var*
//#UC END# *49DEFB410161_49DE2726027E_var*
begin
//#UC START# *49DEFB410161_49DE2726027E_impl*
 Result := -1;
//#UC END# *49DEFB410161_49DE2726027E_impl*
end;//_evCursor_.DoJoinWith

function _evCursor_.DoSplit(const aView: InevView;
 aFlags: TnevInsertStringFlags;
 const anOp: InevOp): Il3TagRef;
//#UC START# *49DEFB770015_49DE2726027E_var*
//#UC END# *49DEFB770015_49DE2726027E_var*
begin
//#UC START# *49DEFB770015_49DE2726027E_impl*
 Result := Tl3NullTag.Instance;
//#UC END# *49DEFB770015_49DE2726027E_impl*
end;//_evCursor_.DoSplit

function _evCursor_.DoJoinWithNext(const aView: InevView;
 const anOp: InevOp): Boolean;
//#UC START# *49DF4C6E0101_49DE2726027E_var*
//#UC END# *49DF4C6E0101_49DE2726027E_var*
begin
//#UC START# *49DF4C6E0101_49DE2726027E_impl*
 Result := false;
//#UC END# *49DF4C6E0101_49DE2726027E_impl*
end;//_evCursor_.DoJoinWithNext

class function _evCursor_.StoreToOldCache: Boolean;
//#UC START# *49DF4E12001A_49DE2726027E_var*
//#UC END# *49DF4E12001A_49DE2726027E_var*
begin
//#UC START# *49DF4E12001A_49DE2726027E_impl*
 Result := true;
//#UC END# *49DF4E12001A_49DE2726027E_impl*
end;//_evCursor_.StoreToOldCache

function _evCursor_.GetRange: InevRange;
//#UC START# *49DF62920242_49DE2726027E_var*
//#UC END# *49DF62920242_49DE2726027E_var*
begin
//#UC START# *49DF62920242_49DE2726027E_impl*
 Result := nil;
//#UC END# *49DF62920242_49DE2726027E_impl*
end;//_evCursor_.GetRange

function _evCursor_.GetAsPoint: InevBasePoint;
//#UC START# *49DF62A201EB_49DE2726027E_var*
//#UC END# *49DF62A201EB_49DE2726027E_var*
begin
//#UC START# *49DF62A201EB_49DE2726027E_impl*
 Result := _Instance_R_(Self);
//#UC END# *49DF62A201EB_49DE2726027E_impl*
end;//_evCursor_.GetAsPoint

function _evCursor_.GetCanBeDeleted: Boolean;
//#UC START# *49DF6777033A_49DE2726027E_var*
//#UC END# *49DF6777033A_49DE2726027E_var*
begin
//#UC START# *49DF6777033A_49DE2726027E_impl*
 Result := not _Instance_R_(Self).ReadOnly;
//#UC END# *49DF6777033A_49DE2726027E_impl*
end;//_evCursor_.GetCanBeDeleted

function _evCursor_.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_49DE2726027E_var*
var
 l_Parent  : InevBasePoint;
 l_Sub     : IevSub;
 l_SubList : InevSubList;
//#UC END# *4A60B23E00C3_49DE2726027E_var*
begin
//#UC START# *4A60B23E00C3_49DE2726027E_impl*
 if IID.EQ(IevDocumentPart) then
 begin
  Result.SetNoInterface;
  l_Parent := _Instance_R_(Self);
  while (l_Parent <> nil) do
  begin
   if Supports(l_Parent, IevSub, l_Sub) then
    try
     if l_Sub.Exists then
     begin
      Result := Tl3HResult_C(l_Sub.QueryInterface(IID.IID, Obj));
      if Result.Ok then Exit;
     end;//l_Sub.Exists
    finally
     l_Sub := nil;
    end;//try..finally
   if (l_Parent.ParentPoint <> nil) then
    l_Parent := l_Parent.ParentPoint
   else
    break;
   if (l_Parent.Position > 1) then
    break;
  end;//while (l_Parent <> nil)
 end//IID.EQ(IevDocumentPart)
 else
 if IID.EQ(IevSub) then
 begin
  l_SubList := ParaX.MainSubList;
  if (l_SubList <> nil) then
   try
    Result.SetOk;
    with ParaX.AsObject.rAtomEx([k2_tiSubs,
                       k2_tiChildren, k2_tiHandle,  Ord(ev_sbtSub),
                       k2_tiChildren, k2_tiByIndex, 0,
                       k2_tiHandle]) do
     if IsValid then
      IevSub(Obj) := l_SubList.Sub[AsLong]
     else
      IevSub(Obj) := l_SubList.Sub[-1];
    if (IevSub(Obj) = nil) then
     Result.SetNOINTERFACE;
   finally
    l_SubList := nil;
   end//try..finally
  else
   Result.SetNOINTERFACE;
 end//IID.EQ(IevSub)
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_49DE2726027E_impl*
end;//_evCursor_.COMQueryInterface

procedure _evCursor_.Assign(Source: Tk2ToolPrim);
//#UC START# *52BC1DD60298_49DE2726027E_var*
//#UC END# *52BC1DD60298_49DE2726027E_var*
begin
//#UC START# *52BC1DD60298_49DE2726027E_impl*
 if (Self = Source) then
  Exit
 else
 if (Source Is _evCursor_) then
  Assert(false)
  //AssignPoint(Obj.Shape.View, InevPoint(_evCursor_(Source)))
 else
  inherited;
//#UC END# *52BC1DD60298_49DE2726027E_impl*
end;//_evCursor_.Assign

procedure _evCursor_.DoForceStore;
//#UC START# *5321B9DF011A_49DE2726027E_var*
var
 l_I : InevBasePoint;
//#UC END# *5321B9DF011A_49DE2726027E_var*
begin
//#UC START# *5321B9DF011A_49DE2726027E_impl*
 l_I := Self.GetInner;
 if (l_I <> nil) then
  l_I.AsObject.ForceStore;
 inherited;
//#UC END# *5321B9DF011A_49DE2726027E_impl*
end;//_evCursor_.DoForceStore
{$IfEnd} // Defined(evUseVisibleCursors)

{$EndIf evCursor_imp_impl}

{$EndIf evCursor_imp}

