unit vtSizeablePanel;

{ $Id: vtSizeablePanel.pas,v 1.26 2013/01/22 15:51:48 kostitsin Exp $ }

// $Log: vtSizeablePanel.pas,v $
// Revision 1.26  2013/01/22 15:51:48  kostitsin
// [$424399029]
//
// Revision 1.25  2012/09/26 15:51:01  kostitsin
// [$397291765]
//
// Revision 1.24  2012/09/06 10:05:04  gensnet
// http://mdp.garant.ru/pages/viewpage.action?pageId=382410422
//
// Revision 1.23  2012/08/10 13:47:18  kostitsin
// [$382421266]
//
// Revision 1.22  2008/09/04 11:16:18  lulin
// - <K>: 88080895.
//
// Revision 1.21  2008/04/04 16:18:04  lulin
// - теперь у базового вью нельзя получить курсор по точке.
//
// Revision 1.20  2007/04/10 14:39:02  oman
// - fix: Не вызывался метод отрисовки - починил и сменил предка (cq24565)
// - new: Ширину сплитера можно настраивать (cq24565)
//
// Revision 1.19  2007/03/05 07:30:08  oman
// - fix: При подсчете клиентской области не учитывали Bevel;ы (cq24556)
//
// Revision 1.18  2006/09/27 14:02:06  lulin
// - cleanup.
//
// Revision 1.17  2005/10/06 10:51:05  lulin
// - класс панелей переехал в более правильное место.
//
// Revision 1.16  2005/05/30 11:10:04  lulin
// - cleanup.
//
// Revision 1.15  2005/05/30 11:02:19  lulin
// - cleanup.
//
// Revision 1.14  2005/05/30 09:55:58  lulin
// - метки переехали в библиотеку VT.
//

{$Include vtDefine.inc}

interface

uses
  Windows,
  Messages,
  Types,
  Classes,
  Controls,
  ExtCtrls,
  Graphics,

  l3InternalInterfaces,

  vtPanel
  ;

type
 TResizeAreaWidth = 3..MaxInt;
 TvtSizeableSide = (szLeft, szRight, szTop, szBottom);
 TvtSizeableSides = set of TvtSizeableSide;
 TResizeStyle = (rsLine, rsUpdate);

const
 cDefaultResizeAreaWidth = 3;
 cDefaultResizeStyle = rsLine;
 cDefaultSplitterBevel = bvNone;

