{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.MultiResBitmap;

interface

{$SCOPEDENUMS ON}

uses
  System.Generics.Collections, System.Generics.Defaults, System.Types, System.UITypes, System.Classes, FMX.Graphics;

type
  TCustomMultiResBitmap = class;
  TCustomBitmapItem = class;

  EMultiResBitmap = class(EComponentError)
  end;

  TBitmapOfItem = class(TBitmap)
  private
    [Weak] FBitmapItem: TCustomBitmapItem;
    FIsChanged: Boolean;
  protected
    procedure DoChange; override;
  public
    property BitmapItem: TCustomBitmapItem read FBitmapItem;
    property IsChanged: Boolean read FIsChanged write FIsChanged;
  end;

  TCustomBitmapItem = class(TCollectionItem)
  public const
    ScaleRange = -3;
    ScaleMax = 100;
    ScaleDefault = 1;
  private
    FFixed: Boolean;
    FDormant: Boolean;
    FDormantChanging: Boolean;
    FBitmap: TBitmapOfItem;
    FStream: TMemoryStream;
    [Weak] FMultiResBitmap: TCustomMultiResBitmap;
    FScale: Single;
    FFileName: string;
    FWidth: Word;
    FHeight: Word;
    function GetFixed: Boolean;
    procedure SetScale(const Value: Single);
    procedure SetBitmap(const Value: TBitmapOfItem);
    function GetBitmap: TBitmapOfItem;
    procedure ReadFileName(Reader: TReader);
    procedure WriteFileName(Writer: TWriter);
    function GetComponent: TComponent;
    procedure SetDormant(const Value: Boolean);
    procedure ReadBitmap(Stream: TStream);
    procedure WriteBitmap(Stream: TStream);
    function GetIsEmpty: Boolean;
    procedure ReadHeight(Reader: TReader);
    procedure ReadWidth(Reader: TReader);
    procedure WriteHeight(Writer: TWriter);
    procedure WriteWidth(Writer: TWriter);
  protected
    procedure SetCollection(Value: TCollection); override;
    procedure DefineProperties(Filer: TFiler); override;
    function ScaleStored: Boolean; virtual;
    procedure SetFixed(const Value: Boolean);
    function GetDisplayName: string; override;
    procedure SetIndex(Value: Integer); override;
    function BitmapStored: Boolean; virtual;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Equals(Obj: TObject): Boolean; override;
    procedure Clear;
    property MultiResBitmap: TCustomMultiResBitmap read FMultiResBitmap;
    property Fixed: Boolean read GetFixed;
    property Component: TComponent read GetComponent;
    class function ScaleOfBitmap(const SourceSize, DestinationSize: TSize): Double;
    class function RectOfBitmap(const SourceSize, DestinationSize: TSize): TRect;
    function CreateBitmap(const AFileName: string = ''): TBitmap; virtual;
    property Scale: Single read FScale write SetScale stored ScaleStored nodefault;
    property Bitmap: TBitmapOfItem read GetBitmap write SetBitmap stored False;
    property FileName: string read FFileName write FFileName stored False;
    property Dormant: Boolean read FDormant write SetDormant;
    property IsEmpty: Boolean read GetIsEmpty;
    property Width: Word read FWidth stored False;
    property Height: Word read FHeight stored False;
  end;

  TCustomBitmapItemClass = class of TCustomBitmapItem;
  TFixedBitmapItemClass = class of TFixedBitmapItem;

  TSizeKind = (Custom, Default, Source);

  TSizeKindHelper = record helper for TSizeKind
  const
    skCustom = TSizeKind.Custom deprecated 'Use TSizeKind.Custom';
    skDefault = TSizeKind.Default deprecated 'Use TSizeKind.Default';
    skSource = TSizeKind.Source deprecated 'Use TSizeKind.Source';
  end;

  TCustomMultiResBitmap = class(TOwnedCollection)
  private
    FFixed: Boolean;
    FWidth: Word;
    FHeight: Word;
    FSizeKind: TSizeKind;
    FTransparentColor: TColor;
    function GetFixed: Boolean;
    procedure ReadWidth(Reader: TReader);
    procedure WriteWidth(Writer: TWriter);
    procedure ReadHeight(Reader: TReader);
    procedure WriteHeight(Writer: TWriter);
    function GetItem(Index: Integer): TCustomBitmapItem;
    procedure SetItem(Index: Integer; const Value: TCustomBitmapItem);
    function GetComponent: TComponent;
    procedure ReadLoadSize(Reader: TReader);
    procedure WriteLoadSize(Writer: TWriter);
    procedure ReadColor(Reader: TReader);
    procedure WriteColor(Writer: TWriter);
    function GetBitmaps(Scale: Single): TBitmapOfItem;
    procedure SetBitmaps(Scale: Single; const Value: TBitmapOfItem);
  protected
    procedure SetFixed(const Value: Boolean);
    function GetDefaultSize: TSize; virtual;
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TPersistent; ItemClass: TCustomBitmapItemClass);
    function ScaleArray(IncludeEmpty: Boolean): TArray<Single>;
    function ItemByScale(const AScale: Single; const ExactMatch: Boolean;
      const IncludeEmpty: Boolean): TCustomBitmapItem;
    procedure LoadItemFromStream(Stream: TStream; Scale: Single);
    procedure LoadFromStream(S: TStream); virtual;
    procedure SaveToStream(S: TStream); virtual;
    function Equals(Obj: TObject): Boolean; override;
    procedure Assign(Source: TPersistent); override;
    function Add: TCustomBitmapItem;
    /// <summary> Load file adding or replacing a single image </summary>
    /// <param name="Scale"> Scale to which the file being loaded corresponds. If the image in this scale does not
    /// exist, a new item in the collection is created. Otherwise, the existing image is replaced. </param>
    /// <param name="FileName"> The name of the file </param>
    /// <returns> New or updated item in the collection</returns>
    /// <remarks> When loading, SizeKind, Width, Height, TransparentColor properties are used </remarks>
    function AddOrSet(const Scale: Single; const FileName: string): TCustomBitmapItem;
    function Insert(Index: Integer): TCustomBitmapItem;
    property Items[Index: Integer]: TCustomBitmapItem read GetItem write SetItem; default;
    property Bitmaps[Scale: Single]: TBitmapOfItem read GetBitmaps write SetBitmaps;
    property Component: TComponent read GetComponent;
    property Fixed: Boolean read GetFixed;
    property DefaultSize: TSize read GetDefaultSize;
    property SizeKind: TSizeKind read FSizeKind write FSizeKind stored False;
    property Width: Word read FWidth write FWidth stored False;
    property Height: Word read FHeight write FHeight stored False;
    property TransparentColor: TColor read FTransparentColor write FTransparentColor stored False;
  end;

  TFixedBitmapItem = class(TCustomBitmapItem)
  private
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
  published
    property Scale;
    property Bitmap;
  end;

  TFixedMultiResBitmap = class(TCustomMultiResBitmap)
  private
    procedure CreateItem(Scale: Single);
    procedure CreateItems;
    function GetItem(Index: Integer): TFixedBitmapItem;
    procedure SetItem(Index: Integer; const Value: TFixedBitmapItem);
    procedure UpdateFixed;
  public
    constructor Create(AOwner: TPersistent; ItemClass: TFixedBitmapItemClass); overload;
    constructor Create(AOwner: TPersistent); overload;
    procedure EndUpdate; override;
    function Add: TFixedBitmapItem;
    function Insert(Index: Integer): TFixedBitmapItem;
    property Items[Index: Integer]: TFixedBitmapItem read GetItem write SetItem; default;
  end;

  TScaleName = record
    Scale: Single;
    Name: string;
  end;

  TScaleList = TList<TScaleName>;

  TScaleNameComparer = class(TInterfacedObject, IComparer<TScaleName>)
    function Compare(const Left, Right: TScaleName): Integer;
  end;

  IMultiResBitmapObject = interface(IBitmapObject)
    ['{D64BEB1F-D3C5-4C83-BE1C-DBBA319C0EA5}']
    function GetMultiResBitmap: TCustomMultiResBitmap;
    property MultiResBitmap: TCustomMultiResBitmap read GetMultiResBitmap;
  end;

