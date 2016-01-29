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

11/22/2002

  Fixed an infinite loop when bgtTileBitmap is set and background image is empty

12/08/2001

  Fixed the bug that might prevent control region from being set

11/20/2001

  Fixed possible AV appearing in PictureChanged when no form image is assigned

============================== Version 3.0 =====================================

09/30/2001

  Fixed right and middle mouse button messages when MoveForm = true and
  CaptionControl = nil

09/10/2001

  Added TransparentColor. This value is used as a transparent color when creating
  image-shaped forms.

09/05/2001

  Added possibility to draw background on any control, not just on the form
  Fixed the problem when MoveForm is True and no CaptionControl assigned - it
  was impossible to click on min/max/close/menu buttons.

============================== Version 2.76 ====================================


12/18/2000

  Clearing the form shape image when the window was not visible didn't work. Fixed.

============================== Version 2.75 ====================================

10/31/2000

  When Movable was true and CaptionControl was nil, it was impossible to click
  on the non-windowed child control on the form. Fixed.

*)

unit ElImgFrm;

interface

uses
  TypInfo,
{$ifdef VCL_6_USED}
  Types,
{$endif}
  Windows,
  Messages,
  Controls,
  Graphics,
  ExtCtrls,
  Forms,
  Classes,
  ElHook,
  ElTools,
  ElVCLUtils,
  ElList,
  ElUxTheme,
  ElTmSchema,
  ElExtBkgnd;

type

  TCustomElImageForm = class;

  TImgFormChangeLink = class(TObject)
  private
    FSender: TCustomElImageForm;
    FOnChange: TNotifyEvent;
  public
    destructor Destroy; override;
    procedure Change; virtual;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Sender: TCustomElImageForm read FSender write FSender;
  end;

  TCustomElImageForm = class(TComponent)
  private
    FCaptionControl: TGraphicControl;
    FChangeRegion: boolean;
    FBkImage : TBitmap;
    FImage   : TImage;
    FBmp     : TBitmap;
    FMoveForm: boolean;
    FMoveHook: TElHook;
    FOldImageEvent: TNotifyEvent;
    {$ifndef LINUX}
    FRegion: HRGN;
    {$else}
    FRegion: Region;
    {$endif}
    FBackgroundType : TElBkGndType;
    FGradientSteps : Integer;
    FGradientStartColor : TColor;
    FGradientEndColor : TColor;
    FNoBk : boolean;
    FCLients : TElList;
    CacheBackground: TBitmap;

    procedure AfterMessage(Sender: TObject; var Msg: TMessage; var Handled: boolean);
    procedure BeforeMessage(Sender: TObject; var Msg: TMessage; var Handled: boolean);
    procedure PictureChanged(Sender: TObject);
    procedure BkImageChange(Sender: TObject);
    procedure SetCaptionControl(const Value: TGraphicControl);
    procedure SetChangeRegion(const Value: boolean);
    procedure SetImage(const Value: TImage);
    procedure SetBkImage(const Value: TBitmap);
    procedure SetMoveForm(const Value: boolean);
    procedure SetGradientStartColor(newValue : TColor);
    procedure SetGradientEndColor(newValue : TColor);
    procedure SetGradientSteps(newValue : Integer);
    procedure SetBackgroundType(newValue : TElBkGndType);
    procedure Change;
    //procedure RedoBmp(DC : HDC);
  protected
    FControl: TWinControl;
    FTransparentColor: TColor;
    procedure CreateHook;
    procedure CreateRegion;
    procedure DestroyHook;
    procedure DestroyRegion;
    function GetTransparentColor: TColor;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetControl(Value: TWinControl);
    procedure SetTransparentColor(Value: TColor);
    procedure CreateCacheBackground;
    procedure DisposeCacheBackground;
    property CaptionControl: TGraphicControl read FCaptionControl write SetCaptionControl;
    property ChangeFormRegion: boolean read FChangeRegion write SetChangeRegion;
    property MoveForm  : boolean read FMoveForm write SetMoveForm default False;
    property FormImage : TImage  read FImage write SetImage;
    property Background: TBitmap read FBkImage write SetBkImage;
    property BackgroundType : TElBkGndType read FBackgroundType write SetBackgroundType default bgtColorFill;
    property GradientStartColor : TColor read FGradientStartColor write SetGradientStartColor;  { Protected }
    property GradientEndColor : TColor read FGradientEndColor write SetGradientEndColor;  { Protected }
    property GradientSteps : Integer read FGradientSteps write SetGradientSteps default 16;  { Protected }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RegisterChanges(Value: TImgFormChangeLink);
    procedure UnregisterChanges(Value: TImgFormChangeLink);

    procedure PaintBkgnd(DC : HDC; R : TRect; Origin : TPoint; Direct : boolean);
    function GetRealControl: TWinControl;
  published
    property Control: TWinControl read FControl write SetControl;
    property TransparentColor: TColor read FTransparentColor write
        SetTransparentColor;
  end;

  TElImageForm = class(TCustomElImageForm)
  published
    property CaptionControl;
    property ChangeFormRegion;
    property FormImage;
    property MoveForm;
    property Background;
    property BackgroundType;
    property GradientStartColor;
    property GradientEndColor;
    property GradientSteps;
  end;

