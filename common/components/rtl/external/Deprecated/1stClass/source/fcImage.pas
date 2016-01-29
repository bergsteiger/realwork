unit fcImage;
{
//
// Components : TfcCustomImage
//
// Copyright (c) 1999 by Woll2Woll Software
}

interface

uses
  Consts, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TfcCustomImage = class(TGraphicControl)
  private
    FPicture: TPicture;
    FAutoSize: Boolean;
    FIncrementalDisplay: Boolean;
    FTransparent: Boolean;
    FDrawing: Boolean;
    function GetCanvas: TCanvas;
    procedure PictureChanged(Sender: TObject);
    procedure SetAutoSize(Value: Boolean);
    procedure SetPicture(Value: TPicture);
    procedure SetTransparent(Value: Boolean);
  protected
    function DestRect: TRect;
    function DoPaletteChange: Boolean;
    function GetPalette: HPALETTE; override;
    procedure Paint; override;
  public
    BasePatch: Variant;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Canvas: TCanvas read GetCanvas;

    property AutoSize: Boolean read FAutoSize write SetAutoSize default False;
    property IncrementalDisplay: Boolean read FIncrementalDisplay write FIncrementalDisplay default False;
    property Picture: TPicture read FPicture write SetPicture;
    property Transparent: Boolean read FTransparent write SetTransparent default False;
  end;

implementation

constructor TfcCustomImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FPicture := TPicture.Create;
  FPicture.OnChange := PictureChanged;
  Height := 105;
  Width := 105;
end;

destructor TfcCustomImage.Destroy;
begin
  FPicture.Free;
  inherited Destroy;
end;

function TfcCustomImage.GetPalette: HPALETTE;
begin
  Result := 0;
  if FPicture.Graphic <> nil then
    Result := FPicture.Graphic.Palette;
end;

function TfcCustomImage.DestRect: TRect;
begin
    Result := Rect(0, 0, Picture.Width, Picture.Height);
end;

procedure TfcCustomImage.Paint;
var
  Save: Boolean;
begin
  if csDesigning in ComponentState then
    with inherited Canvas do
    begin
      Pen.Style := psDash;
      Brush.Style := bsClear;
      Rectangle(0, 0, Width, Height);
    end;
  Save := FDrawing;
  FDrawing := True;
  try
    with inherited Canvas do
      StretchDraw(DestRect, Picture.Graphic);
  finally
    FDrawing := Save;
  end;
end;

function TfcCustomImage.DoPaletteChange: Boolean;
var
  ParentForm: TCustomForm;
  Tmp: TGraphic;
begin
  Result := False;
  Tmp := Picture.Graphic;
  if Visible and (not (csLoading in ComponentState)) and (Tmp <> nil) and
    (Tmp.PaletteModified) then
  begin
    if (Tmp.Palette = 0) then
      Tmp.PaletteModified := False
    else
    begin
      ParentForm := GetParentForm(Self);
      if Assigned(ParentForm) and ParentForm.Active and Parentform.HandleAllocated then
      begin
        if FDrawing then
          ParentForm.Perform(wm_QueryNewPalette, 0, 0)
        else
          PostMessage(ParentForm.Handle, wm_QueryNewPalette, 0, 0);
        Result := True;
        Tmp.PaletteModified := False;
      end;
    end;
  end;
end;

function TfcCustomImage.GetCanvas: TCanvas;
var
  Bitmap: TBitmap;
begin
  if Picture.Graphic = nil then
  begin
    Bitmap := TBitmap.Create;
    try
      Bitmap.Width := Width;
      Bitmap.Height := Height;
      Picture.Graphic := Bitmap;
    finally
      Bitmap.Free;
    end;
  end;
  if Picture.Graphic is TBitmap then
    Result := TBitmap(Picture.Graphic).Canvas
  else
    raise EInvalidOperation.Create(SImageCanvasNeedsBitmap);
end;

procedure TfcCustomImage.SetAutoSize(Value: Boolean);
begin
  FAutoSize := Value;
  PictureChanged(Self);
end;

procedure TfcCustomImage.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

procedure TfcCustomImage.SetTransparent(Value: Boolean);
begin
  if Value <> FTransparent then
  begin
    FTransparent := Value;
    PictureChanged(Self);
  end;
end;

procedure TfcCustomImage.PictureChanged(Sender: TObject);
var
  G: TGraphic;
begin
  if AutoSize and (Picture.Width > 0) and (Picture.Height > 0) then
    SetBounds(Left, Top, Picture.Width, Picture.Height);
  G := Picture.Graphic;
  if G <> nil then
  begin
    if not ((G is TMetaFile) or (G is TIcon)) then
      G.Transparent := FTransparent;
    if (not G.Transparent) and ((G.Width >= Width)
      and (G.Height >= Height)) then
      ControlStyle := ControlStyle + [csOpaque]
    else
      ControlStyle := ControlStyle - [csOpaque];
    if DoPaletteChange and FDrawing then Update;
  end
  else ControlStyle := ControlStyle - [csOpaque];
  if not FDrawing then Invalidate;
end;

end.
