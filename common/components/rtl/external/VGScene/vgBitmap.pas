unit vgBitmap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Модуль: "w:/common/components/rtl/external/VGScene/NOT_FINISHED_vgBitmap.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Impl::TvgBitmap
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$IfNDef NoVGScene}

uses
  SysUtils,
  
  Classes,

  Graphics,

  //vgNonModelTypes,
  vgTypes,
  vgCustomBitmap,
  vgCustomCanvas,
  vgObject
  ;

type
  TvgBitmapObject = class;

  TvgBitmap = class({$IFDEF KS_COMPILER6_UP}TvgCustomBitmap, IStreamPersist{$ELSE}TvgPersistent{$ENDIF})
  private
    FBits: PvgColorArray;
    FHandle: THandle;
    FHeight: integer;
    FOnChange: TNotifyEvent;
    FWidth: integer;
    FNeedUpdate: boolean;
    FOnThreadLoaded: TNotifyEvent;
    FOnBitmapCreate: TNotifyEvent;
    FOnBitmapDestroy: TNotifyEvent;
  protected
    FResource: TvgBitmapObject;
  private  
    FResourceName: string;
    function GetCanvas: TvgCustomCanvas;
    function GetScanline(y: integer): PvgColorArray;
    procedure SetHeight(const Value: integer);
    procedure SetWidth(const Value: integer);
    function GetPixels(x, y: integer): TvgColor;
    procedure SetResource(const Value: TvgBitmapObject);
    function GetResourceName: string;
    procedure SetResourceName(const Value: string);
    function GetBitmap: TvgBitmap;
  protected
    { internal }
    FCanvas: TvgCustomCanvas;
    FOnDestroyHandle: TNotifyEvent;
    procedure Recreate;
    procedure DoLoaded(Sender: TObject);
    { vcl }
    procedure AssignTo(Dest: TPersistent); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadBitmap(Stream: TStream);
    procedure WriteBitmap(Stream: TStream);
  public
    constructor Create(const AWidth, AHeight: integer; const APremulAlpha: boolean = true); virtual;
    constructor CreateFromStream(const AStream: TStream); virtual;
    constructor CreateFromBitmapAndMask(const Bitmap, Mask: TvgBitmap);
    procedure Assign(Source: TPersistent); override;
    procedure Cleanup; override;
    procedure SetSize(const AWidth, AHeight: integer);
    procedure Clear(const AColor: TvgColor = 0); virtual;
    procedure ClearRect(const ARect: TvgRect; const AColor: TvgColor = 0); virtual;
    procedure BitmapChanged;
    function IsEmpty: boolean;
    { vcl }
    {$IFNDEF NOVCL}
    procedure DrawGraphic(const Graphic: TGraphic; const DstRect: TvgRect);
    {$ENDIF}
    { Manipulation }
    procedure Rotate(const Angle: single);
    procedure FlipHorizontal;
    procedure FlipVertical;
    procedure InvertAlpha;
    procedure FillColor(const Color: TvgColor);
    { Mask }
    function CreateMask: PByteArray;
    procedure ApplyMask(const Mask: PByteArray; const DstX: integer = 0; const DstY: integer = 0);
    { Thumb }
    function CreateThumbnail(const Width, Height: integer): TvgBitmap;
    { I/O }
    procedure LoadFromFile(const AFileName: string; const Rotate: single = 0);
    procedure LoadThumbnailFromFile(const AFileName: string; const AFitWidth, AFitHeight: single;
      const UseEmbedded: boolean = true);
    procedure SaveToFile(const AFileName: string; const Params: string = '');
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);
    { }
    property Canvas: TvgCustomCanvas read GetCanvas;
    property Pixels[x, y: integer]: TvgColor read GetPixels;
    property Scanline[y: integer]: PvgColorArray read GetScanline;
    property StartLine: PvgColorArray read FBits;
    property Width: integer read FWidth write SetWidth;
    property Height: integer read FHeight write SetHeight;
    { internal usage only }
    property Handle: THandle read FHandle write FHandle;
    property OnDestroyHandle: TNotifyEvent read FOnDestroyHandle write FOnDestroyHandle;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnThreadLoaded: TNotifyEvent read FOnThreadLoaded write FOnThreadLoaded;
    property OnBitmapCreate: TNotifyEvent read FOnBitmapCreate write FOnBitmapCreate;
    property OnBitmapDestroy: TNotifyEvent read FOnBitmapDestroy write FOnBitmapDestroy;
    property NeedUpdate: boolean read FNeedUpdate write FNeedUpdate;
    property ResourceBitmap: TvgBitmap read GetBitmap; // use to resoruce link
  published
    { This property allow to link bitmap with BitmapObject. }
    property Resource: TvgBitmapObject read FResource write SetResource stored false;
    { This property allow to link bitmap with BitmapObject by name. }
    property ResourceName: string read GetResourceName write SetResourceName;
  end;

  TvgBitmapObject = class(TvgObject)
  private
    FBitmap: TvgBitmap;
  protected
    procedure SetName(const NewName: TComponentName); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Cleanup; override;
  published
    property Bitmap: TvgBitmap read FBitmap write FBitmap;
  end;

