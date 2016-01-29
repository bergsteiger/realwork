{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

(*

Version History

07/06/2003

  BorderColor* properties added. They control the colors of the border, drawn when Flat is true.

03/04/2003

  Added property RightAlignedView

03/11/2003
  Replaced system scrollbars to ElScrollBars

05/09/2002

  Fixed drawing of the scrollbars with XP styles enabled

05/12/2001

  Fixed the problem with the border in XP with themes disabled

03/10/2001

  Removed terrible flicker that happened on repainting

*)

unit ElScrollBox;

interface

uses SysUtils,
     ElVCLUtils,
     ElUxTheme,
     ElTmSchema,
     ElImgFrm,

     Classes,
     StdCtrls,

     Windows,
     Controls,
     Messages,
     Graphics,
     ElStrUtils,
{$ifdef VCL_6_USED}
     Types,
{$endif}
{$ifdef ELPACK_USE_STYLEMANAGER}
     ElStyleMan,
{$ENDIF}
{< ELSCROLLBAR}
     ElSBCtrl,
{> ELSCROLLBAR}
     Forms,
     ElTools;

type

    TElScrollBox = class(TScrollBox)
    private
      FActiveBorderType: TElFlatBorderType;
      FBackground: TBitmap;
      FBorderSides: TElBorderSides;
      FFlat: Boolean;
      FFlatFocusedScrollBars: Boolean;
      FInactiveBorderType: TElFlatBorderType;
      FTheme: HTheme;
      FUseBackground: Boolean;
      FImgForm: TElImageForm;
      FImgFormChLink: TImgFormChangeLink;
      FMouseOver: Boolean;
      FOnMouseEnter: TNotifyEvent;
      FOnMouseLeave: TNotifyEvent;
      FPainting: Boolean;
      FPaintingTo: Boolean;
      FTransparent: Boolean;
      {$IFDEF ELPACK_USE_STYLEMANAGER}
      FStyleMgrLink : TElStyleMgrChangeLink;
      FStyleManager: TElStyleManager;
      FStyleName: string;
      {$endif}
      FRightAlignedView: Boolean;

      {< ELSCROLLBAR}
      fUseCustomScrollBars : Boolean;
      fSBCtrl :TElSBController;

      function GetHorzScrollBar:TElCtrlScrollBarStyles;
      function GetVertScrollBar:TElCtrlScrollBarStyles;
      procedure SetHorzScrollBar(const Value:TElCtrlScrollBarStyles);
      procedure SetVertScrollBar(const Value:TElCtrlScrollBarStyles);
      procedure SetUseCustomScrollBars(const Value:Boolean);
      {> ELSCROLLBAR}

      procedure SetRightAlignedView(Value: Boolean);
      procedure SetActiveBorderType(const Value: TElFlatBorderType);
      procedure SetBackground(const Value: TBitmap);
      procedure SetBorderSides(Value: TElBorderSides);
      procedure SetFlat(const Value: boolean);
      procedure SetFlatFocusedScrollBars(const Value: boolean);
      procedure SetImageForm(newValue : TElImageForm);
      procedure SetInactiveBorderType(const Value: TElFlatBorderType);
      procedure SetUseBackground(const Value: boolean);
      procedure BackgroundChanged(Sender: TObject);
      procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
      procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
      procedure DrawBackground(DC: HDC; R: TRect);
      procedure DrawFlatBorder(DC: HDC);
      procedure DrawParentControl(DC: HDC);
      procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
      procedure WMKillFocus(var Msg: TMessage); message WM_KILLFOCUS;
      procedure WMNCCalcSize(var Message : TWMNCCalcSize); message WM_NCCALCSIZE;
      procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
      procedure WMSetFocus(var Msg: TMessage); message WM_SETFOCUS;
      procedure ImageFormChange(Sender : TObject);
      procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message
          WM_WINDOWPOSCHANGED;
    {$IFDEF MSWINDOWS}
    protected
       FPreventStyleChange :Boolean;
       procedure WMStyleChanging(var Message: TMessage); message WM_STYLECHANGING;
       procedure WMStyleChanged(var Message: TMessage); message WM_STYLECHANGED;
    {$ENDIF}
    protected
      FLineBorderActiveColor: TColor;
      FLineBorderInactiveColor: TColor;
      FUseXPThemes: Boolean;
      {$ifdef ELPACK_UNICODE}
      FHint: TElFString;
      {$endif}
      FTransparentXPThemes: Boolean;
      FBorderColorDkShadow: TColor;
      FBorderColorFace: TColor;
      FBorderColorHighlight: TColor;
      FBorderColorShadow: TColor;
      FBorderColorWindow: TColor;

      procedure SetLineBorderActiveColor(Value: TColor);
      procedure SetLineBorderInactiveColor(Value: TColor);
      procedure SetUseXPThemes(Value: Boolean); virtual;
      procedure CreateThemeHandle; virtual;
      procedure CreateWnd; override;
      procedure DestroyWnd; override;
      procedure FreeThemeHandle; virtual;
      function GetThemedClassName: WideString; virtual;
      function IsThemeApplied: Boolean;
      procedure WMNCPaint(var Msg : TMessage); message WM_NCPAINT;
      procedure ELThemeChanged(var Message: TMessage); message EL_THEMECHANGED;
      procedure WMIsThemedControl(var Message: TMessage); message WM_ISTHEMEDCONTROL;
      procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
      procedure CMMouseWheel(var Msg : TWMMouseWheel); message CM_MOUSEWHEEL;

      procedure DoMouseEnter; virtual;
      procedure DoMouseLeave; virtual;
      procedure DoPaint(DC : HDC); virtual;
      procedure IFMRepaintChildren(var Message: TMessage); message
          IFM_REPAINTCHILDREN;
      procedure CreateParams(var Params: TCreateParams); override;

      {$ifdef ELPACK_USE_STYLEMANAGER}
      procedure SetStyleManager(Value: TElStyleManager); virtual;
      procedure SetStyleName(const Value: string); virtual;
      procedure StyleMgrChange(Sender : TObject);
      procedure UpdateStyle;
      {$endif}

      {$ifdef ELPACK_UNICODE}
      procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
      {$endif}
      procedure DrawThemedBackground(DC : HDC); virtual;
      {$ifdef ELPACK_UNICODE}
      procedure SetHint(Value: TElFString);
      {$endif}
      procedure Notification(AComponent: TComponent; Operation: TOperation); override;
      procedure SetTransparentXPThemes(Value: Boolean); virtual;
      procedure SetBorderColorDkShadow(Value: TColor);
      procedure SetBorderColorFace(Value: TColor);
      procedure SetBorderColorShadow(Value: TColor);
      procedure SetBorderColorHighlight(Value: TColor);
      procedure SetBorderColorWindow(Value: TColor);
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      property Theme: HTheme read FTheme;
    published

      property ActiveBorderType: TElFlatBorderType read FActiveBorderType write
          SetActiveBorderType default fbtSunken;
      property Background: TBitmap read FBackground write SetBackground;
      property BorderSides: TElBorderSides read FBorderSides write SetBorderSides
        default [ebsLeft, ebsTop, ebsRight, ebsBottom];
      property Flat: Boolean read FFlat write SetFlat default False;
      property FlatFocusedScrollBars: Boolean read FFlatFocusedScrollBars write
          SetFlatFocusedScrollBars default False;
      property ImageForm: TElImageForm read FImgForm write SetImageForm;
      property InactiveBorderType: TElFlatBorderType read FInactiveBorderType write
          SetInactiveBorderType default fbtSunkenOuter;
      property LineBorderActiveColor: TColor read FLineBorderActiveColor write
          SetLineBorderActiveColor default clBlack;
      property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
          SetLineBorderInactiveColor default clBlack;
      property UseBackground: Boolean read FUseBackground write SetUseBackground
          default False;
      property UseXPThemes: Boolean read FUseXPThemes write SetUseXPThemes default
          true;
      property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
      property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
      {$ifdef ELPACK_UNICODE}
      property Hint: TElFString read FHint write SetHint;
      {$endif}
      {$ifdef ELPACK_USE_STYLEMANAGER}
      property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
      property StyleName: string read FStyleName write SetStyleName;
      {$endif}
      property TransparentXPThemes: Boolean read FTransparentXPThemes write
          SetTransparentXPThemes default true;

      {< ELSCROLLBAR}
      property UseCustomScrollBars : Boolean read fUseCustomScrollBars write SetUseCustomScrollBars
        default True;
      property HorzScrollBarStyles: TElCtrlScrollBarStyles read GetHorzScrollBar
        write SetHorzScrollBar;
      property VertScrollBarStyles: TElCtrlScrollBarStyles read GetVertScrollBar
        write SetVertScrollBar;
      {> ELSCROLLBAR}

      property RightAlignedView: Boolean read FRightAlignedView write
          SetRightAlignedView default false;
      property BorderColorDkShadow: TColor read FBorderColorDkShadow write 
          SetBorderColorDkShadow default cl3DDkShadow;
      property BorderColorFace: TColor read FBorderColorFace write SetBorderColorFace 
          default clBtnFace;
      property BorderColorHighlight: TColor read FBorderColorDkShadow write 
          SetBorderColorHighlight default clBtnHighlight;
      property BorderColorShadow: TColor read FBorderColorShadow write 
          SetBorderColorShadow default clBtnShadow;
      property BorderColorWindow: TColor read FBorderColorWindow write 
          SetBorderColorWindow default clWindow;
    end;

implementation

{$ifdef VCL_5_USED}
uses FlatSB;
{$endif}

type

  THackWinControl = class(TWinControl);

function QueryThemeData : boolean;
var hTestTheme : HTheme;
begin
  result := false;
  hTestTheme := OpenThemeData(0, 'LISTVIEW');
  if hTestTheme <> 0 then
  begin
    result := true;
    CloseThemeData(hTestTheme);
  end;
end;

procedure TElScrollBox.SetActiveBorderType(const Value: TElFlatBorderType);
begin
  if FActiveBorderType <> Value then
  begin
    FActiveBorderType := Value;
    if Focused or FMouseOver then DrawFlatBorder(0);
  end;
end;

procedure TElScrollBox.SetBackground(const Value: TBitmap);
begin
  FBackground.Assign(Value);
end;

procedure TElScrollBox.SetBorderSides(Value: TElBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TElScrollBox.SetFlat(const Value: boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TElScrollBox.SetFlatFocusedScrollBars(const Value: boolean);
begin
  if FFlatFocusedScrollBars <> Value then
  begin
    FFlatFocusedScrollBars := Value;
    if Focused then DrawFlatBorder(0);
  end;
end;

procedure TElScrollBox.SetImageForm(newValue : TElImageForm);
begin
  if FImgForm <> newValue then
  begin
    if FImgForm <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FImgForm.ComponentState) then
        FImgForm.RemoveFreeNotification(Self);
      {$endif}
      FImgForm.UnregisterChanges(FImgFormChLink);
    end;
    if newValue <> nil then
       newValue.FreeNotification(Self);
    FImgForm := newValue;
    if FImgForm <> nil then FImgForm.RegisterChanges(FImgFormChLink);
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
  end;
end;

procedure TElScrollBox.SetInactiveBorderType(const Value: TElFlatBorderType);
begin
  if FInactiveBorderType <> Value then
  begin
    FInactiveBorderType := Value;
    if not Focused and not FMouseOver then DrawFlatBorder(0);
  end;
end;

procedure TElScrollBox.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if Flat and (Focused or FMouseOver) then
      if HandleAllocated then
        Invalidate;
  end;
end;

procedure TElScrollBox.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if Flat and not (Focused or FMouseOver) then
      if HandleAllocated then
        Invalidate;
  end;
end;

procedure TElScrollBox.SetUseBackground(const Value: boolean);
begin
  if FUseBackground <> Value then
  begin
    FUseBackground := Value;
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
  end;
end;

procedure TElScrollBox.SetUseXPThemes(Value: Boolean);
begin
  if FUseXPThemes <> Value then
  begin
    FUseXPThemes := Value;
    if HandleAllocated then
    {$ifdef MSWINDOWS}
    begin
      {$ifndef OLDELSCROLLBARS}
      fSBCtrl.UseXPThemes := Value;
      {$endif}
      RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_UPDATENOW);
    end;
    {$endif}
  end;
end;

procedure TElScrollBox.BackgroundChanged(Sender: TObject);
begin
  Invalidate;
  Perform(CM_COLORCHANGED, 0, 0);
end;

procedure TElScrollBox.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
  FMouseOver := True;
  if IsThemeApplied or ((Flat and (FInactiveBorderType <> FActiveBorderType)) and not Focused) then
    DrawFlatBorder(0);
  DoMouseEnter;
end;

procedure TElScrollBox.CMMouseLeave(var Msg: TMessage);
begin
  inherited;
  FMouseOver := False;
  if (Msg.lParam = integer(Self)) or (Msg.lParam = 0) then
  begin
    if IsThemeApplied or ((Flat and (FInactiveBorderType <> FActiveBorderType)) and not Focused) then DrawFlatBorder(0);
    DoMouseLeave;
  end;
end;

procedure TElScrollBox.CreateThemeHandle;
begin
  if (ThemesAvailable and IsThemeActive) then
    FTheme := OpenThemeData(Handle, PWideChar(GetThemedClassName()))
  else
    FTheme := 0;
end;

procedure TElScrollBox.CreateWnd;
begin
  {< ELSCROLLBAR}
  fSBCtrl.Control := nil;
  {> ELSCROLLBAR}
  inherited;
  if UseXPThemes and not IsThemeApplied then
  begin
    {$ifdef VCL_5_USED}
    UninitializeFlatSB(Handle);
    {$endif}
    CreateThemeHandle;
  end;
  {< ELSCROLLBAR}
  // reset control handler
  if fUseCustomScrollBars then
  begin
    fSBCtrl.Control := Self;
    if not fSBCtrl.Active then
    begin
      fUseCustomScrollBars := False;
      fSBCtrl.Control := nil;
    end;
  end;
  {> ELSCROLLBAR}
end;

procedure TElScrollBox.DestroyWnd;
begin
  inherited;
  if UseXPThemes and IsThemeApplied then
  begin
    FreeThemeHandle;
  end;
  {< ELSCROLLBAR}
  fSBCtrl.Control := nil;
  {> ELSCROLLBAR}
end;

{< ELSCROLLBAR}
function TElScrollBox.GetHorzScrollBar:TElCtrlScrollBarStyles;
begin
  Result := TElCtrlScrollBarStyles(fSBCtrl.ScrollBar[SB_HORZ]);
end;

function TElScrollBox.GetVertScrollBar:TElCtrlScrollBarStyles;
begin
  Result := TElCtrlScrollBarStyles(fSBCtrl.ScrollBar[SB_VERT]);
end;

procedure TElScrollBox.SetHorzScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  fSBCtrl.ScrollBar[SB_HORZ].Assign(Value);
end;

procedure TElScrollBox.SetVertScrollBar(const Value:TElCtrlScrollBarStyles);
begin
  fSBCtrl.ScrollBar[SB_VERT].Assign(Value);
end;

procedure TElScrollBox.SetUseCustomScrollBars(const Value:Boolean);
begin
  if fUseCustomScrollBars<>Value then
  begin
    fUseCustomScrollBars := Value;
    if fUseCustomScrollBars then
    begin
      fSBCtrl.Control := nil;
      fSBCtrl.Control := Self;
      if not fSBCtrl.Active then
      begin
        fUseCustomScrollBars := False;
        fSBCtrl.Control := nil;
      end;
    end
    else
      fSBCtrl.Control := nil;
  end;
end;
{> ELSCROLLBAR}

procedure TElScrollBox.DrawBackground(DC: HDC; R: TRect);
var
  X, Y: integer;
begin
  if FUseBackground and not FBackground.Empty then
  begin
    X := R.Left; Y := R.Top;
    while Y < R.Bottom do
    begin
      while X < R.Right do
      begin
        BitBlt(DC, X, Y, R.Right - X, R.Bottom - Y,
          FBackground.Canvas.Handle, 0, 0, SRCCOPY);
        Inc(X, FBackground.Width);
      end;
      X := R.Left;
      Inc(Y, FBackground.Height);
    end;
  end;
end;

procedure TElScrollBox.DrawFlatBorder(DC: HDC);
var
  R : TRect;
  BS: TElFlatBorderType;
  MustRelease: boolean;
  AColor : TColor;
  ARgn,
  CRgn   : HRGN;

const BordersFlat : array[boolean] of Integer = (0, WS_BORDER);
      Borders3D : array[boolean] of Integer = (0, WS_EX_CLIENTEDGE);

begin
  if not HandleAllocated then exit;
  R := Rect(0, 0, Width, Height);
  if IsThemeApplied then
  begin
    if BorderStyle = bsSingle then
    begin
      ARgn := CreateRectRgnIndirect(R);
      R := ClientRect;
      CRgn := CreateRectRgnIndirect(R);
      CombineRgn(ARgn, ARgn, CRgn, RGN_DIFF);
      RedrawWindow(Handle, nil, ARgn, RDW_INVALIDATE or RDW_FRAME or RDW_UPDATENOW);
      DeleteObject(ARgn);
      DeleteObject(CRgn);
    end;
    exit;
  end;
  MustRelease := (DC = 0);
  if MustRelease then
    DC := GetWindowDC(Handle);
  try
    if (BorderStyle = bsSingle) then
    begin
      if Focused or FMouseOver then
        BS := FActiveBorderType
      else
        BS := FInactiveBorderType;
      if Focused or FMouseOver then
        AColor := LineBorderActiveColor
      else
        AColor := LineBorderInactiveColor;
      DrawFlatFrameEx2(DC, R, AColor, Color, Focused or FMouseOver, Enabled, FBorderSides, BS, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
    end;
    if (not UseCustomScrollBars) and
       (FFlatFocusedScrollBars or not (Focused or FMouseOver))
    then
       DrawFlatScrollbars(Handle, DC, R,
        (Focused or FMouseOver) and not FFlatFocusedScrollBars,
        ssBoth, False, False, False,
        GetWindowLong(Handle, GWL_STYLE) or BordersFlat[(not Ctl3D) and (BorderStyle = bsSingle)],
        GetWindowLong(Handle, GWL_EXSTYLE) or Borders3D[Ctl3D and (BorderStyle = bsSingle)]);
  finally
    if MustRelease then ReleaseDC(Handle, DC);
  end;
end;

procedure TElScrollBox.DrawParentControl(DC: HDC);
var
  SavedDC: integer;
  P: TPoint;
begin
  if Assigned(Parent) then
  begin
    SavedDC := SaveDC(DC);
    try
      P := Parent.ScreenToClient(ClientOrigin);
      MoveWindowOrg(DC, -P.X, -P.Y);
      Parent.Perform(WM_ERASEBKGND, DC, 0);
      Parent.Perform(WM_PAINT, DC, 0);
      THackWinControl(Parent).PaintControls(DC, nil);
    finally
      RestoreDC(DC, SavedDC);
    end;
  end;
end;

procedure TElScrollBox.FreeThemeHandle;
begin
  {$ifdef MSWINDOWS}
  if ThemesAvailable then
    CloseThemeData(FTheme);
  {$endif}
  FTheme := 0;
end;

function TElScrollBox.GetThemedClassName: WideString;
begin
  Result := 'EDIT';
end;

function TElScrollBox.IsThemeApplied: Boolean;
begin
  Result := UseXPThemes and (FTheme <> 0);
end;

procedure TElScrollBox.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
var
  R1,
  BgRect : TRect;
  ACtl   : TWinControl;
begin
  if IsThemeApplied then
  begin
    if not TransparentXPThemes then
    begin
      inherited;
    end
    else
    begin
      R1 := ClientRect;
      DrawThemeParentBackground(Handle, Msg.DC, R1);
    end;
    //InflateRect(R, 2, 2);
    //DrawThemeBackground(Theme, Msg.DC, 0, 0, R, nil);
  end
  else
  begin
    if (FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in FImgForm.GetRealControl.Componentstate)) then
    begin
      if (FImgForm.Control <> Self) then
      begin
        ACtl := FImgForm.GetRealControl;
        R1 := ClientRect;
        BgRect := ClientRect;
        BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
        BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
        BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
        BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);

        FImgForm.PaintBkgnd(Msg.DC, R1, Point(BgRect.Left, BgRect.Top), false);
      end;
    end
    else
    if FTransparent then
      DrawParentControl(Msg.DC)
    else
    if FUseBackground and not FBackground.Empty then
      DrawBackground(Msg.DC, ClientRect)
    else
    begin
      //if not IsthemeApplied then
      inherited;
      //Msg.Result := 1;
    end;
  end;