function ScaleList: TScaleList;
function RegisterScaleName(Scale: Single; Name: string): Boolean;

implementation

uses
  System.SysUtils, System.Math.Vectors, System.Math, System.TypInfo, System.RTLConsts, FMX.Utils, FMX.Consts;

var
  StrScaleFormat: string;
  StrScaleName: string;

{$REGION 'implementation of TBitmapOfItem'}
{ TBitmapOfItem }

procedure TBitmapOfItem.DoChange;
begin
  inherited;
  if (FBitmapItem <> nil) and (not FBitmapItem.FDormantChanging) then
  begin
    FIsChanged := True;
    FBitmapItem.FWidth := Round(Width);
    FBitmapItem.FHeight := Round(Height);
    if (FBitmapItem.Component <> nil) and ([csLoading, csDestroying] * FBitmapItem.Component.ComponentState = []) and
      (FBitmapItem.Collection is TCustomMultiResBitmap) and
      (TCustomMultiResBitmap(FBitmapItem.Collection).UpdateCount = 0) then
      FBitmapItem.Changed(False);
  end;
end;

{$ENDREGION}
{$REGION 'MultiResBitmap'}
{ TCustomBitmapItem }

constructor TCustomBitmapItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  if FScale <= 0 then
    FScale := ScaleDefault;
  FStream := TMemoryStream.Create;
  FDormant := True;
end;

procedure TCustomBitmapItem.SetDormant(const Value: Boolean);
begin
  if FDormant <> Value then
  begin
    if not FDormantChanging then
    begin
      FDormantChanging := True;
      try
        if Value then
        begin
          try
            if FStream <> nil then
              FStream.Clear
            else
              FStream := TMemoryStream.Create;
            if (FBitmap <> nil) and (not FBitmap.IsEmpty) then
              FBitmap.SaveToStream(FStream);
          except
            FreeAndNil(FStream);
            raise;
          end;
          FreeAndNil(FBitmap);
        end
        else
        begin
          try
            if FBitmap = nil then
              FBitmap := TBitmapOfItem.Create(0, 0);
            FBitmap.FBitmapItem := Self;
            FBitmap.BitmapScale := FScale;
            if (FStream <> nil) and (FStream.Size > 0) then
            begin
              FStream.Position := 0;
              FBitmap.LoadFromStream(FStream);
            end
            else
              FBitmap.SetSize(0, 0);
          except
            FreeAndNil(FBitmap);
            raise;
          end;
          FreeAndNil(FStream);
        end;
      finally
        FDormantChanging := False;
      end;
      FDormant := Value;
    end;
  end;