{$EndIf  NoVGScene}

implementation

{$IfNDef NoVGScene}

uses
  Windows,

  Types,

  l3Base,

  vg_scene
  ;

{ TvgBitmap ===================================================================}

constructor TvgBitmap.Create(const AWidth, AHeight: integer; const APremulAlpha: boolean = true);
begin
  inherited Create;
  FWidth := AWidth;
  FHeight := AHeight;
  Recreate;
end;

constructor TvgBitmap.CreateFromStream(const AStream: TStream);
begin
  Create(0, 0);
  LoadFromStream(AStream);
end;

constructor TvgBitmap.CreateFromBitmapAndMask(const Bitmap, Mask: TvgBitmap);
var
  i: integer;
begin
  Create(Bitmap.Width, Bitmap.Height);
  if (Bitmap.Width <> Mask.Width) or (Bitmap.Height <> Mask.Height) then Exit;
  for i := 0 to FHeight * FWidth - 1 do
  begin
    PvgColorRecArray(FBits)[i] := PvgColorRecArray(Bitmap.FBits)[i];
    PvgColorRecArray(FBits)[i].A := PvgColorRecArray(Mask.FBits)[i].R;
  end;
end;

procedure TvgBitmap.Cleanup;
begin
  if Assigned(FOnDestroyHandle) then
    FOnDestroyHandle(Self);
  if FResource <> nil then
  begin
    FResource.RemoveFreeNotify(Self);
    FResource := nil;
  end;
  if Assigned(FCanvas) then
    FreeAndNil(FCanvas);
  Handle := 0;
  if FBits <> nil then
    l3System.FreeLocalMem(FBits{, FWidth * FHeight * SizeOf(TvgColor)});
  inherited;
end;

procedure TvgBitmap.SetResource(const Value: TvgBitmapObject);
begin
  if FResource <> Value then
  begin
    if FResource <> nil then
      FResource.RemoveFreeNotify(Self);
    FResource := Value;
    if FResource <> nil then
    begin
      FResourceName := FResource.ResourceName;
      FResource.AddFreeNotify(Self);
    end
    else
      FResourceName := '';
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

function TvgBitmap.GetResourceName: string;
begin
  Result := FResourceName;
end;

procedure TvgBitmap.SetResourceName(const Value: string);
begin
  if Value <> FResourceName then
  begin
    FResourceName := Value;
    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

function TvgBitmap.GetBitmap: TvgBitmap;
var
  O: TvgObject;
begin
  Result := nil;
  if FResource <> nil then
  begin
    Result := TvgBitmapObject(FResource).Bitmap;
  end
  else
  if FResourceName <> '' then
  begin
    O := FindResource(FResourceName);
    if O is TvgBitmapObject then
      Resource := TvgBitmapObject(O);
    if FResource <> nil then
      Result := TvgBitmapObject(FResource).Bitmap;
  end;
end;