const IFM_EFFECTIVESIZE   = WM_USER + 1326;
      IFM_REPAINTCHILDREN = WM_USER + 6389;
      IFM_CANPAINTBKGND   = WM_USER + 6391;

implementation

uses
  SysUtils;

function CreateBitmapRgn( RegionBitmap: TBitmap; TransparentColor: TColor{$ifdef D_5_UP}; TransparentColorTolerance: Integer = 0 {$endif}): HRGN;

  function bMin(b1, b2: byte): byte;
  begin
    if b1 < b2 then
      Result := b1
    else
      Result := b2;
  end;
const
  ALLOC_UNIT_DELTA = 100;
var
  MemoryDC, tmpDC: HDC;
  BitmapInfo: TBitmapInfo;
  hBitmap32, hHoldBitmap, hHoldMemoryBitmap: HBitmap;
  PtrBitSec32 : Pointer;
  bm32 : {$ifdef D_5_UP} BITMAP {$else} Windows.TBitmap {$endif};
  maxRects: DWORD;
  hData: HGLOBAL;
  PtrRegionData: PRgnData;
  b, LR, LG, LB, HR, HG, HB: Byte;
  p32: PByte;
  x, x0, y: integer;
  PtrLongInt: PLongInt;
  PtrRect: PRect;
  h: HRGN;
