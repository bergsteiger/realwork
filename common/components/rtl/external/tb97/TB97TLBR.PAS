unit TB97Tlbr;

{
  Toolbar97
  Copyright (C) 1998-99 by Jordan Russell
  For conditions of distribution and use, see LICENSE.TXT.

  TCustomToolbar97, TToolbar97, TToolbarSep97
}
{ $Id: TB97TLBR.PAS,v 1.103 2015/02/11 16:24:49 lulin Exp $ }

interface

{$I TB97Ver.inc}

uses
  Windows,
  Messages,
  Classes,
  Controls,
  Graphics,
  ComCtrls,
  TB97,
  Buttons,
  StdCtrls,
  Contnrs,
  ExtCtrls,
  Forms,
  ActnList,

  l3InternalInterfaces,
  
  tb97vt,
  tb97List,
  tb97Ctls,
  tb97GraphicControl,
  tb97ExtInterfaces,

  {$IfNDef NoVCM}
  vcmExternalInterfaces,
  {$EndIf  NoVCM}

  l3Base,
  l3ObjectList,
  l3LongintList  
  ;

type
  { TCustomToolbar97 }
  TTB97Tag = (tb97tagDropWin         = 1,
              tb97tagHiddenSeparator = 2,
              tb97tagAny             = {65535}3,
              tb97tagRestoreEnabled  = 4);

  Ttb97MoreButton = class(TCustomToolbarButton97)
  // !! в TCustomToolbarButton97 метод Click защищён скобками. Если наследовать
  // от другого объекта, нужно в Click'е прописывать скобки
  // tb97StartOp/tb97EndOp для того, чтобы кнопка не умерла с тулбаром в
  // процессе выполнения Action'а (верно только при использовании из vcm).
  end;//Ttb97MoreButton

  TToolbarParams = record
    InitializeOrderByPosition, DesignOrderByPosition: Boolean;
  end;

  TCustomToolbar97 = class(TCustomToolWindow97)
  private
    FToolbarParams: TToolbarParams;
    FFloatingRightX: Integer;
    FOrderListDirty: Boolean;
    SizeData: Pointer;

    FMoreButton: Ttb97MoreButton;

    { Lists }
    SlaveInfo,         { List of slave controls. Items are pointers to TSlaveInfo's }
    GroupInfo,         { List of the control "groups". List items are pointers to TGroupInfo's }
    LineSeps,          { List of the Y locations of line separators. Items are casted in TLineSep's }
    MarkList: Ttb97List;   { Список признаков контролов (то, для чего сначала использовался _Tag). 0 - видимый, 1 - невидимый, второй бит - выставить Enabled=true при раскрывании }


    f_ResizeLockedCount: Integer;
    f_Bounds: TRect;
    { Property access methods }
    function GetOrderedControls (Index: Integer): TControl;
    function GetOrderedControlsCount: Integer;
    function GetOrderIndex (Control: TControl): Integer;
    procedure SetFloatingWidth (Value: Integer);
    procedure SetOrderIndex (Control: TControl; Value: Integer);

    { Internal }
    procedure CleanOrderList;
    procedure SetControlVisible (const Control: TControl;
      const LeftOrRight: Boolean);
    function ShouldControlBeVisible (const Control: TControl;
      const LeftOrRight: Boolean): Boolean;
    procedure FreeGroupInfo (const List: Ttb97List);
    procedure RemoveRedundantSeparators(aList:Tl3ObjectList);
    procedure BuildGroupInfo (const List: Ttb97List; const TranslateSlave: Boolean;
      const OldDockType, NewDockType: TDockType);

    { Messages }
    procedure CMControlListChange (var Message: TCMControlListChange); message CM_CONTROLLISTCHANGE;
    procedure WMWindowPosChanging (var Message: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;
    procedure WMSetFocus (var Message:TWMSetFocus); message WM_SETFOCUS;
  protected
    f_OrderList: Ttb97ControlsList;
    { List of the child controls, arranged using the current "OrderIndex" values }

    FAssList:TAssList;
    FNeedExecution:TNotifyEvent;
    FExecOwner:TObject;
    FPopWin:TVtPopupWindow;
    FCurrentAction:TCustomAction;
    FHideExtraSeparators: Boolean;
    FHasInvisibleButtons: Boolean;
    
    property ToolbarParams: TToolbarParams read FToolbarParams;

    procedure Paint; override;

    procedure BuildPotentialSizesList (SizesList: Tl3LongintList); virtual;
    function ChildControlTransparent (Ctl: TControl): Boolean; override;
    procedure GetParams (var Params: TToolWindowParams); override;
    procedure GetToolbarParams (var Params: TToolbarParams); virtual;
    procedure ResizeBegin (ASizeHandle: TToolWindowSizeHandle); override;
    procedure ResizeTrack (var Rect: TRect; const OrigRect: TRect); override;
    procedure ResizeEnd (Accept: Boolean); override;

    function IsGToolbarSizeNeeded: Boolean; virtual;
    procedure GetBarSize (var ASize: Integer; const DockType: TDockType); override;
    procedure GetMinimumSize (var AClientWidth, AClientHeight: Integer); override;
    procedure InitializeOrdering; override;
    function OrderControls (CanMoveControls: Boolean; PreviousDockType: TDockType;
      DockingTo: TDock97): TPoint; override;

    procedure UpdateEmpty(aUpdateVisibility : Boolean = True); override;
////////////////////////////////////////////////////////////////////////////////
    procedure ExecuteDefered; virtual;
    procedure MoreButtonClickHandler(Sender:TObject); virtual;
    procedure ExecuteHandler(Sender:TObject); virtual;
    function ActionTerminatesWindow(const aAction:TCustomAction):Boolean; virtual;

  public
    function CanAddSeparator: Boolean;
    procedure LockResize;
    procedure UnlockResize;
    procedure SetBounds(ALeft: Integer;
      ATop: Integer;
      AWidth: Integer;
      AHeight: Integer); override;
  protected
    procedure AdjustSizeForPanels; virtual;
    procedure DeleteLastIfSeparator;

    procedure SetHideExtraSeparators(aValue: Boolean);
    function MaxControlWidthWithMargins(const aMax: Integer): Integer;
      {* - максимальный размер компонента с отступами слева\справа. }
////////////////////////////////////////////////////////////////////////////////
      procedure Cleanup;
        override;
        {-}
  public
  // public methods
    constructor Create (AOwner : TComponent);
      override;
      {-}
    procedure Notification(AComponent : TComponent;
                           Operation  : TOperation);
      override;
      {-}
    procedure ReadPositionData (const ReadIntProc   : TPositionReadIntProc;
                               const ReadStringProc : TPositionReadStringProc;
                               const ExtraData      : Pointer);
      override;
      {-}
    procedure WritePositionData (const WriteIntProc    : TPositionWriteIntProc;
                                 const WriteStringProc : TPositionWriteStringProc;
                                 const ExtraData       : Pointer);
      override;
      {-}
    procedure SetSlaveControl (const ATopBottom, ALeftRight: TControl);
      {-}
  public
  // public properties
    property OrderedControls[Index: Integer]: TControl
      read GetOrderedControls;
      {-}
    property OrderedControlsCount: Integer
      read GetOrderedControlsCount;
      {-}
    property OrderIndex[Control: TControl]: Integer
      read GetOrderIndex
      write SetOrderIndex;
      {-}
    property FloatingWidth: Integer
      read FFloatingRightX
      write SetFloatingWidth;
      {-}
/////////////////////////////// новые /////////////////////////////////
    function EstimateStretch(ARequestedSize : Integer;
                             ALeftRight     : Boolean) : Integer;
      override;
      {-}
    procedure Stretch(ARequestedSize : Integer;
                      ALeftRight     : Boolean);
      override;
      {-}
    function getWidth : Integer;
      override;
      {-}
    function getHeight : Integer;
      override;
      {-}
    function FullWidth : Integer;
      override;
      {-}
    function FullHeight : Integer;
      override;
      {-}
    function Tagged(Control : TControl;
                    aTag    : TTB97Tag):Boolean;
      {-}
    procedure SetTagByIndex(aIndex : Integer;
                            aTag   : TTB97Tag);
      {-}
    procedure DropTagByIndex(aIndex : Integer;
                             aTag   : TTB97Tag);
      {-}
    procedure SetTagByObject(aObject : TControl;
                             aTag    : TTB97Tag);
      {-}
    procedure DropTagByObject(aObject : TControl;
                              aTag    : TTB97Tag);
      {-}
    // корректное освобождение контролов, лежащих на тулбаре
    procedure FreeControls;
      {-}
    procedure ExpandControls;
      override;
      {* - разворачивает компоненты на их полную длину, используется в случае
           когда toolbar помещается во всю длину. }
  public
  // public properties
    property HideExtraSeparators : Boolean
      read FHideExtraSeparators
      write SetHideExtraSeparators;
      {-}
///////////////////////////////////////////////////////////////////////
  end;//TCustomToolbar97

  { TToolbar97 }

  TToolbar97 = class(TCustomToolbar97)
  published
    property AutoSize;

    property Top
      default 0;
      {-}
    property ActivateParent;
    property BorderStyle;
    property Caption;
    property Color;
    property CloseButton;
    property CloseButtonWhenDocked;
    property DefaultDock;
    property DockableTo;
    property DockedTo;
    property DockMode;
    property DockPos;
    property DockRow;
    property DragHandleStyle;
    property FloatingMode;
    property Font;
    property FullSize;
    property HideWhenInactive;
    property LastDock;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property Resizable;
    property ShowCaption;
    property ShowHint;
    property TabOrder;
    property UseLastDock;
    property Visible;

    property OnClose;
    property OnCloseQuery;
    property OnDragDrop;
    property OnDragOver;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMove;
    property OnRecreated;
    property OnRecreating;
    property OnDockChanged;
    property OnDockChanging;
    property OnDockChangingEx;
    property OnDockChangingHidden;
    property OnResize;
    property OnVisibleChanged;
  end;//TToolbar97

  { TToolbarSep97 }

  TToolbarSepSize = 1..MaxInt;

  TToolbarSep97 = class(Ttb97GraphicControl)
  private
    FBlank: Boolean;
    FSizeHorz, FSizeVert: TToolbarSepSize;
    procedure SetBlank (Value: Boolean);
    procedure SetSizeHorz (Value: TToolbarSepSize);
    procedure SetSizeVert (Value: TToolbarSepSize);
  protected
    procedure MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      override;
      {-}
    procedure DoPaint(const aCN: Il3Canvas);
      override;
    procedure SetParent (AParent: TWinControl); override;
  public
    constructor Create (AOwner: TComponent); override;
  published
    { These two properties don't need to be stored since it automatically gets
      resized based on the setting of SizeHorz and SizeVert }
    property Width stored False;
    property Height stored False;
    property Blank: Boolean read FBlank write SetBlank default False;
    property SizeHorz: TToolbarSepSize read FSizeHorz write SetSizeHorz default 6;
    property SizeVert: TToolbarSepSize read FSizeVert write SetSizeVert default 6;
    property Visible;
  end;//TToolbarSep97


{$IFOPT J+}
  {$DEFINE _TB97_OPT_J}
  {$J-}  { don't let the following typed constants be modified }
{$ENDIF}
const
  tb97DefaultBarWidthHeight = 8;

  tb97TopMarginFloating = 2;
  tb97TopMarginDocked = 0;
  tb97TopMargin: array[Boolean] of Integer = (tb97TopMarginFloating, tb97TopMarginDocked);
  tb97BottomMarginFloating = 1;
  tb97BottomMarginDocked = 0;
  tb97BottomMargin: array[Boolean] of Integer = (tb97BottomMarginFloating, tb97BottomMarginDocked);
  tb97LeftMarginFloating = 4;
  tb97LeftMarginDocked = 0;
  tb97LeftMargin: array[Boolean] of Integer = (tb97LeftMarginFloating, tb97LeftMarginDocked);
  tb97RightMarginFloating = 4;
  tb97RightMarginDocked = 0;
  tb97RightMargin: array[Boolean] of Integer = (tb97RightMarginFloating, tb97RightMarginDocked);
  tb97LineSpacing = 6;
{$IFDEF _TB97_OPT_J}
  {$J+}
  {$UNDEF _TB97_OPT_J}
{$ENDIF}

type
 TtbToolbarSize = procedure (aToolbar : TCustomToolbar97;
                           var Size : Integer) of Object;
   {-}

var
 g_ToolbarSize : TtbToolbarSize = nil;
   {-}

implementation

{$R 'TB97_CUSTOM.RES'}

uses
  SysUtils,

  afwFacade,

  TB97Cmn,
  TB97Cnst,
  tb97Mem
  {$If not defined(NoScripts)}
  ,
  tfwClassRef
  {$IfEnd} //not NoScripts
  ;

const
  { Constants for registry values. Do not localize! }
  { TCustomToolbar97 specific }
  rvFloatRightX = 'FloatRightX';

type
  { Used internally by the TCustomToolbar97.Resize* procedures }
  PToolbar97SizeData = ^TToolbar97SizeData;
  TToolbar97SizeData = record
    SizeHandle: TToolWindowSizeHandle;
    NewSizes: Tl3LongintList;  { List of valid new sizes. Items are casted into TSmallPoints }
    CurRightX: Integer;
    DisableSensCheck, OpSide: Boolean;
    SizeSens: Integer;
  end;

  { Used in TCustomToolbar97.GroupInfo lists }
  PGroupInfo = ^TGroupInfo;
  TGroupInfo = record
    GroupWidth,           { Width in pixels of the group, if all controls were
                            lined up left-to-right }
    GroupHeight: Integer; { Heights in pixels of the group, if all controls were
                            lined up top-to-bottom }
    Members: Tl3ObjectList;
  end;

  { Used in TCustomToolbar97.SlaveInfo lists }
  PSlaveInfo = ^TSlaveInfo;
  TSlaveInfo = record
    LeftRight,
    TopBottom: TControl;
  end;

  { Used in TCustomToolbar97.LineSeps lists }
  TLineSep = packed record
    Y: SmallInt;
    Blank: Boolean;
    Unused: Boolean;
  end;

  { Use by CompareControls }
  PCompareExtra = ^TCompareExtra;
  TCompareExtra = record
    Toolbar: TCustomToolbar97;
    ComparePositions: Boolean;
    CurDockType: TDockType;
  end;


procedure TCustomToolbar97.RemoveRedundantSeparators(aList:Tl3ObjectList);
var
  Index, LastIndex:Integer;
  Flag:Boolean;
begin
  Flag := true;
  Index := 0;
  LastIndex := -1;
  while Index < aList.Count do begin
    if TControl(aList[Index]) is TToolbarSep97 then begin
      if Flag then begin
        SetTagByObject(TControl(aList[Index]), tb97tagHiddenSeparator);        
      end
      else begin
        Flag := true;
        LastIndex := Index;        
        DropTagByObject(TControl(aList[Index]), tb97tagHiddenSeparator);
      end;
    end
    else begin
      Flag := false;
      LastIndex := -1;
    end;
    inc(Index);
  end;
  if Flag and (LastIndex > -1) then    
    SetTagByObject(TControl(aList[LastIndex]), tb97tagHiddenSeparator);    
end;

{ TCustomToolbar97 }

constructor TCustomToolbar97.Create (AOwner: TComponent);
begin
  inherited;
 f_ResizeLockedCount := 0;
 l3FillChar(f_Bounds, SizeOf(f_Bounds));
  GetToolbarParams (FToolbarParams);
  GroupInfo := Ttb97List.Make;
  SlaveInfo := Ttb97List.Make;
  LineSeps := Ttb97List.Make;
  f_OrderList := Ttb97ControlsList.Make;
  MarkList := Ttb97List.Make;
  /////////////////////////////////////
  FMoreButton := Ttb97MoreButton.Create(self);
  FMoreButton.Layout := blGlyphTop;
  FMoreButton.Glyph.Handle := LoadBitmap(hInstance, 'TB97_ARROW');
  FMoreButton.Parent := self;
  FMoreButton.Flat := true;
  FMoreButton.Width := c_tbMoreButtonSize;
  FMoreButton.Left := -FMoreButton.Width-1;
  FMoreButton.Top := -FMoreButton.Height-1;
  //FMoreButton.ProtectedClick := False;
  FMoreButton.Show;

  FMoreButton.OnClick := MoreButtonClickHandler;
  FStretched := false;
  FHasInvisibleButtons := False;
  FHideExtraSeparators := false;
  FEmpty := False;

  DoubleBuffered := true;
end;

procedure TCustomToolbar97.Cleanup;
var
  I: Integer;
begin
  //tb97Free(FMoreButton);
  /////////////////////////
 f_ResizeLockedCount := 0;
 l3FillChar(f_Bounds, SizeOf(f_Bounds));
  tb97Free(f_OrderList);
  tb97Free(MarkList);
  tb97Free(LineSeps);
  if Assigned(SlaveInfo) then begin
    for I := SlaveInfo.Count-1 downto 0 do
      tb97FreeMemPrim(SlaveInfo.Items[I]);
    tb97Free(SlaveInfo);
  end;
  FreeGroupInfo (GroupInfo);
  tb97Free(GroupInfo);
  inherited;
end;

procedure TCustomToolbar97.Notification(AComponent: TComponent; Operation: TOperation);
  //override;
  {-}
begin
 inherited;
 if (Operation = opRemove) then
 begin
  if (aComponent = FMoreButton) then
   FMoreButton := nil;
 end;//Operation = opRemove
end;

procedure TCustomToolbar97.ReadPositionData (const ReadIntProc: TPositionReadIntProc;
  const ReadStringProc: TPositionReadStringProc; const ExtraData: Pointer);
begin
  inherited;
  FFloatingRightX := ReadIntProc(Name, rvFloatRightX, 0, ExtraData);
end;

procedure TCustomToolbar97.WritePositionData (const WriteIntProc: TPositionWriteIntProc;
  const WriteStringProc: TPositionWriteStringProc; const ExtraData: Pointer);
begin
  inherited;
  WriteIntProc (Name, rvFloatRightX, FFloatingRightX, ExtraData);
end;

procedure TCustomToolbar97.GetMinimumSize (var AClientWidth, AClientHeight: Integer);
begin
  AClientWidth := 0;
  AClientHeight := 0;
end;

procedure TCustomToolbar97.CleanOrderList;
{ TCustomToolbar97 uses a CM_CONTROLLISTCHANGE handler to detect when new
  controls are added to the toolbar. The handler adds the new controls to
  OrderList, which can be manipulated by the application using the OrderIndex
  property.
  The only problem is, the VCL relays CM_CONTROLLISTCHANGE messages
  to all parents of a control, not just the immediate parent. In pre-1.76
  versions of Toolbar97, OrderList contained not only the immediate children
  of the toolbar, but their children too. So this caused the OrderIndex
  property to return unexpected results.
  What this method does is clear out all controls in OrderList that aren't
  immediate children of the toolbar. (A check of Parent can't be put into the
  CM_CONTROLLISTCHANGE handler because that message is sent before a new
  Parent is assigned.) }
var
  I: Integer;
begin
  if not FOrderListDirty then
    Exit;
  I := 0;
  assert(f_OrderList.Count = MarkList.Count);
  while I < f_OrderList.Count do begin
    if (f_OrderList[I].Parent <> Self) then
    begin
     f_OrderList.Delete(I);
     MarkList.Delete(I);
    end
    else
     Inc(I);
  end;
  FOrderListDirty := False;
  assert(f_OrderList.Count = MarkList.Count);  
end;

function CompareControls (const Item1, Item2, ExtraData: Pointer): Integer; far;
begin
  with PCompareExtra(ExtraData)^ do
    if ComparePositions then begin
      if CurDockType <> dtLeftRight then
        Result := TControl(Item1).Left - TControl(Item2).Left
      else
        Result := TControl(Item1).Top - TControl(Item2).Top;
    end
    else
     if (Item1 = Item2) then
      Result := 0
     else
      with Toolbar.f_OrderList do
       Result := IndexOf(Item1) - IndexOf(Item2);
end;

procedure TCustomToolbar97.InitializeOrdering;
var
  Extra: TCompareExtra;
begin
  inherited;
  { Initialize order of items in OrderList }
  if ToolbarParams.InitializeOrderByPosition then begin
    with Extra do begin
      Toolbar := Self;
      ComparePositions := True;
      CurDockType := GetDockTypeOf(DockedTo);
    end;
    CleanOrderList;
    ListSortEx(f_OrderList, CompareControls, @Extra, MarkList);
  end;
end;

function TCustomToolbar97.IsGToolbarSizeNeeded: Boolean;
begin
 Result := True;
end;

procedure TCustomToolbar97.GetBarSize (var ASize: Integer; const DockType: TDockType);
var
 I     : Integer;
 lSize : Integer;
begin
 ASize := tb97DefaultBarWidthHeight;
 (* ищем компонент с наибольшим размером *)
 for I := 0 to ControlCount-1 do
   if not(Controls[I] is TToolbarSep97) and
      not(Controls[I] is Ttb97MoreButton) then
     with Controls[I] do begin
       if ShouldControlBeVisible(Controls[I], DockType = dtLeftRight) then begin
         if DockType = dtLeftRight then begin
           if Width > ASize then ASize := Width;
         end
         else begin
           if Height > ASize then ASize := Height;
         end;
       end;
     end;
 (* определена глобальная процедура определения размеров *)
 if IsGToolbarSizeNeeded then
  if Assigned(g_ToolbarSize) and Assigned(DockedTo) and
   (DockedTo.Position in [dpTop, dpBottom]) then
  begin
   g_ToolbarSize(Self, lSize);
   if lSize <> 0 then
    ASize := lSize;
  end;
end;

procedure TCustomToolbar97.GetParams (var Params: TToolWindowParams);
begin
  inherited;
  with Params do begin
    CallAlignControls := False;
    ResizeEightCorner := False;
    ResizeClipCursor := False;
  end;
end;

procedure TCustomToolbar97.GetToolbarParams (var Params: TToolbarParams);
begin
  with Params do begin
    InitializeOrderByPosition := True;
    DesignOrderByPosition := True;
  end;
end;

procedure TCustomToolbar97.Paint;
var
  S: Integer;
begin
//  UpdateDockedNCArea;//насильно прорисовываем background
  inherited;
  if Locked then
   Exit;
  { Long separators when not docked }
  if not Docked then
    for S := 0 to LineSeps.Count-1 do begin
      with TLineSep(LineSeps[S]) do begin
        if Blank then Continue;
        Canvas.Pen.Color := clBtnShadow;
        Canvas.MoveTo (1, Y-4);  Canvas.LineTo (ClientWidth-1, Y-4);
        Canvas.Pen.Color := clBtnHighlight;
        Canvas.MoveTo (1, Y-3);  Canvas.LineTo (ClientWidth-1, Y-3);
      end;
    end;
end;

function ControlVisibleOrDesigning (AControl: TControl): Boolean;
begin
  Result := AControl.Visible or  (csDesigning in AControl.ComponentState);
end;

procedure TCustomToolbar97.SetControlVisible (const Control: TControl;
  const LeftOrRight: Boolean);
{ If Control is a master or slave control, it automatically adjusts the
  Visible properties of both the master and slave control based on the value
  of LeftOrRight }
var
  I: Integer;
begin
  for I := 0 to SlaveInfo.Count-1 do
    with PSlaveInfo(SlaveInfo[I])^ do
      if (TopBottom = Control) or (LeftRight = Control) then begin
        if Assigned(TopBottom) then TopBottom.Visible := not LeftOrRight;
        if Assigned(LeftRight) then LeftRight.Visible := LeftOrRight;
        Exit;
      end;
end;

function TCustomToolbar97.ShouldControlBeVisible (const Control: TControl;
  const LeftOrRight: Boolean): Boolean;
{ If Control is a master or slave control, it returns the appropriate visibility
  setting based on the value of LeftOrRight, otherwise it simply returns the
  current Visible setting }
var
  I: Integer;
begin
  for I := 0 to SlaveInfo.Count-1 do
    with PSlaveInfo(SlaveInfo[I])^ do
      if TopBottom = Control then begin
        Result := not LeftOrRight;
        Exit;
      end
      else
      if LeftRight = Control then begin
        Result := LeftOrRight;
        Exit;
      end;
  Result := ControlVisibleOrDesigning(Control);
end;

procedure TCustomToolbar97.FreeGroupInfo (const List: Ttb97List);
var
  I: Integer;
  L: PGroupInfo;
begin
  if List = nil then Exit;
  for I := List.Count-1 downto 0 do begin
    L := List.Items[I];
    if Assigned(L) then begin
      tb97Free(L^.Members);
      tb97FreeMem(L);
    end;
    List.Delete(I);
  end;
end;

procedure TCustomToolbar97.BuildGroupInfo (const List: Ttb97List;
  const TranslateSlave: Boolean; const OldDockType, NewDockType: TDockType);
var
  I: Integer;
  GI: PGroupInfo;
  Children: Tl3ObjectList; {items casted into TControls}
  C: TControl;
  NewGroup: Boolean;
  Extra: TCompareExtra;
begin
  FreeGroupInfo (List);
  if ControlCount <= 1 then Exit;

  Children := Tl3ObjectList.Make;
  try
    for I := 0 to ControlCount-1 do
      if ((not TranslateSlave and ControlVisibleOrDesigning(Controls[I])) or
         (TranslateSlave and ShouldControlBeVisible(Controls[I], NewDockType = dtLeftRight))) and
         not (Controls[I] is Ttb97MoreButton)then
        Children.Add (Controls[I]);

    with Extra do begin
      Toolbar := Self;
      CurDockType := OldDockType;
      ComparePositions := (csDesigning in ComponentState) and
        ToolbarParams.DesignOrderByPosition;
    end;
    if Extra.ComparePositions then begin
      CleanOrderList;
      ListSortEx(f_OrderList, CompareControls, @Extra, MarkList);
    end;
    ListSortEx(Children, CompareControls, @Extra);

    if FHideExtraSeparators then
      RemoveRedundantSeparators(Children);

    GI := nil;
    NewGroup := True;
    for I := 0 to Children.Count-1 do begin
      if NewGroup then begin
        NewGroup := False;
        GI := tb97AllocMem(SizeOf(TGroupInfo));
        { Note: AllocMem initializes the newly allocated data to zero }
        GI^.Members := Tl3ObjectList.Make;
        List.Add (GI);
      end;
      C := TControl(Children[I]);
      GI^.Members.Add (C);
      if C is TToolbarSep97 then
        NewGroup := True
      else begin
        with C do begin
          Inc (GI^.GroupWidth, Width);
          Inc (GI^.GroupHeight, Height);
        end;
      end;
    end;
  finally
    tb97Free(Children);
  end;
end;

function TCustomToolbar97.MaxControlWidthWithMargins(const aMax: Integer): Integer;
  {* - максимальный размер компонента с отступами слева\справа. }
var
 l_Width : Integer;
 I       : Integer;
begin
 Result := aMax;
 for I := 0 to Pred(ControlCount) do
  if not(Controls[I] is TToolbarSep97) then
   with Controls[I] do
   begin
    l_Width := Width + tb97LeftMarginFloating + tb97RightMarginFloating;
    if l_Width > Result then
     Result := l_Width;
   end;//with Controls[I] do
end;//MaxControlWidthWithMargins

function TCustomToolbar97.OrderControls (CanMoveControls: Boolean;
  PreviousDockType: TDockType; DockingTo: TDock97): TPoint;
{ This arranges the controls on the toolbar }
var
  NewDockType      : TDockType;
  NewDocked        : Boolean;
  RightX, I        : Integer;
  CurBarSize       : Integer;
  DockRowSize      : Integer;
  GInfo            : Ttb97List;
  AllowWrap        : Boolean;
  MinPosPixels     : Integer;
  MinRowPixels     : Integer;
  CurPosPixel      : Integer;
  CurLinePixel     : Integer;
  G                : Integer;
  GoToNewLine      : Boolean;
  GI               : PGroupInfo;
  Member           : TControl;
  MemberIsSep      : Boolean;
  GroupPosSize     : Integer;
  MemberPosSize    : Integer;
  PreviousSep      : TToolbarSep97;
  PrevMinPosPixels : Integer;
  NewLineSep       : TLineSep;
  MaxSize          : Integer;
  StartPos         : Integer;
begin
  NewDockType := GetDockTypeOf(DockingTo);
  NewDocked := Assigned(DockingTo);

  RightX := FFloatingRightX;
  if (NewDockType <> dtNotDocked) or (RightX = 0) then
    RightX := High(RightX)
  { Make sure RightX isn't less than the smallest sized control + margins,
    in case one of the *LoadToolbarPositions functions happened to read
    a value too small. }
  else
   RightX := MaxControlWidthWithMargins(RightX);

  if CanMoveControls and (SlaveInfo.Count <> 0) then
    for I := 0 to ControlCount-1 do
      if not(Controls[I] is TToolbarSep97) and not(Controls[I] is Ttb97MoreButton) then
        SetControlVisible (Controls[I], NewDockType = dtLeftRight);

  GetBarSize (CurBarSize, NewDockType);
   if (DockingTo <> nil) and (DockingTo = DockedTo) then
     GetDockRowSize (DockRowSize)
   else
     DockRowSize := CurBarSize;

  if CanMoveControls then
    GInfo := GroupInfo
  else
    GInfo := Ttb97List.Make;
  try
    BuildGroupInfo (GInfo, not CanMoveControls, PreviousDockType, NewDockType);

    if CanMoveControls then
      LineSeps.Clear;

    CurLinePixel := tb97TopMargin[NewDocked];
    MinPosPixels := tb97LeftMargin[NewDocked];
    if GInfo.Count <> 0 then begin
      AllowWrap := not NewDocked;
      CurPosPixel := MinPosPixels;
      GoToNewLine := False;
      PreviousSep := nil;  PrevMinPosPixels := 0;
      for G := 0 to GInfo.Count-1 do begin
        GI := PGroupInfo(GInfo[G]);

        if NewDockType <> dtLeftRight then
          GroupPosSize := GI^.GroupWidth
        else
          GroupPosSize := GI^.GroupHeight;
        if AllowWrap and
           (GoToNewLine or (CurPosPixel+GroupPosSize+tb97RightMargin[NewDocked] > RightX)) then begin
          GoToNewLine := False;
          CurPosPixel := tb97LeftMargin[NewDocked];
          if (G <> 0) and (PGroupInfo(GInfo[G-1])^.Members.Count <> 0) then begin
            Inc (CurLinePixel, CurBarSize + tb97LineSpacing);
            if Assigned(PreviousSep) then begin
              MinPosPixels := PrevMinPosPixels;
              if CanMoveControls then begin
                PreviousSep.Width := 0;

                LongInt(NewLineSep) := 0;
                NewLineSep.Y := CurLinePixel;
                NewLineSep.Blank := PreviousSep.Blank;
                LineSeps.Add (Pointer(NewLineSep));
              end;
            end;
          end;
        end;
        if CurPosPixel > MinPosPixels then MinPosPixels := CurPosPixel;
        for I := 0 to GI^.Members.Count-1 do begin
          Member := TControl(GI^.Members[I]);
          MemberIsSep := Member is TToolbarSep97;
          with Member do begin
            if not MemberIsSep then begin
              if NewDockType <> dtLeftRight then
                MemberPosSize := Width
              else
                MemberPosSize := Height;
            end
            else begin
              if NewDockType <> dtLeftRight then
                MemberPosSize := TToolbarSep97(Member).SizeHorz
              else
                MemberPosSize := TToolbarSep97(Member).SizeVert;
            end;
            { If RightX is passed, proceed to next line }
            if AllowWrap and not MemberIsSep and
               (CurPosPixel+MemberPosSize+tb97RightMargin[NewDocked] > RightX) then begin
              CurPosPixel := tb97LeftMargin[NewDocked];
              Inc (CurLinePixel, CurBarSize);
              GoToNewLine := True;
            end;
            if NewDockType <> dtLeftRight then begin
              if not MemberIsSep then begin
                if CanMoveControls then begin
                  if (Tagged(Member, tb97tagDropWin) and (Self.DockedTo<>nil)) or
                     Tagged(Member, tb97tagHiddenSeparator) then begin
                    FCustomState := FCustomState+[csRestrictAlign];
                    SetBounds (-Width-1, -Height-1, Width, Height);
                    FCustomState := FCustomState-[csRestrictAlign];
                  end
                  else begin
                    //if not SamePos(Left, Top, CurPosPixel, CurLinePixel+((DockRowSize-Height) div 2)) then begin
                      FCustomState := FCustomState+[csRestrictAlign];
                      SetBounds (CurPosPixel, CurLinePixel+((DockRowSize-Height) div 2), Width, Height);
                      FCustomState := FCustomState-[csRestrictAlign];
                    //end;
                    Inc (CurPosPixel, Width);
                  end;
                end
                else begin
                  if not (Tagged(Member, tb97tagDropWin) and (Self.DockedTo<>nil)) and
                     not Tagged(Member, tb97tagHiddenSeparator) then
                    Inc (CurPosPixel, Width);
                end;
              end
              else begin
                if CanMoveControls then begin
                  if (Tagged(Member, tb97tagDropWin) and (Self.DockedTo<>nil)) or
                     Tagged(Member, tb97tagHiddenSeparator) then begin
                    FCustomState := FCustomState+[csRestrictAlign];
                    SetBounds (-TToolbarSep97(Member).SizeHorz-1, -DockRowSize-1, TToolbarSep97(Member).SizeHorz, DockRowSize);
                    FCustomState := FCustomState-[csRestrictAlign];
                  end
                  else begin
                    //if not SamePos(Left, Top, CurPosPixel, CurLinePixel) then begin
                      FCustomState := FCustomState+[csRestrictAlign];
                      SetBounds (CurPosPixel, CurLinePixel, TToolbarSep97(Member).SizeHorz, DockRowSize);
                      FCustomState := FCustomState-[csRestrictAlign];
                    //end;
                    Inc (CurPosPixel, TToolbarSep97(Member).SizeHorz);
                  end;
                end
                else begin
                  if not (Tagged(Member, tb97tagDropWin) and (Self.DockedTo<>nil)) and
                     not Tagged(Member, tb97tagHiddenSeparator) then
                    if MemberIsSep then
                     Inc (CurPosPixel, TToolbarSep97(Member).SizeHorz)
                    else
                     Inc (CurPosPixel, Width);
                end;
              end;
            end
            else begin
              if not MemberIsSep then begin
                if CanMoveControls then begin
                  if (Tagged(Member, tb97tagDropWin) and (Self.DockedTo<>nil)) or
                     Tagged(Member, tb97tagHiddenSeparator) then begin
                    SetBounds (-Width-1, -Height-1, Width, Height);
                  end
                  else begin
                    //if not SamePos(Left, Top, CurLinePixel+((DockRowSize-Width) div 2), CurPosPixel) then begin
                      FCustomState := FCustomState+[csRestrictAlign];
                      SetBounds (CurLinePixel+((DockRowSize-Width) div 2), CurPosPixel, Width, Height);
                      FCustomState := FCustomState-[csRestrictAlign];
                    //end;
                    Inc (CurPosPixel, Height);
                  end;
                end
                else begin
                  if not (Tagged(Member, tb97tagDropWin) and (Self.DockedTo<>nil)) and
                     not Tagged(Member, tb97tagHiddenSeparator) then
                    Inc (CurPosPixel, Width);
                end;
              end
              else begin
                if CanMoveControls then begin
                  if (Tagged(Member, tb97tagDropWin) and (Self.DockedTo<>nil)) or
                     Tagged(Member, tb97tagHiddenSeparator) then begin
                    FCustomState := FCustomState+[csRestrictAlign];
                    SetBounds (-DockRowSize-1, -TToolbarSep97(Member).SizeVert-1, DockRowSize, TToolbarSep97(Member).SizeVert);
                    FCustomState := FCustomState-[csRestrictAlign];
                  end
                  else begin
                    //if not SamePos(Left, Top, CurLinePixel, CurPosPixel) then begin
                      FCustomState := FCustomState+[csRestrictAlign];
                      SetBounds (CurLinePixel, CurPosPixel, DockRowSize, TToolbarSep97(Member).SizeVert);
                      FCustomState := FCustomState-[csRestrictAlign];
                    //end;
                    Inc (CurPosPixel, TToolbarSep97(Member).SizeVert);
                  end;
                end
                else begin
                  if not (Tagged(Member, tb97tagDropWin) and (Self.DockedTo<>nil)) and
                     not Tagged(Member, tb97tagHiddenSeparator) then
                    Inc (CurPosPixel, Width);                
                end;
              end;
            end;
            PrevMinPosPixels := MinPosPixels;
            if not MemberIsSep then
              PreviousSep := nil
            else
              PreviousSep := TToolbarSep97(Member);
            if CurPosPixel > MinPosPixels then MinPosPixels := CurPosPixel;
          end;
        end;
      end;
    end
    else
      Inc (MinPosPixels, tb97DefaultBarWidthHeight);

    if Collapsible and FHasInvisibleButtons and (DockedTo<>nil) then begin
      {найдём контрол с наибольшим Height}
      MaxSize := 0;              
      StartPos := 0;
      for I := 0 to ControlCount-1 do begin
        if (not Tagged(Controls[I], tb97tagAny)) and not (Controls[I] is Ttb97MoreButton) then begin
          if not (DockedTo.Position in [dpLeft, dpRight]) then begin
            if Controls[I].Height>MaxSize then
            begin
              MaxSize := Controls[I].Height;
              StartPos := Controls[I].Top;
            end;
          end
          else begin
            if Controls[I].Width>MaxSize then begin
              MaxSize := Controls[I].Width;
              StartPos := Controls[I].Left;
            end;
          end;
        end;
      end;
      if not (DockedTo.Position in [dpLeft, dpRight]) then begin
        FMoreButton.Left := Self.Width-NonClientWidth-FMoreButton.Width-1;
        FMoreButton.Top := StartPos;
        FMoreButton.Width := c_tbMoreButtonSize;
        FMoreButton.Height := MaxSize;
      end
      else begin
        FMoreButton.Left := StartPos;
        FMoreButton.Top := Self.Height-NonClientHeight-FMoreButton.Height-1;
        FMoreButton.Width := MaxSize;
        FMoreButton.Height := c_tbMoreButtonSize;
      end;
    end
    else begin
      FMoreButton.Left := -FMoreButton.Width-1;
      FMoreButton.Top := -FMoreButton.Height-1;

    end;
    if csDesigning in ComponentState then
      Invalidate;
  finally
    if not CanMoveControls then begin
      FreeGroupInfo (GInfo);
      tb97Free(GInfo);
    end;
  end;

  Inc (MinPosPixels, tb97RightMargin[NewDocked]);
  MinRowPixels := CurLinePixel + CurBarSize + tb97BottomMargin[NewDocked];
  if NewDockType <> dtLeftRight then begin
    Result.X := MinPosPixels;
    Result.Y := MinRowPixels;
  end
  else begin
    Result.X := MinRowPixels;
    Result.Y := MinPosPixels;
  end;
end;

procedure TCustomToolbar97.CMControlListChange (var Message: TCMControlListChange);
{ The VCL sends this message is sent whenever a child control is inserted into
  or deleted from the toolbar }
var
  I: Integer;
  l_Add : Pointer;
begin
  inherited;
  assert(f_OrderList.Count = MarkList.Count);
  with Message, f_OrderList do begin
    { Delete any previous occurances of Control in OrderList. There shouldn't
      be any if Inserting=True, but just to be safe, check anyway. }
    while True do begin
      I := IndexOf(Control);
      if I = -1 then Break;
      Delete(I);
      MarkList.Delete(I);
    end;
    if Inserting then begin
      Add(Control);
      l_Add := nil;
      MarkList.Add(l_Add);
      FOrderListDirty := True;
    end;
  end;
  UpdateEmpty;
  assert(f_OrderList.Count = MarkList.Count);  
end;

function CompareNewSizes (const Item1, Item2, ExtraData: Pointer): Integer; far;
begin
  { Sorts in descending order }
  if ExtraData = nil then
    Result := TSmallPoint(Item2).X - TSmallPoint(Item1).X
  else
    Result := TSmallPoint(Item2).Y - TSmallPoint(Item1).Y;
end;

procedure TCustomToolbar97.BuildPotentialSizesList (SizesList: Tl3LongintList);
var
  MinX, SaveFloatingRightX: Integer;
  X, LastY: Integer;
  S: TPoint;
  S2: TSmallPoint;
begin
  MinX := tb97LeftMarginFloating + tb97RightMarginFloating;
  SaveFloatingRightX := FFloatingRightX;
  try
    { Add the widest size to the list }
    FFloatingRightX := 0;
    S := OrderControls(False, dtNotDocked, nil);
    SizesList.Add (Integer(PointToSmallPoint(S)));
    { Calculate and add rest of sizes to the list }
    LastY := S.Y;
    X := S.X-1;
    while X >= MinX do begin
      FFloatingRightX := X;
      S := OrderControls(False, dtNotDocked, nil);
      if S.X > X then  { if it refuses to go any smaller }
        Break
      else
      if X = S.X then begin
        if (S.Y = LastY) and (SizesList.Count > 1) then
          SizesList.Delete (SizesList.Count-1);
        S2 := PointToSmallPoint(S);
        if SizesList.IndexOf(Integer(S2)) = -1 then
          SizesList.Add (Integer(S2));
        LastY := S.Y;
        Dec (X);
      end
      else
        X := S.X;
    end;
  finally
    FFloatingRightX := SaveFloatingRightX;
  end;
end;

procedure TCustomToolbar97.ResizeBegin (ASizeHandle: TToolWindowSizeHandle);
const
  MaxSizeSens = 12;
var
  I, NewSize: Integer;
  S, N: TSmallPoint;
  P: TPoint;
begin
  inherited;

  SizeData := tb97AllocMem(SizeOf(TToolbar97SizeData));

  with PToolbar97SizeData(SizeData)^ do begin
    SizeHandle := ASizeHandle;
    CurRightX := FFloatingRightX;
    DisableSensCheck := False;
    OpSide := False;

    NewSizes := Tl3LongintList.Make;
    BuildPotentialSizesList (NewSizes);
    for I := 0 to NewSizes.Count-1 do begin
      P := SmallPointToPoint(TSmallPoint(NewSizes[I]));
      AddFloatingNCAreaToSize (P);
      NewSizes[I] := Integer(PointToSmallPoint(P));
    end;
    ListSortEx (NewSizes, CompareNewSizes,
      Pointer(Ord(ASizeHandle in [twshTop, twshBottom])));

    SizeSens := MaxSizeSens;
    { Adjust sensitivity if it's too high }
    for I := 0 to NewSizes.Count-1 do begin
      Integer(S) := NewSizes[I];
      if (S.X = Width) and (S.Y = Height) then begin
        if I > 0 then begin
          Integer(N) := NewSizes[I-1];
          if ASizeHandle in [twshLeft, twshRight] then
            NewSize := N.X - S.X - 1
          else
            NewSize := N.Y - S.Y - 1;
          if NewSize < SizeSens then SizeSens := NewSize;
        end;
        if I < NewSizes.Count-1 then begin
          Integer(N) := NewSizes[I+1];
          if ASizeHandle in [twshLeft, twshRight] then
            NewSize := S.X - N.X - 1
          else
            NewSize := S.Y - N.Y - 1;
          if NewSize < SizeSens then SizeSens := NewSize;
        end;
        Break;
      end;
    end;
    if SizeSens < 0 then SizeSens := 0;
  end;
end;

procedure TCustomToolbar97.ResizeTrack (var Rect: TRect; const OrigRect: TRect);
var
  Pos: TPoint;
  NCXDiff: Integer;
  NewOpSide: Boolean;
  Reverse: Boolean;
  I: Integer;
  P: TSmallPoint;
begin
  inherited;

  with PToolbar97SizeData(SizeData)^ do begin
    GetCursorPos (Pos);

    NCXDiff := ClientToScreen(Point(0, 0)).X - Left;
    Dec (Pos.X, Left);  Dec (Pos.Y, Top);
    if SizeHandle = twshLeft then
      Pos.X := Width-Pos.X
    else
    if SizeHandle = twshTop then
      Pos.Y := Height-Pos.Y;

    { Adjust Pos to make up for the "sizing sensitivity", as seen in Office 97 }
    if SizeHandle in [twshLeft, twshRight] then
      NewOpSide := Pos.X < Width
    else
      NewOpSide := Pos.Y < Height;
    if (not DisableSensCheck) or (OpSide <> NewOpSide) then begin
      DisableSensCheck := False;
      OpSide := NewOpSide;
      if SizeHandle in [twshLeft, twshRight] then begin
        if (Pos.X >= Width-SizeSens) and (Pos.X < Width+SizeSens) then
          Pos.X := Width;
      end
      else begin
        if (Pos.Y >= Height-SizeSens) and (Pos.Y < Height+SizeSens) then
          Pos.Y := Height;
      end;
    end;

    Rect := OrigRect;

    if SizeHandle in [twshLeft, twshRight] then
      Reverse := Pos.X > Width
    else
      Reverse := Pos.Y > Height;
    if not Reverse then
      I := NewSizes.Count-1
    else
      I := 0;
    while True do begin
      if (not Reverse and (I < 0)) or
         (Reverse and (I >= NewSizes.Count)) then
        Break;
      Integer(P) := NewSizes[I];
      if SizeHandle in [twshLeft, twshRight] then begin
        if (not Reverse and ((I = NewSizes.Count-1) or (Pos.X >= P.X))) or
           (Reverse and ((I = 0) or (Pos.X < P.X))) then begin
          if I = 0 then
            CurRightX := 0
          else
            CurRightX := P.X - NCXDiff*2;
          if SizeHandle = twshRight then
            Rect.Right := Rect.Left + P.X
          else
            Rect.Left := Rect.Right - P.X;
          Rect.Bottom := Rect.Top + P.Y;
          DisableSensCheck := not EqualRect(Rect, OrigRect);
        end;
      end
      else begin
        if (not Reverse and ((I = NewSizes.Count-1) or (Pos.Y >= P.Y))) or
           (Reverse and ((I = 0) or (Pos.Y < P.Y))) then begin
          if I = NewSizes.Count-1 then
            CurRightX := 0
          else
            CurRightX := P.X - NCXDiff*2;
          if SizeHandle = twshBottom then
            Rect.Bottom := Rect.Top + P.Y
          else
            Rect.Top := Rect.Bottom - P.Y;
          Rect.Right := Rect.Left + P.X;
          DisableSensCheck := not EqualRect(Rect, OrigRect);
        end;
      end;
      if not Reverse then
        Dec (I)
      else
        Inc (I);
    end;
  end;
end;

procedure TCustomToolbar97.ResizeEnd (Accept: Boolean);
begin
  inherited;
  if Assigned(SizeData) then begin
    with PToolbar97SizeData(SizeData)^ do begin
      if Accept then
        FFloatingRightX := CurRightX;
      tb97Free(NewSizes);
    end;
    tb97FreeMem(SizeData);
  end;
end;

function TCustomToolbar97.GetOrderedControls(Index: Integer): TControl;
begin
  CleanOrderList;
  Result := f_OrderList[Index];
end;

function TCustomToolbar97.GetOrderedControlsCount: Integer;
begin
  CleanOrderList;
  Result := f_OrderList.Count;
end;

function TCustomToolbar97.GetOrderIndex(Control: TControl): Integer;
begin
  CleanOrderList;
  Result := f_OrderList.IndexOf(Control);
  if Result = -1 then
    raise EInvalidOperation.CreateFmt(STB97ToolbarControlNotChildOfToolbar,
      [Control.Name]);
end;

procedure TCustomToolbar97.SetOrderIndex (Control: TControl; Value: Integer);
var
  OldIndex: Integer;
  OldMark:pointer;
begin
  CleanOrderList;
  with f_OrderList do begin
    OldIndex := IndexOf(Control);
    if OldIndex = -1 then
      raise EInvalidOperation.CreateFmt(STB97ToolbarControlNotChildOfToolbar,
        [Control.Name]);
    if Value < 0 then Value := 0;
    if Value >= Count then Value := Count-1;
    if Value <> OldIndex then begin
      Delete (OldIndex);
      OldMark := MarkList[OldIndex];
      MarkList.Delete (OldIndex);
      Insert(Value, Pointer(Control));
      MarkList.Insert (Value, OldMark);
      ArrangeControls;
    end;
  end;
end;

procedure TCustomToolbar97.SetFloatingWidth (Value: Integer);
begin
  if FFloatingRightX <> Value then begin
    FFloatingRightX := Value;
    ArrangeControls;
  end;
end;

procedure TCustomToolbar97.SetSlaveControl (const ATopBottom, ALeftRight: TControl);
var
  NewVersion: PSlaveInfo;
begin
  tb97GetMem(NewVersion, SizeOf(TSlaveInfo));
  with NewVersion^ do begin
    TopBottom := ATopBottom;
    LeftRight := ALeftRight;
  end;
  SlaveInfo.Add (NewVersion);
  ArrangeControls;
end;

function TCustomToolbar97.ChildControlTransparent (Ctl: TControl): Boolean;
begin
  Result := Ctl is TToolbarSep97;
end;

procedure TCustomToolbar97.WMWindowPosChanging (var Message: TWMWindowPosChanging);
var
  R: TRect;
begin
  inherited;
  { When floating, invalidate the toolbar when resized so that the vertical
    separators get redrawn.
    Note to self: The Invalidate call must be in the WM_WINDOWPOSCHANGING
    handler. If it's in WM_SIZE or WM_WINDOWPOSCHANGED there can be repainting
    problems in rare cases (refer to Toolbar97 1.65a's implementation). }
  if not Docked and HandleAllocated then
    with Message.WindowPos^ do
      if flags and SWP_DRAWFRAME <> 0 then
        Invalidate
      else
        if flags and SWP_NOSIZE = 0 then begin
          GetWindowRect (Handle, R);
          if (R.Right-R.Left <> cx) or (R.Bottom-R.Top <> cy) then
            Invalidate;
        end;
end;

function TCustomToolbar97.EstimateStretch(ARequestedSize : Integer;
                                          ALeftRight     : Boolean) : Integer;
var
  I           : Integer;
  LastIdx     : Integer;
  IncSize     : Integer;
  lSize       : Integer;
  lFirstTime  : Boolean;
  lCtrl       : ITB97Ctrl;
  l_Set       : Boolean;
  l_MinWidth  : Integer;
  l_FullWidth : Integer;
begin
  Result := 0;
  if (ControlCount <= 1) then
   Exit;
  LastIdx := 0;
  for I := 1 to f_OrderList.Count - 1 do
   if f_OrderList[I].Visible and
      not (f_OrderList[I] is Ttb97MoreButton) and
      not Tagged(f_OrderList[I], tb97tagHiddenSeparator) and
      not (f_OrderList[I] is TToolbarSep97) then
    LastIdx := I;
  lFirstTime := True;
  IncSize := c_tbMoreButtonSize + c_tbMoreButtonSpace;
  for I := 0 to f_OrderList.Count - 1 do
  begin
   if f_OrderList[I].Visible and
      not (f_OrderList[I] is Ttb97MoreButton) and
      not Tagged(f_OrderList[I], tb97tagHiddenSeparator) then
   begin
     if I = LastIdx then
      IncSize := IncSize - c_tbMoreButtonSize - c_tbMoreButtonSpace;
     if not ALeftRight then
      lSize := f_OrderList[I].Width
     else
      lSize := f_OrderList[I].Height;
     // Если места для размещения компонентов toolbar-а не хватает, то
     // перед помещением не вместившихся компонентов сначала уменьшаем
     // размер компонентов с изменяемыми размерами
     if Supports(f_OrderList[I], ITB97Ctrl, lCtrl) then
     try
      if lCtrl.IsSizeable then
      begin
       // Минимальный размер, если остался один элемент, то сжимаем его до
       // последнего (об этом свидетельствует флаг lFirstTime)
       l_Set := false;
       if not lFirstTime then
       begin
        l_MinWidth := lCtrl.MinWidth;
        if (IncSize + l_MinWidth > aRequestedSize) then
        begin
         f_OrderList[I].Width := l_MinWidth;
         l_Set := true;
        end;//IncSize + l_MinWidth > aRequestedSize
       end;//not lFirstTime
       if not l_Set then
       begin
        l_FullWidth := lCtrl.FullWidth;
        // Занимаем все свободное пространство
        if (IncSize + l_FullWidth > aRequestedSize) then
         lCtrl.DoFitToWidth(aRequestedSize - IncSize)
        // Максимальный размер
        else
         lCtrl.DoUnFitToWidth(l_FullWidth);
       end;//not l_Set
       lSize := f_OrderList[I].Width;
      end;//lCtrl.IsSizeable
     finally
      lCtrl := nil;
     end;//try..finally

     if (IncSize + lSize > aRequestedSize) then
     begin
      if lFirstTime then 
        Result := IncSize + lSize
      else
       Result := aRequestedSize;
      Exit;
     end;// if IncSize + lSize > aRequestedSize then
     lFirstTime := False;
     Inc(IncSize, lSize);
   end;// if (f_OrderList[I].Visible) 
  end;// for I := 0 to f_OrderList.Count - 1 do
  Result := IncSize;
end;

{
  Control._Tag
  если первый бит установлен - контрол спрятан мной.
}

function tbFindNextControl(Form: TCustomForm; CurControl: TWinControl;
  GoForward, CheckTabStop: Boolean): TWinControl;
var
  I, StartIndex: Integer;
  List: TList;
begin
  Result := nil;
  List := TList.Create;
  try
    Form.GetTabOrderList(List);
    if List.Count > 0 then
    begin
      StartIndex := List.IndexOf(CurControl);
      if StartIndex = -1 then
        if GoForward then StartIndex := List.Count - 1 else StartIndex := 0;
      I := StartIndex;
      repeat
        if GoForward then
        begin
          Inc(I);
          if I = List.Count then I := 0;
        end else
        begin
          if I = 0 then I := List.Count;
          Dec(I);
        end;
        CurControl := List[I];
        if CurControl.CanFocus and
          (not CheckTabStop or CurControl.TabStop) then
          Result := CurControl;
      until (Result <> nil) or (I = StartIndex);
    end;
  finally
    List.Free;
  end;
end;

procedure TCustomToolbar97.Stretch(ARequestedSize:Integer; ALeftRight:Boolean);
var
  I, K          : Integer;
  LastIdx       : Integer;
  IncSize       : Integer;
  l_FirstTime   : Boolean;
  l_Size        : Integer;
  l_FocusedItem : TWinControl;
  l_Form        : TCustomForm;
begin
  LastIdx := -1;
  FStretched := False;
  FHasInvisibleButtons := False;
  if ControlCount <= 1 then
   Exit;
  for I := 0 to f_OrderList.Count-1 do
  begin
    if f_OrderList[I].Visible and
       not (f_OrderList[I] is Ttb97MoreButton) and
       not Tagged(f_OrderList[I], tb97tagHiddenSeparator) and
       not (f_OrderList[I] is TToolbarSep97) then
      LastIdx := I;
  end;
  l_FirstTime := True;
  IncSize := c_tbMoreButtonSize + c_tbMoreButtonSpace;
  for I := 0 to f_OrderList.Count-1 do
  begin
    if f_OrderList[I].Visible and
       not (f_OrderList[I] is Ttb97MoreButton) and
       not Tagged(f_OrderList[I], tb97tagHiddenSeparator) then
    begin
      if I = LastIdx then
       IncSize := IncSize - c_tbMoreButtonSize - c_tbMoreButtonSpace;
      if not ALeftRight then
       l_Size := f_OrderList[I].Width
      else
       l_Size := f_OrderList[I].Height;
      if IncSize + l_Size > aRequestedSize then
      begin
        FStretched := true;
        if I <= LastIdx then
         FHasInvisibleButtons := True;
        if l_FirstTime then
          FStretchSize := IncSize + l_Size;
        Break;
      end;
      FStretchSize := IncSize + l_Size;
      l_FirstTime := false;
      inc(IncSize, l_Size);
    end;
  end;

  l_FocusedItem := nil;
  for K := 0 to f_OrderList.Count-1 do
  begin
    if not (f_OrderList[K] is Ttb97MoreButton) and
     ControlVisibleOrDesigning(f_OrderList[K]) and
     not Tagged(f_OrderList[K], tb97tagHiddenSeparator) then
    begin
      if ((K=I) and not l_FirstTime) or (K>I) then
      begin
        SetTagByIndex(K, tb97tagDropWin);
        if f_OrderList[K] is TWinControl then
        begin
          AddToHiddenElements(TWinControl(f_OrderList[K]));
          if TWinControl(f_OrderList[K]).Focused then
            l_FocusedItem := TWinControl(f_OrderList[K]);
        end;
      end
      else
      begin
        DropTagByIndex(K, tb97tagDropWin);
        if f_OrderList[K] is TWinControl then
          RemoveFromHiddenElements(TWinControl(f_OrderList[K]));
      end;
    end;
  end;

  if l_FocusedItem <> nil then
  begin
    l_Form := GetParentForm(l_FocusedItem);
    if l_Form <> nil then
    begin
      l_FocusedItem := tbFindNextControl(l_Form, l_FocusedItem, true, true);
      if l_FocusedItem <> nil then
        l_FocusedItem.SetFocus;
    end;
  end;
end;

function TCustomToolbar97.getWidth: Integer;
begin
 Result := TControl(Self).Width;
 if Collapsible and FStretched and (DockedTo <> nil) and
   not (DockedTo.Position in [dpLeft, dpRight]) then
   Result := FStretchSize+NonClientWidth
 else
 begin
  if (DockedTo<>nil) then
   if (DockedTo.Position = dpTop) or (DockedTo.Position = dpBottom) then
     Result := FullWidth;
 end;//Collapsible and FStretched.. 
end;

procedure TCustomToolbar97.ExecuteHandler(Sender:TObject);
{$IfNDef NoVCM}
var
  l_Int: IvcmPopupIgnoresAction;
{$EndIf  NoVCM}  
begin
  if FAssList<>nil then begin
    if FAssList.ContainsAction(Sender) then begin
      if Assigned(FAssList.GetOnExecuteByAction(Sender)) then begin
        FNeedExecution := FAssList.GetOnExecuteByAction(Sender);
        FCurrentAction := TCustomAction(Sender);
        FExecOwner := Sender;
        {$If Defined(Nemesis) AND not Defined(NoVCM) }
        if (TCustomAction(Sender).Owner <> nil) and
           (not Supports(TCustomAction(Sender).Owner, IvcmPopupIgnoresAction, l_Int) or not l_Int.PopupIgnoresAction) then
         FPopWin.Close
        else
         if Assigned(FNeedExecution) then
         begin
           FNeedExecution(FExecOwner);
           FNeedExecution := nil;
         end;
        {$Else}
        FPopWin.Close;
        {$IfEnd}
      end;
    end;
  end;
end;
{
procedure TCustomToolbar97.BuildSeparator:TToolbarSep97;
var
 K: Integer;
 lSep: TToolbarSep97;
begin
  Result := nil;
  if OrderList.Count>0 then begin
    if not (OrderList[OrderList.Count-1] is TToolbarSep97) then begin
      lSep := TToolbarSep97.Create(self);
      lSep.Parent := self;
    end;
  end;
end;
}
function TCustomToolbar97.CanAddSeparator: Boolean;
var
 l_Cnt : Integer;
begin
 l_Cnt := 0;
 if (FMoreButton <> nil) then
  Inc(l_Cnt);
 Result := (f_OrderList.Count > l_Cnt) AND
           not (f_OrderList[f_OrderList.Count-1] is TToolbarSep97);
end;

procedure TCustomToolbar97.DeleteLastIfSeparator;
begin
  if f_OrderList.Count>0 then begin
    if (f_OrderList[f_OrderList.Count-1] is TToolbarSep97) then begin
      TToolbarSep97(f_OrderList[f_OrderList.Count-1]).Free;
    end;
  end;
end;

procedure TCustomToolbar97.SetHideExtraSeparators(aValue: Boolean);
var
  I: Integer;
begin
  if aValue <> FHideExtraSeparators then begin
    FHideExtraSeparators := aValue;
    for I := 0 to ControlCount - 1 do begin
      DropTagByIndex(I, tb97tagHiddenSeparator);
    end;
    if DockedTo<>nil then begin
      DockedTo.ArrangeToolbars(false);      
    end
    else
      ArrangeControls;
  end;
end;

procedure TCustomToolbar97.MoreButtonClickHandler;
var
 I            : Integer;
 lPanel       : TPanel;
 lCurPos      : Integer;
 lCtrl        : TControl;
 lX           : Integer;
 lDelta       : Integer;
 lBackupOrder : Ttb97ControlsList;
 lBackupMark  : Ttb97List;
 lControl     : TControl;
 lFirstFlag   : Boolean;
 lSeparators  : Ttb97List;
 lCtrlIntf    : ITB97Ctrl;
begin
 lCtrl := nil;
 afw.BeginOp; // для того, чтобы тулбар в процессе выполнения Action'а не умер
 try
  FAssList := TAssList.Create;
  FNeedExecution := nil;
  FExecOwner := nil;
  try
   lBackupOrder := Ttb97ControlsList.Make;
   try
    lBackupOrder.JoinWith(f_OrderList);
    lBackupMark := Ttb97List.Make;
    try
     lBackupMark.JoinWith(MarkList);
     try
      lPanel := TPanel.Create(nil);
      FCustomState := FCustomState + [csRestrictAlign];
      lDelta := 4;
      lCurPos := lDelta;
      lX := 0;
      lFirstFlag := true;
      lSeparators := Ttb97List.Make;
      try
       for I := 0 to lBackupOrder.Count-1 do
       begin
         lControl := TControl(lBackupOrder[I]);
         if lControl.Visible and ((Integer(lBackupMark[I]) and 1)=1) and
           not (lControl is Ttb97MoreButton) then begin
  {          if lControl is TWinControl then
             RemoveFromHiddenElements(lControl as TWinControl); }
           if lControl is TToolbarSep97 then
           begin
            if lFirstFlag then
            begin
             lFirstFlag := false;
             Continue;
            end;
            lCtrl := TDropWindowSeparator.Create(lPanel, dtLeftRight);
            lCtrl.Width := 0;
            lCtrl.Height := 6;
            lSeparators.Add(lCtrl);
           end
           else
           begin
            lCtrl := TControl(lBackupOrder[I]);
            // Установим максимальный размер, необходимый для размещения в списке
            if Supports(lCtrl, ITB97Ctrl, lCtrlIntf) then
            try
             if lCtrlIntf.IsSizeable then
              lCtrl.Width := lCtrlIntf.FullWidth;
            finally
             lCtrlIntf := nil;
            end;
            lCtrl.Parent := nil;
           end;
           if Assigned(lCtrl) then
           begin
            lCtrl.Left := lDelta;
            lCtrl.Top := lCurPos;
            lCtrl.Parent := lPanel;
            lCurPos := lCurPos+lCtrl.Height+2;
            if lCtrl.Width>lX then begin
              lX := lCtrl.Width;
            end;
            if lCtrl.Action <> nil then
            begin
             FAssList.AddItem(lCtrl, lCtrl.Action, lCtrl.Action.OnExecute);
             lCtrl.Action.OnExecute := ExecuteHandler;
            end;
           end;
           lFirstFlag := false;
         end;
       end;//for I
       FPopWin := TvtPopupWindow.Create(FMoreButton, lPanel);
       lPanel.Parent := FPopWin;
       FPopWin.Height := lCurPos+lDelta;
       FPopWin.Width := lX+lDelta*2;
       for I := 0 to lSeparators.Count - 1 do
        TDropWindowSeparator(lSeparators[I]).Width := lX;
      finally
       tb97Free(lSeparators);
      end;//try..finally
      try
        FPopWin.Execute;
        for I := lPanel.ControlCount-1 downto 0 do
        begin
          lCtrl := lPanel.Controls[I];
          lCtrl.Parent := nil;
          if not (lCtrl is TDropWindowSeparator) then
          begin
           lCtrl.Left := -lCtrl.Width-1;
           lCtrl.Top := -lCtrl.Height-1;
           lCtrl.Parent := self;
          end
          else
           lCtrl.Free;
          if FAssList.ContainsControl(lCtrl) then begin
            lCtrl.Action.OnExecute := FAssList.GetOnExecuteByControl(lCtrl);
          end;
        end;//for I
      finally
        tb97Free(lPanel);
        FCustomState := FCustomState-[csRestrictAlign];
      end;
      f_OrderList.Clear;
      f_OrderList.JoinWith(lBackupOrder);
      MarkList.Clear;
      MarkList.JoinWith(lBackupMark);
     finally
      tb97Free(FPopWin);
     end;//try..finally
    finally
     tb97Free(lBackupMark);
    end;//try..finally
   finally
    tb97Free(lBackupOrder);
   end;//try..finally
   Application.ProcessMessages;
   ExecuteDefered;
   { контрол может изменить свой размер в результате выполнения action'а (combotree) }
  finally
    tb97Free(FAssList);
    if DockedTo<>nil then
      DockedTo.ArrangeToolbars(false);
  end;
 finally
  afw.EndOp;
 end;//try..finally
end;

procedure TCustomToolbar97.ExpandControls;
  {* - разворачивает компоненты на их полную длинну. }
var
 lCtrl  : ITB97Ctrl;
 lIndex : Integer;
begin
 for lIndex := 0 to Pred(ControlCount) do
  if Supports(Controls[lIndex], ITB97Ctrl, lCtrl) then
  try
   if lCtrl.IsSizeable then
    lCtrl.Expand;
  finally
   lCtrl := nil;
  end;//try..finally
end;

function TCustomToolbar97.getHeight: Integer;
begin
  Result := TControl(Self).Height;
  if Collapsible and FStretched and (DockedTo<>nil)
    and (DockedTo.Position in [dpLeft, dpRight]) then begin
    Result := FStretchSize + NonClientHeight;
  end
  else begin
    if (DockedTo<>nil) then begin      
      if (DockedTo.Position = dpLeft) or (DockedTo.Position = dpRight) then
        Result := FullHeight
    end;
  end;
end;

function TCustomToolbar97.FullWidth: Integer;
var
 I : Integer;
 lCtrl : ITB97Ctrl;
begin
  Result := NonClientWidth;
  for I := 0 to ControlCount - 1 do begin
    if (Controls[I].Visible) and not (Controls[I] is Ttb97MoreButton) and
       not Tagged(Controls[I], tb97tagHiddenSeparator) then
     if Supports(Controls[I], ITB97Ctrl, lCtrl) then
      try
       Result := Result + lCtrl.FullWidth;
      finally
       lCtrl := nil;
      end
     else
      Result := Result + Controls[I].Width;
  end;
end;

function TCustomToolbar97.FullHeight: Integer;
var
  I:Integer;
begin
  Result := NonClientHeight;
  for I := 0 to ControlCount-1 do begin
    //if (Controls[I].Visible) and not (Controls[I] is Ttb97MoreButton) then begin
    if (Controls[I].Visible) and not (Controls[I] is Ttb97MoreButton) and
       not Tagged(Controls[I], tb97tagHiddenSeparator) then begin
      Result := Result+Controls[I].Height;
    end;
  end;
end;

procedure TCustomToolbar97.UpdateEmpty(aUpdateVisibility : Boolean = True);
{
var
  I:Integer;
  lBool:Boolean;
}  
begin
{
  Аналогичный код в наследнике.
  Пример смотреть в vcmMenuManager
  lBool := false;
  for I := 0 to ControlCount-1 do begin
    if Controls[I].Visible and not (Controls[I] is Ttb97MoreButton) then begin
      lBool := true;
      break;
    end;
  end;
  if not lBool then
    FEmpty := true
  else
    FEmpty := false;
}
  if aUpdateVisibility then
   UpdateVisibility;
{  if DockedTo <> nil then
    DockedTo.ArrangeToolbars(true); }
end;

function TCustomToolbar97.Tagged(Control: TControl; aTag: TTB97TAG): Boolean;
var
  I:Integer;
  Flag:Boolean;
begin
  assert(f_OrderList.Count=MarkList.Count);
  if ((aTag = tb97tagHiddenSeparator) and not FHideExtraSeparators) or
     (aTag = tb97tagDropWin) and not FCollapsible then begin
    Result := false;
    exit;
  end;

  Flag := false;
  for i := 0 to f_OrderList.Count-1 do begin
    if f_OrderList[I] = Control then begin
      Flag := true;
      break;
    end;
  end;
  assert(Flag);
  Result := (Integer(MarkList[I]) and Integer(aTag)) > 0{=Integer(aTag)};
end;

procedure TCustomToolbar97.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
end;

procedure TCustomToolbar97.ExecuteDefered;
begin
  if Assigned(FNeedExecution) then begin
    FNeedExecution(FExecOwner);
    FNeedExecution := nil;
  end;
end;

procedure TCustomToolbar97.FreeControls;
begin
  while ControlCount > 1 do
    if Controls[0] is Ttb97MoreButton then
      Controls[1].Free
    else
      Controls[0].Free;
end;

function TCustomToolbar97.ActionTerminatesWindow(const aAction:TCustomAction): Boolean;
begin
  Result := true;
end;

procedure TCustomToolbar97.DropTagByIndex(aIndex: Integer; aTag: TTB97Tag);
begin
  if (aTag = tb97tagHiddenSeparator) and not FHideExtraSeparators then begin
    exit;
  end;
  MarkList[aIndex] := pointer(Integer(MarkList[aIndex]) and not Integer(aTag));
end;

procedure TCustomToolbar97.SetTagByIndex(aIndex: Integer; aTag: TTB97Tag);
begin
  if (aTag = tb97tagHiddenSeparator) and not FHideExtraSeparators then begin
    exit;
  end;
  MarkList[aIndex] := pointer(Integer(MarkList[aIndex]) or Integer(aTag));
end;

procedure TCustomToolbar97.SetTagByObject(aObject: TControl; aTag: TTB97Tag);
var
  l_Index: Integer;
begin
  l_Index := f_OrderList.IndexOf(aObject);
  assert(l_Index >= 0 );
  SetTagByIndex(l_Index, aTag);
end;

procedure TCustomToolbar97.DropTagByObject(aObject: TControl; aTag: TTB97Tag);
var
  l_Index: Integer;
begin
  l_Index := f_OrderList.IndexOf(aObject);
  assert(l_Index >= 0 );
  DropTagByIndex(l_Index, aTag);
end;

procedure TCustomToolbar97.LockResize;
begin
 Inc(f_ResizeLockedCount);
end;

procedure TCustomToolbar97.UnlockResize;
begin
 Assert(f_ResizeLockedCount > 0);
 Dec(f_ResizeLockedCount);
 if f_ResizeLockedCount = 0 then
  SetBounds(f_Bounds.Left, f_Bounds.Top, f_Bounds.Right, f_Bounds.Bottom);
end;

procedure TCustomToolbar97.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
begin
 if f_ResizeLockedCount > 0 then
 begin
  f_Bounds.Left := ALeft;
  f_Bounds.Top := ATop;
  f_Bounds.Right := AWidth;
  f_Bounds.Bottom := AHeight;
  Exit;
 end;
 inherited SetBounds(aLeft, aTop, aWidth, aHeight);
 AdjustSizeForPanels;
end;

procedure TCustomToolbar97.AdjustSizeForPanels;
begin

end;

{ TToolbarSep97 }

constructor TToolbarSep97.Create (AOwner: TComponent);
begin
  inherited;
  FSizeHorz := 6;
  FSizeVert := 6;
  ControlStyle := ControlStyle - [csOpaque, csCaptureMouse];
end;

procedure TToolbarSep97.SetParent (AParent: TWinControl);
begin
  if (AParent <> nil) and not(AParent is TCustomToolbar97) then
    raise EInvalidOperation.Create(STB97SepParentNotAllowed);
  inherited;
end;

procedure TToolbarSep97.SetBlank (Value: Boolean);
begin
  if FBlank <> Value then begin
    FBlank := Value;
    Invalidate;
  end;
end;

procedure TToolbarSep97.SetSizeHorz (Value: TToolbarSepSize);
begin
  if FSizeHorz <> Value then begin
    FSizeHorz := Value;
    if Parent is TCustomToolbar97 then
      TCustomToolbar97(Parent).ArrangeControls;
  end;
end;

procedure TToolbarSep97.SetSizeVert (Value: TToolbarSepSize);
begin
  if FSizeVert <> Value then begin
    FSizeVert := Value;
    if Parent is TCustomToolbar97 then
      TCustomToolbar97(Parent).ArrangeControls;
  end;
end;

procedure TToolbarSep97.DoPaint(const aCN: Il3Canvas);
var
  R: TRect;
  Z: Integer;
begin
  inherited;
  if not(Parent is TCustomToolbar97) then Exit;

  with aCN.Canvas do
  begin
    { Draw dotted border in design mode }
    if csDesigning in ComponentState then
    begin
      Pen.Style := psDot;
      Pen.Color := clBtnShadow;
      Brush.Style := bsClear;
      R := ClientRect;
      Rectangle (R.Left, R.Top, R.Right, R.Bottom);
      Pen.Style := psSolid;
    end;

    if not FBlank then
      if GetDockTypeOf(TCustomToolbar97(Parent).DockedTo) <> dtLeftRight then
      begin
        Z := Width div 2;
        Pen.Color := clBtnShadow;
        MoveTo (Z-1, 0);  LineTo (Z-1, Height);
        Pen.Color := clBtnHighlight;
        MoveTo (Z, 0);  LineTo (Z, Height);
      end
      else
      begin
        Z := Height div 2;
        Pen.Color := clBtnShadow;
        MoveTo (0, Z-1);  LineTo (Width, Z-1);
        Pen.Color := clBtnHighlight;
        MoveTo (0, Z);  LineTo (Width, Z);
      end;
  end;
end;

procedure TToolbarSep97.MouseDown (Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
begin
  inherited;
  if not(Parent is TCustomToolbar97) then Exit;

  { Relay the message to the parent toolbar }
  P := Parent.ScreenToClient(ClientToScreen(Point(X, Y)));
  TCustomToolbar97(Parent).MouseDown (Button, Shift, P.X, P.Y);
end;

initialization
{$If not defined(NoScripts)}
// Регистрация Ttb97MoreButton
 TtfwClassRef.Register(Ttb97MoreButton);
{$IfEnd} //not NoScripts

end.