procedure TvgBitmap.SetSize(const AWidth, AHeight: integer);
begin
  if (FWidth <> AWidth) or (FHeight <> AHeight) then
  begin
    if FBits <> nil then
      l3System.FreeLocalMem(FBits{, FWidth * FHeight * SizeOf(TvgColor)});
    FBits := nil;
    FWidth := AWidth;
    FHeight := AHeight;
    Recreate;
    BitmapChanged;
  end;
end;

procedure TvgBitmap.Recreate;
begin
  if Assigned(FOnBitmapDestroy) then
    FOnBitmapDestroy(Self);
  if Assigned(FOnDestroyHandle) then
    FOnDestroyHandle(Self);
  FHandle := 0;
  if Assigned(FCanvas) then
    FreeAndNil(FCanvas);
  FCanvas := nil;
  if FBits <> nil then
    l3System.FreeLocalMem(FBits);
  FBits := nil;

  if not IsEmpty then
  begin
    l3System.GetLocalMem(FBits, FWidth * FHeight * SizeOf(TvgColor));
    Clear(0);
  end;
  FNeedUpdate := true;
  if Assigned(FOnBitmapCreate) then
    FOnBitmapCreate(Self);
end;

procedure TvgBitmap.Clear(const AColor: TvgColor);
begin
  if FBits <> nil then
  begin
    vgFillLongword(FBits, FWidth * FHeight, vgPremultyAlpha(AColor));
    BitmapChanged;
    FNeedUpdate := true;
  end;
end;

procedure TvgBitmap.ClearRect(const ARect: TvgRect;
  const AColor: TvgColor);
var
  R: TRect;
begin
  if FBits <> nil then
  begin
    R := Rect(Trunc(ARect.Left), Trunc(ARect.Top), Round(ARect.Right), Round(ARect.Bottom));
    if R.Left < 0 then R.Left := 0;
    if R.Top < 0 then R.Top := 0;
    if R.Right > FWidth then R.Right := FWidth;
    if R.Bottom > FHeight then R.Bottom := FHeight;
    if R.Bottom < R.Top then R.Bottom := R.Top;
    if R.Right < R.Left then R.Right := R.Left;
    if (R.Right < 0) or (R.Top < 0) or (R.Left > FWidth) or (R.Top > FHeight) then Exit;
    vgFillLongwordRect(FBits, FWidth, FHeight, R.Left, R.Top, R.Right, R.Bottom, vgPremultyAlpha(AColor));
    FNeedUpdate := true;
  end;
end;

function TvgBitmap.GetPixels(x, y: integer): TvgColor;
begin
  if (x >= 0) and (y >= 0) and (x < FWidth) and (y < FHeight) and (FBits <> nil) then
    Result := FBits[x + (y * FHeight)]
  else
    Result := 0;
end;

procedure TvgBitmap.BitmapChanged;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

function TvgBitmap.IsEmpty: boolean;
begin
  Result := FWidth * FHeight = 0;
end;

{$IFNDEF NOVCL}
procedure TvgBitmap.DrawGraphic(const Graphic: TGraphic; const DstRect: TvgRect);
var
  Bitmap: Graphics.TBitmap;
  SL: PvgColorArray;
  i, j: integer;
begin
  {$IFNDEF FPC}
  {$IFNDEF UCL}
  { Create DIB copy }
  Bitmap := Graphics.TBitmap.Create;
  try
    Bitmap.HandleType := bmDIB;
    Bitmap.PixelFormat := pf32bit;
    Bitmap.Width := FWidth;
    Bitmap.Height := FHeight;
    Bitmap.Canvas.Brush.Color := RGB(255, 0, 255);
    Bitmap.Canvas.StretchDraw(Rect(round(DstRect.left), round(DstRect.top), round(DstRect.right), round(DstRect.bottom)), Graphic);
    { Copy to bitmap }
    for j := 0 to FHeight - 1 do
    begin
      SL := Bitmap.Scanline[j];
      for i := 0 to FWidth - 1 do
        if (TvgColorRec(SL[i]).R = $FF) and (TvgColorRec(SL[i]).G = 0) and (TvgColorRec(SL[i]).B = $FF) then
          Continue
        else
          FBits[i + (j * Width)] := SL[i];
    end;
  finally
    FreeAndNil(Bitmap);
  end;
  {$ENDIF}
  {$ENDIF}
