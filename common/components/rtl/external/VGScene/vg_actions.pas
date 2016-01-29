unit vg_actions;

{$I vg_define.inc}

interface

uses
  {$IFNDEF NOVCL}
  ImgList, Graphics, ActnList, Forms,
  {$ENDIF}
  Classes, SysUtils, vg_scene,

  vgAnyObjectList,
  vgBitmap
  ;

 {$Define _UnknownIsComponent}

type
 _l3Unknown_Parent_ = TCustomImageList;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
  TvgImageList = class(_l3Unknown_)
  private
    FImages: TvgAnyObjectList;
    function GetCount: integer;
    function GetBitmap(Index: integer): TvgBitmap;
    procedure UpdateList;
 protected
   {$I l3DefineCleanup.inc}
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadData(Stream: TStream); {$IFDEF KS_COMPILER7_UP}override;{$ENDIF}
    procedure WriteData(Stream: TStream); {$IFDEF KS_COMPILER7_UP}override;{$ENDIF}
    procedure ReadImage(Stream: TStream);
    procedure WriteImage(Stream: TStream);
  public
    constructor Create(AOwner: TComponent); override;
    function Add(Bitmap: TvgBitmap): integer;
    procedure Clear;
    property Images[Index: integer]: TvgBitmap read GetBitmap;
    property Count: integer read GetCount;
 public
 // public methods
   procedure Free(var Dummy: Integer);
     {* Для ловли просто Free }
  published
    property Height default 32;
    property Width default 32;
  end;

implementation {===============================================================}

uses
  l3Interfaces,
  l3Base,
  l3Core,
  l3Interlocked,
  Windows
  ;

type _Instance_R_ = TvgImageList;
type _l3Unknown_R_ = TvgImageList;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

{ TvgImageList }

constructor TvgImageList.Create(AOwner: TComponent);
begin
  inherited;
  FImages := TvgAnyObjectList.Create;
  Width := 32;
  Height := 32;
end;

procedure TvgImageList.Clear;
var
  i: integer;
  l_C : TvgBitmap;
begin
  inherited Clear;

  for i := 0 to FImages.Count - 1 do
  begin
   l_C := TvgBitmap(FImages[i]);
   FreeAndNil(l_C);
  end;//for i
  FImages.Clear;
end;

function TvgImageList.Add(Bitmap: TvgBitmap): integer;
var
  B: TvgBitmap;
  R: TvgRect;
begin
  B := TvgBitmap.Create(Width, Height);
  R := vgRect(0, 0, Bitmap.Width, Bitmap.Height);
  vgFitRect(R, vgRect(0, 0, Width, Height));
  TvgCanvas(B.Canvas).DrawBitmap(Bitmap, vgRect(0, 0, Bitmap.Width, Bitmap.Height), R, 1);

  Result := FImages.Add(B);
  UpdateList;
end;

procedure TvgImageList.ReadImage(Stream: TStream);
var
  i: integer;
  S, C: cardinal;
  M: TMemoryStream;
  B: TvgBitmap;
begin
  Stream.Read(C, 4);
  for i := 0 to C - 1 do
  begin
    M := TMemoryStream.Create;

    Stream.Read(S, 4);
    M.SetSize(S);
    Stream.Read(M.Memory^, S);

    B := TvgBitmap.CreateFromStream(M);
    FImages.Add(B);

    FreeAndNil(M);
  end;
  UpdateList;
end;

procedure TvgImageList.WriteImage(Stream: TStream);
var
  i: integer;
  S: cardinal;
  M: TMemoryStream;
begin
  S := FImages.Count;
  Stream.Write(S, 4);
  for i := 0 to FImages.Count - 1 do
  begin
    M := TMemoryStream.Create;
    TvgBitmap(FImages[i]).SaveToStream(M);

    S := M.Size;
    Stream.Write(S, 4);
    Stream.Write(M.Memory^, M.Size);

    FreeAndNil(M);
  end;
end;

procedure TvgImageList.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Images', ReadImage, WriteImage, FImages.Count > 0);
end;

function TvgImageList.GetCount: integer;
begin
  Result := FImages.Count;
end;

function TvgImageList.GetBitmap(Index: integer): TvgBitmap;
begin
  if (Index >= 0) and (Index < Count) then
    Result := TvgBitmap(FImages[Index])
  else
    Result := nil;
end;

procedure TvgImageList.UpdateList;
var
  i: integer;
  B: Graphics.TBitmap;
begin
  if not (csDesigning in ComponentState) then Exit;

  inherited Clear;

  for i := 0 to FImages.Count - 1 do
  begin
    if (Images[i].Width <> Width) or (Images[i].Height <> Height) then Continue;

    B := Graphics.TBitmap.Create;
    B.Assign(Images[i]);
    inherited AddMasked(B, 0);
    FreeAndNil(B);
  end;
end;

procedure TvgImageList.ReadData(Stream: TStream);
begin
end;

procedure TvgImageList.WriteData(Stream: TStream);
begin
end;

procedure TvgImageList.Free(var Dummy: Integer);
begin
 Assert(false, 'Используйте FreeAndNil');
end;

type
 _Unknown_Child_ = _l3Unknown_R_;
{$I l3ImplCleanup.inc}
begin
  Clear;
  FreeAndNil(FImages);
  inherited;
end;

end.