end;

procedure TElScrollBox.WMKillFocus(var Msg: TMessage);
begin
  inherited;
  if not HandleAllocated then exit;
  if (Flat and (FInactiveBorderType <> FActiveBorderType))  and not FMouseOver then DrawFlatBorder(0);
end;

procedure TElScrollBox.WMNCCalcSize(var Message : TWMNCCalcSize);
begin
  inherited;
  if (BorderStyle = bsSingle) and Flat and (not (ThemesAvailable and UseXPThemes)) then
  begin
    if (ebsLeft in BorderSides) then
      inc(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(SM_CYEDGE));
    if (ebsTop in BorderSides) then
      inc(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(SM_CXEDGE));
    if (ebsRight in BorderSides) then
      dec(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(SM_CYEDGE));
    if (ebsBottom in BorderSides) then
      dec(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(SM_CXEDGE));
  end
  else
  if (BorderStyle = bsSingle) then
  begin
    if not (ebsLeft in BorderSides) then
      dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(SM_CYEDGE));
    if not (ebsTop in BorderSides) then
      dec(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(SM_CXEDGE));
    if not (ebsRight in BorderSides) then
      Inc(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(SM_CYEDGE));
    if not (ebsBottom in BorderSides) then
      Inc(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(SM_CXEDGE));
  end;
  // Message.Result := WVR_REDRAW;