end;
{$ENDIF}

procedure TvgBitmap.Assign(Source: TPersistent);
var
  SLine: PvgColorArray;
  SLine24: PvgColor24Array;
  i, j: integer;
begin
  if Source is TvgBitmap then
  begin
    if TvgBitmap(Source).ResourceBitmap <> nil then
    begin
      Resource := TvgBitmap(Source).Resource;
      FResourceName := TvgBitmap(Source).ResourceName;
      if Assigned(FOnChange) then FOnChange(Self);
    end
    else
    begin
      Resource := nil;
      FResourceName := '';
      SetSize(TvgBitmap(Source).Width, TvgBitmap(Source).Height);
      vgMoveLongword(TvgBitmap(Source).FBits, FBits, Width * Height);
      FNeedUpdate := true;
      if Assigned(FOnChange) then FOnChange(Self);
    end;
  end
  else
  {$IFNDEF NOVCL}
  {$IFNDEF FPC}
  {$IFNDEF UCL}
    if (Source is Graphics.TBitmap) and ((Source as Graphics.TBitmap).PixelFormat = pf32bit) and ((Source as Graphics.TBitmap).HandleType = bmDIB) then
    with (Source as Graphics.TBitmap) do
    begin
      Self.SetSize(Width, Height);
      for j := 0 to Height - 1 do
      begin
        SLine := Scanline[j];
        for i := 0 to Width - 1 do
        begin
          if Transparent and (SLine^[i] = ColorToRGB(TransparentColor)) then
            FBits[i + (j * Width)] := 0
          else
            FBits[i + (j * Width)] := SLine^[i];
        end;
      end;
      FNeedUpdate := true;
      if Assigned(FOnChange) then FOnChange(Self);
    end
    else
    if (Source is Graphics.TBitmap) and ((Source as Graphics.TBitmap).PixelFormat = pf24bit) then
    with (Source as Graphics.TBitmap) do
    begin
      Self.SetSize(Width, Height);
      for j := 0 to Height - 1 do
      begin
        SLine24 := Scanline[j];
        for i := 0 to Width - 1 do
        begin
          if Transparent and (RGB(SLine24^[i].R, SLine24^[i].G, SLine24^[i].B) = ColorToRGB(TransparentColor)) then
            FBits[i + (j * Width)] := 0
          else
            FBits[i + (j * Width)] := $FF000000 + RGB(SLine24^[i].R, SLine24^[i].G, SLine24^[i].B);
        end;
      end;
      FNeedUpdate := true;
      if Assigned(FOnChange) then FOnChange(Self);
    end
    else
      if Source is TGraphic then
      begin
        SetSize(TGraphic(Source).Width, TGraphic(Source).Height);
        if FBits = nil then Exit;
        DrawGraphic(TGraphic(Source), vgRect(0, 0, FWidth, FHeight));
        vgFillAlpha(FBits, FWidth * FHeight, $FF);
        FNeedUpdate := true;
        if Assigned(FOnChange) then FOnChange(Self);
      end
      else
        if Source is TPicture then
        begin
          with TPicture(Source) do
          begin
            // icons, metafiles etc...
            Self.SetSize(TPicture(Source).Graphic.Width, TPicture(Source).Graphic.Height);
            if FBits = nil then Exit;
            DrawGraphic(TPicture(Source).Graphic, vgRect(0, 0, FWidth, FHeight));
            vgFillAlpha(FBits, FWidth * FHeight, $FF);
            FNeedUpdate := true;
            if Assigned(FOnChange) then FOnChange(Self);
          end;
        end
        else
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
  { inherited }
          inherited;
end;

procedure TvgBitmap.AssignTo(Dest: TPersistent);
var
  i: integer;
  {$IFNDEF NOVCL}
  B: Graphics.TBitmap;
  {$ENDIF}
