unit vgVisualObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Модуль: "w:/common/components/rtl/external/VGScene/NOT_FINISHED_vgVisualObject.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Impl::TvgVisualObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$IfNDef NoVGScene}

uses
  Classes,
  Controls,

  Menus,

  vgCustomCanvas,
  vgObject,
  vgInterfaces,
  vgTypes,
  //vgNonModelTypes,
  vgObjectList,
  vgBounds,
  vgPosition,
  vgBitmap
  ;

type
  TvgVisualObject = class(TvgObject)
  private
    FOnMouseUp: TvgMouseEvent;
    FOnMouseDown: TvgMouseEvent;
    FOnMouseMove: TvgMouseMoveEvent;
    FOnMouseWheel: TvgMouseWheelEvent;
    FOnClick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FMouseInObject: boolean;
    FHitTest: boolean;
    FClipChildren: boolean;
    FAutoCapture: boolean;
    FMargins: TvgBounds;
  protected
    FAlign: TvgAlign;
  private  
    FDisableDefaultAlign: boolean;
    FPadding: TvgBounds;
    FTempCanvas: TvgCustomCanvas;
    FRotateAngle: single;
    FPosition: TvgPosition;
    FScale: TvgPosition;
    FSkew: TvgPosition;
    FRotateCenter: TvgPosition;
    FCanFocused: boolean;
    FIsMouseOver: boolean;
  protected
    FIsFocused: boolean;
  private  
    FOnCanFocused: TvgCanFocusedEvent;
    FOnEnterFocus: TNotifyEvent;
    FOnKillFocus: TNotifyEvent;
  protected
    FDisableFocusEffect: boolean;
  private  
    FClipParent: boolean;
    FVelocity: TvgPosition;
    FOnMouseLeave: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    {$IfDef vgDesign}
    FDesignHide: boolean;
    {$EndIf vgDesign}
    FOnPaint: TOnPaintEvent;
    FOnBeforePaint: TOnPaintEvent;
    FCanClipped: boolean;
    FCursor: TCursor;
  protected
    FDragMode: TvgDragMode;
  private  
    FDragDisableHighlight: boolean;
    FOnDragEnter: TvgDragEnterEvent;
    FOnDragDrop: TvgDragDropEvent;
    FOnDragLeave: TNotifyEvent;
    FOnDragOver: TvgDragOverEvent;
    FOnDragEnd: TNotifyEvent;
    FIsDragOver: boolean;
    FOnKeyDown: TvgKeyEvent;
    FOnKeyUp: TvgKeyEvent;
    FHint: WideString;
    FShowHint: boolean;
    {$IFNDEF NOVCL}
    FPopupMenu: TPopupMenu;
    {$ENDIF}
    FPopup: TvgVisualObject{TvgPopup};
    FNeedRecalcEnabled: boolean;
    FEnabled: boolean;
    FAbsoluteEnabled: boolean;
    FTabOrder: TTabOrder;
  protected
    FTabList: TvgObjectList;
  protected
    FNeedAlign: boolean;
    FOnApplyResource: TNotifyEvent;
  private  
    f_OnRealign: TNotifyEvent;
    f_IsTabExitPoint : Boolean;
    procedure CreateCaret;
    procedure SetEnabled(const Value: boolean);
    function GetInvertAbsoluteMatrix: TvgMatrix;
    procedure SetRotateAngle(const Value: single);
    procedure SetPosition(const aValue: TvgPosition);
    procedure SetHitTest(const Value: boolean);
    procedure SetClipChildren(const Value: boolean);
    function CheckHitTest(const AHitTest: boolean): boolean;
    function GetCanvas: TvgCustomCanvas;
    procedure SetLocked(const Value: boolean);
    procedure SetTempCanvas(const Value: TvgCustomCanvas);
    procedure SetOpacity(const Value: single);
    {$IfDef vgDesign}
    procedure SetDesignHide(const Value: boolean);
    {$EndIf vgDesign}
    procedure SetTabOrder(const Value: TTabOrder);
  protected
    {$IfDef vgDesign}
    procedure UpdateDesignHide(const Value: boolean);
    {$EndIf vgDesign}
  private  
    function isOpacityStored: Boolean;
    function GetChildrenRect: TvgRect;
    procedure SetCursor(const Value: TCursor);
    function GetAbsoluteWidth: single;
    function GetAbsoluteHeight: single;
    function GetTabOrder: TTabOrder;
    procedure UpdateTabOrder(Value: TTabOrder);
  protected
    FHeight: single;
    FLastHeight: single;
    FWidth: single;
    FLastWidth: single;
    FVisible: boolean;
    FLocalMatrix: TvgMatrix;
    FAbsoluteMatrix: TvgMatrix;
    FNeedRecalcAbsolute: boolean;
    FUpdateEffects: boolean;
    FEffectBitmap: TvgBitmap;
    FLocked: boolean;
    FOpacity: single;
    FAbsoluteOpacity: single;
    FNeedRecalcOpacity: boolean;
    FInPaintTo: boolean;
    FUpdateRect: TvgRect;
    FNeedRecalcUpdateRect: boolean;
    FCaret: TvgVisualObject;
    FPressed: boolean;
    FDoubleClick: boolean;
    FUpdating: integer;
    FDisableAlign: boolean;
    FDisableEffect: boolean;
    FHasEffect: boolean;
    function pm_GetIsVisual: Boolean; override;
    function HasDisablePaintEffect: boolean;
    function HasAfterPaintEffect: boolean;
    procedure SetInPaintTo(value: boolean);
    {}
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure DeleteChildren; override;
    procedure SetVisible(const Value: boolean); virtual;
    { matrix }
    procedure SetHeight(const Value: single); virtual;
    procedure SetWidth(const Value: single); virtual;
    procedure SetAlign(const Value: TvgAlign); virtual;
    function GetAbsoluteRect: TvgRect; virtual;
    function GetAbsoluteMatrix: TvgMatrix; //virtual;
    function GetChildrenMatrix: TvgMatrix; virtual;
    function GetAbsoluteScale: TvgPoint; //virtual;
    function GetLocalRect: TvgRect; //virtual;
    function GetUpdateRect: TvgRect; virtual;
    function GetBoundsRect: TvgRect; //virtual;
    function GetParentedRect: TvgRect; //virtual;
    function GetClipRect: TvgRect; virtual;
    function GetEffectsRect: TvgRect; //virtual;
    function GetAbsoluteEnabled: boolean; //virtual;
    procedure SetBoundsRect(const Value: TvgRect); //virtual;
    procedure NeedRecalcOpacity; //virtual;
    procedure NeedRecalcAbsolute; //virtual;
    procedure RecalcAbsoluteNow;
    procedure NeedRecalcUpdateRect;
    procedure RecalcNeedAlign;
    procedure NeedRecalcEnabled;
    procedure RecalcHasEffect;
    procedure FixupTabList;
    { opacity }
    function GetAbsoluteOpacity: single; //virtual;
    { design }
    {$IfDef vgDesign}
    procedure DesignSelect; virtual;
    procedure DesignClick; virtual;
    procedure DesignInsert; virtual;
    {$EndIf vgDesign}
    { events }
    procedure BeginAutoDrag; virtual;
    procedure Capture;
    procedure ReleaseCapture;
    procedure Click; virtual;
    procedure DblClick; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: single); virtual;
    procedure MouseMove(Shift: TShiftState; X, Y, Dx, Dy: single); virtual;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: single); virtual;
    procedure MouseWheel(Shift: TShiftState; WheelDelta: integer; var Handled: boolean); virtual;
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); virtual;
    procedure KeyUp(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); virtual;
    procedure DialogKey(var Key: Word; Shift: TShiftState); virtual;
    procedure MouseEnter; virtual;
    procedure MouseLeave; virtual;
    procedure ContextMenu(const ScreenPosition: TvgPoint); virtual;
    procedure DragEnter(const Data: TvgDragObject; const Point: TvgPoint); virtual;
    procedure DragOver(const Data: TvgDragObject; const Point: TvgPoint; var Accept: Boolean); virtual;
    procedure DragDrop(const Data: TvgDragObject; const Point: TvgPoint); virtual;
    procedure DragLeave; virtual;
    procedure DragEnd; virtual;
    function EnterFocusChildren(AObject: TvgVisualObject): boolean; virtual;
    procedure EnterFocus; virtual;
  //public  
    procedure KillFocus; virtual;
  protected
    procedure SetNewScene(AScene: IvgScene); override;
    { control resources }
    procedure ApplyResource; virtual;
    { paint }
    procedure BeforePaint; virtual;
    procedure Paint; virtual;
    procedure AfterPaint; virtual;
    procedure PaintChildren; virtual;
    { changes }
    procedure MarginsChanged(Sender: TObject); virtual;
    procedure PaddingChanged(Sender: TObject); virtual;
    procedure MatrixChanged(Sender: TObject); virtual;
    { props }
    property MouseInObject: boolean read FMouseInObject write FMouseInObject;
    property TempCanvas: TvgCustomCanvas read FTempCanvas write SetTempCanvas;
    property Skew: TvgPosition read FSkew write FSkew;

    procedure pm_SetOnClick(Value: TNotifyEvent); virtual;
    function  InSceneDesign: Boolean;
    function FindObjectByPoint(aX: Single; aY: Single;
     aForHint: Boolean = False): TvgVisualObject; virtual;
  public
    {$IfDef vgDesign}
    DisableDesignResize: boolean;
    {$EndIf vgDesign}
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
    { matrix }
    function AbsoluteToLocal(P: TvgPoint): TvgPoint; virtual;
    function LocalToAbsolute(P: TvgPoint): TvgPoint; virtual;
    function AbsoluteToLocalVector(P: TvgVector): TvgVector; virtual;
    function LocalToAbsoluteVector(P: TvgVector): TvgVector; virtual;
    function ObjectByPoint(X, Y: single): TvgVisualObject; virtual;
    function ObjectByPointForHint(X: Single; Y: Single): TvgVisualObject; virtual;
    function PointInObject(X, Y: single): boolean; virtual;
    procedure SetBounds(X, Y, AWidth, AHeight: single); virtual;
    procedure SetSizeWithoutChange(AWidth, AHeight: single);
    function CheckParentVisible: boolean; virtual;
    { drag and drop }
    function MakeScreenshot: TvgBitmap;
    function FindTarget(const APoint: TvgPoint; const Data: TvgDragObject): TvgVisualObject;
    { caret }
    procedure ShowCaretProc;
    procedure SetCaretPos(const APoint: TvgPoint);
    procedure SetCaretSize(const ASize: TvgPoint);
    procedure SetCaretColor(const AColor: TvgColor);
    procedure HideCaret;
    { align }
    procedure BeginUpdate; {$IfNDef Nemesis} virtual; {$EndIf}
    procedure EndUpdate; {$IfDef vgDesign} virtual; {$EndIf}
    procedure Realign; virtual;
    { effects }
    procedure UpdateEffects;
    { }
    procedure GetTabOrderList(List: TvgObjectList; Children: boolean; aCheckCanFocus : Boolean);
    procedure SetFocus; virtual;
    procedure PaintTo(const ACanvas: TvgCustomCanvas; const ARect: TvgRect; const AParent: TvgObject = nil);
    procedure ApplyEffect;
    procedure Repaint;
    procedure InvalidateRect(ARect: TvgRect);
    procedure Lock;
    property AbsoluteMatrix: TvgMatrix read GetAbsoluteMatrix;
    property AbsoluteOpacity: single read GetAbsoluteOpacity;
    property AbsoluteWidth: single read GetAbsoluteWidth;
    property AbsoluteHeight: single read GetAbsoluteHeight;
    property AbsoluteScale: TvgPoint read GetAbsoluteScale;
    property AbsoluteEnabled: boolean read GetAbsoluteEnabled;
    property InvertAbsoluteMatrix: TvgMatrix read GetInvertAbsoluteMatrix;
    property LocalRect: TvgRect read GetLocalRect;
    property AbsoluteRect: TvgRect read GetAbsoluteRect;
    property UpdateRect: TvgRect read GetUpdateRect;
    property BoundsRect: TvgRect read GetBoundsRect write SetBoundsRect;
    property ParentedRect: TvgRect read GetParentedRect;
    property ClipRect: TvgRect read GetClipRect;
    property Canvas: TvgCustomCanvas read GetCanvas;
    property AutoCapture: boolean read FAutoCapture write FAutoCapture default false;
    property CanFocused: boolean read FCanFocused write FCanFocused default false;
    property DisableFocusEffect: boolean read FDisableFocusEffect write FDisableFocusEffect default false;
    property DisableDefaultAlign: boolean read FDisableDefaultAlign write FDisableDefaultAlign;
    property TabOrder: TTabOrder read GetTabOrder write SetTabOrder default -1;
    property OnRealign: TNotifyEvent
      read f_OnRealign
      write f_OnRealign;
  published
    { triggers }
    property IsMouseOver: boolean read FIsMouseOver;
    property IsDragOver: boolean read FIsDragOver;
    property IsFocused: boolean read FIsFocused;
    property IsVisible: boolean read FVisible;
    { props }
    property Align: TvgAlign read FAlign write SetAlign default vaNone;
    property Cursor: TCursor read FCursor write SetCursor default crDefault;
    property DragMode: TvgDragMode read FDragMode write FDragMode default vgDragManual;
    property DragDisableHighlight: boolean read FDragDisableHighlight write FDragDisableHighlight default false;
    property Enabled: boolean read FEnabled write SetEnabled default true;
    property Position: TvgPosition read FPosition write SetPosition;
    property RotateAngle: single read FRotateAngle write SetRotateAngle;
    property RotateCenter: TvgPosition read FRotateCenter write FRotateCenter;
    property Locked: boolean read FLocked write SetLocked default false;
    property Width: single read FWidth write SetWidth;
    property Height: single read FHeight write SetHeight;
    property Margins: TvgBounds read FMargins write FMargins;
    property Padding: TvgBounds read FPadding write FPadding;
    property Opacity: single read FOpacity write SetOpacity stored isOpacityStored;
    property ClipChildren: boolean read FClipChildren write SetClipChildren default false;
    property ClipParent: boolean read FClipParent write FClipParent default false;
    property HitTest: boolean read FHitTest write SetHitTest default true;
    property Hint: WideString read FHint write FHint;
    property ShowHint: boolean read FShowHint write FShowHint default false;
    property CanClipped: boolean read FCanClipped write FCanClipped default true;
    {$IFNDEF NOVCL}
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu;
    {$ENDIF}
    property Popup: TvgVisualObject{TvgPopup} read FPopup write FPopup;
    property Scale: TvgPosition read FScale write FScale;
    property Visible: boolean read FVisible write SetVisible default true;
    {$IfDef vgDesign}
    property DesignHide: boolean read FDesignHide write SetDesignHide default false;
    {$EndIf vgDesign}
    property IsTabExitPoint : Boolean
      read f_IsTabExitPoint
      write f_IsTabExitPoint
      default false;
      {* - контрол является точкой выхода из формы по Tab и точкой входа по Shift-Tab. }
    property OnDragEnter: TvgDragEnterEvent read FOnDragEnter write FOnDragEnter;
    property OnDragLeave: TNotifyEvent read FOnDragLeave write FOnDragLeave;
    property OnDragOver: TvgDragOverEvent read FOnDragOver write FOnDragOver;
    property OnDragDrop: TvgDragDropEvent read FOnDragDrop write FOnDragDrop;
    property OnDragEnd: TNotifyEvent read FOnDragEnd write FOnDragEnd;
    property OnKeyDown: TvgKeyEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyUp: TvgKeyEvent read FOnKeyUp write FOnKeyUp;
    property OnClick: TNotifyEvent read FOnClick write pm_SetOnClick;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnCanFocused: TvgCanFocusedEvent read FOnCanFocused write FOnCanFocused;
    property OnEnterFocus: TNotifyEvent read FOnEnterFocus write FOnEnterFocus;
    property OnKillFocus: TNotifyEvent read FOnKillFocus write FOnKillFocus;
    property OnMouseDown: TvgMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TvgMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TvgMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnMouseWheel: TvgMouseWheelEvent read FOnMouseWheel write FOnMouseWheel;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnBeforePaint: TOnPaintEvent read FOnBeforePaint write FOnBeforePaint;
    property OnPaint: TOnPaintEvent read FOnPaint write FOnPaint;
    property OnApplyResource: TNotifyEvent read FOnApplyResource write FOnApplyResource;
  end;//TvgVisualObject

