{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDColorSpace;

interface

uses
  PDElement, gtObject, PDTypes, PDBaseObject;

const
//  ColorMaxComps = 32;

  XYZRGB: array[0..2, 0..2] of double = (
    (3.240449, -1.537136, -0.498531),
    (-0.969265, 1.876011, 0.041556),
    (0.055643, -0.204026, 1.057229)
    );

type
  TgtColorSpaceMode =
    (
    csDeviceGray,
    csCalGray,
    csDeviceRGB,
    csCalRGB,
    csDeviceCMYK,
    csLab,
    csICCBased,
    csIndexed,
    csSeparation,
    csDeviceN,
    csPattern
    );


  TgtPDColorSpace = class(TgtPDElement)
  protected
    FTagName: AnsiString;
  public
    class function MakeColorSpace(ABaseObject: TgtPDBaseObject;
      ATagName: AnsiString = ''): TgtPDColorSpace; overload;
    class function MakeColorSpace(const ColorSpaceName: AnsiString):
      TgtPDColorSpace; overload;

    destructor Destroy; override;

    class function NoOfColorSpaceModes: Integer;
    function IsName(const TageName: AnsiString): Boolean;
    procedure GetDefaultColor(var Color: TgtColor); virtual;
    function GetNoOfComps: Integer; virtual; abstract;
    function GetMode: TgtColorSpaceMode; virtual; abstract;
    procedure GetDefaultRanges(var DecodeLow, DecodeRange: TgtImageDecodeArray;
      MaxImgPixel: Double); virtual;

    procedure GetGray(Color: TgtColor; var GrayColor: TgtGray); virtual; abstract;
    procedure GetRGB(Color: TgtColor; var RGBColor: TgtRGB); virtual; abstract;
    procedure GetCMYK(Color: TgtColor; var CMYKColor: TgtCMYK); virtual; abstract;

    function Copy: TgtPDColorSpace; virtual; abstract;

    property TagName: AnsiString read FTagName;
  end;

  TgtPDEnumColorSpaceEvent = procedure(Font: TgtPDColorSpace;
    var Name: AnsiString; var Cancel: Boolean) of object;

function Clip01(Color: TgtColorMapComp): TgtColorMapComp; overload;  {$IFDEF VCL9ORABOVE} inline; {$ENDIF}
function Clip01(Color: Double): Double; overload; {$IFDEF VCL9ORABOVE} inline; {$ENDIF}
function DblToCol(X: double): TgtColorMapComp; {$IFDEF VCL9ORABOVE} inline; {$ENDIF}
function ColToDbl(X: TgtColorMapComp): Double; {$IFDEF VCL9ORABOVE} inline; {$ENDIF}

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  gtConstants, PDDeviceGrayColorSpace, PDDeviceRGBColorSpace,
  PDDeviceCMYKColorSpace, PDPatternColorSpace, PDName, PDArray,
  PDCalRGBColorSpace, PDCalGrayColorSpace, PDLabColorSpace, PDICCBasedColorSpace,
  PDIndexedColorSpace, PDSeparationColorSpace, PDDeviceNColorSpace;

function Clip01(Color: TgtColorMapComp): TgtColorMapComp;
begin
  if Color < 0 then
    Result := 0
  else
  begin
    if Color > $10000 then
      Result := $10000
    else
      Result := Color;
  end;
end;

function Clip01(Color: Double): Double;
begin
  if Color < 0 then
    Result := 0
  else
  begin
    if Color > 1 then
      Result := 1
    else
      Result := Color;
  end;
end;

function DblToCol(X: double): TgtColorMapComp;
begin
  Result := Trunc(X * $10000);
end;

function ColToDbl(X: TgtColorMapComp): Double;
begin
  Result := (X / $10000);
end;


{ TgtPDColorSpace }

destructor TgtPDColorSpace.Destroy;
begin

  inherited;
end;

procedure TgtPDColorSpace.GetDefaultColor(var Color: TgtColor);
begin

end;

procedure TgtPDColorSpace.GetDefaultRanges(var DecodeLow,
  DecodeRange: TgtImageDecodeArray; MaxImgPixel: Double);
var
  I: Integer;
begin
  for I := 0 to GetNoOfComps - 1 do
  begin
    DecodeLow[I] := 0;
    DecodeRange[I] := 1;
  end;
end;

function TgtPDColorSpace.IsName(const TageName: AnsiString): Boolean;
begin
  Result := (FTagName = TageName)
end;

class function TgtPDColorSpace.MakeColorSpace(ABaseObject: TgtPDBaseObject;
  ATagName: AnsiString): TgtPDColorSpace;
var
  LObj: TgtPDBaseObject;
begin
  Result := nil;
  if ABaseObject.IsName then
  begin
    if ABaseObject.IsName(PDF_DEVICEGRAY) or ABaseObject.IsName(PDF_G) then
      Result := TgtPDDeviceGrayColorSpace.Create
    else if ABaseObject.IsName(PDF_DEVICERGB) or ABaseObject.IsName(PDF_RGB) then
      Result := TgtPDDeviceRGBColorSpace.Create
    else if ABaseObject.IsName(PDF_DEVICECMYK) or ABaseObject.IsName(PDF_CMYK) then
      Result := TgtPDDeviceCMYKColorSpace.Create
//    else if ABaseObject.IsName(PDF_PATTERN) then
//      Result := TgtPDPatternColorSpace.Create(nil)
    else
    begin
    {$IFDEF DEBUG}
      Logger.LogError('Bad color space %s', [TgtPDName(ABaseObject).Value]);
    {$ENDIF}
    end;
  end
  else if ABaseObject.IsArray then
  begin
    LObj := TgtPDArray(ABaseObject).Get(0);
    if LObj.IsName(PDF_DEVICEGRAY) or LObj.IsName(PDF_G) then
      Result := TgtPDDeviceGrayColorSpace.Create
    else if LObj.IsName(PDF_DEVICERGB) or LObj.IsName(PDF_RGB) then
      Result := TgtPDDeviceRGBColorSpace.Create
    else if LObj.IsName(PDF_DEVICECMYK) or LObj.IsName(PDF_CMYK) then
      Result := TgtPDDeviceCMYKColorSpace.Create
    else if LObj.IsName(PDF_CALRGB) then
      Result := TgtPDCalRGBColorSpace.Create(ABaseObject)
    else if LObj.IsName(PDF_CALGRAY) then
      Result := TgtPDCalGrayColorSpace.Create(ABaseObject)
    else if LObj.IsName(PDF_LAB) then
      Result := TgtPDLabColorSpace.Create(ABaseObject)
    else if LObj.IsName(PDF_ICCBASED) then
      Result := TgtPDICCBasedColorSpace.Create(ABaseObject)
    else if LObj.IsName(PDF_INDEXED) or LObj.IsName(PDF_I) then
      Result := TgtPDIndexedColorSpace.Create(ABaseObject)
    else if LObj.IsName(PDF_SEPARATION) then
      Result := TgtPDSeparationColorSpace.Create(ABaseObject)
    else if LObj.IsName(PDF_DEVICEN) then
      Result := TgtPDDeviceNColorSpace.Create(ABaseObject)
    else if LObj.IsName(PDF_PATTERN) then
      Result := TgtPDPatternColorSpace.Create(ABaseObject)
    else
    begin
    {$IFDEF DEBUG}
      Logger.LogError('Bad color space');
    {$ENDIF}
    end;
  end
  else
  begin
  {$IFDEF DEBUG}
    Logger.LogError('Bad color space - expected name or array');
  {$ENDIF}
  end;

  if Assigned(Result) then
    Result.FTagName := ATagName;
end;

class function TgtPDColorSpace.MakeColorSpace(const ColorSpaceName:
  AnsiString): TgtPDColorSpace;
begin
  Result := nil;
end;

class function TgtPDColorSpace.NoOfColorSpaceModes: Integer;
begin
  Result := 0;
end;

end.