begin
  Result := 0;
  if RegionBitmap <> nil then
  begin
    hData := 0;
    tmpDC := 0;
    hHoldBitmap := 0;
    hHoldMemoryBitmap := 0;
    MemoryDC := CreateCompatibleDC(0);
    if MemoryDC <> 0 then
    try
      with BitmapInfo.bmiHeader do
      begin
        biSize          := sizeof(TBitmapInfoHeader);
        biWidth         := RegionBitmap.Width;
        biHeight        := RegionBitmap.Height;
        biPlanes        := 1;
        biBitCount      := 32;
        biCompression   := BI_RGB; { 0 - when uncompressed }
        biSizeImage     := 0;
        biXPelsPerMeter := 0;
        biYPelsPerMeter := 0;
        biClrUsed       := 0;
        biClrImportant  := 0;
      end;
      hBitmap32 := CreateDIBSection(MemoryDC, BitmapInfo, DIB_RGB_COLORS, PtrBitSec32, 0, 0);
      if hBitmap32 <> 0 then
      begin
        hHoldMemoryBitmap := SelectObject(MemoryDC, hBitmap32);
        GetObject(hBitmap32, SizeOf(bm32), @bm32);
        while (bm32.bmWidthBytes mod 4) > 0 do
          inc(bm32.bmWidthBytes);
        tmpDC := CreateCompatibleDC(MemoryDC);
        hHoldBitmap := SelectObject(tmpDC, RegionBitmap.Handle);
        BitBlt(MemoryDC, 0, 0, RegionBitmap.Width, RegionBitmap.Height, tmpDC, 0, 0, SRCCOPY);
        maxRects := ALLOC_UNIT_DELTA;
        hData := GlobalAlloc(GMEM_MOVEABLE, sizeof(TRgnDataHeader) + SizeOf(TRect) * maxRects);
        PtrRegionData := GlobalLock(hData);
        PtrRegionData^.rdh.dwSize := SizeOf(TRgnDataHeader);
        PtrRegionData^.rdh.iType := RDH_RECTANGLES;
        PtrRegionData^.rdh.nCount := 0;
        PtrRegionData^.rdh.nRgnSize := 0;
        SetRect(PtrRegionData^.rdh.rcBound, MaxInt, MaxInt, 0, 0);

        LR := GetRValue(ColorToRGB(TransparentColor));
        LG := GetGValue(ColorToRGB(TransparentColor));
        LB := GetBValue(ColorToRGB(TransparentColor));

        HR := bMin($FF, LR {$ifdef D_5_UP} + TransparentColorTolerance {$endif});
        HG := bMin($FF, LG {$ifdef D_5_UP} + TransparentColorTolerance {$endif});
        HB := bMin($FF, LB {$ifdef D_5_UP} + TransparentColorTolerance {$endif});

        p32 := bm32.bmBits;
        inc(PChar(p32), (bm32.bmHeight - 1) * bm32.bmWidthBytes);
        for y := 0 to RegionBitmap.Height-1 do
        begin
          x := -1;
          while x+1 < RegionBitmap.Width do
          begin
            inc(x);
            x0 := x;
            PtrLongInt := PLongInt(p32);
            inc(PChar(PtrLongInt), x * SizeOf(LongInt));
            while x < RegionBitmap.Width do
            begin
              b := GetBValue(PtrLongInt^);
              if (b >= LR) and (b <= HR) then
              begin
                b := GetGValue(PtrLongInt^);
                if (b >= LG) and (b <= HG) then
                begin
                  b := GetRValue(PtrLongInt^);
                  if (b >= LB) and (b <= hb) then { is "transparent" }
                    break;
                end;
              end;
              inc(PChar(PtrLongInt), SizeOf(LongInt));
              inc(x);
            end;//of while x < RegionBitmap.Width
            if x > x0 then
            begin
              { Add pixels (x0, y) to (x, y+1) as a new rectangle into region }
              if PtrRegionData^.rdh.nCount >= maxRects then
              begin
                GlobalUnlock(hData);
                inc(maxRects, ALLOC_UNIT_DELTA);
                hData := GlobalReAlloc(hData, SizeOf(TRgnDataHeader) + SizeOf(TRect) * maxRects, GMEM_MOVEABLE);
                PtrRegionData := GlobalLock(hData);
                Assert(PtrRegionData <> NIL);
              end;
              PtrRect := @PtrRegionData^.Buffer[PtrRegionData^.rdh.nCount * SizeOf(TRect)];
              SetRect(PtrRect^, x0, y, x, y+1);
              if x0 < PtrRegionData^.rdh.rcBound.Left then
                PtrRegionData^.rdh.rcBound.Left := x0;
              if y < PtrRegionData^.rdh.rcBound.Top then
                PtrRegionData^.rdh.rcBound.Top := y;
              if x > PtrRegionData^.rdh.rcBound.Right then
                PtrRegionData^.rdh.rcBound.Left := x;
              if y+1 > PtrRegionData^.rdh.rcBound.Bottom then
                PtrRegionData^.rdh.rcBound.Bottom := y+1;
              inc(PtrRegionData^.rdh.nCount);
              { On Windows98: }
              if PtrRegionData^.rdh.nCount = 2000 then
              begin
                h := ExtCreateRegion(NIL, SizeOf(TRgnDataHeader) +
                   (SizeOf(TRect) * maxRects), PtrRegionData^);
                Assert(h <> 0);
                if Result <> 0 then
                begin
                  CombineRgn(Result, Result, h, RGN_OR);
                  DeleteObject(h);
                end else
                  Result := h;
                PtrRegionData^.rdh.nCount := 0;
                SetRect(PtrRegionData^.rdh.rcBound, MaxInt, MaxInt, 0, 0);
              end;
            end;//of if x > x0 then
          end;//of while x+1 < RegionBitmap.Width
          { to next row }
          Dec(PChar(p32), bm32.bmWidthBytes);
        end;//of for y := 0 to RegionBitmap.Height-1
        { Create or extend the region and remaining rectangle }
        h := ExtCreateRegion(NIL, SizeOf(TRgnDataHeader) + (SizeOf(TRect) * maxRects), PtrRegionData^);
        Assert(h <> 0);
        if Result <> 0 then
        begin
          CombineRgn(Result, Result, h, RGN_OR);
          DeleteObject(h);
        end else
          Result := h;
      end;//of if hBitmap32 <> 0
    finally
     { Clean up }
     if hData<>0 then
       GlobalFree(hData);
     if tmpDC<>0 then
       begin
          if hHoldBitmap <> 0 then
            SelectObject(tmpDC, hHoldBitmap);
          DeleteDC(tmpDC);
       end;

     if hHoldMemoryBitmap <> 0
       then DeleteObject( SelectObject(MemoryDC, hHoldMemoryBitmap) );

     DeleteDC(MemoryDC);
    end;//of try
  end;
end;

{ OLD Version CreateBitmapRgn:
function CreateBitmapRgn(Bitmap: TBitmap; TransparentColor: TColor): HRGN;
var
  Rgn1, Rgn2: HRGN;
  Tmp: TBitmap;
  X, Y, StartX: integer;
begin
  Result := 0;
  if not Assigned(Bitmap) then
    exit
  else
  if (Bitmap.Height = 0) or (Bitmap.Width = 0) then
    exit;
  Rgn1 := 0;
  Tmp := TBitmap.Create;
  try
    Tmp.Assign(Bitmap);
    for Y := 0 to Tmp.Height - 1 do
    begin
      X := 0;
      while X < Tmp.Width do
      begin
        while (X < Tmp.Width) and (TColor(GetPixel(Tmp.Canvas.Handle, X, Y)) = TransparentColor) do Inc(X);
        if X >= Tmp.Width then continue;
        StartX := X;
        while (X < Tmp.Width) and (TColor(GetPixel(Tmp.Canvas.Handle, X, Y)) <> TransparentColor) do Inc(X);
        if X >= Tmp.Width then X := Tmp.Width;
        if Rgn1 = 0 then
          Rgn1 := CreateRectRgn(StartX, Y, X, Y + 1)
        else begin
          Rgn2 := CreateRectRgn(StartX, Y, X, Y + 1);
          if Rgn2 <> 0 then
          begin
            CombineRgn(Rgn1, Rgn1, Rgn2, RGN_OR);
            DeleteObject(Rgn2);
          end;
        end;
      end;
    end;
    Result := Rgn1;
  finally
    Tmp.Free;
  end;
end;
}