type
 TvtOnQueryResize = procedure(ALeft, ATop, AWidth, AHeight : Integer;
   var aCanResize : Boolean) of Object;

 TvtCustomSizeablePanel = class(TvtCustomPanel)
 private
  f_Brush: TBrush;
  f_LineDC: HDC;
  f_LineVisible: Boolean;
  f_PrevBrush: HBrush;
  f_ResizeStyle: TResizeStyle;
  f_Resizing: Boolean;
  f_ResizingSide: TvtSizeableSide;
  f_SizeableSides: TvtSizeableSides;
  f_SplitterBevel: TPanelBevel;
  f_LineRect: TRect;
  f_BoundsRect: TRect;
  f_ResizeAreaWidth: TResizeAreaWidth;
  f_OnQueryResize: TvtOnQueryResize;
  f_OuterConstraints: TSizeConstraints;
 private
  procedure pm_SetResizeStyle(const aValue: TResizeStyle);
    {-}
  procedure pm_SetSizeableSides(const aValue: TvtSizeableSides);
    {-}
  procedure pm_SetSplitterBevel(const aValue: TPanelBevel);
    {-}
  procedure pm_SetResizeAreaWidth(const aValue: TResizeAreaWidth);
    {-}
  procedure pm_SetOuterConstraints(const Value: TSizeConstraints);
    {-}
 private
  procedure AllocateLineDC;
    {-}
  procedure ApplyResize(X, Y: Integer);
    {-}
  procedure CalcRealClientRect(var Rect: TRect);
    {-}
  procedure CalcResizeBandRect(Side: TvtSizeableSide; var Rect: TRect);
    {-}
  function DetectSizeableSide(X,Y: Integer; var Side: TvtSizeableSide): Boolean;
    {-}
  procedure DrawLine;
    {-}
  procedure ReleaseLineDC;
    {-}
  procedure UpdateLine(X, Y: Integer);
    {-}
  procedure ConsiderConstrains(Control: TControl; var Delta: Integer);
    {-}
  procedure ConsiderSiblings(var Delta: Integer);
    {-}
  function FindControlOnSide(ASide: TvtSizeableSide): TControl;
    {-}
  procedure DoOuterConstraintsChange(Sender: TObject);
    {-}
 protected
  procedure AdjustClientRect(var Rect: TRect);
   override;
    {-}
  procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
   override;
    {-}
  procedure MouseMove(Shift: TShiftState; X, Y: Integer);
   override;
    {-}
  procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
   override;
    {-}
  procedure Paint(const CN: Il3Canvas);
   override;
    {-}
  procedure CheckOuterConstraints(var aWidth: Integer; aHeight: Integer);
   virtual;
    {-}
  procedure SetBounds(aLeft, aTop, aWidth, aHeight: Integer);
   override;
    {-}
  procedure Cleanup;
   override;
    {-}
 public
  constructor Create(aOwner: TComponent);
   override;
    {-}
 published
  property ResizeStyle: TResizeStyle
      read f_ResizeStyle
     write pm_SetResizeStyle
   default cDefaultResizeStyle;
    {-}
  property ResizeAreaWidth: TResizeAreaWidth
      read f_ResizeAreaWidth
     write pm_SetResizeAreaWidth
   default cDefaultResizeAreaWidth;
    {-}
  property SizeableSides: TvtSizeableSides
      read f_SizeableSides
     write pm_SetSizeableSides;
    {-}
  property OuterConstraints: TSizeConstraints
      read f_OuterConstraints
     write pm_SetOuterConstraints;
    {-}
  property SplitterBevel: TPanelBevel
      read f_SplitterBevel
     write pm_SetSplitterBevel
   default cDefaultSplitterBevel;
    {-}
  property OnQueryResize: TvtOnQueryResize
      read f_OnQueryResize
     write f_OnQueryResize;
    {-}
 end;//TvtCustomSizeablePanel

  TvtSizeablePanel = class(TvtCustomSizeablePanel)
  public
    property DockManager;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property BorderStyle;
    property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FullRepaint;
    property Font;
    property ParentBiDiMode;
    //property DisableAcceptInDockOver;    
    {$IfDef Delphi7}
    property ParentBackground;
    {$EndIf}
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;//TvtSizeablePanel

implementation

uses
  SysUtils,
  
{$IfDef Delphi7}
  Themes,
{$EndIf}
  Dialogs,
  Forms,

  afwFacade
  ;

// start class TvtCustomSizeablePanel

procedure TvtCustomSizeablePanel.AdjustClientRect(var Rect: TRect);
var
 l_BevelSize: Integer;
begin
 if f_SizeableSides = [] then
  inherited
 else
 begin
  CalcRealClientRect(Rect);
  inherited AdjustClientRect(Rect);
 end;
 l_BevelSize := 0;
 if BevelOuter <> bvNone then Inc(l_BevelSize, BevelWidth);
 if BevelInner <> bvNone then Inc(l_BevelSize, BevelWidth);
 InflateRect(Rect, -l_BevelSize, -l_BevelSize);
end;

procedure TvtCustomSizeablePanel.AllocateLineDC;
begin
  f_LineDC := GetDCEx(0{Parent.Handle}, 0, DCX_CACHE or DCX_CLIPSIBLINGS or  DCX_LOCKWINDOWUPDATE);
  if f_Brush = nil then
  begin
    f_Brush := TBrush.Create;
    f_Brush.Bitmap := AllocPatternBitmap(clBlack, clWhite);
  end;
  f_PrevBrush := SelectObject(f_LineDC, f_Brush.Handle);
  // рассчет ограничивающего Rect'a
  // делается через одно место из-за того,
  // что _ClientToParent работает некорректно с тулбарами
  f_BoundsRect := Parent.ClientRect;
  f_BoundsRect.TopLeft := Parent.ClientToScreen(f_BoundsRect.TopLeft);
  f_BoundsRect.BottomRight := Parent.ClientToScreen(f_BoundsRect.BottomRight);
  f_BoundsRect.TopLeft := ScreenToClient(f_BoundsRect.TopLeft);
  f_BoundsRect.BottomRight := ScreenToClient(f_BoundsRect.BottomRight);
end;