end;

procedure TCustomBitmapItem.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Width', ReadWidth, WriteWidth, BitmapStored);
  Filer.DefineProperty('Height', ReadHeight, WriteHeight, BitmapStored);
  Filer.DefineBinaryProperty('PNG', ReadBitmap, WriteBitmap, BitmapStored);
  Filer.DefineProperty('FileName', ReadFileName, WriteFileName, FileName <> '');
end;

destructor TCustomBitmapItem.Destroy;
begin
  if (MultiResBitmap <> nil) and MultiResBitmap.Fixed then
    raise EMultiResBitmap.CreateFMT(StrEChangeFixed, ['MultiResBitmap']);
  FreeAndNil(FBitmap);
  FreeAndNil(FStream);
  inherited;
end;

function TCustomBitmapItem.Equals(Obj: TObject): Boolean;

  function CreateStream(const Item: TCustomBitmapItem): TStream;
  begin
    Result := nil;
    if Item.Dormant then
    begin
      if (Item.FStream <> nil) and (Item.FStream.Size > 0) then
        Result := Item.FStream;
    end
    else
    begin
      if (Item.FBitmap <> nil) and not Item.FBitmap.IsEmpty then
      try
        Result := TMemoryStream.Create;
        Item.FBitmap.SaveToStream(Result);
      except
        Result.Free;
        raise;
      end
    end;
  end;

  procedure FreeStream(var Stream: TStream; Item: TCustomBitmapItem);
  begin
    if Stream <> Item.FStream then
      Stream.Free;
  end;

var
  Src: TCustomBitmapItem;
  SrcStream: TStream;
  DstStream: TStream;
begin
  Result := inherited;
  if not Result then
  begin
    if Obj = nil then
      Result := (Width = 0) and (Height = 0) and SameValue(Scale, 1, TEpsilon.Scale) and IsEmpty and FileName.IsEmpty
    else if Obj is TCustomBitmapItem then
    begin
      Src := TCustomBitmapItem(Obj);
      Result := (Width = Src.Width) and (Height = Src.Height) and SameValue(Scale, Src.Scale, TEpsilon.Scale) and
        (IsEmpty = Src.IsEmpty) and (FileName = Src.FileName);
      if Result and not IsEmpty then
      begin
        DstStream := CreateStream(Self);
        try
          SrcStream := CreateStream(Src);
          try
            Result := (DstStream = nil) and (SrcStream = nil);
            if (not Result) and (DstStream is TMemoryStream) and (SrcStream is TMemoryStream) and
              (DstStream.Size = SrcStream.Size) then
              Result := CompareMem(TMemoryStream(SrcStream).Memory, TMemoryStream(DstStream).Memory, DstStream.Size);
          finally
            FreeStream(SrcStream, Src);
          end;
        finally
          FreeStream(DstStream, Self);
        end;
      end;
    end;
  end;
end;

function TCustomBitmapItem.ScaleStored: Boolean;
begin
  Result := FScale <> ScaleDefault;
end;

procedure TCustomBitmapItem.Assign(Source: TPersistent);
var
  Src: TCustomBitmapItem;
begin
  if (Source = nil) or (Source is TCustomBitmapItem) then
  begin
    Src := TCustomBitmapItem(Source);
    if Src = nil then
    begin
      if (Width > 0) or (Height > 0) then
      begin
        Clear;
        Changed(False);
      end;
      FileName := '';
      FFixed := False;
    end
    else
    begin
      FFixed := False;
      FileName := Src.FileName;
      Clear;
      if Src.Dormant then
      begin
        if Src.FStream <> nil then
        begin
          Src.FStream.Position := 0;
          FStream.LoadFromStream(Src.FStream);
          FWidth := Src.Width;
          FHeight := Src.Height;
        end;
      end
      else
      begin
        if (Src.FBitmap <> nil) and (not Src.FBitmap.IsEmpty) then
        begin
          Src.FBitmap.SaveToStream(FStream);
          FWidth := Src.FBitmap.Width;
          FHeight := Src.FBitmap.Height;
        end;
      end;
      FFixed := Src.Fixed;
      Scale := Src.Scale;
      Changed(False);
    end;
  end
  else
    inherited;
end;

procedure TCustomBitmapItem.Clear;
begin
  if FStream <> nil then
    FStream.Clear;
  if FBitmap <> nil then
    FBitmap.SetSize(0, 0);
  Dormant := True;
  FWidth := 0;
  FHeight := 0;
end;

function TCustomBitmapItem.GetIsEmpty: Boolean;
begin
  if Dormant then
    Result := (FStream = nil) or (FStream.Size <= 0)
  else
    Result := (FBitmap = nil) or FBitmap.IsEmpty;
end;

function TCustomBitmapItem.BitmapStored: Boolean;
begin
  Result := not IsEmpty;
end;

function TCustomBitmapItem.GetBitmap: TBitmapOfItem;
begin
  Dormant := False;
  Result := FBitmap;
end;

procedure TCustomBitmapItem.SetBitmap(const Value: TBitmapOfItem);
begin
  if Dormant then
  begin
    FStream.Clear;
    if Value <> nil then
      Value.SaveToStream(FStream);
  end
  else
  begin
    FBitmap.Assign(Value);
    FBitmap.BitmapScale := FScale;
  end;