{$EndIf  NoVGScene}

implementation

{$IfNDef NoVGScene}

uses
  Windows,
  
  SysUtils,
  
  vgEffect,

  vg_scene,
  vg_ani,
  vg_objects,
  vg_layouts
  ;

// start class TvgVisualObject

procedure TvgVisualObject.SetLocked(const Value: boolean);
begin
  FLocked := Value;
end;

function TvgVisualObject.GetEffectsRect: TvgRect;
var
  i: integer;
begin
  Result := LocalRect;
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
    begin
      if (TvgObject(FChildren[i]) is TvgEffect) and (TvgEffect(FChildren[i]).Enabled) then
        Result := vgUnionRect(Result, TvgEffect(FChildren[i]).GetRect(LocalRect));
    end;
end;

procedure TvgVisualObject.RecalcHasEffect;
var
  i: integer;
begin
  FHasEffect := false;
  if FDisableEffect then Exit;
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
    begin
      if (TvgObject(FChildren[i]) is TvgEffect) and (TvgEffect(FChildren[i]).Enabled) then
      begin
        if not FHasEffect then
        begin
          UpdateEffects;
          Repaint;
        end;
        FHasEffect := true;
        Break;
      end;
    end;
end;

type
  TvgHackEffect = class(TvgEffect)
  end;//TvgHackEffect

function TvgVisualObject.pm_GetIsVisual : Boolean;
begin
 Result := true;
end;

function TvgVisualObject.HasDisablePaintEffect: boolean;
var
  i: integer;
begin
  Result := false;
  if FDisableEffect then Exit;
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
      if (TvgObject(FChildren[i]) is TvgEffect) and
         (TvgEffect(FChildren[i]).Enabled) and
         (TvgHackEffect(TvgEffect(FChildren[i])).DisablePaint) then
      begin
        Result := true;
        Exit;
      end;
end;

function TvgVisualObject.HasAfterPaintEffect: boolean;
var
  i: integer;
begin
  Result := false;
  if FDisableEffect then Exit;
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
      if (TvgObject(FChildren[i]) is TvgEffect) and
         (TvgEffect(FChildren[i]).Enabled) and
         (TvgHackEffect(TvgEffect(FChildren[i])).AfterPaint) then
      begin
        Result := true;
        Exit;
      end;
end;

constructor TvgVisualObject.Create(AOwner: TComponent);
begin
  inherited;
  FTabOrder := -1;
  FEnabled := true;
  FNeedRecalcEnabled := true;
  FOpacity := 1;
  FLocalMatrix := IdentityMatrix;
  FPosition := TvgPosition.Create(vgPoint(0, 0));
  FPosition.OnChange := MatrixChanged;
  FScale := TvgPosition.Create(vgPoint(1, 1));
  FScale.OnChange := MatrixChanged;
  FSkew := TvgPosition.Create(vgPoint(0, 0));
  FSkew.OnChange := MatrixChanged;
  FRotateCenter := TvgPosition.Create(vgPoint(0.5, 0.5));
  FRotateCenter.OnChange := MatrixChanged;
  FMargins := TvgBounds.Create(vgRect(0, 0, 0, 0));
  FMargins.OnChange := MarginsChanged;
  FPadding := TvgBounds.Create(vgRect(0, 0, 0, 0));
  FPadding.OnChange := PaddingChanged;
  FWidth := 50;
  FLastWidth := FWidth;
  FHeight := 50;
  FLastHeight := FHeight;
  FVisible := true;
  FHitTest := true;
  FNeedRecalcAbsolute := true;
  FNeedRecalcOpacity := true;
  FUpdateEffects := true;
  FNeedRecalcUpdateRect := true;
  FCanFocused := false;
  FCanClipped := true;
  f_IsTabExitPoint := false;
end;

procedure TvgVisualObject.Cleanup;
begin
  FreeAndNil(FTabList);
  FreeAndNil(FEffectBitmap);
  FreeAndNil(FMargins);
  FreeAndNil(FPadding);
  FreeAndNil(FRotateCenter);
  FreeAndNil(FScale);
  FreeAndNil(FSkew);
  FreeAndNil(FPosition);
  inherited;
end;

procedure TvgVisualObject.Loaded;
begin
  inherited;
  FLastWidth := FWidth;
  FLastHeight := FHeight;
  MatrixChanged(Self);
  if (FChildren <> nil) and (FChildren.Count > 0) then
    Realign;
  FixupTabList;
end;

procedure TvgVisualObject.DeleteChildren;
begin
  inherited;
  if FTabList <> nil then
    FreeAndNil(FTabList);
end;

procedure TvgVisualObject.Notification(AComponent: TComponent;
      Operation: TOperation);
begin
  {$IFNDEF NOVCL}
  if (Operation = opRemove) and (AComponent = FPopupMenu) then
    FPopupMenu := nil;
  {$ENDIF}
  if (Operation = opRemove) and (AComponent = FPopup) then
    FPopup := nil;
end;

{ matrix }

procedure TvgVisualObject.MatrixChanged(Sender: TObject);
var
  RotMatrix: TvgMatrix;
  M1, M2: TvgMatrix;
begin
  if (FScene <> nil) and
     (not FScene.GetDisableUpdate) and
     (not FInPaintTo) and
     (FUpdating = 0) then
    Repaint;
  FLocalMatrix := IdentityMatrix;
  FLocalMatrix.m31 := FPosition.X;
  FLocalMatrix.m32 := FPosition.Y;
  FLocalMatrix.m11 := FScale.X;
  FLocalMatrix.m22 := FScale.Y;
  if FRotateAngle <> 0 then
  begin
    M1 := IdentityMatrix;
    M1.m31 := -FRotateCenter.X * FWidth{ * FScale.X};
    M1.m32 := -FRotateCenter.Y * FHeight{ * FScale.Y};
    M2 := IdentityMatrix;
    M2.m31 := FRotateCenter.X * FWidth{ * FScale.X};
    M2.m32 := FRotateCenter.Y * FHeight{ * FScale.Y};
    RotMatrix := vgMatrixMultiply(M1, vgMatrixMultiply(vgCreateRotationMatrix(vgDegToRad(FRotateAngle)), M2));
    FLocalMatrix := vgMatrixMultiply(RotMatrix, FLocalMatrix);
  end;
  //NeedRecalcOpacity;
  // - версия не прошла - http://mdp.garant.ru/pages/viewpage.action?pageId=272666699&focusedCommentId=296637343#comment-296637343 
  NeedRecalcAbsolute;
  NeedRecalcUpdateRect;
  UpdateEffects;
  if (FScene <> nil) and
     (not FScene.GetDisableUpdate) then
   if (not FInPaintTo) and (FUpdating = 0)then
    Repaint;
end;

procedure TvgVisualObject.NeedRecalcUpdateRect;
var
  i: integer;
