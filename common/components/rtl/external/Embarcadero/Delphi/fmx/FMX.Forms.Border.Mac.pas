{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Forms.Border.Mac;

interface

uses
  System.TypInfo, System.Math, System.Classes, System.SysUtils, System.Types,
  System.UITypes, Macapi.QuartzCore, Macapi.CoreGraphics, Macapi.Foundation,
  Macapi.CocoaTypes, Macapi.AppKit,
  FMX.Types, FMX.Types3D, System.Generics.Collections,
  FMX.ActnList, FMX.Messages, FMX.Styles, FMX.Controls, FMX.Forms,
  FMX.StdCtrls, FMX.Forms.Border;

{$SCOPEDENUMS ON}

type

  TWindowBorderCocoa = class(TStyledWindowBorder)
  private
    FBuffer: TBitmap;
  protected
    function GetCanvas: TCanvas; override;
    procedure Resize; override;
    procedure Invalidate; override;
    procedure DoApplyStyle; override;
    procedure StyleChanged; override;
    function GetStyleLookup: string; override;
  public
    constructor Create(const AForm: TCommonCustomForm); override;
    destructor Destroy; override;
    procedure Paint(Ctx: CGContextRef);
  end;

function CreateWindowBorder(const AForm: TCommonCustomForm): TWindowBorder;

implementation

uses
  FMX.Platform, FMX.Menus, FMX.Filter, FMX.TextLayout, FMX.Text,
  FMX.Objects, FMX.Platform.Mac;

const
  CaptionHeight = 23;

type
  TOpenControl = class(TControl);

constructor TWindowBorderCocoa.Create(const AForm: TCommonCustomForm);
begin
  inherited;
  FBuffer := TBitmap.Create(AForm.Width, CaptionHeight);
end;

destructor TWindowBorderCocoa.Destroy;
begin
  FreeAndNil(FBuffer);
  inherited;
end;

function TWindowBorderCocoa.GetCanvas: TCanvas;
begin
  Result := FBuffer.Canvas;
end;

function TWindowBorderCocoa.GetStyleLookup: string;
begin
  Result := 'macborderstyle';
end;

procedure TWindowBorderCocoa.DoApplyStyle;
begin
  inherited;
  if Assigned(FCloseObject) then
    FCloseObject.Visible := False;
  if Assigned(FMaxObject) then
    FMaxObject.Visible := False;
  if Assigned(FMinObject) then
    FMinObject.Visible := False;
  if Assigned(FResObject) then
    FResObject.Visible := False;
  if Assigned(FIconObject) then
    FIconObject.Visible := False;
end;

procedure TWindowBorderCocoa.StyleChanged;
begin
  inherited;
  Invalidate;
end;

procedure TWindowBorderCocoa.Paint(Ctx: CGContextRef);
var
  I: Integer;
  Control: TControl;
  ColorSpace: CGColorSpaceRef;
  M: TBitmapData;
  Bmp: CGContextRef;
  Img: CGImageRef;
  R: NSRect;
begin
  if FDisableAlign then Exit;
  if not Assigned(FResourceLink) then Exit;
  FDisableAlign := True;
  if Assigned(FTitleObject) and (FTitleObject is TText) then
    TText(FTitleObject).Text := Form.Caption;
  if FBuffer.Canvas.BeginScene(nil) then
  try
    FBuffer.Canvas.Clear(0);
    for I := 0 to ChildrenCount - 1 do
      if (Children[I] is TControl) and ((TControl(Children[I]).Visible) or
          (not TControl(Children[I]).Visible and (csDesigning in ComponentState) and not TControl(Children[I]).Locked)) then
      begin
        Control := TControl(Children[I]);
        if (csDesigning in Control.ComponentState) and not Control.DesignVisible then
          Continue;
        if Control.UpdateRect.IsEmpty then
          Continue;
        TOpenControl(Control).PaintInternal;
      end;
  finally
    FBuffer.Canvas.EndScene;
    FDisableAlign := False;
  end;
  // Paint to context
  if FBuffer.Map(TMapAccess.maRead, M) then
  try
    ColorSpace := CGColorSpaceCreateDeviceRGB;
    Bmp := CGBitmapContextCreate(M.Data, FBuffer.Width, FBuffer.Height, 8, FBuffer.Width * 4, ColorSpace, kCGImageAlphaPremultipliedLast);
    Img := CGBitmapContextCreateImage(Bmp);

    R.origin.x := 0;
    R.origin.y := -Round(FBuffer.Height / IScene(Self).GetSceneScale);
    R.size.width := Round(FBuffer.Width / IScene(Self).GetSceneScale);
    R.size.height := Round(FBuffer.Height / IScene(Self).GetSceneScale);
    CGContextDrawImage(Ctx, R, Img);

    CGImageRelease(Img);
    CGContextRelease(Bmp);
    CGColorSpaceRelease(ColorSpace);
  finally
    FBuffer.Unmap(M);
  end;
end;

procedure TWindowBorderCocoa.Invalidate;
var
  R: NSRect;
  Wnd: NSWindow;
  View: Pointer;
  AutoReleasePool: NSAutoreleasePool;
begin
  AutoReleasePool := TNSAutoreleasePool.Create;
  try
    Wnd := WindowHandleToPlatform(Form.Handle).Wnd;
    View := Wnd.contentView;
    if Assigned(View)  then
      View := TNSView.Wrap(View).superview;
    if Assigned(View)  then
    begin
      R := TNSView.Wrap(View).frame;
      R.origin.x := 0;
      R.origin.y := R.size.height - 23;
      R.size.height := 23;
      TNSView.Wrap(View).setNeedsDisplayInRect(R);
    end;
  finally
    AutoReleasePool.release;
  end;
end;

procedure TWindowBorderCocoa.Resize;
begin
  IBitmapAccess(FBuffer).BitmapScale := IScene(Self).GetSceneScale;
  FBuffer.SetSize(Round(Form.Width * IScene(Self).GetSceneScale), Round(CaptionHeight * IScene(Self).GetSceneScale));
end;

function CreateWindowBorder(const AForm: TCommonCustomForm): TWindowBorder;
begin
  Result := TWindowBorderCocoa.Create(AForm);
end;

end.