procedure TvtCustomSizeablePanel.ApplyResize(X, Y: Integer);
var
 NC: TControl;
 Delta: Integer;

 procedure lp_DoResize(ALeft, ATop, AWidth, AHeight : Integer);
 var
  l_CanResize : Boolean;
 begin
  l_CanResize := True;
  if Assigned(f_OnQueryResize) then
   f_OnQueryResize(ALeft, ATop, AWidth, AHeight, l_CanResize);
  if l_CanResize then
  begin
   SetBounds(ALeft, ATop, AWidth, AHeight);
   if Assigned(Application) then
    afw.ProcessMessages;
  end;
 end;

begin
 Parent.DisableAlign;
 try
  case f_ResizingSide of
   szLeft:
    begin
     Delta := -X;
     ConsiderSiblings(Delta);
     ConsiderConstrains(Self, Delta);
     if Align = alClient then
     begin
      NC := FindControlOnSide(szLeft);
      if NC <> nil then
       NC.Width := NC.Width-Delta;
     end;
     lp_DoResize(Left-Delta, Top, Width+Delta, Height);
    end;
   szRight:
    begin
     Delta := X - Width;
     ConsiderSiblings(Delta);
     ConsiderConstrains(Self, Delta);
     if Align = alClient then
     begin
      NC := FindControlOnSide(szRight);
      if NC <> nil then
       NC.Width := NC.Width-Delta;
     end;
     lp_DoResize(Left, Top, Width + Delta, Height);
    end;
   szTop:
    begin
     Delta := -Y;
     ConsiderSiblings(Delta);
     ConsiderConstrains(Self, Delta);
     if Align = alClient then
     begin
      NC := FindControlOnSide(szTop);
      if NC <> nil then
       NC.Height := NC.Height-Delta;
     end;
     lp_DoResize(Left, Top-Delta, Width, Height+Delta);
    end;
   szBottom:
    begin
     Delta := Y - Height;
     ConsiderSiblings(Delta);
     ConsiderConstrains(Self, Delta);
     if Align = alClient then
     begin
      NC := FindControlOnSide(szBottom);
      if NC <> nil then
       NC.Height := NC.Height-Delta;
     end;
     lp_DoResize(Left, Top, Width, Height + Delta);
    end;
  end; // case
 finally
  Parent.EnableAlign;
 end;
end;

procedure TvtCustomSizeablePanel.CalcRealClientRect(var Rect: TRect);
begin
 Rect := GetClientRect;
 if szLeft in f_SizeableSides then
  Inc(Rect.Left, ResizeAreaWidth);
 if szRight in f_SizeableSides then
  Dec(Rect.Right, ResizeAreaWidth);
 if szTop in f_SizeableSides then
  Inc(Rect.Top, ResizeAreaWidth);
 if szBottom in f_SizeableSides then
  Dec(Rect.Bottom, ResizeAreaWidth);
end;

procedure TvtCustomSizeablePanel.CalcResizeBandRect(Side: TvtSizeableSide; var Rect: TRect);
begin
 Rect := GetClientRect;
 case Side of
  szLeft:
  begin
   Rect.Right := Rect.Left+ResizeAreaWidth;
   if szTop in f_SizeableSides then
    Inc(Rect.Top, ResizeAreaWidth);
   if szBottom in f_SizeableSides then
    Dec(Rect.Bottom, ResizeAreaWidth);
  end;
  szRight:
  begin
   Rect.Left := Rect.Right-ResizeAreaWidth;
   if szTop in f_SizeableSides then
    Inc(Rect.Top, ResizeAreaWidth);
   if szBottom in f_SizeableSides then
    Dec(Rect.Bottom, ResizeAreaWidth);
  end;
  szTop:
  begin
   Rect.Bottom := Rect.Top+ResizeAreaWidth;
   if szLeft in f_SizeableSides then
    Inc(Rect.Left, ResizeAreaWidth);
   if szRight in f_SizeableSides then
    Dec(Rect.Right, ResizeAreaWidth);
  end;
  szBottom:
  begin
   Rect.Top := Rect.Bottom-ResizeAreaWidth;
   if szLeft in f_SizeableSides then
    Inc(Rect.Left, ResizeAreaWidth);
   if szRight in f_SizeableSides then
    Dec(Rect.Right, ResizeAreaWidth);
  end;
 end;
end;