{ TCustomElImageForm }

procedure TCustomElImageForm.BeforeMessage(Sender: TObject; var Msg: TMessage; var Handled: boolean);
var
  ADC  : HDC;
  R    : TRect;
  ACtl : TWinControl;
  Offs : TPoint;
  //PS: TPaintStruct;

begin
  if (csDesigning in ComponentState) then exit;
  ACtl := GetRealControl;
  if (Msg.Msg = WM_SIZE) then FNoBk := true;
  if (Msg.Msg = WM_ERASEBKGND) and (ACtl <> nil) and
     (not (csDesigning in ACtl.ComponentState)) then
  begin
    if (not (csDesigning in ComponentState)) and
       (ACtl.Perform(IFM_CANPAINTBKGND, 0, 0) = 0) then
      if (Control <> nil) or (FBackgroundType <> bgtColorFill) then
      begin
        ADC := TWMEraseBkGnd(Msg).DC;
        GetClipBox(ADC, R);
        if IsRectEmpty(R) then
        begin
          R := Rect(0, 0, ACtl.ClientWidth, ACtl.ClientHeight);
          ACtl.Perform(IFM_EFFECTIVESIZE, 0, Integer(@R));
        end;
        if GetWindowLong(ACtl.Handle, GWL_STYLE) and WS_HSCROLL = WS_HSCROLL then
          Offs.x := GetScrollPos(ACtl.Handle, SB_HORZ)
        else
          Offs.x := 0;
        if GetWindowLong(ACtl.Handle, GWL_STYLE) and WS_VSCROLL = WS_VSCROLL then
          Offs.y := GetScrollPos(ACtl.Handle, SB_VERT)
        else
          Offs.y := 0;
        Offs := Point(0, 0);
        PaintBkgnd(ADC, R, Offs, true);
        if (not FNoBk) then
        begin
          Msg.Result := 1;
          Handled := true;
        end;
      end;
  end;
end;

procedure TCustomElImageForm.AfterMessage(Sender: TObject;
  var Msg: TMessage; var Handled: boolean);
var
  P    : TPoint;
  R    : TRect;
  ACtl : TWinControl;
  Message: TMessage;
  SS   : TShiftState;
  ShiftKeys,
  NewMsg : integer;
  (*
  ATheme : HTheme;
  ADC    : HDC;
  Result : HRESULT;
  *)
