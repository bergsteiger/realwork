{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Vcl.Bind.GenData;

interface

implementation

uses
 System.Classes, Data.Bind.Components,
    System.RTTI, Vcl.Graphics,
    Generics.Collections, System.SysUtils, Data.Bind.ObjectScope,
    System.Math, System.UITypes, System.Types;


type
  TBitmapGenerator = class(TDelegateValueGenerator)
  private
    function MakeBitmap(AIndex: Integer): TBitmap;
  protected
    function CreateDelegate: TValueGeneratorDelegate; override;
  end;


  TInternalBitmap = class(TBitmap, IStreamPersist)
  protected
    procedure SaveToStream(Stream: TStream); override;                         
    procedure AssignTo(ADest: TPersistent); override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
  end;

function TBitmapGenerator.CreateDelegate: TValueGeneratorDelegate;
const
  cCount = 50;
var
  ADelegate: TValueGeneratorDelegateWithEvents;
  LList: TList<Integer>;
  I: Integer;
begin
  ADelegate := nil;
  case FieldType of
    ftBitmap,
    ftString:
    begin
      LList := TList<integer>.Create;
      try
        for I := 1 to cCount do
          LList.Add(I);
        ADelegate := TTypedListValueGeneratorDelegate<Integer>.Create(Options, LList.ToArray);
        if FieldType = ftBitmap then
          ADelegate.OnGetValue :=
            function(AValue: TValue; var AFree: Boolean): TValue
            begin
              Result := MakeBitmap(AValue.AsInteger);
              AFree := True;
            end
        else
          ADelegate.OnGetValue :=
            function(AValue: TValue; var AFree: Boolean): TValue
            begin
              Result := Format('Bitmap%d', [AValue.AsInteger]);
            end
      finally
        LList.Free;
      end;
    end;
  else
    Assert(False);
  end;
  Result := ADelegate;
end;

const
  // Arbitrary colors for bitmaps
  CColorValues: array[0..43] of TColor =
  (
TColorRec.Darkblue, //    Darkblue = Alpha or TAlphaColor($00008B);
TColorRec.Darkcyan, //    Darkcyan = Alpha or TAlphaColor($008B8B);
TColorRec.Darkgoldenrod, //    Darkgoldenrod = Alpha or TAlphaColor($B8860B);
TColorRec.Darkgray, //    Darkgray = Alpha or TAlphaColor($A9A9A9);
TColorRec.Darkgreen, //    Darkgreen = Alpha or TAlphaColor($006400);
TColorRec.Darkgrey, //    Darkgrey = Alpha or TAlphaColor($A9A9A9);
TColorRec.Darkkhaki, //    Darkkhaki = Alpha or TAlphaColor($BDB76B);
TColorRec.Darkmagenta, //    Darkmagenta = Alpha or TAlphaColor($8B008B);
TColorRec.Darkolivegreen, //    Darkolivegreen = Alpha or TAlphaColor($556B2F);
TColorRec.Darkorange, //    Darkorange = Alpha or TAlphaColor($FF8C00);
TColorRec.Darkorchid, //    Darkorchid = Alpha or TAlphaColor($9932CC);
TColorRec.Darkred, //    Darkred = Alpha or TAlphaColor($8B0000);
TColorRec.Darksalmon, //    Darksalmon = Alpha or TAlphaColor($E9967A);
TColorRec.Darkseagreen, //    Darkseagreen = Alpha or TAlphaColor($8FBC8F);
TColorRec.Darkslateblue, //    Darkslateblue = Alpha or TAlphaColor($483D8B);
TColorRec.Darkslategray, //    Darkslategray = Alpha or TAlphaColor($2F4F4F);
TColorRec.Darkslategrey, //    Darkslategrey = Alpha or TAlphaColor($2F4F4F);
TColorRec.Darkturquoise, //    Darkturquoise = Alpha or TAlphaColor($00CED1);
TColorRec.Darkviolet, //    Darkviolet = Alpha or TAlphaColor($9400D3);
TColorRec.Lightblue, //    Lightblue = Alpha or TAlphaColor($ADD8E6);
TColorRec.Lightcoral, //    Lightcoral = Alpha or TAlphaColor($F08080);
TColorRec.Lightcyan, //    Lightcyan = Alpha or TAlphaColor($E0FFFF);
TColorRec.Lightgoldenrodyellow, //    Lightgoldenrodyellow = Alpha or TAlphaColor($FAFAD2);
TColorRec.Lightgray, //    Lightgray = Alpha or TAlphaColor($D3D3D3);
TColorRec.Lightgreen, //    Lightgreen = Alpha or TAlphaColor($90EE90);
TColorRec.Lightgrey, //    Lightgrey = Alpha or TAlphaColor($D3D3D3);
TColorRec.Lightpink, //    Lightpink = Alpha or TAlphaColor($FFB6C1);
TColorRec.Lightsalmon, //    Lightsalmon = Alpha or TAlphaColor($FFA07A);
TColorRec.Lightseagreen, //    Lightseagreen = Alpha or TAlphaColor($20B2AA);
TColorRec.Lightskyblue, //    Lightskyblue = Alpha or TAlphaColor($87CEFA);
TColorRec.Lightslategray, //    Lightslategray = Alpha or TAlphaColor($778899);
TColorRec.Lightslategrey, //    Lightslategrey = Alpha or TAlphaColor($778899);
TColorRec.Lightsteelblue, //    Lightsteelblue = Alpha or TAlphaColor($B0C4DE);
TColorRec.Lightyellow, //    Lightyellow = Alpha or TAlphaColor($FFFFE0);
TColorRec.Mediumaquamarine, //    Mediumaquamarine = Alpha or TAlphaColor($66CDAA);
TColorRec.Mediumblue, //    Mediumblue = Alpha or TAlphaColor($0000CD);
TColorRec.Mediumorchid, //    Mediumorchid = Alpha or TAlphaColor($BA55D3);
TColorRec.Mediumpurple, //    Mediumpurple = Alpha or TAlphaColor($9370DB);
TColorRec.Mediumseagreen, //    Mediumseagreen = Alpha or TAlphaColor($3CB371);
TColorRec.Mediumslateblue, //    Mediumslateblue = Alpha or TAlphaColor($7B68EE);
TColorRec.Mediumspringgreen, //    Mediumspringgreen = Alpha or TAlphaColor($00FA9A);
TColorRec.Mediumturquoise, //    Mediumturquoise = Alpha or TAlphaColor($48D1CC);
TColorRec.Mediumvioletred, //    Mediumvioletred = Alpha or TAlphaColor($C71585);
TColorRec.Midnightblue //    Midnightblue = Alpha or TAlphaColor($191970);
  );

function TBitmapGenerator.MakeBitmap(AIndex: Integer): TBitmap;
var
  BMP   : TBitmap;
  C     : TCanvas;
  LColor: TColor;
  LWidth: Integer;
  LHeight: Integer;
  LColorIndex: Integer;
  LText: string;
  LRect: TRect;
begin
  LWidth := 100;
  LHeight := 100;
  LColorIndex := AIndex mod Length(CColorValues);
  Assert(LColorIndex >= 0);
  Assert(LColorIndex < Length(CColorValues));
  LColor := CColorValues[LColorIndex];

  BMP := TInternalBitmap.Create;
  BMP.SetSize(LWidth, LHeight);
  C := BMP.Canvas;
  C.Brush.Color := LColor;
  C.Pen.Color := TColorRec.Black;
  C.Pen.Width := 5;
  C.Rectangle(0, 0, LWidth, LHeight);
  C.Font.Size := 24;
  LText := IntToStr(AIndex);
  LRect := Rect(0, 20, LWidth, LHeight);
  C.TextRect(LRect, LText, [TTextFormats.tfExternalLeading, TTextFormats.tfCenter]);

  Result := BMP;
end;


type
  TGraphicHeader = record
    Count: Word;                { Fixed at 1 }
    HType: Word;                { Fixed at $0100 }
    Size: Longint;              { Size not including header }
  end;

procedure TInternalBitmap.Assign(ASource: TPersistent);
begin
  if ASource is TPicture then
    inherited Assign(TPicture(ASource).Bitmap)
  else
    inherited;
end;

procedure TInternalBitmap.AssignTo(ADest: TPersistent);
var
  BlobStream: TStream;
  Size: Longint;
  Header: TGraphicHeader;
  LStreamPersist: IStreamPersist;
begin
  if Supports(ADest, IStreamPersist, LStreamPersist) then
  begin
    BlobStream := TMemoryStream.Create;
    try
      SaveToStream(BlobStream);
      Size := BlobStream.Size;
      if Size >= SizeOf(TGraphicHeader) then
      begin
        BlobStream.Read(Header, SizeOf(Header));
        if (Header.Count <> 1) or (Header.HType <> $0100) or
          (Header.Size <> Size - SizeOf(Header)) then
          BlobStream.Position := 0;
      end;
      LStreamPersist.LoadFromStream(BlobStream);
    finally
      BlobStream.Free;
    end;
  end;
end;


constructor TInternalBitmap.Create;
begin
  inherited;
end;

destructor TInternalBitmap.Destroy;
begin

  inherited;
end;

procedure TInternalBitmap.SaveToStream(Stream: TStream);
begin
  inherited; //TBitmapCodecManager.SaveToStream(Stream, Self, '.bmp');
end;


const
  sDfm = 'DFM';
  sThisUnit = 'Vcl.Bind.GenData';
  sBitmaps = 'Bitmaps';
  sBitmapNames = 'BitmapNames';

  sBitmapsField = 'Bitmap%d';
  sBitmapNamesField = 'BitmapName%d';

procedure RegisterGenerators;
begin
  RegisterValueGenerator(sBitmaps, [ftBitmap], TValueGeneratorDescription.Create(TBitmapGenerator, sBitmapsField, sThisUnit), sDfm); //sFmx);
  RegisterValueGenerator(sBitmapNames, [ftString], TValueGeneratorDescription.Create(TBitmapGenerator, sBitmapNamesField, sThisUnit), sDfm); //sFmx);
end;

procedure UnRegisterGenerators;
begin
  UnRegisterValueGenerator(sBitmaps, [ftBitmap], sDfm);
  UnRegisterValueGenerator(sBitmapNames, [ftString], sDfm);
end;


initialization
  RegisterGenerators;
finalization
  UnregisterGenerators;
end.