end;

{$IFDEF MSWINDOWS}
procedure TElScrollBox.WMStyleChanging(var Message: TMessage);
begin
  if not FPreventStyleChange then
    inherited
  else
    Message.Result := 0;
end;

procedure TElScrollBox.WMStyleChanged(var Message: TMessage);
begin
  if not FPreventStyleChange then
    inherited
  else
    Message.Result := 0;
end;
{$ENDIF IFDEFf MSWINDOWS}

procedure TElScrollBox.WMNCPaint(var Msg : TMessage);
var DC : HDC;
    RW,
    RC,
    R : TRect;
    ARgn, CRgn : HRGN;

const BordersFlat : array[boolean] of Integer = (0, WS_BORDER);
      Borders3D : array[boolean] of Integer = (0, WS_EX_CLIENTEDGE);
      ScrollBars : array[boolean, boolean] of Integer = ((0, WS_VSCROLL), (WS_HSCROLL, WS_HSCROLL or WS_VSCROLL));

  procedure PaintCrossSystemScrollbarsArea;
    var
      nFrameSize :Integer;
  begin
    // paint left cross scrollbars area for system scrollbars:
    begin
      GetWindowRect(Handle, RW);
      MapWindowPoints(0, Handle, RW, 2);
      OffsetRect(RW, -RW.Left, -RW.Top);

      if ((GetWindowLong(Handle, GWL_STYLE) and WS_BORDER) = WS_BORDER) then
        nFrameSize := GetSystemMetrics(SM_CXBORDER)
      else
        if ((GetWindowLong(Handle, GWL_EXSTYLE) and WS_EX_CLIENTEDGE) = WS_EX_CLIENTEDGE) then
        nFrameSize := GetSystemMetrics(SM_CXEDGE)
      else
        nFrameSize := 0;

      with RW do
      begin
        if (not RightAlignedView) or (not NewStyleControls) then
        begin
          dec(Right, nFrameSize);
          Left:= Right - GetSystemMetrics(SM_CXVSCROLL);
          dec(Bottom, nFrameSize);
          Top   := Bottom - GetSystemMetrics(SM_CYHSCROLL);
        end
        else
        begin
          Left   := nFrameSize;
          Right := Left + GetSystemMetrics(SM_CXVSCROLL);
          dec(Bottom, nFrameSize);
          Top   := Bottom - GetSystemMetrics(SM_CYHSCROLL);
        end;
        Windows.DrawEdge(DC, RW, EDGE_SUNKEN, BF_MIDDLE);
      end;
    end;
  end;

  procedure CallInheritedWOFrame;
  var
    WS, WES :DWORD;
  begin
    try
      WES := GetWindowLong(Handle, GWL_EXSTYLE);
      if WES and WS_EX_CLIENTEDGE <> 0 then
      begin
        WS := 0;
        FPreventStyleChange := True;
        SetWindowLong(Handle, GWL_EXSTYLE, WES and not WS_EX_CLIENTEDGE);
      end
      else
      begin
        WES := 0;
        WS  := GetWindowLong(Handle, GWL_STYLE);
        if WS and WS_BORDER <> 0 then
        begin
          FPreventStyleChange := True;
          SetWindowLong(Handle, GWL_STYLE, WS and not WS_BORDER);
        end
        else
          WS := 0;
      end;

      //inherited;
      DefWindowProc(Handle, Msg.Msg, Msg.wParam, Msg.lParam);

      if WES <> 0 then
        SetWindowLong(Handle, GWL_EXSTYLE, WES)
      else if WS <> 0 then
        SetWindowLong(Handle, GWL_STYLE, WS);
    finally
      if FPreventStyleChange then
        FPreventStyleChange := False;
    end;
  end;