begin
  if (csDesigning in ComponentState) then exit;

  ACtl := GetRealControl;
  if (not (csDesigning in ComponentState)) and MoveForm then
  begin
    if (Msg.Msg = WM_NCHITTEST) and (Msg.Result <> HTBOTTOM) and (Msg.Result <> HTBOTTOMLEFT)
      and (Msg.Result <> HTBOTTOMRIGHT) and (Msg.Result <> HTLEFT) and (Msg.Result <> HTRIGHT)
      and (Msg.Result <> HTTOPLEFT) and (Msg.Result <> HTTOPRIGHT) then
      if not Assigned(FCaptionControl) then
      begin
        P := Point(TWMNCHitTest(Msg).XPos, TWMNCHitTest(Msg).YPos);
        P := ACtl.ScreenToClient(P);
        if (P.x >= 0) and (P.Y >= 0) and
           (ACtl.ControlAtPos(P, true {$IFDEF VCL_5_USED}, true{$ENDIF}) = nil) then
           TWMNCHitTest(Msg).Result := HTCAPTION;
      end
      else
      begin
        P := Point(TWMNCHitTest(Msg).XPos, TWMNCHitTest(Msg).YPos);
        if PtInRect(FCaptionControl.ClientRect, FCaptionControl.ScreenToClient(P)) then
          TWMNCHitTest(Msg).Result := HTCAPTION;
      end;
  end;
  if Msg.Msg = WM_CREATE then
  begin
    // CreateRegion;
  end
  else
  if (Msg.Msg = WM_SIZE) then
  begin
    //RedoBmp(Fbmp.Canvas.Handle);
    R := Rect(0, 0, ACtl.ClientWidth, ACtl.ClientHeight);
    FNoBk := false;
    if (ACtl <> nil) and ACtl.HandleAllocated then
        InvalidateRect(ACtl.Handle, @R, true);
    CreateCacheBackground;
    Message.Msg := IFM_REPAINTCHILDREN;
    Message.wParam := 0;
    Message.lParam := 0;
    Message.Result := 0;
    ACtl.Broadcast(Message);
  end;
  if Msg.Msg = WM_ERASEBKGND then
  begin
    (*
    ADC := TWMEraseBkGnd(Msg).Dc;
    if ThemesAvailable then
    begin
      ATheme := OpenThemeData(ACtl.Handle, 'WINDOW');
      if ATheme <> 0 then
      try
        result := DrawThemeBackground(ATheme, adc, 0, 0, ACtl.ClientRect, nil);
      finally
        CloseThemeData(ATheme);
      end;
    end;
    *)
    //DrawThemeBackgroundTo('WINDOW', DC, WP_DIALOG, 0, ACtl.ClientRect, nil);
    (*
    GetClipBox(ADC, R);
    ACtl := TForm(Owner);
    if IsRectEmpty(R) then
      R := Rect(0, 0, ACtl.ClientWidth - 1, ACtl.ClientHeight - 1);
    bitblt(ADC, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, FBmp.Canvas.Handle, R.Left, R.Top, SRCCOPY);
    //ACtl.Canvas.CopyRect(R, FBmp.Canvas, R);
    Msg.Result := 1;
    Handled := true;
    *)
  end;
  if (Msg.Msg = WM_VSCROLL) or (Msg.Msg = WM_HSCROLL) then
  begin
    //RedoBmp(Fbmp.Canvas.Handle);
    if (ACtl <> nil) and ACtl.HandleAllocated then
        InvalidateRect(ACtl.Handle, nil, false);
    Message.Msg := IFM_REPAINTCHILDREN;
    Message.wParam := 0;
    Message.lParam := 0;
    Message.Result := 0;
    ACtl.Broadcast(Message);
  end;
  if (not (csDesigning in ComponentState)) and
     ((Msg.Msg = WM_NCRBUTTONDOWN) or
     (Msg.Msg = WM_NCRBUTTONUP) or
     (Msg.Msg = WM_NCRBUTTONDBLCLK) or
     (Msg.Msg = WM_NCMBUTTONDOWN) or
     (Msg.Msg = WM_NCMBUTTONUP) or
     (Msg.Msg = WM_NCMBUTTONDBLCLK)) then
  begin
    if MoveForm and (not Assigned(FCaptionControl)) then
    begin
      P := Point(Msg.lParam and $0000FFFF, Msg.lParam shr 16);
      P := ACtl.ScreenToClient(P);
      ShiftKeys := 0;
      SS := GetShiftState;
      NewMsg := WM_NULL;
      if ssCtrl in SS then
        ShiftKeys := ShiftKeys or MK_CONTROL;
      if ssShift in SS then
        ShiftKeys := ShiftKeys or MK_SHIFT;
      case Msg.Msg of
        WM_NCRBUTTONDOWN: NewMsg := WM_RBUTTONDOWN;
        WM_NCRBUTTONUP: NewMsg := WM_RBUTTONUP;
        WM_NCRBUTTONDBLCLK: NewMsg := WM_RBUTTONDBLCLK;
        WM_NCMBUTTONDOWN: NewMsg := WM_MBUTTONDOWN;
        WM_NCMBUTTONUP: NewMsg := WM_MBUTTONUP;
        WM_NCMBUTTONDBLCLK: NewMsg := WM_MBUTTONDBLCLK;
      end;
      ACtl.Perform(NewMsg, ShiftKeys, P.x or (P.y shl 16));
    end;
  end;
  if Msg.Msg = WM_PALETTECHANGED then
  begin
    //RedoBmp(Fbmp.Canvas.Handle);
    if (ACtl <> nil) and ACtl.HandleAllocated then
        InvalidateRect(ACtl.Handle, nil, true);
  end;
end;

procedure TCustomElImageForm.SetGradientStartColor(newValue : TColor);
begin
  if FGradientStartColor <> newValue then
  begin
    FGradientStartColor := newValue;
    if FBackgroundType in [bgtHorzGradient, bgtVertGradient] then
    begin
      //RedoBmp(Fbmp.Canvas.Handle);
      if (FMoveHook <> nil) and (FMoveHook.Control <> nil) then
         FMoveHook.Control.Invalidate;
    end;
  end;
end;