function TvtCustomSizeablePanel.DetectSizeableSide(X,Y: Integer; var Side: TvtSizeableSide): Boolean;
begin
 Result := False;
 if (szLeft in f_SizeableSides) and (X <= ResizeAreaWidth) then
 begin
  Side := szLeft;
  Result := True;
  Exit;
 end;
 if (szRight in f_SizeableSides) and (X >= Width-ResizeAreaWidth) then
 begin
  Side := szRight;
  Result := True;
  Exit;
 end;
 if (szTop in f_SizeableSides) and (Y <= ResizeAreaWidth) then
 begin
  Side := szTop;
  Result := True;
  Exit;
 end;
 if (szBottom in f_SizeableSides) and (Y >= Height-ResizeAreaWidth) then
 begin
  Side := szBottom;
  Result := True;
 end; 
end;

procedure TvtCustomSizeablePanel.DrawLine;
var
 TmpR: TRect;
begin
  f_LineVisible := not f_LineVisible;
  TmpR.TopLeft := ClientToScreen(f_LineRect.TopLeft);
  TmpR.BottomRight := ClientToScreen(f_LineRect.BottomRight);
  with TmpR do
   PatBlt(f_LineDC, Left, Top, Right-Left, Bottom-Top, PATINVERT);
end;

procedure TvtCustomSizeablePanel.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
 Side: TvtSizeableSide;
begin
 if DetectSizeableSide(X,Y,Side) then
 begin
  f_Resizing := True;
  if f_ResizeStyle = rsLine then
  begin
   AllocateLineDC;
   CalcResizeBandRect(Side, f_LineRect);
   afw.ProcessMessages;
   DrawLine;
  end;
  if ResizeStyle <> rsLine then
   Invalidate;
 end
 else
  inherited;
end;

procedure TvtCustomSizeablePanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
 Side: TvtSizeableSide;
begin
  if f_Resizing then
  begin
   case f_ResizeStyle of
    rsLine: UpdateLine(X,Y);
    rsUpdate: ApplyResize(X, Y);
   end; 
  end
  else
   if DetectSizeableSide(X,Y,Side) then
   begin
    f_ResizingSide := Side;
    if Side in [szLeft, szRight] then
     Cursor := crHSplit
    else
     Cursor := crVSplit;
   end
   else
   begin
    Cursor := crDefault;
    inherited;
   end;
end;

procedure TvtCustomSizeablePanel.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
 RY: Integer;
 RX: Integer;
begin
 if f_Resizing then
 begin
  f_Resizing := False;
  if f_ResizeStyle = rsLine then
  begin
   DrawLine;
   case f_ResizingSide of
    szLeft:
     begin
      RX := f_LineRect.Left;
      RY := f_LineRect.Top;
     end;
    szRight:
     begin
      RX := f_LineRect.Right;
      RY := f_LineRect.Top;
     end;
    szTop:
     begin
      RX := f_LineRect.Right;
      RY := f_LineRect.Top;
     end;
    szBottom:
     begin
      RX := f_LineRect.Right;
      RY := f_LineRect.Bottom;
     end;
    else
     begin
      RX := 0;
      RY := 0;
     end;
   end; // case
   ApplyResize(RX, RY);
   ReleaseLineDC;
  end;
  Invalidate;
 end;
 inherited;
end;

procedure TvtCustomSizeablePanel.Paint(const CN: Il3Canvas);
(* procedure AdjustColors(Bevel: TPanelBevel);
 begin
   TopColor := clBtnHighlight;
   if Bevel = bvLowered then TopColor := clBtnShadow;
   BottomColor := clBtnShadow;
   if Bevel = bvLowered then BottomColor := clBtnHighlight;
 end;*)

var
 aSide: TvtSizeableSide;
const
  XorColor = $00FFD8CE;
var
 Rect: TRect;
 TopColor, BottomColor: TColor;

 procedure DrawBand(Side: TvtSizeableSide);
 var
  R: TRect;
 begin
  if (Side in f_SizeableSides) and not (f_Resizing and (Side = f_ResizingSide) and
     (f_ResizeStyle = rsUpdate)) then
  begin
   CalcResizeBandRect(Side, R);
   with CN.Canvas do
   begin
    Pen.Style := psClear;
    Brush.Color := Color;
    Rectangle(R);
    Pen.Style := psSolid;
    if f_SplitterBevel in [bvRaised, bvLowered] then
     Frame3D(CN.Canvas, R, TopColor, BottomColor, 1);
   end;
  end;
 end;