begin
  if FPreventStyleChange then
    exit;

  if IsThemeApplied and (BorderStyle = bsSingle) then
  begin
    //DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
    //if DC = 0 then
      DC := GetWindowDC(Handle);

    Windows.GetClientRect(Handle, RC);

    {< ELSCROLLBAR}
    if UseCustomScrollBars then
    begin //???
      if VertScrollBarStyles.Visible then
      begin
        if (not RightAlignedView) then
          inc(RC.Right, VertScrollBarStyles.Depth)
        else
          dec(RC.Left, VertScrollBarStyles.Depth);
      end;
      if HorzScrollBarStyles.Visible then
        inc(RC.Bottom, HorzScrollBarStyles.Depth);
    end
    else
    {> ELSCROLLBAR}
    begin
      if GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0 then
      begin
        if (not RightAlignedView) or (not NewStyleControls) then
          inc(RC.Right, GetSystemMetrics(SM_CXVSCROLL))
        else
          dec(RC.Left, GetSystemMetrics(SM_CXVSCROLL));

        if (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0) then
          PaintCrossSystemScrollbarsArea;

      end;
      if GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0 then
        inc(RC.Bottom, GetSystemMetrics(SM_CYHSCROLL));
    end;

    GetWindowRect(Handle, RW);
    MapWindowPoints(0, Handle, RW, 2);
    OffsetRect(RC, -RW.Left, -RW.Top);

    R := RW;
    OffsetRect(R, -RW.Left, -RW.Top);
    CRgn := CreateRectRgn(R.Left, R.Top, R.Right, R.Bottom);

    ARgn := CreateRectRgn(RC.Left, RC.Top, RC.Right, RC.Bottom);
    SelectClipRgn(DC, ARgn);

    //inherited;
    if (not UseCustomScrollBars) and (
       (GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0) or
       (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0) )
    then
    begin
      CallInheritedWOFrame;
      //PaintCrossSystemScrollbarsArea;
    end;

    CombineRgn(CRgn, CRgn, ARgn, RGN_DIFF);
    DeleteObject(ARgn);
    SelectClipRgn(DC, CRgn);
    OffsetRect(RW, -RW.Left, -RW.Top);

    //if UseCustomScrollBars and
    DrawThemeBackgroundTo('EDIT', DC, 0, 0, RW, nil);

    DeleteObject(CRgn);

    ReleaseDC(Handle, DC);
  end
  else
  begin
    inherited;
    if RightAlignedView and (not UseCustomScrollBars) and
       (GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0) and
       (GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0) and
       (NewStyleControls)
    then
    begin
      DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
      if DC = 0 then
        DC := GetWindowDC(Handle);
      PaintCrossSystemScrollbarsArea;
      ReleaseDC(Handle, DC);
    end;
  end;