begin
  {$IFNDEF NOVCL}
  {$IFNDEF FPC}
  {$IFNDEF UCL}
  if Dest is TPicture then
  begin
    B := Graphics.TBitmap.Create;
    B.HandleType := bmDIB;
    B.PixelFormat := pf32bit;
    B.Width := FWidth;
    B.Height := FHeight;
    for i := 0 to FHeight - 1 do
      l3Move(Scanline[i]^, B.Scanline[i]^, Width * 4);
    TPicture(Dest).Assign(B);
    FreeAndNil(B);
  end
  else
  if Dest is Graphics.TBitmap then
  begin
    Graphics.TBitmap(Dest).HandleType := bmDIB;
    Graphics.TBitmap(Dest).PixelFormat := pf32bit;
    Graphics.TBitmap(Dest).Width := FWidth;
    Graphics.TBitmap(Dest).Height := FHeight;
    for i := 0 to FHeight - 1 do
      l3Move(Scanline[i]^, Graphics.TBitmap(Dest).Scanline[i]^, Width * 4);
  end
  else
  {$ENDIF}
  {$ENDIF}
  {$ENDIF}
    inherited;
end;

procedure TvgBitmap.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('PNG', ReadBitmap, WriteBitmap, FWidth * FHeight > 0);
end;

procedure TvgBitmap.ReadBitmap(Stream: TStream);
begin
  LoadFromStream(Stream);
end;

procedure TvgBitmap.WriteBitmap(Stream: TStream);
begin
  SaveToStream(Stream);
end;

procedure TvgBitmap.DoLoaded(Sender: TObject);
begin
  if Assigned(FOnThreadLoaded) then
    FOnThreadLoaded(Self);
end;

procedure TvgBitmap.Rotate(const Angle: single);
var
  temp: TvgBitmap;
  M, M2: TvgMatrix;
  Pts: array [1..4] of TvgPoint;
  R: TvgRect;
begin
  if Angle = 0 then Exit;

  M := IdentityMatrix;
  M.m31 := -FWidth / 2;
  M.m32 := -FHeight / 2;
  M := vgMatrixMultiply(M, vgCreateRotationMatrix(vgDegToRad(Angle)));
  { calc new size }
  Pts[1] := vgPointFromVector(vgVectorTransform(vgVector(0, 0), M));
  Pts[2] := vgPointFromVector(vgVectorTransform(vgVector(FWidth, 0), M));
  Pts[3] := vgPointFromVector(vgVectorTransform(vgVector(FWidth, FHeight), M));
  Pts[4] := vgPointFromVector(vgVectorTransform(vgVector(0, FHeight), M));
  R := vgNormalizeRect(Pts);
  { translate }
  M2 := IdentityMatrix;
  M2.m31 := vgRectWidth(R) / 2;
  M2.m32 := vgRectHeight(R) / 2;
  M := vgMatrixMultiply(M, M2);
  { rotate }
  temp := TvgBitmap.Create(Trunc(vgRectWidth(R)), Trunc(vgRectHeight(R)));
  temp.Clear(0);
  TvgCanvas(temp.Canvas).BeginScene;
  TvgCanvas(temp.Canvas).SetMatrix(M);
  TvgCanvas(temp.Canvas).DrawBitmap(Self, vgRect(0, 0, FWidth, FHeight), vgRect(0, 0, FWidth, FHeight), 1);
  TvgCanvas(temp.Canvas).EndScene;
  Assign(temp);
  FreeAndNil(temp);
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TvgBitmap.FlipHorizontal;
var
  i: integer;
  tmp: PvgColorArray;
begin
  l3System.GetLocalMem(tmp, Width * 4);
  for i := 0 to (Height - 1) div 2 do
  begin
    l3Move(Scanline[Height - 1 - i][0], tmp[0], Width * 4);
    l3Move(Scanline[i][0], Scanline[Height - 1 - i][0], Width * 4);
    l3Move(tmp[0], Scanline[i][0], Width * 4);
  end;
  if Assigned(FOnChange) then FOnChange(Self);
  l3System.FreeLocalMem(tmp{, Width * 4});
end;

procedure TvgBitmap.FlipVertical;
var
  i, j: integer;
  tmp: TvgColor;
begin
  for j := 0 to Height - 1 do
    for i := 0 to (Width - 1) div 2 do
    begin
      tmp := Scanline[j][Width - 1 - i];
      Scanline[j][Width - 1 - i] := Scanline[j][i];
      Scanline[j][i] := tmp;
    end;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TvgBitmap.InvertAlpha;
