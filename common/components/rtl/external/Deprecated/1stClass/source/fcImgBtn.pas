unit fcImgBtn;
{
//
// Components : TfcImageBtn
//
// Copyright (c) 1999 by Woll2Woll Software
}

interface

{$i fcIfDef.pas}

uses Windows, Messages, Classes, Controls, Forms, Graphics, StdCtrls,
  CommCtrl, Buttons, Dialogs, Math, Consts, SysUtils, fcCommon, fcText,
  fcButton, fcBitmap, fcChangeLink, fcImager
  {$ifdef fcDelphi4up}
  ,ImgList, ActnList
  {$endif};

type
  TfcDitherStyle = (dsDither, dsBlendDither, dsFill);

  TfcImgDownOffsets = class(TfcOffsets)
  private
    FImageDownX: Integer;
    FImageDownY: Integer;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(AControl: TfcCustomBitBtn);
  published
    property ImageDownX: Integer read FImageDownX write FImageDownX default 2;
    property ImageDownY: Integer read FImageDownY write FImageDownY default 2;
  end;

  TfcCustomImageBtn = class (TfcCustomBitBtn)
  private
    // Property Storage Variables
    FDitherColor: TColor;
    FDitherStyle: TfcDitherStyle;
    FImage: TfcBitmap;
    FImageDown: TfcBitmap;
    FImageChangeLink: TfcChangeLink;
    FExtImage: TComponent;
    FExtImageDown: TComponent;
    FTransparentColor: TColor;

    // Property Access Methods
    function GetOffsets: TfcImgDownOffsets;
    function GetParentClipping: Boolean;
    function GetRespectPalette: Boolean;
    procedure SetDitherColor(Value: TColor);
    procedure SetDitherStyle(Value: TfcDitherStyle);
    procedure SetExtImage(Value: TComponent);
    procedure SetExtImageDown(Value: TComponent);
    procedure SetImage(Value: TfcBitmap);
    procedure SetImageDown(Value: TfcBitmap);
    procedure SetOffsets(Value: TfcImgDownOffsets);
    procedure SetParentClipping(Value: Boolean);
    procedure SetRespectPalette(Value: Boolean);
    procedure SetTransparentColor(Value: TColor);
  protected
    procedure Draw3DLines(SrcBitmap, DstBitmap: TfcBitmap; TransColor: TColor; Down: Boolean);

    procedure SetExtImages(Value: TComponent; var Prop: TComponent);

    // Virtual Methods
    procedure WndProc(var Message: TMessage); override;
    function CreateRegion(DoImplementation: Boolean; Down: Boolean): HRgn; override;
    function CreateOffsets: TfcOffsets; override;
    function GetTransparentColor(Down: Boolean): TColor;
    function ObtainImage(DownImage: Boolean): TfcBitmap; virtual;
    function StoreRegionData: Boolean; override;
    procedure AssignTo(Dest: TPersistent); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure GetSizedImage(SourceBitmap: TfcBitmap; DestBitmap: TfcBitmap;
      ShadeStyle: TfcShadeStyle; ForRegion: Boolean); virtual;
    procedure ImageChanged(Sender: TObject); virtual;
    procedure ExtImageDestroying(Sender: TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function UseRegions: boolean; override;

  public
    Patch: Variant;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function ColorAtPoint(APoint: TPoint): TColor; virtual;
    function IsMultipleRegions: Boolean; override;
    procedure GetDrawBitmap(DrawBitmap: TfcBitmap; ForRegion: Boolean;
      ShadeStyle: TfcShadeStyle; Down: Boolean); override;
    procedure SplitImage; virtual;
    procedure SizeToDefault; override;

    // Public Properties
    property DitherColor: TColor read FDitherColor write SetDitherColor;
    property DitherStyle: TfcDitherStyle read FDitherStyle write SetDitherStyle;
    property ExtImage: TComponent read FExtImage write SetExtImage;
    property ExtImageDown: TComponent read FExtImageDown write SetExtImageDown;
    property Image: TfcBitmap read FImage write SetImage;
    property ImageDown: TfcBitmap read FImageDown write SetImageDown;
    property Offsets: TfcImgDownOffsets read GetOffsets write SetOffsets;
    property ParentClipping: Boolean read GetParentClipping write SetParentClipping;
    property RespectPalette: Boolean read GetRespectPalette write SetRespectPalette default False;
    property TransparentColor: TColor read FTransparentColor write SetTransparentColor;
  end;

  TfcImageBtn = class(TfcCustomImageBtn)
  published
    {$ifdef fcDelphi4Up}
    property Action;
    property Anchors;
    property Constraints;
    {$endif}
    property AllowAllUp;
    property Cancel;
    property Caption;
    property Color;
    property Default;
    property DitherColor;
    property DitherStyle;
    property DragCursor;   //3/31/99 - PYW - Exposed DragCursor and DragKind properties.
    {$ifdef fcDelphi4Up}
    property DragKind;
    {$endif}
    property DragMode;
    property Down;
    property Font;
    property Enabled;
    property ExtImage;
    property ExtImageDown;
    property Glyph;
    property GroupIndex;
    property Image;
    property ImageDown;
    property Kind;
    property Layout;
    property Margin;
    property ModalResult;
    property NumGlyphs;
    property Offsets;
    property Options;
    property ParentClipping;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property RespectPalette;
    property ShadeColors;
    property ShadeStyle;
    property ShowHint;
    {$ifdef fcDelphi4Up}
    property SmoothFont;
    {$endif}
    property Style;
    property Spacing;
    property TabOrder;
    property TabStop;
    property TextOptions;
    property TransparentColor;
    property Visible;

    property OnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnSelChange;
    property OnStartDrag;
  end;

implementation

{$r-}

constructor TfcImgDownOffsets.Create(AControl: TfcCustomBitBtn);
begin
  inherited;
  FImageDownX := 2;
  FImageDownY := 2;
end;

procedure TfcImgDownOffsets.AssignTo(Dest: TPersistent);
begin
  if Dest is TfcImgDownOffsets then
    with Dest as TfcImgDownOffsets do
  begin
    ImageDownX := self.ImageDownX;
    ImageDownY := self.ImageDownY;
  end;
  inherited;
end;

constructor TfcCustomImageBtn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDitherColor := clWhite;
  FImage := TfcBitmap.Create;
  FImage.OnChange := ImageChanged;
  FImageDown := TfcBitmap.Create;
  FImageDown.OnChange := ImageChanged;
  FTransparentColor := clNone;
  FImageChangeLink := TfcChangeLink.Create;
  FImageChangeLink.OnChange := ImageChanged;
  Color := clNone;
end;

destructor TfcCustomImageBtn.Destroy;
begin
  FImage.Free;
  FImageDown.Free;
  FImageChangeLink.Free;
  inherited Destroy;
end;

function TfcCustomImageBtn.IsMultipleRegions: Boolean;
begin
  result := (not ObtainImage(False).Empty and not ObtainImage(True).Empty) or (ShadeStyle = fbsRaised);
  if result and (FTransparentColor=clNullColor) then result:= false;
end;

function TfcCustomImageBtn.StoreRegionData: Boolean;
begin
  result := True;
end;

// Added Down parameter to fix bug. - 4/6/99

function TfcCustomImageBtn.GetTransparentColor(Down: Boolean): TColor;
begin
  if FTransparentColor <> clNullColor then
  begin
    if FTransparentColor = clNone then
    begin
      if Down and not ObtainImage(True).Empty then
        result := fcGetStdColor(ObtainImage(True).Pixels[0, 0])
      else result:= fcGetStdColor(ObtainImage(False).Pixels[0, 0]);
      result := ColorToRGB(result) and $00FFFFFF;
    end else result := FTransparentColor;
  end else result := clNullColor;
end;

function TfcCustomImageBtn.ObtainImage(DownImage: Boolean): TfcBitmap;
begin
  if (not DownImage and (FExtImage <> nil)) and not (csDestroying in FExtImage.ComponentState) then
  begin
    result := Image;
    if FExtImage is TfcCustomImager then with FExtImage as TfcCustomImager do
    begin
      if WorkBitmap.Empty and not PictureEmpty then Resized;
      result := WorkBitmap;
    end else if FExtImage is TfcCustomImageBtn then with FExtImage as TfcCustomImageBtn do
      result := Image;
  end else if DownImage and (FExtImageDown <> nil) and not (csDestroying in FExtImageDown.ComponentState) then
  begin
    result := ImageDown;
    if FExtImageDown is TfcCustomImager then with FExtImageDown as TfcCustomImager do
    begin
      if WorkBitmap.Empty and not PictureEmpty then Resized;
      result := WorkBitmap;
    end else if FExtImageDown is TfcCustomImageBtn then with FExtImageDown as TfcCustomImageBtn do
      result := ImageDown;
  end else if DownImage then result := ImageDown
  else result := Image;
end;

function TfcCustomImageBtn.CreateOffsets: TfcOffsets;
begin
  result := TfcImgDownOffsets.Create(self);
end;

function TfcCustomImageBtn.CreateRegion(DoImplementation: Boolean; Down: Boolean): HRgn;
var SizedImage: TfcBitmap;
    Rgn: HRGN;
begin
  if TransparentColor = clNullColor then
  begin
    result := 0;
    Exit;
  end;

  result := inherited CreateRegion(False, Down);
  if not DoImplementation or (result <> 0) or ObtainImage(False).Empty then Exit;

  SizedImage := TfcBitmap.Create;
  SizedImage.RespectPalette := RespectPalette;
  GetSizedImage(ObtainImage(Down and not ObtainImage(True).Empty), SizedImage, ShadeStyle, True);

  result := fcRegionFromBitmap(SizedImage, GetTransparentColor(Down));

  if ShadeStyle = fbsRaised then
  begin
    Rgn := CreateRectRgn(0, 0, 10, 10);
    if CombineRgn(Rgn, result, 0, RGN_COPY) = ERROR then Exit;
    OffsetRgn(Rgn, 2, 2);
    if Down then CombineRgn(result, Rgn, 0, RGN_COPY)
    else CombineRgn(result, Rgn, result, RGN_OR);
    DeleteObject(Rgn);
  end;

  SizedImage.Free;

  SaveRegion(result, Down);
end;

procedure TfcCustomImageBtn.SetDitherColor(Value: TColor);
begin
  if FDitherColor <> Value then
  begin
    FDitherColor := Value;
    Invalidate;
  end;
end;

procedure TfcCustomImageBtn.SetDitherStyle(Value: TfcDitherStyle);
begin
  if FDitherStyle <> Value then
  begin
    FDitherStyle := Value;
    Invalidate;
  end;
end;

procedure TfcCustomImageBtn.SetImage(Value: TfcBitmap);
begin
  if Value <> nil then ExtImage := nil;
  FImage.Assign(Value);
  if not Down or ObtainImage(True).Empty then RecreateWnd;
end;

procedure TfcCustomImageBtn.SetImageDown(Value: TfcBitmap);
begin
  if Value <> nil then ExtImageDown := nil;
  FImageDown.Assign(Value);
  if Down then RecreateWnd;
end;

procedure TfcCustomImageBtn.SetExtImages(Value: TComponent; var Prop: TComponent);
begin
  if Prop <> nil then
  begin
    if Prop is TfcCustomImager then (Prop as TfcCustomImager).UnRegisterChanges(FImageChangeLink)
    else if Prop is TfcCustomImageBtn then (Prop as TfcCustomImageBtn).UnRegisterChanges(FImageChangeLink);
  end;
  Prop := Value;
  if Value <> nil then
  begin
    if Value is TfcCustomImager then (Value as TfcCustomImager).RegisterChanges(FImageChangeLink)
    else if Value is TfcCustomImageBtn then (Value as TfcCustomImageBtn).Image.RegisterChanges(FImageChangeLink);
    Value.FreeNotification(self);
  end;

  RecreateWnd;
end;

procedure TfcCustomImageBtn.SetExtImage(Value: TComponent);
begin
  if Value <> nil then Image.Clear;
  SetExtImages(Value, FExtImage);
end;

procedure TfcCustomImageBtn.SetExtImageDown(Value: TComponent);
begin
  if Value <> nil then ImageDown.Clear;
  SetExtImages(Value, FExtImageDown);
end;

procedure TfcCustomImageBtn.Draw3DLines(SrcBitmap, DstBitmap: TfcBitmap; TransColor: TColor; Down: Boolean);
var WorkingBm{, DstBm}: TfcBitmap;
    DstPixels, SrcPixels: PfcPLines;
    StartPt, EndPt, OldEndPt: TPoint;
    Col, Row: Integer;
    ABtnHighlight, ABtn3DLight, ABtnShadow, ABtnBlack: TfcColor;
    BitmapSize: TSize;
  function CheckPoint(p: TPoint): TPoint;
  begin
    result := p;
    if result.x < 0 then result.x := 0;
    if result.y < 0 then result.y := 0;
    if result.x > BitmapSize.cx - 1 then result.x := BitmapSize.cx - 1;
    if result.y > BitmapSize.cy - 1 then result.y := BitmapSize.cy - 1;
  end;
  function PointValid(x, y: Integer): Boolean;
  begin
    result := not ((x < 0) or (y < 0) or
      (x >= BitmapSize.cx) or (y >= BitmapSize.cy));
  end;
  procedure GetFirstPixelColor(CurrentCol, CurrentRow: Integer; var ResultPt: TPoint; AColor: TColor; NotColor: Boolean; SearchForward: Boolean);
  var i, MaxIncr: Integer;
      CurColor: TColor;
  begin
    if SearchForward then MaxIncr := fcMin(BitmapSize.cx - CurrentCol, BitmapSize.cy - CurrentRow)
    else MaxIncr := fcMin(CurrentCol, CurrentRow);
    for i := 0 to MaxIncr - 1 do
    begin
      with SrcPixels[CurrentRow, CurrentCol] do CurColor := RGB(r, g, b);
      if ((CurColor = AColor) and not NotColor) or
         ((CurColor <> AColor) and NotColor) then
      begin
        ResultPt.x := CurrentCol;
        ResultPt.y := CurrentRow;
        if not NotColor then ResultPt := CheckPoint(Point(ResultPt.x - 1, ResultPt.y - 1));
        Break;
      end;
      if SearchForward then inc(CurrentCol) else dec(CurrentCol);
      if SearchForward then inc(CurrentRow) else dec(CurrentRow);
    end;
  end;
  procedure DrawHighlights(ABtnBlack, ABtnShadow, ABtn3dLight, ABtnHighlight: TfcColor);
  var AEndPt, AStartPt: TPoint;
  begin
    AEndPt := EndPt;
    AStartPt := StartPt;
    if (boFocusable in Options) and (Focused) then
      AStartPt := Point(AStartPt.x + 1, AStartPt.y + 1);

    with Point(AEndPt.x - 1, AEndPt.y - 1) do
      if PointValid(x, y) then DstPixels[y, x] := ABtnShadow;
    with Point(AStartPt.x + 1, AStartPt.y + 1) do
      if PointValid(x, y) then DstPixels[y, x] := ABtn3dLight;
    with Point(AEndPt.x, AEndPt.y) do
      if PointValid(x, y) then DstPixels[y, x] := ABtnBlack;
    with Point(AStartPt.x, AStartPt.y) do
      if PointValid(x, y) then DstPixels[y, x] := ABtnHighlight;

    if (boFocusable in Options) and (Focused) and Down then
      with Point(AStartPt.x - 1, AStartPt.y - 1) do
        if PointValid(x, y) then DstPixels[y, x] := fcGetColor(clBlack);
  end;
begin
  if SrcBitmap.Empty or (SrcBitmap.Width <> DstBitmap.Width) or (SrcBitmap.Height <> DstBitmap.Height) then
    Exit;

  // Must convert to BGR values because apparantly that's what PixBuf is...
  ABtnHighlight := fcGetColor(ColorToRGB(ShadeColors.BtnHighlight));
  ABtn3dLight := fcGetColor(ColorToRGB(ShadeColors.Btn3dLight));
  ABtnShadow := fcGetColor(ColorToRGB(ShadeColors.BtnShadow));
  ABtnBlack := fcGetColor(ColorToRGB(ShadeColors.BtnBlack));

  BitmapSize.cx := SrcBitmap.Width;
  BitmapSize.cy := SrcBitmap.Height;

  WorkingBm := TfcBitmap.Create;
  WorkingBm.Assign(SrcBitmap);
//  DstBm := nil;
{  if DstBitmap = SrcBitmap then WorkingPixels := WorkingBm.Pixels
  else begin
    DstBm := TfcBitmap.Create;
    DstBm.Assign(DstBitmap);
    WorkingPixels := DstBm.Pixels;
  end;}
  SrcPixels := WorkingBm.Pixels;
  DstPixels := DstBitmap.Pixels;

  if TransColor = -1 then TransColor := fcGetStdColor(WorkingBm.Pixels[0, 0]);

  try
    // Work Diagonally from top right of image to Top left of image
    Col := BitmapSize.cx - 1;
    Row := 0;
    while Row < WorkingBm.Height do
    begin
      // Find the first non transparent pixel
      EndPt := Point(Col - 1, Row - 1);

      repeat
        StartPt := Point(-1, -1);

        GetFirstPixelColor(EndPt.x + 1, EndPt.y + 1, StartPt, TransColor, True, True);
        if (StartPt.x <> -1) and (StartPt.y <> -1) then
        begin
          OldEndPt := EndPt;
          EndPt := CheckPoint(Point(Col + fcMin(BitmapSize.cx - 1 - Col, BitmapSize.cy - 1 - Row),
            Row + fcMin(BitmapSize.cx - 1 - Col, BitmapSize.cy - 1 - Row)));
          GetFirstPixelColor(StartPt.x + 1, StartPt.y + 1, EndPt, TransColor, False, True);

          if Focused or Default then
          begin
            StartPt := Point(StartPt.x + 1, StartPt.y + 1);
            EndPt := Point(EndPt.x - 1, EndPt.y - 1);
          end;

          if not Down then DrawHighlights(ABtnBlack, ABtnShadow, ABtn3dLight, ABtnHighlight)
          else DrawHighlights(ABtnHighlight, ABtn3dLight, ABtnShadow, ABtnBlack);

          if Focused or Default then
          begin
            StartPt := Point(StartPt.x - 1, StartPt.y - 1);
            EndPt := Point(EndPt.x + 1, EndPt.y + 1);
            DstPixels[StartPt.y, StartPt.x] := ABtnBlack;
            DstPixels[EndPt.y, EndPt.x] := ABtnBlack;
          end;
        end;
      until (StartPt.x = -1) and (StartPt.y = -1);
      if Col > 0 then dec(Col) else inc(Row);
    end;
{
    if SrcBitmap = DstBitmap then
      DstBitmap.Canvas.Draw(0, 0, WorkingBm)
    else begin
      DstBitmap.Canvas.Draw(0, 0, DstBm);
      DstBm.Free;
    end;}
  finally
    WorkingBm.Free;
  end;
end;

function TfcCustomImageBtn.ColorAtPoint(APoint: TPoint): TColor;
var Bitmap: TfcBitmap;
begin
  Bitmap := TfcBitmap.Create;
  try
    GetDrawBitmap(Bitmap, False, ShadeStyle, Down);
    result := Bitmap.Canvas.Pixels[APoint.x, APoint.y];
  finally
    Bitmap.Free;
  end;
end;

procedure TfcCustomImageBtn.GetDrawBitmap(DrawBitmap: TfcBitmap; ForRegion: Boolean;
  ShadeStyle: TfcShadeStyle; Down: Boolean);
var TempImage: TfcBitmap;
    Offset: TPoint;
begin
  DrawBitmap.SetSize(Width, Height);
  if RespectPalette then
  begin
    CopyMemory(@DrawBitmap.Colors, @ObtainImage(False).Colors, SizeOf(ObtainImage(False).Colors));
    DrawBitmap.RespectPalette := True;
  end;

  //3/16/99 - PYW - Raises canvas draw error when anchors cause width or height to be <=0
  with DrawBitmap do if (Width <=0) or (Height<=0) then exit;

  if ObtainImage(False).Empty then with DrawBitmap do
  begin
    Canvas.Brush.Color := clBtnFace;
    Canvas.Pen.Style := psDashDot;
    Canvas.Pen.Color := clBlack;
    Canvas.Rectangle(0, 0, Width, Height);
    Exit;
  end;

  Offset := Point(0, 0);                                       // Offset used if drawing shadows, etc.
  TempImage := TfcBitmap.Create;                                 // Temp image stores a copy of either Image or ImageDown
  TempImage.RespectPalette := RespectPalette;

  if not Down or ObtainImage(True).Empty then
    GetSizedImage(ObtainImage(False), TempImage, ShadeStyle, ForRegion)                            // If the button is not down or there is no down image
  else
    GetSizedImage(ObtainImage(True), TempImage, ShadeStyle, ForRegion);                    // defined then use the up image, otherwise use the down image.

  try
    if Down and ObtainImage(True).Empty then Offset := Point(Offsets.ImageDownX, Offsets.ImageDownY);  // Offset for Upper-left shadow
    if (ShadeStyle = fbsHighlight) or ((ShadeStyle = fbsFlat) and MouseInControl(-1, -1, False)) then
    begin
      DrawBitmap.Canvas.Draw(Offset.x, Offset.y, TempImage);
      Draw3dLines(TempImage, DrawBitmap, GetTransparentColor(Down), Down);
      Offset := Point(-1, -1);
    end else begin
      DrawBitmap.Canvas.Brush.Color := ShadeColors.Shadow;
      DrawBitmap.Canvas.FillRect(Rect(0, 0, Width, Height));   // Fill in with shadow color
    end;

    if (Offset.x <> -1) and (Offset.y <> -1) then
    begin
      if TransparentColor <> clNullColor then
      begin
        TempImage.Transparent := True;
        TempImage.TransparentColor := GetTransparentColor(Down);
      end;
      DrawBitmap.Canvas.Draw(Offset.x, Offset.y, TempImage)
    end;
  finally
    TempImage.Free;                                            // Clean up temp bitmaps
  end;
end;

procedure TfcCustomImageBtn.SplitImage;
var Bitmap, Bitmap2: TfcBitmap;
    ARgn: HRGN;
begin
  if not ObtainImage(False).Empty then
  begin
    Bitmap := TfcBitmap.Create;
    Bitmap2 := TfcBitmap.Create;
    GetDrawBitmap(Bitmap, False, fbsHighlight, False);
    GetDrawBitmap(Bitmap2, False, fbsHighlight, True);
    ARgn := CreateRegion(True, Down);
    fcClipBitmapToRegion(Bitmap2, ARgn);
    DeleteObject(ARgn);
    ObtainImage(False).Assign(Bitmap);
    ImageDown.Assign(Bitmap2);
    Bitmap.Free;
    Bitmap2.Free;
    RecreateWnd;
  end;
end;

procedure TfcCustomImageBtn.SizeToDefault;
var Rect: TRect;
begin
  if not ObtainImage(False).Empty then
  begin
    Width := ObtainImage(False).Width;
    Height := ObtainImage(False).Height;
    Rect := BoundsRect;
    if Parent <> nil then InvalidateRect(Parent.Handle, @Rect, True);
  end;
end;

procedure TfcCustomImageBtn.AssignTo(Dest: TPersistent);
begin
  if Dest is TfcCustomImageBtn then
    with Dest as TfcCustomImageBtn do
  begin
    DitherColor := self.DitherColor;
    DitherStyle := self.DitherStyle;
{    Image := self.Image;
    ImageDown := self.ImageDown;  DONT CHANGE THIS!!!}
    ExtImage := self;
    ExtImageDown := self;
    Offsets.Assign(self.Offsets);
    RespectPalette := self.RespectPalette;
    TransparentColor := self.TransparentColor;
  end;
  inherited;
end;

procedure TfcCustomImageBtn.CreateWnd;
begin
  if Image.Sleeping then Image.Wake;
  inherited;
  ApplyRegion;
end;

procedure TfcCustomImageBtn.DestroyWnd;
begin
  inherited;
  Image.Sleep;
end;

procedure TfcCustomImageBtn.GetSizedImage(SourceBitmap: TfcBitmap; DestBitmap: TfcBitmap;
  ShadeStyle: TfcShadeStyle; ForRegion: Boolean);
var s: TSize;
    Rgn: HRGN;
    BlendColor: TColor;
begin
  Rgn := 0;
  s := fcSize(Width, Height);
    //3/16/99 - PYW - Raises canvas draw error when anchors cause width or height to be <=0
  if (Width <=0) or (Height<=0) then exit;

  if ShadeStyle = fbsRaised then s := fcSize(Width - 2, Height - 2);
  DestBitmap.SetSize(s.cx, s.cy);

  if not ForRegion and ((Color <> clNone) or
     ((GroupIndex > 0) and Down and (DitherColor <> clNone) and ObtainImage(True).Empty)) then
    Rgn := CreateRegion(True, Down);

  DestBitmap.Canvas.StretchDraw(Rect(0, 0, s.cx, s.cy), SourceBitmap);

  if not ForRegion and (Color <> clNone) then
  begin
    SelectClipRgn(DestBitmap.Canvas.Handle, Rgn);
    DestBitmap.TransparentColor := GetTransparentColor(Down);
    with fcBitmap.fcGetColor(Color) do DestBitmap.Colorize(r, g, b);
  end;

  if (GroupIndex > 0) and Down and (DitherColor <> clNone) and not ForRegion and ObtainImage(True).Empty then
  begin
    if ShadeStyle = fbsRaised then OffsetRgn(Rgn, -2, -2);

    SelectClipRgn(DestBitmap.Canvas.Handle, Rgn);
    if DitherStyle in [dsDither, dsBlendDither] then
    begin
      if DitherStyle = dsBlendDither then BlendColor := clNone else BlendColor := clSilver;
      fcDither(DestBitmap.Canvas, Rect(0, 0, Width, Height), BlendColor, DitherColor);
    end else begin
      DestBitmap.Canvas.Brush.Color := DitherColor;
      DestBitmap.Canvas.FillRect(Rect(0, 0, Width, Height));
    end;
  end;
  if Rgn <> 0 then
  begin
    SelectClipRgn(DestBitmap.Canvas.Handle, 0);
    DeleteObject(Rgn);
  end;
end;

procedure TfcCustomImageBtn.ImageChanged(Sender: TObject);
var ARgnData: PfcRegionData;
    r: TRect;
begin
  ARgnData := nil;
  if Sender = ObtainImage(False) then ARgnData := @FRegionData
  else if Sender = ObtainImage(True) then ARgnData := @FDownRegionData;
  if ARgnData <> nil then ClearRegion(ARgnData);

  (Sender as TfcBitmap).IgnoreChange := True;
  ApplyRegion;
  (Sender as TfcBitmap).IgnoreChange := False;

  r := BoundsRect;
  if Parent <> nil then InvalidateRect(Parent.Handle, @r, True);
  Invalidate;
end;

procedure TfcCustomImageBtn.ExtImageDestroying(Sender: TObject);
begin
  if Sender = FExtImage then FExtImage := nil;
end;

procedure TfcCustomImageBtn.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) then
  begin
    if (AComponent = FExtImage) then FExtImage := nil
    else if (AComponent = FExtImageDown) then FExtImageDown := nil;
  end;