end;

procedure TElScrollBox.WMPaint(var Msg: TWMPaint);
//var PS : TPaintStruct;
var CtlDC : HDC;
begin
  if Msg.DC = 0 then
  begin
    inherited;
    if FFlat and (not IsThemeApplied) then
    begin
      CtlDC := GetWindowDC(Handle);
      DrawFlatBorder(CtlDC);
      ReleaseDC(Handle, CtlDC);
    end;
  end
  else
  if not FPainting and not FPaintingTo then
  begin
    //BeginPaint(Handle, PS);
    // inherited;
    (*if FTransparent or (FUseBackground and not FBackground.Empty) or
       ((FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in Componentstate))) then
    *)
    DoPaint(Msg.DC);
    //EndPaint(Handle, PS);
  end
  else
    inherited;
end;

procedure TElScrollBox.WMSetFocus(var Msg: TMessage);
begin
  inherited;
  if (Flat and (FInactiveBorderType <> FActiveBorderType)) and (not FMouseOver) and
     (not IsThemeApplied)
  then
    DrawFlatBorder(0);
end;

procedure TElScrollBox.WMIsThemedControl(var Message: TMessage);
begin
  Message.Result := Theme;
end;


procedure TElScrollBox.WMMouseWheel(var Msg: TWMMouseWheel);
begin
  inherited;
  CMMouseWheel(Msg);