var
  i, j: integer;
  Bits: PvgColorRecArray;
begin
  Bits := PvgColorRecArray(Startline);
  for j := 0 to Height - 1 do
    for i := 0 to Width - 1 do
    begin
      Bits[i + (j * Width)].Color := vgUnpremultyAlpha(Bits[i + (j * Width)].Color);
      TvgColorRec(Bits[(i) + ((j) * Width)]).A := $FF - TvgColorRec(Bits[(i) + ((j) * Width)]).A;
      Bits[i + (j * Width)].Color := vgPremultyAlpha(Bits[i + (j * Width)].Color);
    end;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TvgBitmap.FillColor(const Color: TvgColor);
var
  Bits: PvgColorRecArray;
  i, j: integer;
  a: byte;
begin
  Bits := PvgColorRecArray(Startline);
  for j := 0 to Height - 1 do
  begin
    for i := 0 to Width - 1 do
    begin
      {$ifdef FPC_BIG_ENDIAN}
      a := TvgColorRec(Bits[(i) + ((j) * Width)]).Color and $FF;
      {$else}
      a := TvgColorRec(Bits[(i) + ((j) * Width)]).A;
      {$endif}
      if a > 0 then
      begin
        bits[(i) + ((j) * Width)].Color := vgPremultyAlpha(vgOpacity(Color, a / $FF));
        {$ifdef FPC_BIG_ENDIAN}
        ReverseBytes(@Bits[(i) + ((j) * Width)].Color, 4);
        {$endif}
      end;
    end
  end;
  if Assigned(FOnChange) then FOnChange(Self);
  FNeedUpdate := true;
end;

function TvgBitmap.CreateMask: PByteArray;
var
  a: byte;
  Bits: PvgColorRecArray;
  i, j: integer;
begin
  l3System.GetLocalMem(Result, Width * Height);
  l3FillChar(Result^, Width * Height{, 0});
  Bits := PvgColorRecArray(Startline);
  for j := 0 to Height - 1 do
  begin
    for i := 0 to Width - 1 do
    begin
      {$ifdef FPC_BIG_ENDIAN}
      a := TvgColorRec(Bits[(i) + ((j) * Width)]).Color and $FF;
      {$else}
      a := TvgColorRec(Bits[(i) + ((j) * Width)]).A;
      {$endif}
      if a > 0 then
      begin
        Result[i + (j * Width)] := a;
      end;
    end
  end;
end;

procedure TvgBitmap.ApplyMask(const Mask: PByteArray; const DstX: integer = 0; const DstY: integer = 0);
var
  Bits: PvgColorRecArray;
  i, j: integer;
begin
  Bits := PvgColorRecArray(Startline);
  for j := 0 to Height - 1 do
  begin
    for i := 0 to Width - 1 do
    begin
      if (i - DstX < 0) or (i - DstX > Width - 1) or (j - DstY < 0) or (j - DstY > Height - 1) then Continue;

      if mask[i - DstX + ((j - DstY) * Width)] > 0 then
      begin
        Bits[i + (j * Width)].Color := vgPremultyAlpha(vgOpacity(vgUnpremultyAlpha(Bits[i + (j * Width)].Color), ($FF - mask[i - DstX + ((j - DstY) * Width)]) / $FF))
      end;
      {$ifdef FPC_BIG_ENDIAN}
      ReverseBytes(@Bits[(i) + ((j) * Width)].Color, 4);
      {$endif}
    end
  end;
  if Assigned(FOnChange) then FOnChange(Self);
  FNeedUpdate := true;
end;

function TvgBitmap.CreateThumbnail(const Width, Height: integer): TvgBitmap;
begin
  Result := TvgBitmap.Create(Width, Height);
  TvgCanvas(Result.Canvas).BeginScene;
  TvgCanvas(Result.Canvas).DrawThumbnail(Self, Width, Height);
  TvgCanvas(Result.Canvas).EndScene;
end;