end;

procedure TCustomBitmapItem.ReadBitmap(Stream: TStream);
begin
  if Dormant then
  begin
    FStream.Clear;
    FStream.LoadFromStream(Stream);
  end
  else
  begin
    FBitmap.LoadFromStream(Stream);
    FWidth := FBitmap.Width;
    FHeight := FBitmap.Height;
    FBitmap.BitmapScale := FScale;
  end;
end;

procedure TCustomBitmapItem.WriteBitmap(Stream: TStream);
begin
  if Dormant then
  begin
    FStream.Position := 0;
    FStream.SaveToStream(Stream);
  end
  else
    FBitmap.SaveToStream(Stream);
end;

procedure TCustomBitmapItem.SetCollection(Value: TCollection);
begin
  ValidateInheritance(Value, TCustomMultiResBitmap);
  if (Value <> nil) and TCustomMultiResBitmap(Value).Fixed then
    raise EMultiResBitmap.CreateFMT(StrEChangeFixed, ['MultiResBitmap']);
  try
    if Value <> nil then
    begin
      if FScale <= 0 then
        FScale := ScaleDefault;
      while TCustomMultiResBitmap(Value).ItemByScale(FScale, True, True) <> nil do
        FScale := FScale + 1;
    end;
    inherited SetCollection(Value);
  finally
    FMultiResBitmap := TCustomMultiResBitmap(inherited Collection);
  end;
end;

function TCustomBitmapItem.GetComponent: TComponent;
var
  Parent: TPersistent;
begin
  Parent := self;
  repeat
    if Parent is TOwnedCollection then
      Parent := TOwnedCollection(Parent).Owner
    else if Parent is TCollectionItem then
      Parent := TCollectionItem(Parent).Collection
    else if not(Parent is TComponent) then
      Parent := nil;
  until (Parent = nil) or (Parent is TComponent);
  Result := TComponent(Parent);
end;

function TCustomBitmapItem.GetDisplayName: string;
begin
  if IsEmpty then
    Result := string.Format(StrScaleName, [SEmpty, Scale])
  else
    Result := string.Format(StrScaleFormat, [Scale])
end;

procedure TCustomBitmapItem.SetIndex(Value: Integer);
begin
  if Value <> inherited Index then
  begin
    if (MultiResBitmap <> nil) and (not MultiResBitmap.Fixed) then
      inherited
    else
      raise EMultiResBitmap.CreateFMT(StrEChangeFixed, ['MultiResBitmap']);
  end;
end;

function TCustomBitmapItem.GetFixed: Boolean;
begin
  if (MultiResBitmap <> nil) and (MultiResBitmap.Owner is TComponent) then
    Result := FFixed and (TComponent(MultiResBitmap.Owner).ComponentState * [csLoading, csDestroying] = [])
  else
    Result := False;
end;

class function TCustomBitmapItem.ScaleOfBitmap(const SourceSize, DestinationSize: TSize): Double;
var
  HScale, VScale: Double;
begin
  if SourceSize.cx > 0 then
    HScale := DestinationSize.cx / SourceSize.cx
  else
    HScale := 1;
  if SourceSize.cy > 0 then
    VScale := DestinationSize.cy / SourceSize.cy
  else
    VScale := 1;
  Result := Min(HScale, VScale);
end;

class function TCustomBitmapItem.RectOfBitmap(const SourceSize, DestinationSize: TSize): TRect;
var
  W, H: Integer;
  LScale: Double;
begin
  LScale := ScaleOfBitmap(SourceSize, DestinationSize);
  W := Round(SourceSize.cx * LScale);
  H := Round(SourceSize.cy * LScale);
  Result.Left := (DestinationSize.cx - W) div (2);
  Result.Top := (DestinationSize.cy - H) div (2);
  Result.Width := W;
  Result.Height := H;
end;

function TCustomBitmapItem.CreateBitmap(const AFileName: string = ''): TBitmap;
var
  C: TAlphaColorRec;
  CC: TColorRec;
  Data: TBitmapData;
  X, Y: Integer;
  LSize: TSize;
  LName: String;
  TmpBitmap: TBitmap;
  R: TRect;
  SrcRect, DstRect: TRectF;