procedure TCustomElImageForm.SetGradientEndColor(newValue : TColor);
begin
  if FGradientEndColor <> newValue then
  begin
    FGradientEndColor := newValue;
    if FBackgroundType in [bgtHorzGradient, bgtVertGradient] then
    begin
      //RedoBmp(Fbmp.Canvas.Handle);
      if (FMoveHook <> nil) and (FMoveHook.Control <> nil) then
         FMoveHook.Control.Invalidate;
    end;
  end;
end;

procedure TCustomElImageForm.SetGradientSteps(newValue : Integer);
begin
  if FGradientSteps <> newValue then
  begin
    FGradientSteps := newValue;
    if FBackgroundType in [bgtHorzGradient, bgtVertGradient] then
    begin
      //RedoBmp(Fbmp.Canvas.Handle);
      if (FMoveHook <> nil) and (FMoveHook.Control <> nil) then
         FMoveHook.Control.Invalidate;
    end;
  end;
end;

procedure TCustomElImageForm.SetBackgroundType(newValue : TElBkGndType);
begin
  if FBackgroundType <> newValue then
  begin
    if (FBackgroundType = bgtStretchBitmap) and (newValue <> bgtStretchBitmap) then
      DisposeCacheBackground
    else
    if (FBackgroundType <> bgtStretchBitmap) and (newValue = bgtStretchBitmap) then
    begin
      FBackgroundType := newValue;
      CreateCacheBackground;
    end;
    FBackgroundType := newValue;

    //RedoBmp(Fbmp.Canvas.Handle);
    if (FMoveHook <> nil) and (FMoveHook.Control <> nil) then
        FMoveHook.Control.Invalidate;
    Change;
  end;
end;

type
  THackWinControl = class(TWinControl) end;

procedure TCustomElImageForm.PaintBkgnd(DC : HDC; R : TRect; Origin : TPoint; Direct : boolean);
var ACtl : TWinControl;
    R1   : TRect;
    Color: TColor;
    SI   : TScrollInfo;
    //ATheme: HTheme;
begin
  ACtl := GetRealControl;
  Color := THackWinControl(ACtl).Color;

  R1 := Rect(0, 0, ACtl.ClientWidth, ACtl.ClientHeight);

  if GetWindowLong(ACtl.Handle, GWL_STYLE) and WS_HSCROLL = WS_HSCROLL then
  begin
    SI.cbSize := sizeof(SI);
    SI.fMask := SIF_RANGE or SIF_POS;
    GetScrollInfo(ACtl.Handle, SB_HORZ, SI);
    if SI.nMax - SI.nMin = 0 then
      R1.Right := ACtl.ClientWidth
    else
      R1.Right := SI.nMax - SI.nMin;
    Inc(Origin.x, SI.nPos);
  end;
  if GetWindowLong(ACtl.Handle, GWL_STYLE) and WS_VSCROLL = WS_VSCROLL then
  begin
    SI.cbSize := sizeof(SI);
    SI.fMask := SIF_RANGE or SIF_POS;
    GetScrollInfo(ACtl.Handle, SB_Vert, SI);
    if SI.nMax - SI.nMin = 0 then
      R1.Bottom := ACtl.ClientHeight
    else
      R1.Bottom := SI.nMax - SI.nMin;
    Inc(Origin.y, SI.nPos);
  end;

  ACtl.Perform(IFM_EFFECTIVESIZE, 0, Integer(@R1));

  case FBackgroundType of
    bgtColorFill:
      begin
        (*
        if ThemesAvailable then
        begin
          // intentionally left blank
        end
        else
        *)
          GradientFill(DC, R, Color, Color, 0, false);
      end;
    bgtStretchBitmap:
     begin
       if (CacheBackground = nil) then
           GradientFill(DC, R, Color, Color, 0, false)
       else
       begin
         if not Direct then
           ExtDrawBkgnd2(DC, R, R1, Origin, Color, CacheBackground, bgtTileBitmap)
         else
           ExtDrawBkgnd(DC, R1, R1, R1, R1, false, Color, Color, CacheBackground, bgtTileBitmap);
       end;
     end;
    bgtTopLeftBitmap,
    bgtTileBitmap,
    bgtCenterBitmap:
      begin
        if Background.Empty then
           GradientFill(DC, R, Color, Color, 0, false)
        else
        begin
          if BackgroundType = bgtTopLeftBitmap then
          begin
            Color := FBkImage.Canvas.Pixels[FBkImage.Width-1, FBkImage.Height-1];
          end;
          if not Direct then
            ExtDrawBkgnd2(DC,  R, R1, Origin, Color, Background, BackgroundType)
          else
            ExtDrawBkgnd(DC, R1, R1, R1, R1, false, Color, Color, Background, BackgroundType);
        end;
      end;
    bgtHorzGradient,
    bgtVertGradient:
      begin
        GradientFillEx(DC, R, R1, Origin, GradientStartColor, GradientEndColor, GradientSteps, BackgroundType = bgtVertGradient);
      end;
  end;