begin
  if (Parent <> nil) and
     Parent.IsVisual and
     not (TvgVisualObject(Parent.Visual).ClipChildren) then
   if ((Position.X < 0) or (Position.Y < 0) or
       (Position.X + Width <{={LAW} TvgVisualObject(Parent.Visual).Width) or
       (Position.Y + Height <{={LAW} TvgVisualObject(Parent.Visual).Height))
    then
     TvgVisualObject(Parent.Visual).FNeedRecalcUpdateRect := true;

  FNeedRecalcUpdateRect := true;
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
    begin
      if not TvgObject(FChildren[i]).IsVisual then Continue;
      TvgVisualObject(FChildren[i]).NeedRecalcUpdateRect;
    end;
end;

function TvgVisualObject.GetUpdateRect: TvgRect;
var
  R: TvgRect;
  P: TvgObject;
  i: integer;
begin
  if FNeedRecalcUpdateRect then
  begin
    FNeedRecalcUpdateRect := false;
    Inc(FUpdating);
    try
     FUpdateRect := AbsoluteRect;
     if (FScene <> nil) and not (FScene.GetDisableUpdate) then
     begin
       if not (csLoading in ComponentState) then
       begin
         P := Parent;
         while (P <> nil) and (P.IsVisual) do
         begin
           if TvgVisualObject(P).ClipChildren then
             vgIntersectRect(FUpdateRect, FUpdateRect, TvgVisualObject(P).UpdateRect);
           P := P.Parent;
         end;//while (P <> nil) and (P.IsVisual)
         { focused }
         if CanFocused and IsFocused then
           vgInflateRect(FUpdateRect, 5, 5);
         { design }
         {$IfDef vgDesign}
         if (FScene <> nil) and (Self = FScene.GetSelected) then
         begin
           vgInflateRect(FUpdateRect, (GripSize) + 1, (GripSize) + 1);
           FUpdateRect.Top := FUpdateRect.Top - RotSize - GripSize;
         end;//(FScene <> nil) and (Self = FScene.GetSelected)
         {$EndIf vgDesign}
         {$IfDef vgDesign}
         if (FScene <> nil) and (FScene.GetDesignPlaceObject = Self) then
         begin
           vgInflateRect(FUpdateRect, 1, 1);
           FUpdateRect.Top := FUpdateRect.Top - 20;
           if vgRectWidth(FUpdateRect) < 160 then
             FUpdateRect.Right := FUpdateRect.Left + 160;
         end;//(FScene <> nil) and (FScene.GetDesignPlaceObject = Self)
         {$EndIf vgDesign}
         { Effects }
         if FHasEffect and not ClipChildren then
         begin
           R := GetEffectsRect;
           with R do
             R := vgNormalizeRect([LocaltoAbsolute(vgPoint(Left, Top)), LocaltoAbsolute(vgPoint(Right, Top)),
               LocaltoAbsolute(vgPoint(Right, Bottom)), LocaltoAbsolute(vgPoint(Left, Bottom))]);
           FUpdateRect := vgUnionRect(FUpdateRect, R);
         end;//FHasEffect..
         { Children }
         if not ClipChildren and (FChildren <> nil) then
         begin
           for i := 0 to FChildren.Count - 1 do
           begin
             if not TvgObject(FChildren[i]).IsVisual then Continue;
             if not TvgVisualObject(FChildren[i]).Visible then Continue;
             R := TvgVisualObject(FChildren[i]).UpdateRect;
             FUpdateRect := vgUnionRect(FUpdateRect, R);
           end;//for i
         end;//not ClipChildren and (FChildren <> nil)
       end;//not (csLoading in ComponentState)
     end;//(FScene <> nil) and not (FScene.GetDisableUpdate)
    finally
     Dec(FUpdating);
    end;//try..finally
  end;//FNeedRecalcUpdateRect
  Result := FUpdateRect;
end;

function TvgVisualObject.GetChildrenRect: TvgRect;
var
  i: integer;
begin
  Result := AbsoluteRect;
  { children }
  if not ClipChildren and (FChildren <> nil) then
    for i := 0 to FChildren.Count - 1 do
      if TvgObject(FChildren[i]).IsVisual and (TvgVisualObject(FChildren[i]).Visible) then
        Result := vgUnionRect(Result, TvgVisualObject(FChildren[i]).GetChildrenRect);
end;

function TvgVisualObject.GetAbsoluteWidth: single;
var
  V: TvgVector;
begin
  V := LocalToAbsoluteVector(vgVector(Width, Height));
  Result := V.X;
end;

function TvgVisualObject.GetAbsoluteHeight: single;
var
  V: TvgVector;
begin
  V := LocalToAbsoluteVector(vgVector(Width, Height));
  Result := V.Y;
end;

function TvgVisualObject.GetAbsoluteScale: TvgPoint;
var
  P: TvgObject;
begin
  Result := Scale.Point;
  P := Parent;
  while P <> nil do
  begin
    if P.IsVisual then
    begin
      Result.X := Result.X * TvgVisualObject(P.Visual).Scale.X;
      Result.Y := Result.Y * TvgVisualObject(P.Visual).Scale.Y;
    end;
    P := P.Parent;
  end;
end;

function TvgVisualObject.GetChildrenMatrix: TvgMatrix;
begin
  Result := IdentityMatrix;
end;

function TvgVisualObject.GetAbsoluteMatrix: TvgMatrix;
begin
 if FNeedRecalcAbsolute then
 begin
  if (FParent <> nil) and (FParent.IsVisual) then
    FAbsoluteMatrix := vgMatrixMultiply(
                        vgMatrixMultiply(FLocalMatrix,
                                         TvgVisualObject(FParent.Visual).
                                          GetChildrenMatrix),
                        TvgVisualObject(FParent.Visual).AbsoluteMatrix)
  else
    FAbsoluteMatrix := FLocalMatrix;
  Result := FAbsoluteMatrix;
  FNeedRecalcAbsolute := false;
  if (FScene <> nil) and
     (not FScene.GetDisableUpdate) and
     (not FInPaintTo) and (FUpdating = 0) then
    Repaint;
 end//FNeedRecalcAbsolute
 else
  Result := FAbsoluteMatrix;
end;

function TvgVisualObject.GetInvertAbsoluteMatrix: TvgMatrix;
begin
  Result := AbsoluteMatrix;
  vgInvertMatrix(Result);
end;

procedure TvgVisualObject.RecalcAbsoluteNow;
var
  i: integer;
  Child: TvgVisualObject;
begin
  AbsoluteMatrix; // recalc
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
    begin
      if not TvgObject(FChildren[i]).isVisual then Continue;
      Child := TvgVisualObject(FChildren[i]);
      TvgVisualObject(Child).RecalcAbsoluteNow;
    end;
end;

procedure TvgVisualObject.NeedRecalcAbsolute;
var
  i: integer;
  Child: TvgVisualObject;
begin
  FNeedRecalcAbsolute := true;
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
    begin
      if not TvgObject(FChildren[i]).isVisual then Continue;
      Child := TvgVisualObject(FChildren[i]);
      TvgVisualObject(Child).NeedRecalcAbsolute;
    end;
end;

function TvgVisualObject.AbsoluteToLocalVector(P: TvgVector): TvgVector;
begin
  P.W := 0;
  Result := vgVectorTransform(P, InvertAbsoluteMatrix);
end;

function TvgVisualObject.LocalToAbsoluteVector(P: TvgVector): TvgVector;
begin
  P.W := 0;
  Result := vgVectorTransform(P, AbsoluteMatrix);
end;

function TvgVisualObject.AbsoluteToLocal(P: TvgPoint): TvgPoint;
var
  V: TvgVector;
begin
  V.X := P.X;
  V.Y := P.Y;
  V.W := 1;
  V := vgVectorTransform(V, InvertAbsoluteMatrix);
  Result.X := V.X;
  Result.Y := V.Y;
end;

function TvgVisualObject.LocalToAbsolute(P: TvgPoint): TvgPoint;
var
  V: TvgVector;
begin
  V.X := P.X;
  V.Y := P.Y;
  V.W := 1;
  V := vgVectorTransform(V, AbsoluteMatrix);
  Result := vgPoint(V.X, V.Y);
end;

{ Opacity }

function TvgVisualObject.GetAbsoluteOpacity: single;
begin
  if FNeedRecalcOpacity then
  begin
    if (FParent <> nil) and (FParent.IsVisual) then
      FAbsoluteOpacity := FOpacity * TvgVisualObject(FParent.Visual).AbsoluteOpacity
    else
      FAbsoluteOpacity := FOpacity;

    if not AbsoluteEnabled and (FScene <> nil) and ((FScene.GetRoot <> Self) and (FScene.GetRoot <> Parent)) then
      FAbsoluteOpacity := FAbsoluteOpacity * 0.8;

    Result := FAbsoluteOpacity;

    FNeedRecalcOpacity := false;
  end
  else
  begin
    Result := FAbsoluteOpacity;
  end;
end;

procedure TvgVisualObject.NeedRecalcOpacity;
var
  i: integer;
  Child: TvgVisualObject;
begin
  FNeedRecalcOpacity := true;
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
    begin
      if not TvgObject(FChildren[i]).isVisual then Continue;
      Child := TvgVisualObject(FChildren[i]);
      TvgVisualObject(Child).NeedRecalcOpacity;
    end;
end;

{ methods }

procedure TvgVisualObject.CreateCaret;
var
  A: TvgFloatAnimation;
begin
  if FCaret = nil then
  begin
    FCaret := TvgRectangle.Create(Self);
    FCaret.Parent := Self;
    FCaret.Width := 3;
    FCaret.Height := 20;
    FCaret.Stored := false;
    FCaret.HitTest := false;
    FCaret.Locked := true;
    TvgRectangle(FCaret).Fill.Color := vcBlue;
    TvgRectangle(FCaret).Stroke.Style := vgBrushNone;
    if Assigned(FScene) and (FScene.GetAnimatedCaret) then
    begin
      A := TvgFloatAnimation.Create(Self);
      A.BindingName := 'caret';
      A.Parent := FCaret;
      A.StartValue := 1;
      A.Duration := 0.1;
      A.PropertyName := 'Opacity';
      A.StopValue := 0;
      A.AutoReverse := true;
      A.Loop := true;
      A.Enabled := false;
    end;
    FCaret.Visible := false;
  end;
end;

procedure TvgVisualObject.ShowCaretProc;
begin
  if FCaret = nil then
    CreateCaret;

  FCaret.Visible := true;
  if (FCaret.FindBinding('caret') <> nil) and not TvgFloatAnimation(FCaret.FindBinding('caret')).Running then
    TvgFloatAnimation(FCaret.FindBinding('caret')).Start;
end;

procedure TvgVisualObject.SetCaretPos(const APoint: TvgPoint);
begin
  if FCaret = nil then
    CreateCaret;
  FCaret.Position.Point := vgPoint(round(APoint.x), round(APoint.y));
end;

procedure TvgVisualObject.SetCaretSize(const ASize: TvgPoint);
begin
  if FCaret = nil then
    CreateCaret;
  FCaret.Width := ASize.X;
  FCaret.Height := ASize.Y;
end;

procedure TvgVisualObject.SetCaretColor(const AColor: TvgColor);
begin
  if FCaret = nil then
    CreateCaret;
  TvgRectangle(FCaret).Fill.SolidColor := AColor;
end;

procedure TvgVisualObject.HideCaret;
begin
  if FCaret <> nil then
    FCaret.Visible := false;
end;

function TvgVisualObject.PointInObject(X, Y: single): boolean;
var
  P: TvgPoint;
begin
  Result := false;
  P := AbsoluteToLocal(vgPoint(X, Y));
  if (P.X > 0) and (P.X < Width) and
     (P.Y > 0) and (P.Y < Height) then
  begin
    Result := true;
  end;
end;

function TvgVisualObject.CheckHitTest(const AHitTest: boolean): boolean;
begin
  Result := FHitTest;
  {$IfDef vgDesign}
  if ((Scene <> nil) and (Scene.GetDesignTime)) then
    Result := true;
  if (((Scene <> nil) and (Scene.GetDesignTime))) and FLocked then
    Result := false;
  if (((Scene <> nil) and (Scene.GetDesignTime))) and FDesignHide then
    Result := false;
  {$EndIf vgDesign}  
end;

function TvgVisualObject.InSceneDesign: Boolean;
begin
 {$IfDef vgDesign}
 Result := Assigned(FScene) and (FScene.GetDesignTime);
 {$Else  vgDesign}
 Result := false;
 {$EndIf vgDesign}
end;

function TvgVisualObject.FindObjectByPoint(aX: Single; aY: Single;
 aForHint: Boolean = False): TvgVisualObject;
var
  i: integer;
  Obj, NewObj: TvgVisualObject;
begin
  if not Visible and not InSceneDesign then
  begin
    Result := nil;
    Exit;
  end;
  if (Self is TvgControl) and not TvgControl(Self).AbsoluteEnabled and not InSceneDesign then
  begin
    Result := nil;
    Exit;
  end;
  if ClipChildren and not PointInObject(aX, aY) then
  begin
    Result := nil;
    Exit;
  end;
  if FChildren <> nil then
    for i := FChildren.Count - 1 downto 0 do
    begin
      if not TvgObject(FChildren[i]).IsVisual then Continue;
      Obj := TvgVisualObject(FChildren[i]);
      if (not Obj.Visible) and not InSceneDesign then Continue;
      {$IfDef vgDesign}
      if FDesignHide and InSceneDesign then Continue;
      {$EndIf vgDesign}
      NewObj := Obj.FindObjectByPoint(aX, aY, aForHint);
      if NewObj <> nil then
      begin
        Result := NewObj;
        Exit;
      end;
    end;

  Result := nil;
  if PointInObject(aX, aY) and CheckHitTest(HitTest)  then
    Result := Self;
end;

function TvgVisualObject.FindTarget(const APoint: TvgPoint; const Data: TvgDragObject): TvgVisualObject;
var
  i: integer;
  Obj, NewObj: TvgVisualObject;
  Accept: boolean;
begin
  if not Visible and not InSceneDesign then
  begin
    Result := nil;
    Exit;
  end;
  if (Self is TvgControl) and not TvgControl(Self).AbsoluteEnabled and not InSceneDesign then
  begin
    Result := nil;
    Exit;
  end;

  if FChildren <> nil then
    for i := FChildren.Count - 1 downto 0 do
    begin
      if not TvgObject(FChildren[i]).IsVisual then Continue;
      Obj := TvgVisualObject(FChildren[i]);
      if (not Obj.Visible) and not InSceneDesign then Continue;
      {$IfDef vgDesign}
      if FDesignHide and InSceneDesign then Continue;
      {$EndIf vgDesign}
      if ClipChildren and not PointInObject(APoint.X, APoint.Y) then Continue;

      NewObj := Obj.FindTarget(APoint, Data);
      if NewObj <> nil then
      begin
        Result := NewObj;
        Exit;
      end;
    end;

  Result := nil;
  Accept := false;
  DragOver(Data, APoint, Accept);
  if PointInObject(APoint.X, APoint.Y) and CheckHitTest(HitTest) and (Accept) then
    Result := Self;
end;

function TvgVisualObject.ObjectByPoint(X, Y: single): TvgVisualObject;
begin
 Result := FindObjectByPoint(X, Y);
end;

function TvgVisualObject.ObjectByPointForHint(X: Single; Y: Single): TvgVisualObject;
begin
 Result := FindObjectByPoint(X, Y, True);
end;

function TvgVisualObject.GetCanvas: TvgCustomCanvas;
begin
  if FTempCanvas <> nil then
    Result := FTempCanvas
  else
    if FScene <> nil then
      Result := FScene.GetCanvas
    else
      Result := nil;
end;

procedure TvgVisualObject.BeforePaint;
begin
end;

procedure TvgVisualObject.ApplyResource;
begin
end;

procedure TvgVisualObject.Paint;
begin
end;

procedure TvgVisualObject.AfterPaint;
begin
end;

procedure TvgVisualObject.SetInPaintTo(value: boolean);
var
  i: integer;
begin
  FInPaintTo := value;
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
      if TvgObject(FChildren[i]).isVisual then
        TvgVisualObject(FChildren[i]).SetInPaintTo(value);
end;

type
  TvgHackPosition = class(TvgPosition)
  end;//TvgHackPosition

procedure TvgVisualObject.PaintTo(const ACanvas: TvgCustomCanvas; const ARect: TvgRect; const AParent: TvgObject = nil);
var
  SaveIndex: integer;
  SaveTempCanvas: TvgCanvas;
  SaveDisableAlign: boolean;
  SavePos: TvgPoint;
  SaveScale: TvgPoint;
  SaveParent: TvgObject;
  SaveRotate: single;
begin
  if FScene = nil then Exit;
  if Width * Height = 0 then Exit;

  FScene.SetDisableUpdate(true);
  SaveDisableAlign := FDisableAlign;
  FDisableAlign := true;
  SetInPaintTo(true);
  try
    SaveTempCanvas := TvgCanvas(TempCanvas);
    TempCanvas := ACanvas;
    SaveIndex := TvgCanvas(TempCanvas).SaveCanvas;
    { save }
    SavePos := Position.Point;
    SaveScale := Scale.Point;
    SaveParent := FParent;
    SaveRotate := RotateAngle;
    FParent := AParent;
    TvgHackPosition(FPosition).FX := ARect.Left;
    TvgHackPosition(FPosition).FY := ARect.Top;
    TvgHackPosition(FScale).FX := vgRectWidth(ARect) / Width;
    TvgHackPosition(FScale).FY := vgRectHeight(ARect) / Height;
    FRotateAngle := 0;
    MatrixChanged(Self);

    { paint }
    TvgCanvas(TempCanvas).SetMatrix(AbsoluteMatrix);
    BeforePaint;
    Paint;
    AfterPaint;
    PaintChildren;

    { restore }
    FRotateAngle := SaveRotate;
    TvgHackPosition(FPosition).FX := SavePos.X;
    TvgHackPosition(FPosition).FY := SavePos.Y;
    TvgHackPosition(FScale).FX := SaveScale.X;
    TvgHackPosition(FScale).FY := SaveScale.Y;
    FParent := SaveParent;
    MatrixChanged(Self);
    NeedRecalcUpdateRect;
    RecalcAbsoluteNow;
    NeedRecalcOpacity;
    NeedRecalcEnabled;
  finally
    SetInPaintTo(false);
    FDisableAlign := SaveDisableAlign;
    TvgCanvas(TempCanvas).RestoreCanvas(SaveIndex);
    TempCanvas := SaveTempCanvas;
    FScene.SetDisableUpdate(false);
  end;
end;

procedure TvgVisualObject.UpdateEffects;
var
  P: TvgObject;
begin
  if FHasEffect then
  begin
    FUpdateEffects := true;
  end;
  P := Parent;
  while P <> nil do
  begin
    if P.IsVisual then
      TvgVisualObject(P.Visual).UpdateEffects;
    P := P.Parent;
  end;
end;

procedure TvgVisualObject.ApplyEffect;
var
  i, State, State2: integer;
  M: TvgMatrix;
  R: TvgRect;
  Effect: TvgEffect;
  EffectRect: TvgRect;
begin
  if FChildren = nil then Exit;
  if FScene = nil then Exit;
  if FDisableEffect then Exit;
  if not FHasEffect then Exit;

  State := TvgCanvas(Canvas).SaveCanvas;
  if not FUpdateEffects then
  begin
    if FEffectBitmap <> nil then
    begin
      TvgCanvas(Canvas).SetMatrix(AbsoluteMatrix);
      for i := 0 to FChildren.Count - 1 do
      if (TvgObject(FChildren[i]) is TvgEffect) and (TvgEffect(FChildren[i]).Enabled) then
      begin
        Effect := TvgEffect(FChildren[i]);
        EffectRect := Effect.GetRect(vgRect(0, 0, Width, Height));
        TvgCanvas(Canvas).DrawBitmap(FEffectBitmap, vgRect(0, 0, FEffectBitmap.Width, FEffectBitmap.Height), EffectRect, AbsoluteOpacity, RotateAngle = 0);
      end;
    end;
  end
  else
  begin
    for i := 0 to FChildren.Count - 1 do
    if (TvgObject(FChildren[i]) is TvgEffect) and (TvgEffect(FChildren[i]).Enabled) then
    begin
      Effect := TvgEffect(FChildren[i]);
      EffectRect := Effect.GetRect(vgRect(0, 0, Width, Height));
      with GetAbsoluteScale do
        vgMultiplyRect(EffectRect, X, Y);
      if FEffectBitmap = nil then
      begin
        { create }
        FEffectBitmap := TvgBitmap.Create(trunc(vgRectWidth(EffectRect)), trunc(vgRectHeight(EffectRect)));
      end
      else
        if (FEffectBitmap.Width <> trunc(vgRectWidth(EffectRect))) or
           (FEffectBitmap.Height <> trunc(vgRectHeight(EffectRect))) then
        begin
          { resize }
          FEffectBitmap.SetSize(trunc(vgRectWidth(EffectRect)), trunc(vgRectHeight(EffectRect)));
        end;
      { Paint Self }
      State2 := TvgCanvas(FEffectBitmap.Canvas).SaveCanvas;
      M := IdentityMatrix;
      TvgCanvas(FEffectBitmap.Canvas).BeginScene;
      try
       TvgCanvas(FEffectBitmap.Canvas).Clear(0);
       TvgCanvas(FEffectBitmap.Canvas).SetMatrix(M);
       R := vgRect(Effect.GetOffset.X, Effect.GetOffset.Y, (Effect.GetOffset.X + Width), (Effect.GetOffset.Y + Height));
       with GetAbsoluteScale do
         vgMultiplyRect(R, X, Y);

       PaintTo(TvgCanvas(FEffectBitmap.Canvas), R);

      finally
       TvgCanvas(FEffectBitmap.Canvas).EndScene;
      end;//try..finally
      TvgCanvas(FEffectBitmap.Canvas).RestoreCanvas(State2);
      { apply effects }
      with GetAbsoluteScale do
      begin
        Effect.ProcessEffect(TvgCanvas(FEffectBitmap.Canvas), FEffectBitmap, X);
        { draw effectBitmap }
        vgMultiplyRect(EffectRect, 1 / X, 1 / Y);
      end;
      TvgCanvas(Canvas).SetMatrix(AbsoluteMatrix);
      TvgCanvas(Canvas).DrawBitmap(FEffectBitmap, vgRect(0, 0, FEffectBitmap.Width, FEffectBitmap.Height), EffectRect, AbsoluteOpacity, RotateAngle = 0);
    end;
    FUpdateEffects := false;
  end;
  TvgCanvas(Canvas).RestoreCanvas(State);
end;

procedure TvgVisualObject.PaintChildren;
var
  i, j: integer;
  R: TvgRect;
  State, State2, State3: cardinal;
  ClipParentObject: TvgVisualObject;
  AllowPaint: boolean;
begin
  if FScene = nil then Exit;
  if FChildren <> nil then
  begin
    for i := 0 to FChildren.Count - 1 do
      if TvgObject(FChildren[i]).IsVisual and
         ((TvgVisualObject(FChildren[i]).Visible) or
          (not TvgVisualObject(FChildren[i]).Visible and InSceneDesign and not TvgVisualObject(FChildren[i]).Locked)) then
        with TvgVisualObject(FChildren[i]) do
        begin
          {$IfDef vgDesign}
          if InSceneDesign and FDesignHide then Continue;
          {$EndIf vgDesign}
          if (vgRectWidth(UpdateRect) = 0) or (vgRectHeight(UpdateRect) = 0) then Continue;

          FScene := Self.FScene;
          if Self.ClipChildren and not vgIntersectRect(Self.UpdateRect, UpdateRect) then Continue;

          AllowPaint := false;
          if InSceneDesign or FInPaintTo then
            AllowPaint := true;
          if not AllowPaint then
          begin
            R := vgUnionRect(GetChildrenRect, UpdateRect);
            for j := 0 to FScene.GetUpdateRectsCount - 1 do
              if vgIntersectRect(FScene.GetUpdateRect(j), R) then
              begin
                AllowPaint := true;
                Break;
              end;
          end;

          if AllowPaint then
          begin
            if Self.FClipChildren and CanClipped then
            begin
              State := TvgCanvas(Canvas).SaveCanvas;
              TvgCanvas(Canvas).SetMatrix(Self.AbsoluteMatrix);
              TvgCanvas(Canvas).IntersectClipRect(Self.ClipRect);
            end
            else
              State := InvalideCanvasState;
            TvgCanvas(Canvas).SetMatrix(AbsoluteMatrix);
            BeforePaint;
            if FHasEffect and not HasAfterPaintEffect then
              ApplyEffect;
            TvgCanvas(Canvas).SetMatrix(AbsoluteMatrix);
            if not HasDisablePaintEffect then
            begin
              ClipParentObject := TvgVisualObject(HasClipParent);
              if ClipParentObject <> nil then
              begin
                State3 := TvgCanvas(Canvas).SaveCanvas;

                TvgCanvas(Canvas).SetMatrix(ClipParentObject.AbsoluteMatrix);
                TvgCanvas(Canvas).ExcludeClipRect(ClipParentObject.LocalRect);
                TvgCanvas(Canvas).SetMatrix(AbsoluteMatrix);

                if ClipChildren then
                begin
                  // Clip self
                  State2 := TvgCanvas(Canvas).SaveCanvas;
                  TvgCanvas(Canvas).SetMatrix(AbsoluteMatrix);
                  TvgCanvas(Canvas).IntersectClipRect(ClipRect);
                  if Assigned(FOnBeforePaint) then
                  begin
                    FOnBeforePaint(TvgVisualObject(Self.FChildren[i]), TvgCanvas(Canvas), LocalRect);
                    TvgCanvas(Canvas).SetMatrix(AbsoluteMatrix);
                  end;
                  Paint;
                  TvgCanvas(Canvas).RestoreCanvas(State2);
                end
                else
                begin
                  if Assigned(FOnBeforePaint) then
                  begin
                    FOnBeforePaint(TvgVisualObject(Self.FChildren[i]), TvgCanvas(Canvas), LocalRect);
                    TvgCanvas(Canvas).SetMatrix(AbsoluteMatrix);
                  end;
                  Paint;
                end;
                TvgCanvas(Canvas).RestoreCanvas(State3);
                PaintChildren;
                if Assigned(FOnPaint) then
                begin
                  TvgCanvas(Canvas).SetMatrix(AbsoluteMatrix);
                  FOnPaint(TvgVisualObject(Self.FChildren[i]), TvgCanvas(Canvas), LocalRect);
                end;
              end
              else
              begin
                if ClipChildren then
                begin
                  // Clip self
                  State2 := TvgCanvas(Canvas).SaveCanvas;
                  TvgCanvas(Canvas).SetMatrix(AbsoluteMatrix);
                  TvgCanvas(Canvas).IntersectClipRect(ClipRect);
                  if Assigned(FOnBeforePaint) then
                  begin
                    FOnBeforePaint(TvgVisualObject(Self.FChildren[i]), TvgCanvas(Canvas), LocalRect);
                    TvgCanvas(Canvas).SetMatrix(AbsoluteMatrix);
                  end;
                  Paint;
                  TvgCanvas(Canvas).RestoreCanvas(State2);
                end
                else
                begin
                  if Assigned(FOnBeforePaint) then
                  begin
                    FOnBeforePaint(TvgVisualObject(Self.FChildren[i]), TvgCanvas(Canvas), LocalRect);
                    TvgCanvas(Canvas).SetMatrix(AbsoluteMatrix);
                  end;
                  Paint;
                end;
                PaintChildren;
                if Assigned(FOnPaint) then
                begin
                  TvgCanvas(Canvas).SetMatrix(AbsoluteMatrix);
                  FOnPaint(TvgVisualObject(Self.FChildren[i]), TvgCanvas(Canvas), LocalRect);
                end;
              end;
            end;
            AfterPaint;
            // design selection
            {$IfDef vgDesign}
            if (vgDesigner <> nil) and (Assigned(Self.Scene)) and (Self.GetOwner <> nil) and
               (Self.FChildren[i] <> Scene.GetSelected) and (vgDesigner.IsSelected(Self.Scene.GetOwner, TvgVisualObject(Self.FChildren[i]))) then
            begin
              TvgCanvas(Canvas).SetMatrix(AbsoluteMatrix);
              TvgCanvas(Canvas).Stroke.Style := vgBrushSolid;
              TvgCanvas(Canvas).Stroke.SolidColor := $B200CC5A;
              TvgCanvas(Canvas).StrokeCap := vgCapFlat;
              TvgCanvas(Canvas).StrokeJoin := vgJoinMiter;
              TvgCanvas(Canvas).StrokeDash := vgDashDash;
              TvgCanvas(Canvas).StrokeThickness := 1;
              R := vgRect(0, 0, Width, Height);
              vgInflateRect(R, -1, -1);
              TvgCanvas(Canvas).DrawRect(R, 1, 1, AllCorners, 1);
              TvgCanvas(Canvas).StrokeDash := vgDashSolid;
            end;
            {$EndIf vgDesign}
            // drag highlight
            if IsDragOver and not DragDisableHighlight then
            begin
              TvgCanvas(Canvas).SetMatrix(AbsoluteMatrix);
              TvgCanvas(Canvas).Stroke.Style := vgBrushSolid;
              TvgCanvas(Canvas).Stroke.SolidColor := $B2005ACC;
              TvgCanvas(Canvas).StrokeCap := vgCapFlat;
              TvgCanvas(Canvas).StrokeJoin := vgJoinMiter;
              TvgCanvas(Canvas).StrokeDash := vgDashSolid;
              TvgCanvas(Canvas).StrokeThickness := 3;
              R := vgRect(0, 0, Width, Height);
              vgInflateRect(R, -1, -1);
              TvgCanvas(Canvas).DrawRect(R, 1, 1, AllCorners, 1);
              TvgCanvas(Canvas).StrokeDash := vgDashSolid;
            end;
            if State <> InvalideCanvasState then
            begin
              TvgCanvas(Canvas).RestoreCanvas(State);
            end;
          end;
          if HasAfterPaintEffect then
          begin
            TvgCanvas(Canvas).SetMatrix(AbsoluteMatrix);
            ApplyEffect;
          end;
          {$IFDEF BOUNDS}
          State3 := TvgCanvas(Canvas).SaveCanvas;
          TvgCanvas(Canvas).ResetClipRect;
          TvgCanvas(Canvas).SetMatrix(IdentityMatrix);
          TvgCanvas(Canvas).Stroke.Style := vgBrushSolid;
          TvgCanvas(Canvas).Stroke.Color := '#FF00FF00';
          TvgCanvas(Canvas).StrokeThickness := 1;
          R := AbsoluteRect;
          TvgCanvas(Canvas).DrawRect(R, 0, 0, Allcorners, 0.5);
          TvgCanvas(Canvas).RestoreCanvas(State3);
          {$ENDIF}
        end;
  end;
  {$IFDEF DRAWFOCUSED}
  if Canfocused and IsFocused then
  begin
    State3 := TvgCanvas(Canvas).SaveCanvas;
    TvgCanvas(Canvas).ResetClipRect;
    TvgCanvas(Canvas).SetMatrix(AbsoluteMatrix);
    R := localRect;
    TvgCanvas(Canvas).Stroke.Style := vgBrushsolid;
    TvgCanvas(Canvas).Stroke.Color := vcRed;
    TvgCanvas(Canvas).StrokeThickness := 1;
    TvgCanvas(Canvas).DrawRect(R, 1, 1, Allcorners, AbsoluteOpacity);
    TvgCanvas(Canvas).RestoreCanvas(State3);
  end;
  {$ENDIF}
end;

function TvgVisualObject.CheckParentVisible: boolean;
var
  P: TvgObject;
begin
  P := Self;
  Result := false;
  while P <> nil do
  begin
    if P.IsVisual and not TvgVisualObject(P).Visible then Exit;
    P := P.Parent;
  end;
  Result := true;
end;

procedure TvgVisualObject.InvalidateRect(ARect: TvgRect);
begin
  if not Visible {$IfDef vgDesign}and
     (FScene <> nil)
     and (not FScene.GetDesignTime){$EndIf vgDesign} then
   Exit;
  if FScene = nil then Exit;
  {$IfDef vgDesign}
  if (((Scene <> nil) and (Scene.GetDesignTime))) and FDesignHide then
   Exit;
  {$EndIf vgDesign}
  if FScene.GetDisableUpdate then Exit;
  if not InSceneDesign and not CheckParentVisible then
   Exit;
  ARect.TopLeft := LocalToAbsolute(ARect.TopLeft);
  ARect.BottomRight := LocalToAbsolute(ARect.BottomRight);
  FScene.AddUpdateRect(ARect);
end;

procedure TvgVisualObject.Repaint;
begin
  if not Visible {$IfDef vgDesign}and
     (FScene <> nil) and
     (not FScene.GetDesignTime){$EndIf vgDesign} then
   Exit;
  if FScene = nil then Exit;
  {$IfDef vgDesign}
  if (((Scene <> nil) and (Scene.GetDesignTime))) and FDesignHide then
   Exit;
  {$EndIf vgDesign}
  if FScene.GetDisableUpdate then Exit;
  if not InSceneDesign and not CheckParentVisible then
   Exit;
  if FUpdating > 0 then Exit;
  if HasDisablePaintEffect then
    FUpdateEffects := true;
  FScene.AddUpdateRect(UpdateRect);
end;


procedure TvgVisualObject.Lock;
var
  i: integer;
begin
  Locked := true;
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
      if TvgObject(FChildren[i]).isVisual then
        TvgVisualObject(FChildren[i]).Lock;
end;

{ bounds }

function TvgVisualObject.GetLocalRect: TvgRect;
begin
  Result := vgRect(0, 0, FWidth, FHeight);
end;

function TvgVisualObject.GetAbsoluteRect: TvgRect;
begin
  Result := vgNormalizeRect([LocalToAbsolute(vgPoint(0, 0)), LocalToAbsolute(vgPoint(Width, 0)),
    LocalToAbsolute(vgPoint(Width, Height)), LocalToAbsolute(vgPoint(0, Height))]);
end;

function TvgVisualObject.GetClipRect: TvgRect;
begin
  Result := vgRect(0, 0, Width, Height);
end;

function TvgVisualObject.GetBoundsRect: TvgRect;
begin
  Result := vgRect(0, 0, Width, Height);
end;

function TvgVisualObject.GetParentedRect: TvgRect;
begin
  Result := vgRect(0, 0, Width, Height);
  vgOffsetRect(Result, Position.X, Position.Y);
end;

procedure TvgVisualObject.SetBoundsRect(const Value: TvgRect);
var
  P: TvgPoint;
begin
  Repaint;
  FWidth := Value.Right - Value.Left;
  FHeight := Value.Bottom - Value.Top;
  P := LocalToAbsolute(vgPoint(Value.Left + FRotateCenter.X * FWidth, Value.Top + FRotateCenter.Y * FHeight));
  if (Parent <> nil) and (Parent.isVisual) then
    P := TvgVisualObject(Parent).AbsoluteToLocal(P);
  TvgHackPosition(FPosition).FX := P.X - FScale.X * FRotateCenter.X * FWidth;
  TvgHackPosition(FPosition).FY := P.Y - FScale.Y * FRotateCenter.Y * FHeight;
  if (FWidth < 0) then
  begin
    FWidth := Abs(FWidth);
    FScale.X := -FScale.X;
  end;
  if (FHeight < 0) then
  begin
    FHeight := Abs(FHeight);
    FScale.Y := -FScale.Y;
  end;
  MatrixChanged(Self);
  Realign;
end;

{ }

procedure TvgVisualObject.PaddingChanged(Sender: TObject);
begin
  if (FParent <> nil) and (FParent.isVisual) then
    TvgVisualObject(FParent).Realign;
end;

procedure TvgVisualObject.MarginsChanged(Sender: TObject);
begin
  Realign;
end;

{$IfDef vgDesign}
procedure TvgVisualObject.DesignInsert;
begin

end;

procedure TvgVisualObject.DesignSelect;
begin

end;

procedure TvgVisualObject.DesignClick;
begin

end;
{$EndIf vgDesign}

type
  TvgAlignInfo = record
    AlignList: TvgObjectList;
    ControlIndex: Integer;
    Align: TvgAlign;
    Scratch: Integer;
  end;

procedure TvgVisualObject.BeginUpdate;
var
  i: integer;
begin
  Inc(FUpdating);
  for i := 0 to ChildrenCount - 1 do
    if TvgObject(FChildren[i]).IsVisual then
      TvgVisualObject(FChildren[i]).BeginUpdate;
end;

procedure TvgVisualObject.EndUpdate;
var
  i: integer;
begin
  Dec(FUpdating);
  for i := 0 to ChildrenCount - 1 do
    if TvgObject(FChildren[i]).IsVisual then
      TvgVisualObject(FChildren[i]).EndUpdate;
  if (FUpdating = 0) then
    Realign;
end;

procedure TvgVisualObject.RecalcNeedAlign;
var
  i: integer;
begin
  FNeedAlign := false;
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
    begin
      if not (TvgObject(FChildren[i]).IsVisual) then Continue;
      if TvgVisualObject(FChildren[i]).Align <> vaNone then
      begin
        FNeedAlign := true;
        Break;
      end;
    end;
end;

procedure TvgVisualObject.Realign;
var
  R: TvgRect;
  AlignList: TvgObjectList;

  function InsertBefore(C1, C2: TvgVisualObject; AAlign: TvgAlign): Boolean;
  begin
    Result := False;
    case AAlign of
      vaTop, vaMostTop: Result := C1.Position.Y < C2.Position.Y;
      vaBottom, vaMostBottom: Result := (C1.Position.Y + C1.Height) >= (C2.Position.Y + C2.Height);
      vaLeft, vaMostLeft: Result := C1.Position.X < C2.Position.X;
      vaRight, vaMostRight: Result := (C1.Position.X + C1.Width) >= (C2.Position.X + C2.Width);
    end;
  end;

  procedure DoPosition(Control: TvgVisualObject; AAlign: TvgAlign; AlignInfo: TvgAlignInfo);
  var
    NewLeft, NewTop, NewWidth, NewHeight: single;
    cR, mR: TvgRect;
    fitScale: single;
  begin
    with R do
    begin
      NewWidth := Right - Left;
      if (NewWidth < 0) or (AAlign in [vaLeft, vaRight, vaVertical, vaMostLeft, vaMostRight, vaTopLeft, vaTopRight, vaBottomLeft, vaBottomRight]) then
        NewWidth := Control.Width + Control.Padding.Left + Control.Padding.Right;
      NewHeight := Bottom - Top;
      if (NewHeight < 0) or (AAlign in [vaTop, vaBottom, vaMostTop, vaMostBottom, vaHorizontal, vaTopLeft, vaTopRight, vaBottomLeft, vaBottomRight]) then
        NewHeight := Control.Height + Control.Padding.Top + Control.Padding.Bottom;
      NewLeft := Left;
      NewTop := Top;
      if (AAlign in [vaVertical]) then
        NewLeft := Control.Position.X + Control.Padding.Left;
      if (AAlign in [vaHorizontal]) then
        NewTop := Control.Position.Y + Control.Padding.Top;
      case AAlign of
        vaTop, vaMostTop:
          Top := Top + NewHeight;
        vaBottom, vaMostBottom:
          begin
            Bottom := Bottom - NewHeight;
            NewTop := Bottom;
          end;
        vaLeft, vaMostLeft:
          Left := Left + NewWidth;
        vaRight, vaMostRight:
          begin
            Right := Right - NewWidth;
            NewLeft := Right;
          end;
        vaContents:
          begin
            NewLeft := 0;
            NewTop := 0;
            NewWidth := Width;
            NewHeight := Height;
            TvgHackPosition(Control.FPosition).FX := NewLeft + Control.Padding.Left;
            TvgHackPosition(Control.FPosition).FY := NewTop + Control.Padding.Top;
            Control.FWidth := NewWidth - Control.Padding.Left - Control.Padding.Right;
            Control.FHeight := NewHeight - Control.Padding.Top - Control.Padding.Bottom;
            Control.MatrixChanged(Self);
            Control.Realign;
            Exit;
          end;
        vaFit, vaFitLeft, vaFitRight:
          begin
            mR := vgRect(Margins.Left, Margins.Top, Width - Margins.Right, Height - Margins.Bottom);
            cR := vgRect(TvgHackPosition(Control.FPosition).FX - Control.Padding.Left, TvgHackPosition(Control.FPosition).FY - Control.Padding.Top,
              TvgHackPosition(Control.FPosition).FX + Control.FWidth + Control.Padding.Right,
              TvgHackPosition(Control.FPosition).FY + Control.FHeight + Control.Padding.Bottom);
            fitScale := vgFitRect(cR, mR);
            if fitScale < 1 then
            begin
              cR.Left := cR.Left / fitScale;
              cR.Right := cR.Right / fitScale;
              cR.Top := cR.Top / fitScale;
              cR.Bottom := cR.Bottom / fitScale;
              vgRectCenter(cR, mR);
              if AAlign = vaFitLeft then
                vgOffsetRect(cR, mR.Left - cR.Left, 0);
              if AAlign = vaFitRight then
                vgOffsetRect(cR, mR.Right - cR.Right, 0);
              NewLeft := cR.Left;
              NewTop := cR.Top;
              NewWidth := cR.Right - cR.Left;
              NewHeight := cR.Bottom - cR.Top;
            end
            else
            begin
              if AAlign = vaFitLeft then
                vgOffsetRect(cR, mR.Left - cR.Left, 0);
              if AAlign = vaFitRight then
                vgOffsetRect(cR, mR.Right - cR.Right, 0);
              NewLeft := cR.Left;
              NewTop := cR.Top;
              NewWidth := cR.Right - cR.Left;
              NewHeight := cR.Bottom - cR.Top;
            end;
            TvgHackPosition(Control.FPosition).FX := NewLeft + Control.Padding.Left;
            TvgHackPosition(Control.FPosition).FY := NewTop + Control.Padding.Top;
            Control.FWidth := NewWidth - Control.Padding.Left - Control.Padding.Right;
            Control.FHeight := NewHeight - Control.Padding.Top - Control.Padding.Bottom;
            Control.MatrixChanged(Self);
            Control.Realign;
            Exit;
          end;
        vaCenter:
          begin
            NewLeft := Left + Trunc((NewWidth - (Control.Width + Control.Padding.Left + Control.Padding.Right)) / 2);
            NewWidth := (Control.Width + Control.Padding.Left + Control.Padding.Right);
            NewTop := Top + Trunc((NewHeight - (Control.Height + Control.Padding.Top + Control.Padding.Bottom)) / 2);
            NewHeight := (Control.Height + Control.Padding.Top + Control.Padding.Bottom);
          end;
        vaHorzCenter:
          begin
            NewLeft := Left + Trunc((NewWidth - (Control.Width + Control.Padding.Left + Control.Padding.Right)) / 2);
            NewWidth := (Control.Width + Control.Padding.Left + Control.Padding.Right);
          end;
        vaVertCenter:
          begin
            NewTop := Top + Trunc((NewHeight - (Control.Height + Control.Padding.Top + Control.Padding.Bottom)) / 2);
            NewHeight := (Control.Height + Control.Padding.Top + Control.Padding.Bottom);
          end;
        vaTopRight:
          begin
            Control.Position.X := Control.Position.X + (FWidth - FLastWidth);
            Exit;
          end;
        vaBottomLeft:
          begin
            Control.Position.Y := Control.FPosition.Y + (FHeight - FLastHeight);
            Exit;
          end;
        vaBottomRight:
          begin
            TvgHackPosition(Control.Position).SetPoint(vgPoint(Control.Position.X + (FWidth - FLastWidth), Control.FPosition.Y + (FHeight - FLastHeight)));
            Exit;
          end;
      end;
    end;

    if (AALign = vaScale) then
    begin
      if (FLastWidth > 0) and (FLastHeight > 0) and (FWidth > 0) and (FHeight > 0) then
      begin
        TvgHackPosition(Control.FPosition).FX := Control.FPosition.X * (FWidth / FLastWidth);
        TvgHackPosition(Control.FPosition).FY := Control.FPosition.Y * (FHeight / FLastHeight);
        Control.FWidth := Control.FWidth * (FWidth / FLastWidth);
        Control.FHeight := Control.FHeight * (FHeight / FLastHeight);
        Control.MatrixChanged(Self);
        Control.Realign;
      end;
      Exit;
    end
    else
    begin
      TvgHackPosition(Control.FPosition).FX := NewLeft + Control.Padding.Left;
      TvgHackPosition(Control.FPosition).FY := NewTop + Control.Padding.Top;
      if (Control.FWidth <> NewWidth - Control.Padding.Left - Control.Padding.Right) or
         (Control.FHeight <> NewHeight - Control.Padding.Top - Control.Padding.Bottom) then
      begin
        Control.FWidth := NewWidth - Control.Padding.Left - Control.Padding.Right;
        Control.FHeight := NewHeight - Control.Padding.Top - Control.Padding.Bottom;
        Control.Realign;
      end;
      Control.MatrixChanged(Self);
    end;

    { Adjust client rect if control didn't resize as we expected }
    if (Control.Width + Control.Padding.Left + Control.Padding.Right <> NewWidth) or
       (Control.Height + Control.Padding.Top + Control.Padding.Bottom <> NewHeight) then
      with R do
        case AAlign of
          vaTop:
            Top := Top - (NewHeight - (Control.Height + Control.Padding.Left + Control.Padding.Right));
          vaBottom:
            Bottom := Bottom + (NewHeight - (Control.Height + Control.Padding.Top + Control.Padding.Bottom));
          vaLeft:
            Left := Left - (NewWidth - (Control.Width + Control.Padding.Left + Control.Padding.Right));
          vaRight:
            Right := Right + (NewWidth - (Control.Width + Control.Padding.Top + Control.Padding.Bottom));
          vaClient:
            begin
              Right := Right + NewWidth - (Control.Width + Control.Padding.Left + Control.Padding.Right);
              Bottom := Bottom + NewHeight - (Control.Height + Control.Padding.Top + Control.Padding.Bottom);
            end;
        end;
  end;

  procedure DoAlign(AAlign: TvgAlign);
  var
    I, J: Integer;
    Control: TvgVisualObject;
    AlignInfo: TvgAlignInfo;
  begin
    AlignList.Clear;
    for I := 0 to FChildren.Count - 1 do
    begin
      if not TvgObject(FChildren[i]).isVisual then Continue;
      Control := TvgVisualObject(FChildren[i]);
      if (Control.Align = AAlign) and (Control.Visible) then
      begin
        J := 0;
        while (J < AlignList.Count) and not InsertBefore(Control, TvgVisualObject(AlignList[J]), AAlign) do Inc(J);
        AlignList.Insert(J, Control);
      end;
    end;
    for I := 0 to AlignList.Count - 1 do
    begin
      AlignInfo.AlignList := AlignList;
      AlignInfo.ControlIndex := I;
      AlignInfo.Align := AAlign;
      DoPosition(TvgVisualObject(AlignList[I]), AAlign, AlignInfo);
    end;
  end;

begin
  if csDestroying in ComponentState then Exit;
  if ((FWidth > -2) and (FWidth < 2)) or ((FHeight > -2) and (FHeight < 2)) then Exit;
  if FDisableDefaultAlign then Exit;
  if FDisableAlign then Exit;
  if FUpdating > 0 then Exit;
  if csLoading in ComponentState then
  begin
    FLastWidth := FWidth;
    FLastHeight := FHeight;
    Exit;
  end;
  if ((FLastWidth <> FWidth) or (FLastHeight <> FHeight)) and FHasEffect then
  begin
    UpdateEffects;
  end;
  if not FNeedAlign then Exit;
  if FChildren = nil then Exit;
  if FChildren.Count = 0 then Exit;

  if Assigned(f_OnRealign) then
   f_OnRealign(Self);

  FDisableAlign := true;
  try
    R := vgRect(0, 0, FWidth, FHeight);
    R := FMargins.MarginRect(R);
    AlignList := TvgObjectList.Create;
    try
      DoAlign(vaMostTop);
      DoAlign(vaMostBottom);
      DoAlign(vaMostLeft);
      DoAlign(vaMostRight);
      DoAlign(vaTop);
      DoAlign(vaBottom);
      DoAlign(vaLeft);
      DoAlign(vaRight);
      DoAlign(vaClient);
      DoAlign(vaHorizontal);
      DoAlign(vaVertical);
      DoAlign(vaContents);
      DoAlign(vaCenter);
      DoAlign(vaHorzCenter);
      DoAlign(vaVertCenter);
      DoAlign(vaScale);
      DoAlign(vaFit);
      DoAlign(vaFitLeft);
      DoAlign(vaFitRight);
      // Move anchored controls
      // DoAlign(vaTopLeft); nothing to move
      DoAlign(vaTopRight);
      DoAlign(vaBottomLeft);
      DoAlign(vaBottomRight);
    finally
      FreeAndNil(AlignList);
    end;
    FLastWidth := FWidth;
    FLastHeight := FHeight;
    Repaint;
  finally
    FDisableAlign := false;
  end;
end;

{ events }

procedure TvgVisualObject.KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
var
  VP: TvgPoint;
begin
  if (Key = VK_APPS) then
  begin
    VP := LocalToAbsolute(vgPoint(Width / 2, Height / 2));
    VP := Scene.LocalToScreen(VP);
    ContextMenu(VP);
  end
  else
    if Assigned(FOnKeyDown) then
      FOnKeyDown(Self, Key, KeyChar, Shift);
end;

procedure TvgVisualObject.KeyUp(var Key: Word; var KeyChar: System.WideChar;
  Shift: TShiftState);
begin
  if Assigned(FOnKeyUp) then
    FOnKeyUp(Self, Key, KeyChar, Shift);
end;

procedure TvgVisualObject.DialogKey(var Key: Word; Shift: TShiftState);
var
  i: integer;
begin
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
      if TvgObject(FChildren[i]).isVisual and (TvgVisualObject(FChildren[i]).Visible) and TvgVisualObject(FChildren[i]).Enabled then
      begin
        TvgVisualObject(FChildren[i]).DialogKey(Key, Shift);
        if Key = 0 then Break;
      end;
end;

procedure TvgVisualObject.Capture;
begin
  if (FScene <> nil) then
  begin
    FScene.SetCaptured(Self);
  end;
end;

procedure TvgVisualObject.ReleaseCapture;
begin
  if (FScene <> nil) and (FScene.GetCaptured = Self) then
  begin
    FScene.SetCaptured(nil);
  end;
end;

procedure TvgVisualObject.MouseEnter;
begin
  FIsMouseOver := true;
  StartTriggerAnimation(Self, 'IsMouseOver');
  ApplyTriggerEffect(Self, 'IsMouseOver');
  if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
end;

procedure TvgVisualObject.MouseLeave;
begin
  FIsMouseOver := false;
  StartTriggerAnimation(Self, 'IsMouseOver');
  ApplyTriggerEffect(Self, 'IsMouseOver');
  if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

function TvgVisualObject.EnterFocusChildren(AObject: TvgVisualObject): boolean;
begin
  Result := false;
end;

procedure TvgVisualObject.EnterFocus;
var
  P: TvgObject;
begin
  if not CanFocused then Exit;

  P := Parent;
  while P <> nil do
  begin
    if P.IsVisual then
      if TvgVisualObject(P.Visual).EnterFocusChildren(Self) then Break;
    P := P.Parent;
  end;
  FIsFocused := true;
  FNeedRecalcUpdateRect := true;
  Repaint;
  if Assigned(FOnEnterFocus) then FOnEnterFocus(Self);
  if DisableFocusEffect then Exit;
  if GlobalDisableFocusEffect then Exit;
  StartTriggerAnimation(Self, 'IsFocused');
  ApplyTriggerEffect(Self, 'IsFocused');
end;

procedure TvgVisualObject.SetNewScene(AScene: IvgScene);
begin
  if (AScene = nil) and (FIsFocused) then
    KillFocus;
  inherited;
end;

procedure TvgVisualObject.SetPosition(const aValue : TvgPosition);
begin
 fPosition.Assign(aValue);
end;

procedure TvgVisualObject.KillFocus;
begin
  if not CanFocused then Exit;

  FNeedRecalcUpdateRect := true;
  Repaint;
  FIsFocused := false;
  if Assigned(FOnKillFocus) then FOnKillFocus(Self);
  if DisableFocusEffect then Exit;
  if GlobalDisableFocusEffect then Exit;
  StartTriggerAnimation(Self, 'IsFocused');
  ApplyTriggerEffect(Self, 'IsFocused');
end;

procedure TvgVisualObject.SetFocus;
var
  C: boolean;
begin
  if not CanFocused then Exit;
  if Assigned(FOnCanFocused) then
  begin
    C := true;
    FOnCanFocused(Self, C);
    if not C then Exit;
  end;
  FScene.SetFocused(Self);
end;

procedure TvgVisualObject.ContextMenu(const ScreenPosition: TvgPoint);
begin
  {$IFNDEF NOVCL}
  if FPopupMenu <> nil then
  begin
    FPopupMenu.PopupComponent := Self;
    FPopupMenu.Popup(round(ScreenPosition.X), round(ScreenPosition.Y));
    Exit;
  end;
  {$ENDIF}
  if FPopup <> nil then
  begin
    TvgPopup(FPopup).StaysOpen := false;
    TvgPopup(FPopup).PopupModal;
  end;
end;

procedure TvgVisualObject.Click;
begin
  if Assigned(FOnClick) then
    FOnClick(Self);
end;

procedure TvgVisualObject.DblClick;
begin
  if Assigned(FOnDblClick) then
    FOnDblClick(Self);
end;

function TvgVisualObject.MakeScreenshot: TvgBitmap;
begin
  Result := TvgBitmap.Create(round(Width), round(Height));
  Result.Clear(0);

  TvgCanvas(Result.Canvas).BeginScene;
  try
   PaintTo(TvgCanvas(Result.Canvas), vgRect(0, 0, Result.Width, Result.Height));
  finally
   TvgCanvas(Result.Canvas).EndScene;
  end;//try..finally 
end;

procedure TvgVisualObject.BeginAutoDrag;
var
  B, S: TvgBitmap;
  R: TvgRect;
begin
  S := MakeScreenshot;
  try
   B := nil;
   try
    if (S.Width > 512) or (S.Height > 512) then
    begin
      R := vgRect(0, 0, S.Width, S.Height);
      vgFitRect(R, vgRect(0, 0, 512, 512));
      B := TvgBitmap.Create(round(vgRectWidth(R)), round(vgRectHeight(R)));
      TvgCanvas(B.Canvas).BeginScene;
      try
       TvgCanvas(B.Canvas).DrawBitmap(S, vgRect(0, 0, S.Width, S.Height), vgRect(0, 0, B.Width, B.Height), 0.7, true);
      finally
       TvgCanvas(B.Canvas).EndScene;
      end;//try..finally
    end//(S.Width > 512) or (S.Height > 512)
    else
    begin
      B := TvgBitmap.Create(S.Width, S.Height);
      TvgCanvas(B.Canvas).BeginScene;
      try
       TvgCanvas(B.Canvas).DrawBitmap(S, vgRect(0, 0, B.width, B.Height), vgRect(0, 0, B.width, B.Height), 0.7, true);
      finally
      TvgCanvas(B.Canvas).EndScene;
      end;//try..finally
    end;//(S.Width > 512) or (S.Height > 512)
    FScene.BeginVCLDrag(Self, B);
   finally
    FreeAndNil(B);
   end;//try..finally
  finally
   FreeAndNil(S);
  end;//try..finally
end;

procedure TvgVisualObject.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: single);
//var
//  VP: TvgPoint;
begin
  {$IfDef vgDesign}
  if (ssDouble in Shift) and (((FScene <> nil) and (FScene.GetDesignTime))) then
    FScene.SetDesignRoot(Self);
  {$EndIf vgDesign}  
  if (Assigned(FScene) {$IfDef vgDesign}and
      not (FScene.GetDesignTime){$EndIf vgDesign}) and
     CanFocused and
     not FIsFocused and
     (FScene <> nil) and (FScene.GetFocused <> Self) then
    SetFocus;
  if Assigned(FOnMouseDown) then
    FOnMouseDown(Self, Button, Shift, X, Y);
//  if (Button = mbRight) then
//  begin
//    VP := LocalToAbsolute(vgPoint(X, Y));
//    VP := Scene.LocalToScreen(VP);
//    ContextMenu(VP);
//    Exit;
//  end;
  if FAutoCapture then
    Capture;
  if (ssDouble in Shift) then
  begin
    DblClick;
    FDoubleClick := true;
  end
  else
  if Button = mbLeft then
  begin
    FPressed := true;
  end;
end;

procedure TvgVisualObject.MouseMove(Shift: TShiftState; X, Y, Dx, Dy: single);
begin
  if Assigned(FOnMouseMove) then
    FOnMouseMove(Self, Shift, X, Y, Dx, Dy);
end;

procedure TvgVisualObject.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: single);
var
  VP: TvgPoint;
begin
  ReleaseCapture;
  if Assigned(FOnMouseUp) then
    FOnMouseUp(Self, Button, Shift, X, Y);
  if (Button = mbRight) then
  begin
    VP := LocalToAbsolute(vgPoint(X, Y));
    VP := Scene.LocalToScreen(VP);
    ContextMenu(VP);
    Exit;
  end;
  if FPressed and not (FDoubleClick) and vgPtInRect(vgPoint(X, Y), LocalRect) then
  begin
    FPressed := false;
    Click;
  end;
  FPressed := false;
  FDoubleClick := false;
end;

procedure TvgVisualObject.MouseWheel(Shift: TShiftState; WheelDelta: integer; var Handled: boolean);
begin
  if Assigned(FOnMouseWheel) then
    if FScene <> nil then
      FOnMouseWheel(Self, Shift, WheelDelta, FScene.GetMousePos, Handled)
    else
      FOnMouseWheel(Self, Shift, WheelDelta, vgPoint(0, 0), Handled);
end;

procedure TvgVisualObject.DragEnter(const Data: TvgDragObject; const Point: TvgPoint);
begin
  FIsDragOver := true;
  Repaint;
  StartTriggerAnimation(Self, 'IsDragOver');
  ApplyTriggerEffect(Self, 'IsDragOver');
  if Assigned(OnDragEnter) then
    OnDragEnter(Self, Data, Point);
end;

procedure TvgVisualObject.DragLeave;
begin
  FIsDragOver := false;
  Repaint;
  StartTriggerAnimation(Self, 'IsDragOver');
  ApplyTriggerEffect(Self, 'IsDragOver');
  if Assigned(OnDragLeave) then
    OnDragLeave(Self);
end;

procedure TvgVisualObject.DragOver(const Data: TvgDragObject; const Point: TvgPoint; var Accept: Boolean);
begin
  if Assigned(OnDragOver) then
    OnDragOver(Self, Data, Point, Accept);
end;

procedure TvgVisualObject.DragDrop(const Data: TvgDragObject; const Point: TvgPoint);
begin
  FIsDragOver := false;
  Repaint;
  StartTriggerAnimation(Self, 'IsDragOver');
  ApplyTriggerEffect(Self, 'IsDragOver');
  if Assigned(OnDragDrop) then
    OnDragDrop(Self, Data, Point);
end;

procedure TvgVisualObject.DragEnd;
begin
  // Call mouse up - for effects - inside control
  if DragMode = vgDragAutomatic then
    MouseUp(mbLeft, [ssLeft], $FFFF, $FFFF);
  if Assigned(OnDragEnd) then
    OnDragEnd(Self);
end;

{ controls }

procedure TvgVisualObject.SetEnabled(const Value: boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    NeedRecalcEnabled;
    NeedRecalcOpacity;
    Repaint;
  end;
end;

function TvgVisualObject.GetAbsoluteEnabled: boolean;
begin
  if FNeedRecalcEnabled then
  begin
    if (FParent <> nil) and
       (FParent.IsVisual) and
       (not TvgVisualObject(FParent.Visual).AbsoluteEnabled) then
      FAbsoluteEnabled := false
    else
      FAbsoluteEnabled := FEnabled;

    Result := FAbsoluteEnabled;
    FNeedRecalcEnabled := false;

    if not Result and Assigned(FScene) and CanFocused and IsFocused then
      FScene.SetFocused(nil);
  end
  else
  begin
    Result := FAbsoluteEnabled;
  end;
end;

procedure TvgVisualObject.NeedRecalcEnabled;
var
  i: integer;
begin
  FNeedRecalcEnabled := true;
  if FChildren <> nil then
    for i := 0 to FChildren.Count - 1 do
      if TvgObject(FChildren[i]).IsVisual then
        TvgVisualObject(FChildren[i]).NeedRecalcEnabled;
end;

{ properties }

procedure TvgVisualObject.SetTempCanvas(const Value: TvgCustomCanvas);
var
  i: integer;
begin
  FTempCanvas := Value;
  if (FChildren <> nil) and (FChildren.Count > 0) then
    for i := 0 to FChildren.Count - 1 do
      if TvgObject(FChildren[i]).IsVisual then
        TvgVisualObject(FChildren[i]).TempCanvas := Value;
end;

procedure TvgVisualObject.SetHitTest(const Value: boolean);
begin
  FHitTest := Value;
end;

procedure TvgVisualObject.SetClipChildren(const Value: boolean);
begin
  if FClipChildren <> Value then
  begin
    FClipChildren := Value;
    Repaint;
  end;
end;

procedure TvgVisualObject.SetAlign(const Value: TvgAlign);
begin
  if FAlign <> Value then
  begin
    FAlign := Value;
    if (FParent <> nil) and (FParent.IsVisual) then
    begin
      TvgVisualObject(FParent.Visual).FNeedAlign := true;
      if not (csLoading in ComponentState) then
        TvgVisualObject(FParent.Visual).Realign;
    end;
  end;
end;

procedure TvgVisualObject.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then
  begin
    if FVisible then
    begin
      if FScene <> nil then
        FScene.AddUpdateRect(UpdateRect);
    end;
    FVisible := Value;
    if not (csLoading in ComponentState) then
    begin
      if (Parent <> nil) and (Parent.IsVisual) and (Align <> vaNone) then
        TvgVisualObject(Parent).Realign;
    end;
    if FVisible then
    begin
      NeedRecalcUpdateRect;
      if FScene <> nil then
        FScene.AddUpdateRect(UpdateRect);
      StartTriggerAnimation(Self, 'IsVisible');
    end
    else
      if CanFocused and FIsFocused then
        FScene.SetFocused(nil);
  end;
end;

procedure TvgVisualObject.SetRotateAngle(const Value: single);
begin
  if FRotateAngle <> Value then
  begin
    FRotateAngle := vgNormalizeAngle(Value);
    MatrixChanged(Self);
  end;
end;

procedure TvgVisualObject.SetBounds(X, Y, AWidth, AHeight: single);
var
  SizeChanged: boolean;
begin
  Repaint;
  SizeChanged := false;
  if (FHeight <> AHeight) then
  begin
    FHeight := AHeight;
    {$IfDef vgDesign}
    if (FHeight < 0) and (((FScene <> nil) and (FScene.GetDesignTime))) then
    begin
      FHeight := Abs(FHeight);
      FScale.Y := -FScale.Y;
    end;
    {$EndIf vgDesign}
    SizeChanged := true;
  end;
  if (FWidth <> AWidth) then
  begin
    FWidth := AWidth;
    {$IfDef vgDesign}
    if (FWidth < 0) and (((FScene <> nil) and (FScene.GetDesignTime))) then
    begin
      FWidth := Abs(FWidth);
      FScale.X := -FScale.X;
    end;
    {$EndIf vgDesign}
    SizeChanged := true;
  end;

  if (X <> FPosition.X) or (Y <> FPosition.Y) then
  begin
    TvgHackPosition(FPosition).FX := X;
    TvgHackPosition(FPosition).FY := Y;
    MatrixChanged(Self);
  end;

  if not (csLoading in ComponentState) and (SizeChanged) then
  begin
    if (Parent <> nil) and (Parent.IsVisual) and (Align <> vaNone) then
    begin
      TvgVisualObject(Parent).Realign;
    end;
    if (FChildren <> nil) then
      Realign;
  end;
  if not (csLoading in ComponentState) then
  begin
    NeedRecalcUpdateRect;
    Repaint;
  end;
end;

procedure TvgVisualObject.SetSizeWithoutChange(AWidth, AHeight: single);
begin
  FWidth := AWidth;
  FLastWidth := AWidth;
  FHeight := AHeight;
  FLastHeight := AHeight;
end;

procedure TvgVisualObject.SetHeight(const Value: single);
begin
  if FHeight <> Value then
  begin
    Repaint;
    FHeight := Value;
    {$IfDef vgDesign}
    if (FHeight < 0) and (((FScene <> nil) and (FScene.GetDesignTime))) then
    begin
      FHeight := Abs(FHeight);
      FScale.Y := -FScale.Y;
    end;
    {$EndIf vgDesign}
    if not (csLoading in ComponentState) and (FScene <> nil) then
    begin
      UpdateEffects;
      NeedRecalcUpdateRect;
      if (Parent <> nil) and
         (Parent.IsVisual) and
         ((Align <> vaNone) or (Parent is TvgScrollContent)) then
      begin
        TvgVisualObject(Parent).Realign;
      end;
      if (FChildren <> nil) then
        Realign;
    end;
  end;
end;

procedure TvgVisualObject.SetWidth(const Value: single);
begin
  if FWidth <> Value then
  begin
    Repaint;
    FWidth := Value;
    {$IfDef vgDesign}
    if (FWidth < 0) and (((FScene <> nil) and (FScene.GetDesignTime))) then
    begin
      FWidth := Abs(FWidth);
      FScale.X := -FScale.X;
    end;
    {$EndIf vgDesign}
    if not (csLoading in ComponentState) and (FScene <> nil) then
    begin
      UpdateEffects;
      NeedRecalcUpdateRect;
      if (Parent <> nil) and (Parent.IsVisual) and ((Align <> vaNone) or (Parent is TvgScrollContent)) then
      begin
        TvgVisualObject(Parent).Realign;
      end;
      if (FChildren <> nil) then
        Realign;
    end;
  end;
end;

function TvgVisualObject.isOpacityStored: Boolean;
begin
  Result := FOpacity <> 1;
end;

procedure TvgVisualObject.SetOpacity(const Value: single);
begin
  if FOpacity <> Value then
  begin
    FOpacity := Value;
    if FOpacity < 0 then FOpacity := 0;
    if FOpacity > 1 then FOpacity := 1;
    NeedRecalcOpacity;
    Repaint;
  end;
end;

{$IfDef vgDesign}
procedure TvgVisualObject.UpdateDesignHide(const Value: boolean);
var
  i: integer;
begin
  FDesignHide := Value;
  for i := 0 to ChildrenCount - 1 do
  begin
    if Children[i].IsVisual then
      TvgVisualObject(Children[i].Visual).UpdateDesignHide(Value);
  end;
end;
{$EndIf vgDesign}

{$IfDef vgDesign}
procedure TvgVisualObject.SetDesignHide(const Value: boolean);
begin
  if FDesignHide <> Value then
  begin
    FDesignHide := Value;
    if (FScene <> nil) and FScene.GetDesignTime and (Parent <> nil) then
    begin
      {$IfDef vgDesign}
      if FDesignHide and (Scene.GetSelected = Self) and (vgDesigner <> nil) then
        vgDesigner.SelectObject(Owner, Parent.Visual, []);
      {$EndIf vgDesign}
      TvgVisualObject(Parent.Visual).Repaint;
    end;
  end;
end;
{$EndIf vgDesign}

procedure TvgVisualObject.SetCursor(const Value: TCursor);
begin
  if FCursor <> Value then
  begin
    FCursor := Value;
  end;
end;

procedure TvgVisualObject.FixupTabList;
var
  I, J: Integer;
  List: TvgObjectList;
  Control: TvgObject;
begin
  if not Assigned(Scene) then Exit;
  if FTabList = nil then Exit;
  List := TvgObjectList.Create;
  try
    List.Count := FTabList.Count;
    for i := 0 to FTabList.Count - 1 do
    begin
      Control := FTabList[i];
      Assert(Control.IsVisual);
      j := TvgVisualObject(Control).FTabOrder;
      if (j >= 0) and (j < FTabList.Count) then
       List[j] := Control;
    end;//for i
    for I := 0 to FTabList.Count - 1 do
    begin
      Control := List[I];
      if (Control <> nil) AND Control.IsVisual then
       TvgVisualObject(Control).UpdateTabOrder(I);
    end;//for i
  finally
    FreeAndNil(List);
  end;
end;

procedure TvgVisualObject.GetTabOrderList(List: TvgObjectList; Children: boolean; aCheckCanFocus : Boolean);
var
  i: integer;
  Control: TvgObject;
begin
 if (FTabList <> nil) then
  for I := 0 to FTabList.Count - 1 do
  begin
   Control := FTabList[I];
   if Control.IsVisual then
   begin
    if not aCheckCanFocus OR
       (TvgVisualObject(Control).CheckParentVisible and
        TvgVisualObject(Control).CanFocused and
        TvgVisualObject(Control).AbsoluteEnabled) then
     List.Add(Control);
    if Children then
      TvgVisualObject(Control).GetTabOrderList(List, Children, aCheckCanFocus);
   end;//Control.IsVisual
  end;//for I
end;

function TvgVisualObject.GetTabOrder: TTabOrder;
begin
  if (FParent <> nil) and
     (FParent.IsVisual) and
     (TvgVisualObject(FParent.Visual).FTabList <> nil) then
    Result := TvgVisualObject(FParent).FTabList.IndexOf(Self)
  else
    Result := -1;
end;

procedure TvgVisualObject.UpdateTabOrder(Value: TTabOrder);
var
  CurIndex, Count: Integer;
begin
  CurIndex := GetTabOrder;
  if CurIndex >= 0 then
  begin
    Count := TvgVisualObject(FParent).FTabList.Count;
    if Value < 0 then Value := 0;
    if Value >= Count then Value := Count - 1;
    if Value <> CurIndex then
    begin
      TvgVisualObject(FParent).FTabList.Delete(CurIndex);
      TvgVisualObject(FParent).FTabList.Insert(Value, Self);
    end;
  end;
end;

procedure TvgVisualObject.SetTabOrder(const Value: TTabOrder);
begin
  if csLoading in ComponentState then
    FTabOrder := Value
  else
    UpdateTabOrder(Value);
end;

procedure TvgVisualObject.pm_SetOnClick(Value: TNotifyEvent);
begin
 FOnClick := Value;
end;

{$EndIf  NoVGScene}

end.