begin
  Result := nil;
  LName := AFileName;
  if Trim(LName) = '' then
    LName := FileName;
  LSize := TSize.Create(0, 0);
  CC.Color := TColors.SysNone;
  if MultiResBitmap <> nil then
  begin
    case MultiResBitmap.SizeKind of
      TSizeKind.Custom:
        LSize := TSize.Create(MultiResBitmap.Width, MultiResBitmap.Height);
      TSizeKind.Default:
        LSize := MultiResBitmap.DefaultSize;
    end;
    CC.Color := MultiResBitmap.TransparentColor;
  end;
  LSize.cx := Round(LSize.cx * Scale);
  LSize.cy := Round(LSize.cy * Scale);
  if not TBitmapCodecManager.CodecExists(ExtractFileExt(LName)) then
    raise EMultiResBitmap.CreateFMT(SInvalidFileName, [LName]);
  TmpBitmap := TBitmap.Create(0, 0);
  try
    TmpBitmap.LoadFromFile(LName);
    // replace transparent color
    if CC.Color <> TColors.SysNone then
    begin
      TmpBitmap.Map(TMapAccess.ReadWrite, Data);
      try
        if CC.Color = TColors.SysDefault then
        begin
          C.Color := Data.GetPixel(0, TmpBitmap.Height - 1);
          C.A := 255;
        end
        else
        begin
          CC.Color := TColors.ColorToRGB(CC.Color);
          C.A := 255;
          C.R := CC.R;
          C.G := CC.G;
          C.B := CC.B;
        end;
        for Y := 0 to TmpBitmap.Height - 1 do
          for X := 0 to TmpBitmap.Width - 1 do
          begin
            if C.Color = (TAlphaColorRec.Alpha) or Data.GetPixel(X, Y) then
              Data.SetPixel(X, Y, TAlphaColorRec.Null);
          end;
      finally
        TmpBitmap.Unmap(Data);
      end;
    end;
    // Resize bitmap
    if (LSize.cx > 0) and (LSize.cy > 0) then
    begin
      R := RectOfBitmap(TSize.Create(TmpBitmap.Width, TmpBitmap.Height), LSize);
      if (LSize.cx <> TmpBitmap.Width) or (LSize.cy <> TmpBitmap.Height) then
      begin
        Result := TBitmap.Create(LSize.cx, LSize.cy);
        try
          SrcRect := TRectF.Create(0, 0, TmpBitmap.Width, TmpBitmap.Height);
          DstRect := TRectF.Create(R);
          if Result.Canvas.BeginScene then
            try
              Result.Clear(TAlphaColorRec.Null);
              Result.Canvas.DrawBitmap(TmpBitmap, SrcRect, DstRect, 1, False);
            finally
              Result.Canvas.EndScene;
            end;
        except
          FreeAndNil(Result);
          raise;
        end;
      end
      else
        Result := TmpBitmap; // original size
    end
    else
      Result := TmpBitmap; // original size
  finally
    if TmpBitmap <> Result then
      FreeAndNil(TmpBitmap);
  end;
end;

procedure TCustomBitmapItem.ReadWidth(Reader: TReader);
begin
  FWidth := Reader.ReadInteger;
end;

procedure TCustomBitmapItem.WriteWidth(Writer: TWriter);
begin
  Writer.WriteInteger(FWidth);
end;

procedure TCustomBitmapItem.ReadHeight(Reader: TReader);
begin
  FHeight := Reader.ReadInteger;
end;

procedure TCustomBitmapItem.WriteHeight(Writer: TWriter);
begin
  Writer.WriteInteger(FHeight);
end;

procedure TCustomBitmapItem.ReadFileName(Reader: TReader);
begin
  FileName := Reader.ReadString;
end;

procedure TCustomBitmapItem.WriteFileName(Writer: TWriter);
begin
  Writer.WriteString(FileName);
end;

procedure TCustomBitmapItem.SetFixed(const Value: Boolean);
begin
  FFixed := Value;
end;

procedure TCustomBitmapItem.SetScale(const Value: Single);
var
  LValue: Single;
begin
  LValue := RoundTo(Value, ScaleRange);
  if FScale <> LValue then
  begin
    if Fixed then
      raise EMultiResBitmap.CreateFMT(StrEChangeFixed, ['BitmapItem']);
    if (LValue <= 0) or (LValue > ScaleMax) then
      raise EMultiResBitmap.CreateFMT(SOutOfRange, [0, ScaleMax]);
    if (Collection <> nil) and (TCustomMultiResBitmap(Collection).ItemByScale(LValue, True, True) <> nil) then
      raise EMultiResBitmap.CreateFMT(StrEDupScale, [Format(StrScaleFormat, [LValue])]);
    FScale := LValue;
    if FBitmap <> nil then
      FBitmap.BitmapScale := FScale;
    Changed(False);
  end;
end;

{ TCustomMultiResBitmap }

function TCustomMultiResBitmap.Equals(Obj: TObject): Boolean;
var
  Src: TCustomMultiResBitmap;
  I: Integer;
begin
  Result := inherited;
  if not Result then
  begin
    if Obj = nil then
      Result := (TransparentColor = TColors.SysNone) and (SizeKind = TSizeKind.Custom) and (Width = 0) and
        (Height = 0) and (Count = 0)
    else if Obj is TCustomMultiResBitmap then
    begin
      Src := TCustomMultiResBitmap(Obj);
      Result := (TransparentColor = Src.TransparentColor) and (SizeKind = Src.SizeKind) and (Width = Src.Width) and
       (Height = Src.Height) and (Count = Src.Count);
      if Result then
        for I := 0 to Count - 1 do
          if not Items[I].Equals(Src.Items[I]) then
            Exit(False);
    end;
  end;
end;

procedure TCustomMultiResBitmap.Assign(Source: TPersistent);
var
  Src: TCustomMultiResBitmap;
  Item: TCustomBitmapItem;
  SourceName: string;
  I: Integer;
begin
  if (Source = nil) or (Source is TCustomMultiResBitmap) then
  begin
    Src := TCustomMultiResBitmap(Source);
    BeginUpdate;
    try
      if Src = nil then
      begin
        Clear;
        TransparentColor := TColors.SysNone;
        SizeKind := TSizeKind.Custom;
        Width := 0;
        Height := 0;
        FFixed := False;
      end
      else
      begin
        FFixed := False;
        Clear;
        TransparentColor := Src.TransparentColor;
        SizeKind := Src.SizeKind;
        Width := Src.Width;
        Height := Src.Height;
        for I := Src.Count - 1 downto 0 do
        begin
          Item := Add;
          Item.FFixed := False;
          Item.Assign(Src.Items[I]);
          Item.FFixed := Src.Items[I].Fixed;
        end;
        FFixed := Src.Fixed;
      end;
    finally
      EndUpdate;
    end;
  end
  else
  begin
    SourceName := Source.ClassName;
    raise EConvertError.CreateFMT(SAssignError, [SourceName, ClassName]);
  end;