end;

constructor TCustomElImageForm.Create(AOwner: TComponent);
begin
  inherited;
  FMoveForm := False;
  FMoveHook := nil;
  {$ifndef LINUX}
  FRegion   := 0;
  {$else}
  FRegion := nil;
  {$endif}
  FClients  := TElList.Create;
  FBMP := TBitmap.Create;
  FBkImage := TBitmap.Create;
  FBkImage.OnChange := BkImageChange;
  FBackgroundType := bgtColorFill;
  FGradientSteps := 16;
  CreateHook;
end;

procedure TCustomElImageForm.CreateHook;
begin
  if (GetRealControl <> nil) and not (csDesigning in GetRealControl.ComponentState) then
  begin
    if Assigned(FMoveHook) then FMoveHook.Free;

    FMoveHook := TElHook.Create(Self);
    FMoveHook.Control := GetRealControl;
    FMoveHook.OnBeforeProcess := BeforeMessage;
    FMoveHook.OnAfterProcess := AfterMessage;
    FMoveHook.Active := True;
  end;
end;

procedure TCustomElImageForm.CreateRegion;
begin
  {$ifndef LINUX}
  if FRegion <> 0 then DestroyRegion;
  {$else}
  if FRegion <> nil then DestroyRegion;
  {$endif}
  if Assigned(FImage) and (GetRealControl <> nil) and
     (not (csDesigning in GetRealControl.ComponentState)) and (not FImage.Picture.Bitmap.Empty) then
  begin
    FRegion := CreateBitmapRgn(FImage.Picture.Bitmap, GetTransparentColor);
    if FRegion <> 0 then
      SetWindowRgn(GetRealControl.Handle, FRegion, True);
  end;
end;

destructor TCustomElImageForm.Destroy;
begin
  DestroyHook;
  DestroyRegion;
  while FClients.Count > 0 do
    UnRegisterChanges(TImgFormChangeLink(FClients.Last));
  FClients.Free;
  FClients := nil;
  FBkImage.Free;
  FBkImage := nil;
  FBMP.Free;
  DisposeCacheBackground;
  inherited;
end;

procedure TCustomElImageForm.DestroyHook;
begin
  if not Assigned(FMoveHook) then exit;
  FMoveHook.Free;
  FMoveHook := nil;
end;

procedure TCustomElImageForm.DestroyRegion;
var ACtl : TWinControl;
begin
{$ifndef LINUX}
  if FRegion = 0 then exit;
{$else}
  if FRegion = nil then exit;
{$endif}
  ACtl := GetRealControl;
  if Assigned(ACtl) then
  begin
    if ACtl.HandleAllocated then
       SetWindowRgn(ACtl.Handle, 0, True);
    DeleteObject(FRegion);
{$ifndef LINUX}
    FRegion := 0;
{$else}
    FRegion := nil;
{$endif}
  end;
end;

function TCustomElImageForm.GetTransparentColor: TColor;
begin
  Result := clNone;
  if Assigned(FImage) and (FImage.Picture.Height > 0) and (FImage.Picture.Width > 0) then
    Result := FImage.Picture.Bitmap.Canvas.Pixels[0, FImage.Picture.Height - 1];
end;

procedure TCustomElImageForm.Loaded;
begin
  inherited;
  if FImage <> nil then
    PictureChanged(Self);
  CreateHook;
  //RedoBmp(Fbmp.Canvas.Handle);
end;

procedure TCustomElImageForm.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (AComponent = FCaptionControl) and (Operation = opRemove) then
    SetCaptionControl(nil);
  if (AComponent = Control) and (Operation = opRemove) then
    SetControl(nil);
  if (AComponent = FImage) and (Operation = opRemove) then
    SetImage(nil);
end;

procedure TCustomElImageForm.BkImageChange(Sender: TObject);
begin
  if (FBackgroundType = bgtStretchBitmap) then
    if Self.FBkImage.Empty then
      DisposeCacheBackground
    else
      CreateCacheBackground;

  //RedoBmp(Fbmp.Canvas.Handle);
  if (FMoveHook <> nil) and (FMoveHook.Control <> nil) then
      FMoveHook.Control.Invalidate;
  Change;
end;

procedure TCustomElImageForm.PictureChanged(Sender: TObject);
begin
  if Assigned(FOldImageEvent) then FOldImageEvent(Sender);
  if (ComponentState * [csReading, csLoading]) = [] then
  begin
    DestroyRegion;
    TransparentColor := GetTransparentColor;
    if FChangeRegion and not FImage.Picture.Bitmap.Empty then
      CreateRegion;
    Change;
  end;
end;