end;

function TfcCustomImageBtn.GetOffsets: TfcImgDownOffsets;
begin
  result := TfcImgDownOffsets(inherited Offsets);
end;

function TfcCustomImageBtn.GetParentClipping: Boolean;
begin
  result := False;
  if Parent <> nil then
    result := GetWindowLong(Parent.Handle, GWL_STYLE) and WS_CLIPCHILDREN = WS_CLIPCHILDREN;
end;

function TfcCustomImageBtn.GetRespectPalette: Boolean;
begin
  result := ObtainImage(False).RespectPalette;
end;

procedure TfcCustomImageBtn.SetOffsets(Value: TfcImgDownOffsets);
begin
  inherited Offsets := Value;
end;

procedure TfcCustomImageBtn.SetParentClipping(Value: Boolean);
begin
  if Parent <> nil then
  begin
    if Value then
      SetWindowLong(Parent.Handle, GWL_STYLE,
        GetWindowLong(Parent.Handle, GWL_STYLE) or WS_CLIPCHILDREN)
    else
      SetWindowLong(Parent.Handle, GWL_STYLE,
        GetWindowLong(Parent.Handle, GWL_STYLE) and not WS_CLIPCHILDREN);
  end;
end;

procedure TfcCustomImageBtn.SetRespectPalette(Value: Boolean);
begin
  ObtainImage(False).RespectPalette := Value;
  ObtainImage(True).RespectPalette := Value;
  Invalidate;
end;

procedure TfcCustomImageBtn.SetTransparentColor(Value: TColor);
var Rect: TRect;
begin
  if FTransparentColor <> Value then
  begin
    FTransparentColor := Value;
    RecreateWnd;
    Rect := BoundsRect;
    if Parent <> nil then InvalidateRect(Parent.Handle, @Rect, True);
  end;
end;

function TfcCustomImageBtn.UseRegions: boolean;
begin
   result:= (FTransparentColor<>clNullColor)
end;

procedure TfcCustomImageBtn.WndProc(var Message: TMessage);
begin
  inherited;
end;

{$r+}

end.