end;

procedure TElScrollBox.CMMouseWheel(var Msg : TWMMouseWheel);
var
  Dy : integer;
  sl : integer;
  SD : DWORD;
  SC : DWORD;
  bIsVSB, bIsHSb :Boolean;
begin
  bIsVSB := (WS_VSCROLL and GetWindowLong(Handle, GWL_STYLE))<>0;
  bIsHSB := (not bIsVSB) and ((WS_HSCROLL and GetWindowLong(Handle, GWL_STYLE))<>0);
  if not (bIsVSB or bIsHSB) then
    exit;
  if bIsVSB then
    SD := WM_VSCROLL
  else
    SD := WM_HSCROLL;
  if IsWinNT or IsWin98 then
     SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @sl, SPIF_SENDCHANGE)
  else
     sl := 3;
  if sl = 0 then
    sl := 1;
  Dy := Msg.WheelDelta div (MOUSE_WHEEL_DELTA div sl);
  if Dy <> 0 then
  begin
    if Dy>0 then
      SC := SB_LINEUP
    else
      SC := SB_LINEDOWN;
    for Dy := 1 to sl do
      Perform( SD, SC, 0);
  end;
end;


procedure TElScrollBox.ELThemeChanged(var Message: TMessage);
begin
  if ThemesAvailable and UseXPThemes then
  begin
    FreeThemeHandle;
    CreateThemeHandle;
    SetWindowPos(
      Handle,
      0,
      0, 0, 0, 0,
      SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER
      );
    RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ERASE);
  end;
  Message.Result := 1;