procedure TCustomElImageForm.SetCaptionControl(const Value: TGraphicControl);
begin
  if FCaptionControl <> Value then
  begin
    //if Assigned(FCaptionControl) then DestroyHook;
    FCaptionControl := Value;
    //if Assigned(FCaptionControl) {and FMoveForm }then CreateHook;
  end;
end;

procedure TCustomElImageForm.SetChangeRegion(const Value: boolean);
begin
  if FChangeRegion <> Value then
  begin
    if FChangeRegion then DestroyRegion;
    FChangeRegion := Value;
    if FChangeRegion then CreateRegion;
  end;
end;

procedure TCustomElImageForm.SetBkImage(const Value: TBitmap);
begin
  FBkImage.Assign(Value);
  //RedoBmp(Fbmp.Canvas.Handle);
  if (FMoveHook <> nil) and (FMoveHook.Control <> nil) then
     FMoveHook.Control.Invalidate;
end;

procedure TCustomElImageForm.SetImage(const Value: TImage);
begin
  if FImage <> Value then
  begin
    if Assigned(FImage) then
    begin
      {$IFDEF VCL_5_USED}
      if not (csDestroying in FImage.ComponentState) then
        FImage.RemoveFreeNotification(Self);
      {$ENDIF}
      if not (csDesigning in ComponentState) then
        FImage.Picture.OnChange := FOldImageEvent;
    end;
    if FChangeRegion then DestroyRegion;
    FImage := Value;
    if Assigned(FImage) then
    begin
      FImage.FreeNotification(Self);
      if not (csDesigning in ComponentState) then
      begin
        FOldImageEvent := FImage.Picture.OnChange;
        FImage.Picture.OnChange := PictureChanged;
      end;
    end;
    if FChangeRegion then CreateRegion;
  end;
end;

procedure TCustomElImageForm.SetMoveForm(const Value: boolean);
begin
  if FMoveForm <> Value then
  begin
    {if FMoveForm and not (csDesigning in ComponentState) and not (csLoading in ComponentState) then
      DestroyHook;
    }
    FMoveForm := Value;
    {if FMoveForm and not (csDesigning in ComponentState) and not (csLoading in ComponentState) then
      CreateHook;}
  end;
end;

procedure TCustomElImageForm.RegisterChanges(Value: TImgFormChangeLink);
begin
  Value.Sender := Self;
  if (FClients <> nil) then FClients.Add(Value);
end;

procedure TCustomElImageForm.UnRegisterChanges(Value: TImgFormChangeLink);
var
  I: Integer;
begin
  if FClients <> nil then
    for I := 0 to FClients.Count - 1 do
      if FClients[I] = Value then
      begin
        Value.Sender := nil;
        FClients.Delete(I);
        Break;
      end;
end;

procedure TCustomElImageForm.Change;
var
  I: Integer;
begin
  for I := 0 to FClients.Count - 1 do
    TImgFormChangeLink(FClients[I]).Change;
end;

procedure TCustomElImageForm.SetControl(Value: TWinControl);
begin
  if FControl <> Value then
  begin
    DestroyHook;
    DestroyRegion;
    FControl := Value;
    if not (csDestroying in ComponentState) then
    begin
      CreateRegion;
      CreateHook;
      CreateCacheBackground;
    end;
  end;
end;

function TCustomElImageForm.GetRealControl: TWinControl;
begin
  if Control = nil then
    Result := TWinControl(Owner)
  else
    Result := Control;
end;

procedure TCustomElImageForm.SetTransparentColor(Value: TColor);
begin
  if FTransparentColor <> Value then
  begin
    FTransparentColor := Value;
    if (ComponentState * [csReading, csLoading]) = [] then
    begin
      DestroyRegion;
      CreateRegion;
      Change;
    end;
  end;
end;

procedure TCustomElImageForm.CreateCacheBackground;
var AControl : TControl;
begin
  if (FBackgroundType = bgtStretchBitmap) and (not FBkImage.Empty) then
  begin
    if CacheBackground = nil then
      CacheBackground := TBitmap.Create;
    AControl := GetRealControl;
    if AControl = nil then exit;
    CacheBackground.Width := AControl.Width;
    CacheBackground.Height := AControl.Height;
    CacheBackground.Canvas.StretchDraw(Rect(0, 0, CacheBackground.Width, CacheBackground.Height), FBkimage);
  end;
end;

procedure TCustomElImageForm.DisposeCacheBackground;
begin
  if CacheBackground <> nil then
  begin
    CacheBackground.Free;
    CacheBackground := nil;
  end;
end;

destructor TImgFormChangeLink.Destroy;
begin
  if Sender <> nil then Sender.UnRegisterChanges(Self);
  inherited Destroy;
end;

procedure TImgFormChangeLink.Change;
begin
  if Assigned(OnChange) then OnChange(Sender);
end;

end.