begin
 if f_SizeableSides = [] then
  inherited
 else
 with CN do
 begin
  CalcRealClientRect(Rect);
  if BevelOuter <> bvNone then
  begin
   AdjustColors(BevelOuter, TopColor, BottomColor);
   Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
  end;
  Frame3D(Canvas, Rect, Color, Color, BorderWidth);
  if BevelInner <> bvNone then
  begin
   AdjustColors(BevelInner, TopColor, BottomColor);
   Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
  end;
  with Canvas do
  begin
  {$IfDef Delphi7}
   if not ThemeServices.ThemesEnabled or not ParentBackground then
  {$EndIf}
   begin
    Brush.Color := Color;
    FillRect(Rect);
   end;
   if (f_ResizeStyle = rsUpdate) and f_Resizing then
   begin
    CalcResizeBandRect(f_ResizingSide, Rect);
    Pen.Style := psDot;
    Pen.Mode := pmXor;
    Pen.Color := XorColor;
    Brush.Style := bsClear;
    Rectangle(Rect);
    Pen.Style := psSolid;
    Pen.Mode := pmCopy;
   end;
   AdjustColors(f_SplitterBevel, TopColor, BottomColor);
   for aSide := szLeft to szBottom do
    DrawBand(aSide);
  end;
 end;
end;

procedure TvtCustomSizeablePanel.CheckOuterConstraints(var aWidth: Integer; aHeight: Integer);
begin
 if Assigned(OuterConstraints) and Assigned(Parent) then
  case Align of
   alLeft, alRight:
    if OuterConstraints.MinWidth > 0 then
     if Parent.ClientWidth - aWidth < OuterConstraints.MinWidth then
      aWidth := Parent.ClientWidth - OuterConstraints.MinWidth;
   alTop, alBottom:
    if OuterConstraints.MinHeight > 0 then
     if Parent.ClientHeight - aHeight < OuterConstraints.MinHeight then
      aHeight := Parent.ClientHeight - OuterConstraints.MinHeight;
  end;
end;

procedure TvtCustomSizeablePanel.SetBounds(aLeft, aTop, aWidth, aHeight: Integer);
begin
 CheckOuterConstraints(aWidth, aHeight);
 inherited SetBounds(aLeft, aTop, aWidth, aHeight);
end;

procedure TvtCustomSizeablePanel.Cleanup;
begin
 f_OuterConstraints.Free;
 inherited;
end;

procedure TvtCustomSizeablePanel.ReleaseLineDC;
begin
  if (f_PrevBrush <> 0) then
    SelectObject(f_LineDC, f_PrevBrush);
  ReleaseDC(Parent.Handle, f_LineDC);
  FreeAndNil(f_Brush);
end;

procedure TvtCustomSizeablePanel.pm_SetResizeStyle(const aValue: TResizeStyle);
begin
 f_ResizeStyle := aValue;
end;

procedure TvtCustomSizeablePanel.pm_SetSizeableSides(const aValue: TvtSizeableSides);
begin
 if f_SizeableSides <> aValue then
 begin
  f_SizeableSides := aValue;
  Height := Height+1;
  Height := Height-1;
 end;
end;

procedure TvtCustomSizeablePanel.pm_SetSplitterBevel(const aValue: TPanelBevel);
begin
 if f_SplitterBevel <> aValue then
 begin
  f_SplitterBevel := aValue;
  Invalidate;
 end;
end;

procedure TvtCustomSizeablePanel.UpdateLine(X, Y: Integer);
var
 Delta: Integer;