end;

constructor TElScrollBox.Create(AOwner: TComponent);
begin
  inherited;
  {< ELSCROLLBAR}
  fSBCtrl := TElSBController.Create(Self);
  fSBCtrl.UseXPThemes := true;
  fUseCustomScrollBars := True;
  {> ELSCROLLBAR}
  //ControlStyle := ControlStyle + [csOpaque];
  FActiveBorderType := fbtSunken;
  FBackground := TBitmap.Create;
  FBackground.OnChange := BackgroundChanged;
  FBorderSides := AllBorderSides;
  FFlat := False;
  FBorderColorFace := clBtnFace;
  FBorderColorShadow := clBtnShadow;
  FBorderColorDkShadow := cl3DDkShadow;
  FBorderColorHighlight := clBtnHighlight;
  FBorderColorWindow := clWindow;
 
  FFlatFocusedScrollBars := False;
  FInactiveBorderType := fbtSunkenOuter;
  FMouseOver := False;
  FPainting := False;
  FPaintingTo := False;
  FTransparent := False;
  FUseBackground := False;
  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  FUseXPThemes := true;
  FTransparentXPThemes := true;
{$IFDEF ELPACK_USE_STYLEMANAGER}
  FStyleMgrLink := TElStyleMgrChangeLink.Create;
  FStyleMgrLink.OnChange := StyleMgrChange;
{$ENDIF}
end;

destructor TElScrollBox.Destroy;
begin
  ImageForm := nil;
  FImgFormChLink.Free;
  FBackground.Free;
{$ifdef ELPACK_USE_STYLEMANAGER}
  StyleManager := nil;
  FreeAndNil(FStyleMgrLink);
{$ENDIF}
  inherited;
end;

procedure TElScrollBox.DoMouseEnter;
begin
  if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
end;

procedure TElScrollBox.DoMouseLeave;
begin
  if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TElScrollBox.DoPaint(DC : HDC);
const
  BorderOffsets: array [TBorderStyle] of integer = (1, -1);
var
  CtlDC, TempDC: HDC;
  OldBmp, TempBmp: HBITMAP;
begin
  FPainting := True;
  if (not IsThemeApplied) and
     (FTransparent or (FUseBackground and not FBackground.Empty)   or
     ((FImgForm <> nil) and (FImgForm.Backgroundtype <> bgtColorFill) and (not (csDesigning in Componentstate)))) then
  begin
    CtlDC := DC;//GetDC(Handle);
    try
      TempDC := CreateCompatibleDC(CtlDC);
      try
        TempBmp := CreateCompatibleBitmap(CtlDC, ClientWidth + 1, ClientHeight + 1);
        try
          OldBmp := SelectObject(TempDC, TempBmp);
          FPaintingTo := True;
          try
            PaintTo(TempDC, 0, 0);
          finally
            FPaintingTo := False;
          end;
          if IsThemeApplied or FFlat then DrawFlatBorder(TempDC);
          BitBlt(CtlDC, BorderOffsets[BorderStyle], BorderOffsets[BorderStyle], ClientWidth, ClientHeight, TempDC, 1, 1, SRCCOPY);
          SelectObject(TempDC, OldBmp);
        finally
          DeleteObject(TempBmp);
        end;
      finally
        DeleteDC(TempDC);
      end;
    finally
      // ReleaseDC(Handle, CtlDC);
    end;
  end
  else
  begin
    DrawThemedBackground(DC);
    // CtlDC := GetDC(Handle);
    //ReleaseDC(Handle, CtlDC);
  end;
  FPainting := False;
end;

procedure TElScrollBox.IFMRepaintChildren(var Message: TMessage);
var i : integer;
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  for i := 0 to ControlCount -1 do
  begin
    if Controls[i] is TWinControl then
      PostMessage(TWinControl(Controls[i]).Handle, Message.Msg, Message.wParam, Message.lParam);
  end;
end;

procedure TElScrollBox.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TElScrollBox.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  if Assigned(ImageForm) then
    Perform(IFM_REPAINTCHILDREN, 0, 0);
end;

procedure TElScrollBox.CreateParams(var Params: TCreateParams);
const
  LeftSB: array[Boolean] of DWORD = (0, WS_EX_LEFTSCROLLBAR);
begin
  inherited;
  Params.Style := Params.Style or WS_CLIPCHILDREN;
  if (BorderStyle = bsSingle) and Flat and (not (ThemesAvailable and UseXPThemes and QueryThemeData)) then
  begin
    Params.Style := Params.Style and (not WS_BORDER);
    Params.ExStyle := Params.ExStyle and (not WS_EX_CLIENTEDGE);
  end;
  if NewStyleControls or UseCustomScrollBars then
    Params.ExStyle := Params.ExStyle or LeftSB[RightAlignedView];
  Params.WindowClass.style := Params.WindowClass.style or CS_HREDRAW or CS_VREDRAW;
end;