procedure TvgBitmap.LoadFromFile(const AFileName: string; const Rotate: single = 0);
var
  Filter: TvgFilter;
begin
  if not FileExists(AFileName) then Exit;
  Filter := DefaultFilterClass.Create;
  if Filter.LoadFromFile(AFileName, Rotate, Self) then
    if Assigned(FOnChange) then FOnChange(Self);
  FreeAndNil(Filter);
end;

procedure TvgBitmap.LoadThumbnailFromFile(const AFileName: string; const AFitWidth, AFitHeight: single;
  const UseEmbedded: boolean = true);
var
  Filter: TvgFilter;
begin
  Filter := DefaultFilterClass.Create;
  if Filter.LoadThumbnailFromFile(AFileName, AFitWidth, AFitHeight, UseEmbedded, Self) then
    if Assigned(FOnChange) then FOnChange(Self);
  FreeAndNil(Filter);
end;

procedure TvgBitmap.SaveToFile(const AFileName: string; const Params: string = '');
var
  Filter: TvgFilter;
begin
  Filter := DefaultFilterClass.Create;
  Filter.SaveToFile(AFileName, Self, Params);
  FreeAndNil(Filter);
end;

procedure TvgBitmap.LoadFromStream(Stream: TStream);
var
  Filter: TvgFilter;
  S: TStream;
begin
  if Stream.Position > 0 then
  begin
    // need to create temp stream
    S := TMemoryStream.Create;
    try
     S.CopyFrom(Stream, Stream.Size - Stream.Position);
     S.Position := 0;
     Filter := DefaultFilterClass.Create;
     try
      if Filter.LoadFromStream(S, Self) then
        if Assigned(FOnChange) then FOnChange(Self);
     finally
      FreeAndNil(Filter);
     end;
    finally
     FreeAndNil(S);
    end;
  end
  else
  begin
    Filter := DefaultFilterClass.Create;
    try
     if Filter.LoadFromStream(Stream, Self) then
       if Assigned(FOnChange) then FOnChange(Self);
    finally
     FreeAndNil(Filter);
    end;
  end;
end;

procedure TvgBitmap.SaveToStream(Stream: TStream);
var
  i: integer;
  hasAlpha: boolean;
  Filter: TvgFilter;
begin
  { check alpha }
  hasAlpha := false;
  for i := 0 to FWidth * FHeight - 1 do
    if FBits[i] and $FF000000 <> $FF000000 then
    begin
      hasAlpha := true;
      Break;
    end;

  if hasAlpha then
  begin
    Filter := DefaultFilterClass.Create;
    Filter.SaveToStream(Stream, Self, 'png');
    FreeAndNil(Filter);
  end
  else
  begin
    Filter := DefaultFilterClass.Create;
    Filter.SaveToStream(Stream, Self, 'jpeg', 'quality=100');
    FreeAndNil(Filter);
  end;
end;

procedure TvgBitmap.SetHeight(const Value: integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    Recreate;
  end;
end;

procedure TvgBitmap.SetWidth(const Value: integer);
begin
  if FWidth <> Value then
  begin
    FWidth := Value;
    Recreate;
  end;
end;

function TvgBitmap.GetCanvas: TvgCustomCanvas;
begin
  if FCanvas = nil then
  begin
    FCanvas := DefaultCanvasClass.CreateFromBitmap(Self);
    TvgCanvas(FCanvas).SetMatrix(IdentityMatrix);
  end;
  Result := FCanvas;
end;

function TvgBitmap.GetScanline(y: integer): PvgColorArray;
begin
  Result := DefaultCanvasClass.GetBitmapScanline(Self, y);
end;

{ TvgBitmapObject ============================================================}

constructor TvgBitmapObject.Create(AOwner: TComponent);
begin
  inherited;
  FBitmap := TvgBitmap.Create(1, 1);
end;

procedure TvgBitmapObject.Cleanup;
begin
  FreeAndNil(FBitmap);
  inherited;
end;

procedure TvgBitmapObject.SetName(const NewName: TComponentName);
begin
  inherited;
  if FResourceName = '' then
    FResourceName := Name;
end;

{$EndIf  NoVGScene}

end.