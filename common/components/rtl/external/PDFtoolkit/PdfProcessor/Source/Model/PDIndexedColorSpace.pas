{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDIndexedColorSpace;

interface

uses
  PDColorSpace, PDElement, gtObject, PDTypes, PDBaseObject;

type
  TgtPDIndexedColorSpace = class(TgtPDColorSpace)
  private
    FBase: TgtPDColorSpace;
    FIndexHigh: Integer;
    FLookup: AnsiString;
    FIndexArray: string;
  public
    constructor Create(ABaseObject: TgtPDBaseObject);
    destructor Destroy; override;

    function GetMode: TgtColorSpaceMode; override;
    function GetNoOfComps: Integer; override;
    function GetBase: TgtPDColorSpace;
    function GetIndexHigh: Integer;
    function GetLookup: AnsiString;
    function MapColorToBase(Color: TgtColor; BaseColor: TgtColor): TgtColor;

    procedure GetDefaultColor(var Color: TgtColor); override;
    procedure GetGray(Color: TgtColor; var GrayColor: TgtGray); override;
    procedure GetRGB(Color: TgtColor; var RGBColor: TgtRGB); override;
    procedure GetCMYK(Color: TgtColor; var CMYKColor: TgtCMYK); override;
    procedure GetDefaultRanges(var DecodeLow, DecodeRange: TgtImageDecodeArray;
      MaxImgPixel: Double); override;
    function Copy: TgtPDColorSpace; override;
    procedure Update; override;
    procedure GetIndexArray(var AIndexArray: AnsiString);
  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  SysUtils, PDArray, PDInteger, PDStream, gtConstants, PDString,
  gtMethods, Stream;

{ TgtPDIndexedColorSpace }

function TgtPDIndexedColorSpace.Copy: TgtPDColorSpace;
var
  LColorSpace: TgtPDIndexedColorSpace;
  LI: Integer;
begin
  LColorSpace := TgtPDIndexedColorSpace.Create(FBaseObject);
  SetLength(LColorSpace.FLookup, Length(FLookup));
  for LI := 0 to Length(FLookup) - 1 do
    LColorSpace.FLookup[LI] := FLookup[LI];

  Result := LColorSpace;
end;

constructor TgtPDIndexedColorSpace.Create(ABaseObject: TgtPDBaseObject);
var
  LObj: TgtPDBaseObject;
  LN, LI, LJ, LX, LLength, LCompLength: Integer;
  LS, LStr, LChar: AnsiString;
  LStream: TgtStream;
begin
  FBaseObject := ABaseObject;
  LStr := '';
  LChar := '';
  LCompLength := 0;

  if (TgtPDArray(FBaseObject).GetLength <> 4) then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Bad Indexed color space');
    {$ENDIF}
    Exit;
  end;

  LObj := TgtPDArray(FBaseObject).Get(1);
  FBase := TgtPDColorSpace.MakeColorSpace(LObj);
  if not Assigned(FBase) then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Bad Indexed color space (base color space)');
    {$ENDIF}
    Exit;
  end;

  LObj := TgtPDArray(FBaseObject).Get(2);
  if not LObj.IsInteger then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Bad Indexed color space (hival)');
    {$ENDIF}
    Exit;
  end;

  FIndexHigh := TgtPDInteger(LObj).Value;
  // the PDF spec requires indexHigh to be in [0,255] -- allowing
  // values larger than 255 creates a security hole: if nComps *
  // indexHigh is greater than 2^31, the loop below may overwrite
  // past the end of the array
  if (FIndexHigh < 0) or (FIndexHigh > 255) then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Bad Indexed color space (invalid indexHigh value)');
    {$ENDIF}
    Exit;
  end;

  LObj := TgtPDArray(FBaseObject).Get(3);
  LN := FBase.GetNoOfComps;
  LCompLength := FIndexHigh * LN + LN;
  SetLength(FLookup, LCompLength);
  if LObj.IsStream then
  begin
    LStream := TgtPDStream(LObj).GetStream;
    LStream.Reset;
    for LI := 0 to FIndexHigh do
    begin
      for LJ := 0 to LN - 1 do
      begin
        LX := LStream.GetChar;
        if LX = ENDOFFILE then
        begin
          {$IFDEF DEBUG}
          Logger.LogError('Bad Indexed color space (lookup table stream too short)');
          {$ENDIF}
          Exit;
        end;
        FLookup[LI * LN + (LJ + 1)] := AnsiChar(LX);
      end;
    end;
    LStream.Close;
  end
  else if LObj.IsString then
  begin
    FIndexArray := TgtPDString(LObj).Value;
    LLength := Length(TgtPDString(LObj).Value);
    if (TgtPDString(LObj).IsHexString and ((LLength / 2) < (FIndexHigh + 1) * LN))
      or (LLength < (FIndexHigh + 1) * LN) then
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Bad Indexed color space (lookup table AnsiString too short)');
      {$ENDIF}
      Exit;
    end;

    LStr := TgtPDString(LObj).Value;
    LX := 1;
    LS := LStr;
    for LI := 0 to FIndexHigh do
    begin
      if TgtPDString(LObj).IsHexString then
      begin
        for LJ := 0 to LN - 1 do
        begin
          LS := '$';
          LS := LS + LStr[LX];
          Inc(LX);
          LS := LS + LStr[LX];
          Inc(LX);
          FLookup[LI * LN + (LJ + 1)] := AnsiChar(StrToIntDef(LS, 0));
        end
      end
      else
      begin
        for LJ := 1 to LN do
        begin
          FLookup[LI * LN + LJ] := LS[LX];
          Inc(LX);
        end;
      end;
    end;
  end
  else
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Bad Indexed color space (lookup table)');
    {$ENDIF}
    Exit;
  end;
end;

destructor TgtPDIndexedColorSpace.Destroy;
begin
  SetLength(FLookup, 0);
  if Assigned(FBase) then
    FBase.Free;
end;

function TgtPDIndexedColorSpace.GetBase: TgtPDColorSpace;
begin
  Result := FBase;
end;

procedure TgtPDIndexedColorSpace.GetCMYK(Color: TgtColor;
  var CMYKColor: TgtCMYK);
var
  LColor: TgtColor;
begin
  FBase.GetCMYK(MapColorToBase(Color, LColor), CMYKColor);
end;

procedure TgtPDIndexedColorSpace.GetDefaultColor(var Color: TgtColor);
begin
  Color.Comps[0] := 0;
end;

procedure TgtPDIndexedColorSpace.GetDefaultRanges(var DecodeLow,
  DecodeRange: TgtImageDecodeArray; MaxImgPixel: Double);
begin
  DecodeLow[0] := 0;
  DecodeRange[0] := MaxImgPixel;
end;

procedure TgtPDIndexedColorSpace.GetGray(Color: TgtColor;
  var GrayColor: TgtGray);
begin
  FBase.GetGray(Color, GrayColor);
end;

procedure TgtPDIndexedColorSpace.GetIndexArray(var AIndexArray: AnsiString);
begin
  AIndexArray := FIndexArray;
end;

function TgtPDIndexedColorSpace.GetIndexHigh: Integer;
begin
  Result := FIndexHigh;
end;

function TgtPDIndexedColorSpace.GetLookup: AnsiString;
begin
  Result := FLookup;
end;

function TgtPDIndexedColorSpace.GetMode: TgtColorSpaceMode;
begin
  Result := csIndexed;
end;

function TgtPDIndexedColorSpace.GetNoOfComps: Integer;
begin
  Result := 1;
end;

procedure TgtPDIndexedColorSpace.GetRGB(Color: TgtColor;
  var RGBColor: TgtRGB);
var
  LColor: TgtColor;
begin
  FBase.GetRGB(MapColorToBase(Color, LColor), RGBColor);
end;

function TgtPDIndexedColorSpace.MapColorToBase(Color,
  BaseColor: TgtColor): TgtColor;
var
  LN: Integer;
  LLow: TgtImageDecodeArray;
  LRange: TgtImageDecodeArray;
  LP: AnsiString;
  LI: Integer;
begin
  LN := FBase.GetNoOfComps;
  FBase.GetDefaultRanges(LLow, LRange, FIndexHigh);
  LP := FLookup[Round((ColToDbl(Color.Comps[0]) + 0.5) * LN)];
  for LI := 0 to LN - 1 do
    BaseColor.Comps[LI] := dblToCol(LLow[LI] + (Ord(LP[LI]) div 255) * LRange[LI]);

  Result := BaseColor;
end;

procedure TgtPDIndexedColorSpace.Update;
begin
  inherited;

end;

end.