begin
 DrawLine;
 case f_ResizingSide of
  szLeft, szRight:
   begin
    Delta := X - f_LineRect.Left - ResizeAreaWidth div 2;
    if  (f_ResizingSide = szLeft) and (f_LineRect.Right+Delta > Width) then
     Delta := (Width-ResizeAreaWidth) - f_LineRect.Left;
    if (f_ResizingSide = szRight) and (f_LineRect.Left+Delta < 0) then
     Delta := -f_LineRect.Left;
    with f_LineRect do
    begin
     if (Left+Delta < f_BoundsRect.Left) then
      Delta := f_BoundsRect.Left - Left;
     if (Right+Delta > f_BoundsRect.Right) then
      Delta := f_BoundsRect.Right - Right;
     Left := Left+Delta;
     Right := Right+Delta;
    end;
   end;
  szTop, szBottom:
   begin
    Delta := Y - f_LineRect.Top - ResizeAreaWidth div 2;
    if  (f_ResizingSide = szTop) and (f_LineRect.Bottom+Delta > Height) then
     Delta := (Height-ResizeAreaWidth) - f_LineRect.Top;
    if (f_ResizingSide = szBottom) and (f_LineRect.Top+Delta < 0) then
     Delta := -f_LineRect.Top;
    with f_LineRect do
    begin
     if (Top+Delta < f_BoundsRect.Top) then
      Delta := f_BoundsRect.Top - Top;
     if (Bottom+Delta > f_BoundsRect.Bottom) then
      Delta := f_BoundsRect.Bottom - Bottom;
     Top := Top+Delta;
     Bottom := Bottom+Delta;
    end;
   end;
 end; // case
 DrawLine;
end;

constructor TvtCustomSizeablePanel.Create(aOwner: TComponent);
begin
 inherited;
 f_SplitterBevel := cDefaultSplitterBevel;
 f_ResizeStyle := cDefaultResizeStyle;
 f_Resizing := False;
 f_SizeableSides := [];
 f_ResizeAreaWidth := cDefaultResizeAreaWidth;
 f_OuterConstraints := TSizeConstraints.Create(Self);
 f_OuterConstraints.OnChange := DoOuterConstraintsChange;
end;

procedure TvtCustomSizeablePanel.ConsiderConstrains(Control: TControl; var Delta: Integer);
begin
 with Control do
 begin
  case f_ResizingSide of
   szLeft, szRight:
    begin
     if (Constraints.MinWidth > 0) and (Width + Delta < Constraints.MinWidth) then
      Delta := Constraints.MinWidth - Width;
     if (Constraints.MaxWidth > 0) and (Width + Delta > Constraints.MaxWidth) then
      Delta := Constraints.MaxWidth - Width;
    end;
   szTop, szBottom:
    begin
     if (Constraints.MinHeight > 0) and (Height + Delta < Constraints.MinHeight) then
      Delta := Constraints.MinHeight - Height;
     if (Constraints.MaxHeight > 0) and (Height + Delta > Constraints.MaxHeight) then
      Delta := Constraints.MaxHeight - Height;
    end;
  end; //case
 end;
end;

procedure TvtCustomSizeablePanel.ConsiderSiblings(var Delta: Integer);
var
 NeighbourControl : TControl;
begin
 NeighbourControl := FindControlOnSide(f_ResizingSide);
 if NeighbourControl <> nil then
 begin
  Delta := -Delta;
  ConsiderConstrains(NeighbourControl, Delta);
  Delta := -Delta;
 end;
end;

function TvtCustomSizeablePanel.FindControlOnSide(ASide: TvtSizeableSide): TControl;
var
 R: TRect;
 I: Integer;
begin
 Result := nil;
 if Align = alNone then Exit;
 for I := 0 to Pred(Parent.ControlCount) do
 begin
  Result := Parent.Controls[I];
  if Result.Visible and Result.Enabled and (Result.Align <> alNone) then
  begin
   R := Result.BoundsRect;
   case ASide of
    szLeft  : if Left - R.Right = 0 then Exit;
    szRight : if Left+Width-R.Left = 0 then Exit;
    szTop   : if Top - R.Bottom = 0 then Exit;
    szBottom: if Top+Height - R.Top = 0 then Exit;
   end;
  end;
 end;
 Result := nil;
end;

procedure TvtCustomSizeablePanel.DoOuterConstraintsChange(Sender: TObject);
begin
 SetBounds(Left, Top, Width, Height);
end;

procedure TvtCustomSizeablePanel.pm_SetResizeAreaWidth(const aValue: TResizeAreaWidth);
begin
 if f_ResizeAreaWidth <> aValue then
 begin
  f_ResizeAreaWidth := aValue;
  Invalidate;
 end;
end;

procedure TvtCustomSizeablePanel.pm_SetOuterConstraints(const Value: TSizeConstraints);
begin                                                                               
 Assert((Value.MaxHeight = 0) and (Value.MaxWidth = 0));
 f_OuterConstraints.Assign(Value);
 //SetBounds(Left, Top, Width, Height);
end;

end.