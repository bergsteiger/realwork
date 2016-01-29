unit fcImager;
{
//
// Components : TfcImager
//
// Copyright (c) 1999 by Woll2Woll Software
// 4/21/99 - RSW - Added CopyToClipboard method
// 8/2/99 - Check if parent is nil in BitmapChange event.
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  fcCommon, fcBitmap, fcChangeLink;

{$i fcIfDef.pas}

type
  TfcImagerDrawStyle = (dsNormal, dsCenter, dsStretch, dsTile, dsProportional);

  TfcBitmapOptions = class;

  TfcRotate = class(TPersistent)
  private
    FBitmapOptions: TfcBitmapOptions;

    FCenterX: Integer;
    FCenterY: Integer;
    FAngle: Integer;

    procedure SetAngle(Value: Integer);
    procedure SetCenterX(Value: Integer);
    procedure SetCenterY(Value: Integer);
  public
    constructor Create(BitmapOptions: TfcBitmapOptions);
  published
    property CenterX: Integer read FCenterX write SetCenterX;
    property CenterY: Integer read FCenterY write SetCenterY;
    property Angle: Integer read FAngle write SetAngle;
  end;

  TfcAlphaBlend = class(TPersistent)
  private
    FBitmapOptions: TfcBitmapOptions;

    FAmount: Byte;
    FBitmap: TfcBitmap;
    FChanging: Boolean;

    function GetTransparent: Boolean;
    procedure SetAmount(Value: Byte);
    procedure SetBitmap(Value: TfcBitmap);
    procedure SetTransparent(Value: Boolean);
  protected
    procedure BitmapChanged(Sender: TObject); virtual;
  public
    constructor Create(BitmapOptions: TfcBitmapOptions);
    destructor Destroy; override;
  published
    property Amount: Byte read FAmount write SetAmount;
    property Bitmap: TfcBitmap read FBitmap write SetBitmap;
    property Transparent: Boolean read GetTransparent write SetTransparent;
  end;

  TfcWave = class(TPersistent)
  private
    FBitmapOptions: TfcBitmapOptions;
    FXDiv, FYDiv, FRatio: Integer;
    FWrap: Boolean;

    procedure SetXDiv(Value: Integer);
    procedure SetYDiv(Value: Integer);
    procedure SetRatio(Value: Integer);
    procedure SetWrap(Value: Boolean);
  public
    constructor Create(BitmapOptions: TfcBitmapOptions);
  published
    property XDiv: Integer read FXDiv write SetXDiv;
    property YDiv: Integer read FYDiv write SetYDiv;
    property Ratio: Integer read FRatio write SetRatio;
    property Wrap: Boolean read FWrap write SetWrap;
  end;

  TfcBitmapOptions = class(TPersistent)
  private
    FComponent: TComponent;

    FAlphaBlend: TfcAlphaBlend;
    FColor: TColor;
    FContrast: Integer;
    FEmbossed: Boolean;
    FTintColor: TColor;
    FGaussianBlur: Integer;
    FGrayScale: Boolean;
    FHorizontallyFlipped: Boolean;
    FInverted: Boolean;
    FLightness: Integer;
    FRotation: TfcRotate;
    FSaturation: Integer;
    FSharpen: Integer;
    FSponge: Integer;
    FTile: Boolean;
    FVerticallyFlipped: Boolean;
    FWave: TfcWave;

    FOnChange: TNotifyEvent;
    FOrigPicture: TPicture;
    FDestBitmap: TfcBitmap;
    FUpdateLock: Integer;

    // Property Access methods;
    procedure SetColor(Value: TColor);
    procedure SetBooleanProperty(Index: Integer; Value: Boolean);
    procedure SetTintColor(Value: TColor);
    procedure SetIntegralProperty(Index: Integer; Value: Integer);
  public
    constructor Create(AComponent: TComponent);
    destructor Destroy; override;

    procedure BeginUpdate; virtual;
    procedure Changed; virtual;
    procedure EndUpdate;

    property DestBitmap: TfcBitmap read FDestBitmap write FDestBitmap;
    property OrigPicture: TPicture read FOrigPicture write FOrigPicture;
    property Tile: Boolean read FTile write FTile;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property AlphaBlend: TfcAlphaBlend read FAlphaBlend write FAlphaBlend;
    property Color: TColor read FColor write SetColor;
    property Contrast: Integer index 4 read FContrast write SetIntegralProperty;
    property Embossed: Boolean index 0 read FEmbossed write SetBooleanProperty;
    property TintColor: TColor read FTintColor write SetTintColor;
    property GaussianBlur: Integer index 3 read FGaussianBlur write SetIntegralProperty;
    property GrayScale: Boolean index 2 read FGrayScale write SetBooleanProperty;
    property HorizontallyFlipped: Boolean index 3 read FHorizontallyFlipped write SetBooleanProperty;
    property Inverted: Boolean index 1 read FInverted write SetBooleanProperty;
    property Lightness: Integer index 0 read FLightness write SetIntegralProperty;
    property Rotation: TfcRotate read FRotation write FRotation;
    property Saturation: Integer index 1 read FSaturation write SetIntegralProperty;
    property Sharpen: Integer index 5 read FSharpen write SetIntegralProperty;
    property Sponge: Integer index 2 read FSponge write SetIntegralProperty;
    property VerticallyFlipped: Boolean index 4 read FVerticallyFlipped write SetBooleanProperty;
    property Wave: TfcWave read FWave write FWave;
  end;

  TfcCustomImager = class(TGraphicControl)
  private
    { Private declarations }
    FAutoSize: Boolean;
    FBitmapOptions: TfcBitmapOptions;
    FDrawStyle: TfcImagerDrawStyle;
    FEraseBackground: Boolean;
    FPreProcess: Boolean;
    FWorkBitmap: TfcBitmap;
//    FBitmap: TfcBitmap;
    FPicture: TPicture;
    FChangeLinks: TList;

    function GetRespectPalette: Boolean;
    function GetSmoothStretching: Boolean;
    function GetTransparent: Boolean;
    function GetTransparentColor: TColor;
    procedure SetAutoSize(Value: Boolean);
//    procedure SetBitmap(Value: TfcBitmap);
    procedure SetDrawStyle(Value: TfcImagerDrawStyle);
    procedure SetEraseBackground(Value: Boolean);
    procedure SetPreProcess(Value: Boolean);
    procedure SetPicture(Value: TPicture);
    procedure SetRespectPalette(Value: Boolean);
    procedure SetSmoothStretching(Value: Boolean);
    procedure SetTransparent(Value: Boolean);
    procedure SetTransparentColor(Value: TColor);
    function GetDrawRect: TRect;
    procedure NotifyChanges;
  protected
    procedure SetParent(Value: TWinControl); override;

    procedure BitmapOptionsChange(Sender: TObject); virtual;
    procedure BitmapChange(Sender: TObject);
    procedure UpdateAutoSize; virtual;

    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure WndProc(var Message: TMessage); override;
//    procedure ParentMessages(var Message: TMessage; var ProcessMessage: Boolean); virtual;

    property EraseBackground: Boolean read FEraseBackground write SetEraseBackground default True;
  public
    UpdatingAutoSize: Boolean;
    InSetBounds: boolean;
    Patch: Variant;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function PictureEmpty: Boolean; virtual;
    procedure Invalidate; override;
    procedure RegisterChanges(ChangeLink: TfcChangeLink); virtual;
    procedure Resized; virtual;
    procedure UpdateWorkBitmap; virtual;
    procedure UnRegisterChanges(ChangeLink: TfcChangeLink); virtual;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure CopyToClipboard; virtual;

    property Align;
    property AutoSize: Boolean read FAutoSize write SetAutoSize;
    property BitmapOptions: TfcBitmapOptions read FBitmapOptions write FBitmapOptions;
    property DrawStyle: TfcImagerDrawStyle read FDrawStyle write SetDrawStyle;
    property PreProcess: Boolean read FPreProcess write SetPreProcess;
//    property Bitmap: TfcBitmap read FBitmap write SetBitmap;
    property Picture: TPicture read FPicture write SetPicture;
    property RespectPalette: Boolean read GetRespectPalette write SetRespectPalette default True;
    property SmoothStretching: Boolean read GetSmoothStretching write SetSmoothStretching;
    property Transparent: Boolean read GetTransparent write SetTransparent;
    property TransparentColor: TColor read GetTransparentColor write SetTransparentColor;
    property WorkBitmap: TfcBitmap read FWorkBitmap;
  end;

  TfcImager = class(TfcCustomImager)
  published
    { Published declarations }
    property Align;
    property AutoSize;
//    property Bitmap;
    property BitmapOptions;
    property DrawStyle;
//    property EraseBackground;
    property Picture;
    property PreProcess;
    property RespectPalette;
    property SmoothStretching;
    property Transparent;
    property TransparentColor;
    property Visible;

    {$ifdef fcDelphi4Up}
    property Anchors;
    property Constraints;
    property OnEndDock;
    property OnStartDock;
    {$endif}

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

implementation

uses clipbrd;

constructor TfcRotate.Create(BitmapOptions: TfcBitmapOptions);
begin
  inherited Create;
  FCenterX := -1;
  FCenterY := -1;
  FBitmapOptions := BitmapOptions;
end;

procedure TfcRotate.SetCenterX(Value: Integer);
begin
  if FCenterX <> Value then
  begin
    FCenterX := Value;
    FBitmapOptions.Changed;
  end;
end;

procedure TfcRotate.SetCenterY(Value: Integer);
begin
  if FCenterY <> Value then
  begin
    FCenterY := Value;
    FBitmapOptions.Changed;
  end;
end;

procedure TfcRotate.SetAngle(Value: Integer);
begin
  if FAngle <> Value then
  begin
    FAngle := Value;
    FBitmapOptions.Changed;
  end;
end;

constructor TfcAlphaBlend.Create(BitmapOptions: TfcBitmapOptions);
begin
  inherited Create;
  FBitmapOptions := BitmapOptions;
  FBitmap := TfcBitmap.Create;
//  FBitmap.OnChange := BitmapChanged;
end;

destructor TfcAlphaBlend.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

procedure TfcAlphaBlend.BitmapChanged(Sender: TObject);
begin
  if FChanging then Exit;
  FChanging := True;
  FBitmapOptions.Changed;
  FChanging := False;
end;

function TfcAlphaBlend.GetTransparent: Boolean;
begin
  result := Bitmap.Transparent;
end;

procedure TfcAlphaBlend.SetTransparent(Value: Boolean);
begin
  Bitmap.Transparent := Value;
end;

procedure TfcAlphaBlend.SetAmount(Value: Byte);
begin
  if FAmount <> Value then
  begin
    FAmount := Value;
    FBitmapOptions.Changed;
  end;
end;

procedure TfcAlphaBlend.SetBitmap(Value: TfcBitmap);
begin
  FBitmap.Assign(Value);
end;

constructor TfcWave.Create(BitmapOptions: TfcBitmapOptions);
begin
  inherited Create;
  FBitmapOptions := BitmapOptions;
end;

procedure TfcWave.SetXDiv(Value: Integer);
begin
  if FXDiv <> Value then
  begin
    FXDiv := Value;
    FBitmapOptions.Changed;
  end;
end;

procedure TfcWave.SetYDiv(Value: Integer);
begin
  if FYDiv <> Value then
  begin
    FYDiv := Value;
    FBitmapOptions.Changed;
  end;
end;

procedure TfcWave.SetRatio(Value: Integer);
begin
  if FRatio <> Value then
  begin
    FRatio := Value;
    FBitmapOptions.Changed;
  end;
end;

procedure TfcWave.SetWrap(Value: Boolean);
begin
  if FWrap <> Value then
  begin
    FWrap := Value;
    FBitmapOptions.Changed;
  end;
end;

constructor TfcBitmapOptions.Create(AComponent: TComponent);
begin
  inherited Create;
  FComponent := AComponent;

  FAlphaBlend := TfcAlphaBlend.Create(self);
  FRotation := TfcRotate.Create(self);
  FColor := clNone;
  FTintColor := clNone;
  FSaturation := -1;
  FWave := TfcWave.Create(self);
end;

destructor TfcBitmapOptions.Destroy;
begin
  FAlphaBlend.Free;
  FRotation.Free;
  FWave.Free;
  inherited;
end;

procedure TfcBitmapOptions.Changed;
var TmpBitmap: TfcBitmap;
begin
  if (csLoading in FComponent.ComponentState) or DestBitmap.Empty or ((OrigPicture.Graphic = nil) or OrigPicture.Graphic.Empty) or (FUpdateLock > 0) then Exit;
  if (DestBitmap.Width = OrigPicture.Width) and (DestBitmap.Height = OrigPicture.Height) then
    DestBitmap.Assign(OrigPicture.Graphic)
  else begin
    if Tile then fcTileDraw(OrigPicture.Graphic, DestBitmap.Canvas, Rect(0, 0, DestBitmap.Width, DestBitmap.Height))
    else begin
      TmpBitmap := TfcBitmap.Create;
      TmpBitmap.Assign(OrigPicture.Graphic);
      TmpBitmap.SmoothStretching := TfcCustomImager(FComponent).SmoothStretching;
      try
        DestBitmap.Canvas.StretchDraw(Rect(0, 0, DestBitmap.Width, DestBitmap.Height), TmpBitmap);
      finally
        TmpBitmap.Free;
      end;
    end;
  end;

  if FGrayScale then DestBitmap.GrayScale;
  if FLightness <> 0 then DestBitmap.Brightness(FLightness);
  if (FAlphaBlend.Amount <> 0) and not FAlphaBlend.Bitmap.Empty then
    DestBitmap.AlphaBlend(FAlphaBlend.Bitmap, FAlphaBlend.Amount, True);
  if FColor <> clNone then with fcGetColor(ColorToRGB(FColor)) do
    DestBitmap.Colorize(r, g, b);
  if FTintColor <> clNone then with fcGetColor(ColorToRGB(FTintColor)) do
    DestBitmap.ColorTint(r div 2, g div 2, b div 2);
  if FSponge <> 0 then DestBitmap.Sponge(FSponge);
  if FSaturation <> -1 then DestBitmap.Saturation(FSaturation);
  if FGaussianBlur <> 0 then DestBitmap.GaussianBlur(FGaussianBlur);
  if FEmbossed then DestBitmap.Emboss;
  if FInverted then DestBitmap.Invert;
  if FContrast <> 0 then DestBitmap.Contrast(FContrast);
  if FSharpen <> 0 then DestBitmap.Sharpen(FSharpen);
  if FHorizontallyFlipped then DestBitmap.Flip(True);
  if FVerticallyFlipped then DestBitmap.Flip(False);
  with FWave do if (Ratio <> 0) and (XDiv <> 0) and (YDiv <> 0) then
    DestBitmap.Wave(XDiv, YDiv, Ratio, Wrap);
  if FRotation.Angle <> 0 then with Rotation do
    DestBitmap.Rotate(Point(CenterX, CenterY), Angle);

  if Assigned(FOnChange) then FOnChange(self);
end;

procedure TfcBitmapOptions.BeginUpdate;
begin
  inc(FUpdateLock);
end;

procedure TfcBitmapOptions.EndUpdate;
begin
  if FUpdateLock > 0 then dec(FUpdateLock);
  Changed;
end;

procedure TfcBitmapOptions.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed;
  end;
end;

procedure TfcBitmapOptions.SetTintColor(Value: TColor);
begin
  if FTintColor <> Value then
  begin
    FTintColor := Value;
    Changed;
  end;
end;

procedure TfcBitmapOptions.SetIntegralProperty(Index: Integer; Value: Integer);
  procedure DoCheck(StorageVar: PInteger);
  begin
    if StorageVar^ <> Value then
    begin
      StorageVar^ := Value;
      Changed;
    end;
  end;
begin
  case Index of
    0: DoCheck(@FLightness);
    1: DoCheck(@FSaturation);
    2: DoCheck(@FSponge);
    3: DoCheck(@FGaussianBlur);
    4: DoCheck(@FContrast);
    5: DoCheck(@FSharpen);
  end;
end;

type PBoolean = ^Boolean;

procedure TfcBitmapOptions.SetBooleanProperty(Index: Integer; Value: Boolean);
  procedure DoCheck(StorageVar: PBoolean);
  begin
    if StorageVar^ <> Value then
    begin
      StorageVar^ := Value;
      Changed;
    end;
  end;
begin
  case Index of
    0: DoCheck(@FEmbossed);
    1: DoCheck(@FInverted);
    2: DoCheck(@FGrayScale);
    3: DoCheck(@FHorizontallyFlipped);
    4: DoCheck(@FVerticallyFlipped);
  end;
end;

constructor TfcCustomImager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  FBitmap := TfcBitmap.Create;
//  FBitmap.OnChange := BitmapChange;
  FEraseBackground:= True;
  FPicture := TPicture.Create;
  FPicture.OnChange := BitmapChange;
  FWorkBitmap := TfcBitmap.Create;
  FWorkBitmap.RespectPalette := True;
  FBitmapOptions := TfcBitmapOptions.Create(self);
  FBitmapOptions.OnChange := BitmapOptionsChange;
  FBitmapOptions.DestBitmap := FWorkBitmap;
  FBitmapOptions.OrigPicture := FPicture;
  ControlStyle := ControlStyle + [csOpaque];
  FPreProcess := True;
  FChangeLinks := TList.Create;
  Width := 100;
  Height := 100;
end;

destructor TfcCustomImager.Destroy;
begin
  FPicture.Free;
  FPicture:= nil;
  FBitmapOptions.Free;
  FWorkBitmap.Free;
  FChangeLinks.Free;
  inherited Destroy;
end;

function TfcCustomImager.GetDrawRect: TRect;
begin
  case DrawStyle of
    dsNormal: result := Rect(0, 0, Picture.Width, Picture.Height);
    dsCenter: with Point(Width div 2 - FWorkBitmap.Width div 2,
        Height div 2 - FWorkBitmap.Height div 2) do
      result := Rect(x, y, Width - x, Height - y);
    dsTile, dsStretch: result := Rect(0, 0, Width, Height);
    dsProportional: result := fcProportionalRect(Rect(0, 0, Width, Height), FWorkBitmap.Width, FWorkBitmap.Height);
  end
end;

procedure TfcCustomImager.SetDrawStyle(Value: TfcImagerDrawStyle);
begin
  if FDrawStyle <> Value then
  begin
    FDrawStyle := Value;
    BitmapOptions.Tile := FDrawStyle = dsTile;
    Resized;
    Invalidate;
  end;
end;

procedure TfcCustomImager.SetEraseBackground(Value: Boolean);
var r: TRect;
begin
  if FEraseBackground <> Value then
  begin
    FEraseBackground := Value;
    if Parent <> nil then begin
       r:= BoundsRect;
       InvalidateRect(Parent.Handle, @r, True);
//       Parent.Invalidate;
    end
  end;
end;

procedure TfcCustomImager.SetParent(Value: TWinControl);
begin
  inherited;
end;

procedure TfcCustomImager.BitmapOptionsChange(Sender: TObject);
var r: TRect;
begin
  if Parent <> nil then
  begin
    r := BoundsRect;
    InvalidateRect(Parent.Handle, @r, Transparent);
  end;
  NotifyChanges;
end;

procedure TfcCustomImager.NotifyChanges;
var i: Integer;
begin
  for i := 0 to FChangeLinks.Count - 1 do with TfcChangeLink(FChangeLinks[i]) do
  begin
    Sender := WorkBitmap;
    Change;
  end;
end;

procedure TfcCustomImager.BitmapChange(Sender: TObject);
var r: TRect;
begin
  Resized;
  r := BoundsRect;
  if Parent<>nil then { 8/2/99 }
     InvalidateRect(Parent.Handle, @r, True);
  NotifyChanges;
end;

procedure TfcCustomImager.Resized;
begin
//  if (not InSetBounds) and EraseBackground and not Transparent and not PictureEmpty and not WorkBitmap.Empty and (Parent <> nil) then
//    SendMessage(Parent.Handle, WM_ERASEBKGND, Canvas.Handle, 0);
  if csLoading in ComponentState then Exit;
  if not PreProcess and not (DrawStyle in [dsNormal, dsCenter]) then
    FWorkBitmap.SetSize(Width, Height)
  else FWorkBitmap.SetSize(Picture.Width, Picture.Height);
  UpdateWorkBitmap;
  UpdateAutoSize;
end;

procedure TfcCustomImager.UpdateAutoSize;
begin
  if FAutoSize and not PictureEmpty and not (csLoading in ComponentState) and (Align = alNone) then
  begin
    UpdatingAutosize := True;
{    if DrawStyle = dsProportional then
    begin
      with fcProportionalRect(Rect(0, 0, Width, Height), Bitmap.Width, Bitmap.Height) do
        if (Width <> Right - Left) or (Height <> Bottom - Top) then
          SetBounds(self.Left, self.Top, self.Left + (Right - Left), self.Top + (Bottom - Top))
    end else }if (Width <> Picture.Width) or (Height <> Picture.Height) then
      SetBounds(Left, Top, Picture.Width, Picture.Height);
    UpdatingAutosize := False;
  end;
end;

procedure TfcCustomImager.UpdateWorkBitmap;
begin
  if not PictureEmpty and not (csLoading in ComponentState) then
  begin
    if FWorkBitmap.Empty then Resized;
    BitmapOptions.Changed;
  end;
end;

procedure TfcCustomImager.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TfcCustomImager.SetPreProcess(Value: Boolean);
begin
  if FPreProcess <> Value then
  begin
    FPreProcess := Value;
    Resized;
  end;
end;

procedure TfcCustomImager.SetTransparent(Value: Boolean);
begin
  if not PictureEmpty then Picture.Graphic.Transparent := Value;
  Invalidate;
end;

procedure TfcCustomImager.SetTransparentColor(Value: TColor);
begin
  WorkBitmap.TransparentColor := Value;
  UpdateWorkBitmap;
  Invalidate;
  ColorToString(clNone);
end;

function TfcCustomImager.GetRespectPalette;
begin
  result := WorkBitmap.RespectPalette;
end;

function TfcCustomImager.GetSmoothStretching: Boolean;
begin
  result := WorkBitmap.SmoothStretching;
end;

function TfcCustomImager.GetTransparent: Boolean;
begin
  result := False;
  if not PictureEmpty then result := Picture.Graphic.Transparent;
end;

function TfcCustomImager.GetTransparentColor: TColor;
begin
  result := WorkBitmap.TransparentColor;
end;

procedure TfcCustomImager.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    UpdateAutoSize;
  end;
end;
{
procedure TfcCustomImager.SetBitmap(Value: TfcBitmap);
begin
  FBitmap.Assign(Value);
end;
}

function TfcCustomImager.PictureEmpty: Boolean;
begin
  result := (FPicture=Nil) or (FPicture.Graphic = nil) or (FPicture.Graphic.Empty);
end;

procedure TfcCustomImager.Invalidate;
var r: TRect;
begin
  if InSetBounds then exit;
  r := BoundsRect;
  if Parent <> nil then InvalidateRect(Parent.Handle, @r, True);
end;

procedure TfcCustomImager.RegisterChanges(ChangeLink: TfcChangeLink);
begin
  FChangeLinks.Add(ChangeLink);
end;

procedure TfcCustomImager.UnRegisterChanges(ChangeLink: TfcChangeLink);
begin
  FChangeLinks.Remove(ChangeLink);
end;

procedure TfcCustomImager.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var SizeChanged: Boolean;
    OldControlStyle: TControlStyle;
begin
  SizeChanged := (AWidth <> Width) or (AHeight <> Height);
  if SizeChanged and not UpdatingAutosize then begin
     InSetBounds:= True; { RSW - Don't erase background when resizing }
     { 5/7/99 - Setting parent to opaque so it doesn't clear background.
       This allows imager to not flicker when resizing imager }
     if Parent<>nil then
     begin
        OldControlStyle:= Parent.ControlStyle;
        Parent.ControlStyle:= Parent.ControlStyle + [csOpaque];
     end;
     inherited;
     if Parent<>nil then Parent.ControlStyle:= OldControlStyle;
     if Visible then Update;
     Resized;
     InSetBounds:= False;
  end
  else inherited;
end;

procedure TfcCustomImager.SetRespectPalette(Value: Boolean);
begin
  WorkBitmap.RespectPalette := Value;
  Invalidate;
end;

procedure TfcCustomImager.SetSmoothStretching(Value: Boolean);
begin
  WorkBitmap.SmoothStretching := Value;
  UpdateWorkBitmap;
  Invalidate;
end;

procedure TfcCustomImager.Paint;
begin
  inherited;
  if csDestroying in ComponentState then exit;

  if FWorkBitmap.Empty and not PictureEmpty then
  begin
    UpdateWorkBitmap;
    Exit;
  end;

  if (csDesigning in ComponentState) and FWorkBitmap.Empty then with Canvas do
  begin
    Pen.Style := psDash;
    Pen.Color := clBlack;
    Brush.Color := clWhite;
    Rectangle(0, 0, Width, Height);
    Exit;
  end;
  if FWorkBitmap.Empty then Exit;

  try
    with GetDrawRect do
      if PreProcess then
        case DrawStyle of
          dsNormal: Canvas.Draw(Left, Top, FWorkBitmap);
          dsCenter: Canvas.Draw(Left, Top, FWorkBitmap);
          dsTile: FWorkBitmap.TileDraw(Canvas, Rect(Left, Top, Right, Bottom));
          dsStretch: Canvas.StretchDraw(Rect(Left, Top, Right, Bottom), FWorkBitmap);
          dsProportional: Canvas.StretchDraw(Rect(Left, Top, Right, Bottom), FWorkBitmap);
        end
      else Canvas.Draw(Left, Top, FWorkBitmap);
  finally
{    if Transparent then fcTransparentDraw(Canvas, Rect(0, 0, Width, Height), DrawBitmap, DrawBitmap.Canvas.Pixels[0, 0])
    else Canvas.Draw(0, 0, DrawBitmap);}
  end;
end;

(*procedure TfcCustomImager.ParentMessages(var Message: TMessage; var ProcessMessage: Boolean);
var s: TfcCustomImager;
begin
  if csDestroying in ComponentState then exit;

  if not PictureEmpty and ((not EraseBackground) or InSetBounds) and
{     not (csDesigning in ComponentState) and}  { 4/27/99 - Comment out - RSW }
     (Message.Msg = WM_ERASEBKGND) then//and not (DrawStyle in [dsNormal, dsProportional]) {and (Align = alClient) }then { 3/19/99 - Comment out alClient to prevent flicker of form}
  begin
    with TWMEraseBkGnd(Message) do
    begin
      Result := 1;
      ProcessMessage := False;
    end;
  end
end;
*)
procedure TfcCustomImager.Loaded;
begin
  inherited;
  UpdateAutoSize;
  FBitmapOptions.Changed;
end;

procedure TfcCustomImager.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
end;

procedure TfcCustomImager.CopyToClipboard;
var tempBitmap: TBitmap;
begin
   tempBitmap:= TBitmap.create;
   WorkBitmap.SaveToBitmap(tempBitmap);
   Clipboard.Assign(tempBitmap);
   tempBitmap.Free;
end;

procedure TfcCustomImager.WndProc(var Message: TMessage);
begin
  inherited;
end;

(*var Hook: HHOOK = 0;

function CallWndProc(code: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var  p: PCWPStruct;
begin
  result := CallNextHookEx(Hook, code, wParam, lParam);
  if wParam<>0 then
  begin
     p:= PCWPStruct(lParam);
     if (p.message= WM_ERASEBKGND) {and
        (p.hwnd=MonitorHandle) }then result:= 0;
  end

end;

initialization
//  Hook := SetWindowsHookEx(WH_CALLWNDPROC, @CallWndProc, 0, GetCurrentThreadID);
finalization
//  UnhookWindowsHookEx(Hook);
*)
end.