end;

constructor TCustomMultiResBitmap.Create(AOwner: TPersistent; ItemClass: TCustomBitmapItemClass);
begin
  inherited Create(AOwner, ItemClass);
  FTransparentColor := TColors.SysNone;
end;

function TCustomMultiResBitmap.GetComponent: TComponent;
var
  Parent: TPersistent;
begin
  Parent := self;
  repeat
    if Parent is TOwnedCollection then
      Parent := TOwnedCollection(Parent).Owner
    else if Parent is TCollectionItem then
      Parent := TCollectionItem(Parent).Collection
    else if not(Parent is TComponent) then
      Parent := nil;
  until (Parent = nil) or (Parent is TComponent);
  Result := TComponent(Parent);
end;

function TCustomMultiResBitmap.GetDefaultSize: TSize;
begin
  Result := TSize.Create(32, 32);
end;

function TCustomMultiResBitmap.GetFixed: Boolean;
begin
  if Owner is TComponent then
  begin
    Result := FFixed and (TComponent(Owner).ComponentState * [csLoading, csDestroying] = [])
  end
  else
    Result := False;
end;

function TCustomMultiResBitmap.Add: TCustomBitmapItem;
begin
  Result := TCustomBitmapItem(inherited Add);
end;

function TCustomMultiResBitmap.AddOrSet(const Scale: Single; const FileName: string): TCustomBitmapItem;
var
  TmpBitmap: TBitmap;
  LNew: Boolean;
begin
  Result := ItemByScale(Scale, True, True);
  LNew := Result = nil;
  if LNew then
  begin
    Result := Add;
    Result.Scale := Scale;
  end;
  try
    TmpBitmap := Result.CreateBitmap(FileName);
    try
      if TmpBitmap <> nil then
        Result.Bitmap.Assign(TmpBitmap);
    finally
      TmpBitmap.Free;
    end;
  except
    if LNew then
      Delete(Result.Index);
    raise;
  end;
  Result.FileName := FileName;
end;

function TCustomMultiResBitmap.Insert(Index: Integer): TCustomBitmapItem;
begin
  Result := TCustomBitmapItem(inherited Insert(Index));
end;

function TCustomMultiResBitmap.GetItem(Index: Integer): TCustomBitmapItem;
begin
  Result := TCustomBitmapItem(inherited GetItem(Index));
end;

