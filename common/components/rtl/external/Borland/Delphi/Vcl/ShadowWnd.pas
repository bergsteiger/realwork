
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{  Copyright (c) 1995-2002 Borland Software Corporation }
{                                                       }
{ NOTE: On Windows XP and later includes a class style  }
{       (CS_DROPSHADOW) which can be specified in the   }
{       CreateParams method of a TWinControl class to   }
{       render the same effect as although depending on }
{       the video card this class may be significantly  }
{       faster.                                         }
{                                                       }
{*******************************************************}

unit ShadowWnd;

interface

uses Windows, Messages, Classes, Controls, Forms, Graphics;

type

{ TShadowWindow }

  TControlSide = (csRight, csBottom);

  TShadowWindow = class(TCustomControl)
  private
    FRGB: COLORREF;
    H,L,S: Word;
    FCachedFade: Integer;
    FCachedclr: COLORREF;
    FCachedHue,
    FCachedSat,
    FCachedLum: Word;
    FControl: TControl;
    FDesktop: TBitmap;
    FSide: TControlSide;
    procedure SetControl(const Value: TControl);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd);
      message WM_ERASEBKGND;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateShadow(AOwner: TComponent; ControlSide: TControlSide); virtual;
    destructor Destroy; override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer;
      AHeight: Integer); override;
    property Control: TControl read FControl write SetControl;
    property Side: TControlSide read FSide write FSide;
  end;

implementation

uses SysUtils, Contnrs, GraphUtil;

const
  Darkness = 58;  //Darkness of the shadow

{ TShadowWindow }

constructor TShadowWindow.Create(AOwner: TComponent);
begin
  inherited;
  Side := csRight;
  FDeskTop := TBitmap.Create;
  FDesktop.HandleType := bmDDB;
  FDesktop.PixelFormat := pf24bit;
  Hide;
  FCachedclr := 0;
  FCachedFade := 0;  
  ParentWindow := Forms.Application.Handle;
end;

constructor TShadowWindow.CreateShadow(AOwner: TComponent;
  ControlSide: TControlSide);
begin
  Create(AOwner);
  Side := ControlSide;
end;

destructor TShadowWindow.Destroy;
begin
  FDeskTop.Free;
  inherited;
end;

procedure TShadowWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    if ParentWindow <> 0 then
      Style := Style and not WS_CHILD or WS_POPUP or WS_OVERLAPPED;
    WindowClass.Style := CS_SAVEBITS or CS_DBLCLKS or not (CS_HREDRAW or not CS_VREDRAW);
    ExStyle := ExStyle or WS_EX_TOPMOST;
  end;
end;

procedure TShadowWindow.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FControl) then
  begin
    FControl := nil;
    Visible := False;
  end;
end;

procedure TShadowWindow.Paint;
begin
  inherited Paint;
  Canvas.StretchDraw(Rect(0,0,Width,Height), FDeskTop);
end;

procedure TShadowWindow.SetControl(const Value: TControl);
var
  Pt: TPoint;
begin
  if Assigned(FControl) then
    FControl.RemoveFreeNotification(Self);
  FControl := Value;
  if not Assigned(FControl) then exit;
  FControl.FreeNotification(Self);
  Pt := FControl.BoundsRect.TopLeft;
  if FControl.Parent <> nil then
    Pt := FControl.ClientToScreen(FControl.ClientRect.TopLeft);
  Hide;
  case FSide of
    csRight: SetBounds(Pt.X + Control.Width, Pt.Y + 4, 4, Control.Height - 4);
    csBottom: SetBounds(Pt.X + 4, Pt.Y + Control.Height, Control.Width, 4);
  end;
  Show;
end;

procedure TShadowWindow.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 0;
end;

const
  MaxPixels = 4096;
  IntensityCutoff = 140;

type
  PRGBTripleArray = ^TRGBTripleArray;
  TRGBTripleArray = array[0..MaxPixels - 1] of TRGBTriple;

procedure TShadowWindow.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);

  procedure CalcShadowColor(var RGBTriple: TRGBTriple; FadeValue: Integer);
  var
    Clr: TColor;
  begin
    Clr := ColorHLSToRGB(H, L + FadeValue, S);
    RGBTriple.rgbtBlue := GetBValue(Clr);
    RGBTriple.rgbtGreen := GetGValue(Clr);
    RGBTriple.rgbtRed := GetRValue(Clr);
  end;

  procedure ColorRGBToHLS(clrRGB: COLORREF; var Hue, Luminance, Saturation: Word);
  begin
    if clrRGB = FCachedclr then
    begin
      Hue := FCachedHue;
      Luminance := FCachedLum;
      Saturation := FCachedSat;
    end
    else
    begin
      GraphUtil.ColorRGBToHLS(clrRGB, Hue, Luminance, Saturation);
      FCachedHue := Hue;
      FCachedLum := Luminance;
      FCachedSat := Saturation;
      FCachedclr := clrRGB;
    end;
  end;

var
  DC: HDC;
  X, Y: Integer;
  RGBArray: PRGBTripleArray;
begin
  inherited;
  if Visible then exit;
  FDeskTop.Width := Width;
  FDeskTop.Height := Height;
  DC := GetDC(GetDeskTopWindow);
  try
    BitBlt(FDeskTop.Canvas.Handle, 0, 0, Width, Height, DC, Left, Top, SRCCOPY);
  finally
    ReleaseDC(GetDeskTopWindow, DC);
  end;
  case Side of
    csRight:
      for Y := 0 to Height - 1 do
      begin
        RGBArray  := FDeskTop.Scanline[Y];
        for X := 0 to Width - 1 do
        begin
            if Y - X < 0 then continue;
            with RGBArray[X] do
            begin
              FRGB := RGB(rgbtRed, rgbtGreen, rgbtBlue);
              ColorRGBToHLS(FRGB, H, L, S);
            end;
            if L < Darkness then Continue;
              if (Y <= Width) then
                CalcShadowColor(RGBArray[X], -Darkness + (X * 15) + (Width - Y) * 10)
              else if (Y >= Height) then
                CalcShadowColor(RGBArray[X], -Darkness - ((Width - X) * 15) - ((Height - 8)- Y) * 15)
              else
                CalcShadowColor(RGBArray[X], -Darkness + X * 15);
        end;
      end;
    csBottom:
      for Y := 0 to Height - 1 do
      begin
        RGBArray  := FDeskTop.Scanline[Y];
        for X := Y to Width - 1 - Y do
        begin
          with RGBArray[X] do
          begin
            FRGB := RGB(rgbtRed, rgbtGreen, rgbtBlue);
            ColorRGBToHLS(FRGB, H, L, S);
          end;
          if L < Darkness then Continue;
            if (X <= Height) then
              CalcShadowColor(RGBArray[X], -Darkness + (Y * 15) + (Height - X) * 10)
            else if (X >= Width - Height) then
              CalcShadowColor(RGBArray[X], -Darkness - ((Height - Y) * 15) - ((Width - 8)- X) * 15)
            else
              CalcShadowColor(RGBArray[X], -Darkness + Y * 15);
        end;
      end;
  end;
end;

end.