procedure TElScrollBox.SetRightAlignedView(Value: Boolean);
begin
  if FRightAlignedView <> Value then
  begin
    FRightAlignedView := Value;
    RecreateWnd;
  end;
end;

{$ifdef ELPACK_UNICODE}
procedure TElScrollBox.CMHintShow(var Message: TMessage);
var T: WideChar;
  HintInfo : PHintInfo;
  l : integer;
  S : String;
  WS: WideString;
begin
  inherited;
  HintInfo := PHintInfo(Message.lParam);
  if Length(FHint) = 0 then
  begin
    HintInfo.hintStr := '';
    exit;
  end;

  S := GetShortHint(inherited Hint);
  if HintInfo.HintStr = S then
  begin
    WS := GetShortHintW(FHint);
  end
  else
  begin
    S := FHint;
    WS := FHint;
  end;

  l := Length(S) + 1 + Length(WS) * 2;
  SetLength(HintInfo.HintStr, l + 4);
  Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);

  Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
  T := #0;
  Move(T, HintInfo.HintStr[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, HintInfo.HintStr[l + 3], sizeof(T));
end;

{$endif}

procedure TElScrollBox.DrawThemedBackground(DC : HDC);
var
  hBr : HBRUSH;
  R : TRect;
begin
  GetClipBox(DC, R);
  if IsRectEmpty(R) then
    R := ClientRect;
  hBr := CreateSolidBrush(ColorToRGB(Color));
  FillRect(DC, R, hBr);
  DeleteObject(hBr);
end;

{$ifdef ELPACK_UNICODE}
procedure TElScrollBox.SetHint(Value: TElFString);
var S : String;
    i,
    l : integer;
    T : WideChar;
begin
  FHint := Value;

  S := FHint;
  i := Length(S);
  l := Length(S) + 1 + Length(FHint) * 2;
  SetLength(S, l + 4);
  S[i + 1] := #0;

  Move(FHint[1], S[i + 2], Length(FHint) * 2);
  T := #0;
  Move(T, S[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, S[l + 3], sizeof(T));
  inherited Hint := S;
end;

{$endif}

procedure TElScrollBox.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited;
  {$ifdef ELPACK_USE_IMAGEFORM}
  if (Operation = opRemove) and (AComponent = FImgForm) then
    ImageForm := nil;
  {$endif}

{$ifdef ELPACK_USE_STYLEMANAGER}
  if (Operation = opRemove) and (AComponent = FStyleManager) then
     StyleManager := nil;
{$ENDIF}
end; { Notification }

{$ifdef ELPACK_USE_STYLEMANAGER}
procedure TElScrollBox.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
  begin
    {$ifdef VCL_5_USED}
    if (FStyleManager <> nil) and (not (csDestroying in FStyleManager.ComponentState)) then
      FStyleManager.RemoveFreeNotification(Self);
    {$endif}
    if FStyleManager <> nil then
       FStyleManager.UnregisterChanges(FStyleMgrLink);
    FStyleManager := Value;
    if FStyleManager <> nil then
    begin
      FStyleManager.FreeNotification(Self);
      FStyleManager.RegisterChanges(FStyleMgrLink);
      UpdateStyle;
    end;
  end;
end;

procedure TElScrollBox.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
  begin
    FStyleName := Value;
    UpdateStyle;
  end;
end;

procedure TElScrollBox.StyleMgrChange(Sender : TObject);
begin
  UpdateStyle;
end;

procedure TElScrollBox.UpdateStyle;
begin
  if FStyleManager <> nil then
  begin
    if HandleAllocated then
      SendMessage(Handle, WM_SETREDRAW, 0, 0);
    FStyleManager.ApplyStyle(Self, StyleName);
    if HandleAllocated then
    begin
      SendMessage(Handle, WM_SETREDRAW, 1, 0);
      Invalidate;
    end;
  end;
end;

{$endif}

procedure TElScrollBox.SetTransparentXPThemes(Value: Boolean);
begin
  if FTransparentXPThemes <> Value then
  begin
    FTransparentXPThemes := Value;
    Invalidate;
  end;
end;

procedure TElScrollBox.SetBorderColorDkShadow(Value: TColor);
begin
  if FBorderColorDkShadow <> Value then
  begin
    FBorderColorDkShadow := Value;
    if Flat then
      DrawFlatBorder(0);
  end;
end;

procedure TElScrollBox.SetBorderColorFace(Value: TColor);
begin
  if FBorderColorFace <> Value then
  begin
    FBorderColorFace := Value;
    if Flat then
      DrawFlatBorder(0);
  end;
end;

procedure TElScrollBox.SetBorderColorShadow(Value: TColor);
begin
  if FBorderColorShadow <> Value then
  begin
    FBorderColorShadow := Value;
    if Flat then
      DrawFlatBorder(0);
  end;
end;

procedure TElScrollBox.SetBorderColorHighlight(Value: TColor);
begin
  if FBorderColorHighlight <> Value then
  begin
    FBorderColorHighlight := Value;
    if Flat then
      DrawFlatBorder(0);
  end;
end;

procedure TElScrollBox.SetBorderColorWindow(Value: TColor);
begin
  if FBorderColorWindow <> Value then
  begin
    FBorderColorWindow := Value;
    if Flat then
      DrawFlatBorder(0);
  end;
end;


end.