procedure TCustomMultiResBitmap.SetItem(Index: Integer; const Value: TCustomBitmapItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TCustomMultiResBitmap.Notify(Item: TCollectionItem; Action: TCollectionNotification);
begin
  if (Item <> nil) and (Action = cnDeleting) and Fixed then
    raise EMultiResBitmap.CreateFMT(StrEChangeFixed, ['MultiResBitmap']);
  inherited;
end;

procedure TCustomMultiResBitmap.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Height', ReadHeight, WriteHeight, (Height > 0) and (Height <> GetDefaultSize.cy));
  Filer.DefineProperty('Width', ReadWidth, WriteWidth, (Width > 0) and (Width <> GetDefaultSize.cx));
  Filer.DefineProperty('LoadSize', ReadLoadSize, WriteLoadSize, SizeKind <> TSizeKind.Custom);
  Filer.DefineProperty('TransparentColor', ReadColor, WriteColor, TransparentColor <> TColors.SysNone);
end;

function TCustomMultiResBitmap.ScaleArray(IncludeEmpty: Boolean): TArray<Single>;
var
  I, J: Integer;
  List: TList<TScaleName>;
  Comparer: TScaleNameComparer;
  S: Single;
  ScaleName: TScaleName;
  Found: Boolean;

begin
  Comparer := TScaleNameComparer.Create;
  List := TList<TScaleName>.Create(Comparer);
  try
    for I := 0 to Count - 1 do
      if (IncludeEmpty or (not Items[I].IsEmpty)) then
      begin
        S := Items[I].Scale;
        Found := False;
        for J := 0 to List.Count - 1 do
          if SameValue(List[J].Scale, S, TEpsilon.Scale) then
          begin
            Found := True;
            Break;
          end;
        if not Found then
        begin
          ScaleName.Scale := S;
          ScaleName.Name := '';
          List.Add(ScaleName);
        end;
      end;
    List.Sort;
    SetLength(Result, List.Count);
    for I := 0 to List.Count - 1 do
      Result[I] := List[I].Scale;
  finally
    FreeAndNil(List);
  end;
end;

function TCustomMultiResBitmap.ItemByScale(const AScale: Single; const ExactMatch: Boolean; const IncludeEmpty: Boolean)
  : TCustomBitmapItem;
var
  LScale, LCurrentScale: Single;
  I, LCount: Integer;
  LScaleArray: TArray<Single>;
begin
  LScale := RoundTo(AScale, TCustomBitmapItem.ScaleRange);
  Result := nil;
  if not ExactMatch then
  begin
    LScaleArray := ScaleArray(IncludeEmpty);
    LCount := Length(LScaleArray);
    if LCount > 0 then
    begin
      I := -1;
      repeat
        Inc(I)
      until (LScale < LScaleArray[I]) or (I >= LCount - 1);
      if I > 0 then
      begin
        LCurrentScale := LScaleArray[I - 1] + (LScaleArray[I] - LScaleArray[I - 1]) / 5;
        if LScale <= LCurrentScale then
          Dec(I);
      end;
      LScale := LScaleArray[I];
    end;
  end;
  for I := 0 to Count - 1 do
    if SameValue(LScale, Items[I].Scale, TEpsilon.Scale) and (IncludeEmpty or (not Items[I].IsEmpty)) then
    begin
      Result := Items[I];
      Exit;
    end
end;

type
  TWrapperMultiResBitmap = class(TComponent)
  private
    FBitmaps: TCustomMultiResBitmap;
  published
    property Bitmaps: TCustomMultiResBitmap read FBitmaps write FBitmaps;
  end;

procedure TCustomMultiResBitmap.LoadFromStream(S: TStream);
var
  Wrapper: TWrapperMultiResBitmap;
begin
  Wrapper := TWrapperMultiResBitmap.Create(nil);
  try
    BeginUpdate;
    try
      Clear;
      Wrapper.Bitmaps := self;
      S.ReadComponent(Wrapper);
    finally
      EndUpdate
    end;
  finally
    FreeAndNil(Wrapper);
  end;
end;

procedure TCustomMultiResBitmap.SaveToStream(S: TStream);
var
  Wrapper: TWrapperMultiResBitmap;
begin
  Wrapper := TWrapperMultiResBitmap.Create(nil);
  try
    Wrapper.Bitmaps := self;
    S.WriteComponent(Wrapper);
  finally
    FreeAndNil(Wrapper);
  end;
end;

procedure TCustomMultiResBitmap.ReadHeight(Reader: TReader);
begin
  Height := Reader.ReadInteger;
end;

procedure TCustomMultiResBitmap.WriteHeight(Writer: TWriter);
begin
  Writer.WriteInteger(Height);
end;

procedure TCustomMultiResBitmap.ReadWidth(Reader: TReader);
begin
  Width := Reader.ReadInteger;
end;

procedure TCustomMultiResBitmap.WriteWidth(Writer: TWriter);
begin
  Writer.WriteInteger(Width);
end;

procedure TCustomMultiResBitmap.ReadLoadSize(Reader: TReader);
var
  B: Integer;
begin
  B := $0000000F and Reader.ReadInteger;
  if (B >= Byte(Low(TSizeKind))) and (B <= Byte(High(TSizeKind))) then
    SizeKind := TSizeKind(B)
end;

procedure TCustomMultiResBitmap.WriteLoadSize(Writer: TWriter);
begin
  Writer.WriteInteger($0000000F and Integer(SizeKind));
end;

procedure TCustomMultiResBitmap.ReadColor(Reader: TReader);
begin
  FTransparentColor := Reader.ReadInteger;
end;

procedure TCustomMultiResBitmap.WriteColor(Writer: TWriter);
begin
  Writer.WriteInteger(TransparentColor);
end;

procedure TCustomMultiResBitmap.LoadItemFromStream(Stream: TStream; Scale: Single);
var
  B: TBitmap;
  Item: TCustomBitmapItem;
  LFound: Boolean;
begin
  B := nil;
  Item := ItemByScale(Scale, True, True);
  if Item <> nil then
    B := Item.Bitmap;
  LFound := B <> nil;
  if not LFound then
    B := TBitmap.Create(0, 0);
  try
    B.LoadFromStream(Stream);
    if not LFound then
    begin
      BeginUpdate;
      try
        if Item = nil then
          Item := Add;
        Item.Scale := Scale;
        Item.Bitmap.Assign(B);
        Item.Dormant := True;
      finally
        EndUpdate;
      end;
    end;
  finally
    if not LFound then
      FreeAndNil(B);
  end;
end;

function TCustomMultiResBitmap.GetBitmaps(Scale: Single): TBitmapOfItem;
var
  Item: TCustomBitmapItem;
begin
  Scale := RoundTo(Scale, TCustomBitmapItem.ScaleRange);
  Item := ItemByScale(Scale, True, True);
  if Item <> nil then
    Result := Item.Bitmap
  else
    Result := nil;
end;

procedure TCustomMultiResBitmap.SetBitmaps(Scale: Single; const Value: TBitmapOfItem);
var
  Item: TCustomBitmapItem;
begin
  Scale := RoundTo(Scale, TCustomBitmapItem.ScaleRange);
  Item := ItemByScale(Scale, True, True);
  if Item <> nil then
  begin
    if (Value <> nil) and (not Value.IsEmpty) then
      Item.Bitmap.Assign(Value)
    else
    begin
      if Fixed then
        Item.Clear
      else
        Delete(Item.Index);
    end;
  end
  else
  begin
    if Value <> nil then
    begin
      Item := Add;
      Item.Scale := Scale;
      Item.Bitmap.Assign(Value);
    end;
  end;
end;

procedure TCustomMultiResBitmap.SetFixed(const Value: Boolean);
begin
  FFixed := Value;
end;

var
  vScaleList: TScaleList;
  vScaleNameComparer: TScaleNameComparer;

  { TScaleNameComparer }

function TScaleNameComparer.Compare(const Left, Right: TScaleName): Integer;
begin
  if Left.Scale < Right.Scale then
    Result := -1
  else if Left.Scale > Right.Scale then
    Result := 1
  else
    Result := 0;
end;

function ScaleList: TScaleList;
begin
  if vScaleList = nil then
  begin
    vScaleNameComparer := TScaleNameComparer.Create;
    vScaleList := TScaleList.Create(vScaleNameComparer);
  end;
  Result := vScaleList;
end;

function RegisterScaleName(Scale: Single; Name: string): Boolean;
var
  R: TScaleName;
  I: Integer;
begin
  Result := False;
  if ScaleList <> nil then
  begin
    R.Scale := RoundTo(Scale, TCustomBitmapItem.ScaleRange);
    R.Name := Name;
    for I := 0 to vScaleList.Count - 1 do
      if ScaleList[I].Scale = R.Scale then
      begin
        ScaleList[I] := R;
        Exit;
      end;
    ScaleList.Add(R);
    Result := True;
  end;
end;

{ TFixedBitmapItem }

constructor TFixedBitmapItem.Create(Collection: TCollection);
begin
  inherited;
  if Collection is TCustomMultiResBitmap then
    SetFixed(TCustomMultiResBitmap(Collection).Fixed);
end;

function TFixedBitmapItem.GetDisplayName: string;
  function GetName: string;
  var
    I: Integer;
  begin
    for I := 0 to ScaleList.Count - 1 do
      if Scale = ScaleList[I].Scale then
      begin
        Result := ScaleList[I].Name;
        Exit;
      end;
    Result := StrOther;
  end;

begin
  if IsEmpty then
    Result := inherited GetDisplayName
  else
    Result := string.Format(StrScaleName, [GetName, Scale]);
end;

{ TFixedMultiResBitmap }

constructor TFixedMultiResBitmap.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner, TFixedBitmapItem);
  CreateItems;
end;

constructor TFixedMultiResBitmap.Create(AOwner: TPersistent; ItemClass: TFixedBitmapItemClass);
begin
  inherited Create(AOwner, ItemClass);
  CreateItems;
end;

procedure TFixedMultiResBitmap.CreateItem(Scale: Single);
var
  I: Integer;
  NewItem: TCustomBitmapItem;
  OldFixed: Boolean;
begin
  Scale := RoundTo(Scale, TCustomBitmapItem.ScaleRange);
  for I := 0 to Count - 1 do
    if Items[I].Scale = Scale then
      Exit;
  NewItem := Add;
  OldFixed := Fixed;
  NewItem.SetFixed(False);
  try
    NewItem.Scale := Scale;
    for I := 0 to ScaleList.Count - 1 do
      if ScaleList[I].Scale = Scale then
      begin
        NewItem.Index := I;
        Break;
      end;
  finally
    NewItem.SetFixed(OldFixed);
  end;
end;

procedure TFixedMultiResBitmap.UpdateFixed;
var
  I, J: Integer;
begin
  for I := 0 to ScaleList.Count - 1 do
  begin
    for J := 0 to Count - 1 do
      if Items[J].Scale = ScaleList[I].Scale then
      begin
        Items[J].SetFixed(True);
        Break;
      end;
  end;
end;

procedure TFixedMultiResBitmap.CreateItems;
var
  I: Integer;
  OldFixed: Boolean;
begin
  OldFixed := Fixed;
  SetFixed(False);
  try
    for I := 0 to ScaleList.Count - 1 do
      CreateItem(ScaleList[I].Scale);
    UpdateFixed;
  finally
    SetFixed(OldFixed);
  end;
end;

procedure TFixedMultiResBitmap.EndUpdate;
begin
  if UpdateCount = 1 then
    CreateItems;
  inherited;
end;

function TFixedMultiResBitmap.Add: TFixedBitmapItem;
begin
  Result := TFixedBitmapItem(inherited Add);
end;

function TFixedMultiResBitmap.Insert(Index: Integer): TFixedBitmapItem;
begin
  Result := TFixedBitmapItem(inherited Insert(Index));
end;

function TFixedMultiResBitmap.GetItem(Index: Integer): TFixedBitmapItem;
begin
  Result := TFixedBitmapItem(inherited GetItem(Index));
end;

procedure TFixedMultiResBitmap.SetItem(Index: Integer; const Value: TFixedBitmapItem);
begin
  inherited SetItem(Index, Value);
end;

{$ENDREGION}

procedure RegisterAliases;
begin
  AddEnumElementAliases(TypeInfo(TSizeKind), ['skCustom', 'skDefault', 'skSource']);
end;

procedure UnregisterAliases;
begin
  RemoveEnumElementAliases(TypeInfo(TSizeKind));
end;

initialization
  RegisterAliases;
  vScaleNameComparer := nil;
  vScaleList := nil;
  StrScaleFormat := Format('(%%5.%df)', [Abs(TCustomBitmapItem.ScaleRange)]);
  StrScaleName := Format('%%s (%%5.%df)', [Abs(TCustomBitmapItem.ScaleRange)]);
  RegisterScaleName(1, StrScale1);
//RegisterScaleName(2, StrScale2);

finalization
  UnregisterAliases;
  FreeAndNil(vScaleList);

end.
