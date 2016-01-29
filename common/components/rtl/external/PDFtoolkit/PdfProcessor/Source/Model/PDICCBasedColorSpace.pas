{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDICCBasedColorSpace;

interface

uses
  PDColorSpace, PDElement, gtObject, PDTypes, PDBaseObject;

type
  TgtPDICCBasedColorSpace = class(TgtPDColorSpace)
  private
    // number of color components (1, 3, or 4)
    FNoOfComps: Integer;

    // alternate color space
    FAlt: TgtPDColorSpace;

    // min and mx values for each component respectively
    FRangeMin: array[0..3] of Double;
    FRangeMax: array[0..3] of Double;

    FICCProfileStream: TgtPDBaseObject;
  public
    constructor Create(ABaseObject: TgtPDBaseObject);
    destructor Destroy; override;

    function GetMode: TgtColorSpaceMode; override;
    function GetNoOfComps: Integer; override;
    function GetAlt: TgtPDColorSpace;

    procedure GetDefaultColor(var Color: TgtColor); override;
    procedure GetGray(Color: TgtColor; var GrayColor: TgtGray); override;
    procedure GetRGB(Color: TgtColor; var RGBColor: TgtRGB); override;
    procedure GetCMYK(Color: TgtColor; var CMYKColor: TgtCMYK); override;
    procedure GetDefaultRanges(var DecodeLow, DecodeRange: TgtImageDecodeArray;
      MaxImgPixel: Double); override;
    function Copy: TgtPDColorSpace; override;
    procedure Update; override;
  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  PDArray, PDDictionary, PDStream, gtConstants, PDName, PDDeviceRGBColorSpace,
  PDDeviceGrayColorSpace, PDDeviceCMYKColorSpace, gtMethods, PDInteger;

{ TgtPDICCBasedColorSpace }

function TgtPDICCBasedColorSpace.Copy: TgtPDColorSpace;
var
  LColorSpace: TgtPDICCBasedColorSpace;
  LI: Integer;
begin
  LColorSpace := TgtPDICCBasedColorSpace.Create(FBaseObject);
  for LI := 0 to 3 do
  begin
    LColorSpace.FRangeMin[LI] := FRangeMin[LI];
    LColorSpace.FRangeMax[LI] := FRangeMax[LI];
  end;

  Result := LColorSpace;
end;

constructor TgtPDICCBasedColorSpace.Create(ABaseObject: TgtPDBaseObject);
var
  LObj, LObj2, LObj3: TgtPDBaseObject;
  LColorSpaceName: AnsiString;
  LI: Integer;
begin
  FBaseObject := ABaseObject;

  FAlt := nil;
//  LObj := nil;
//  LObj2 := nil;
//  LObj3 := nil;

  LObj := TgtPDArray(FBaseObject).Get(1);

  if not Assigned(LObj) or not LObj.IsStream then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Bad ICCBased color space (stream)');
    {$ENDIF}
    Exit;
  end;

  if Assigned(LObj) then
  begin
    //ICC profile stream object
    FICCProfileStream := LObj;

    //Getting the no: of color components
    LObj2 := TgtPDDictionary(TgtPDStream(LObj).GetDict).LookUp(PDF_N);
    if Assigned(LObj2) then
    begin
      if LObj2.IsNumber then
      begin
        FNoOfComps := TgtPDInteger(LObj2).Value;
        if FNoOfComps > ColorMapMaxComps then
        begin
          {$IFDEF DEBUG}
          Logger.LogError('ICCBased color space with too many (%d > %d) components',
            [FNoOfComps, ColorMapMaxComps]);
          {$ENDIF}
          FNoOfComps := ColorMapMaxComps;
        end;
      end
      else
      begin
        {$IFDEF DEBUG}
        Logger.LogError('Bad ICCBased color space (N)');
        {$ENDIF}
        Exit;
      end;
    end;

    //Checking for alternate colorSpace
//    LObj2 := nil;
    LObj2 := TgtPDDictionary(TgtPDStream(LObj).GetDict).LookUp(PDF_ALTERNATE);
    if Assigned(LObj2) then
    begin
      LColorSpaceName := TgtPDName(LObj2).Value;
      if LColorSpaceName = PDF_DEVICERGB then
        FAlt := TgtPDDeviceRGBColorSpace.Create
      else if LColorSpaceName = PDF_DEVICEGRAY then
        FAlt := TgtPDDeviceGrayColorSpace.Create
      else if LColorSpaceName = PDF_DEVICECMYK then
        FAlt := TgtPDDeviceCMYKColorSpace.Create;
    end
    else if (not Assigned(LObj2)) or (not Assigned(FAlt)) then
    begin
      case FNoOfComps of
        1: FAlt := TgtPDDeviceGrayColorSpace.Create;
        3: FAlt := TgtPDDeviceRGBColorSpace.Create;
        4: FAlt := TgtPDDeviceCMYKColorSpace.Create;
      else
        begin
          {$IFDEF DEBUG}
          Logger.LogError('Bad ICCBased color space - invalid N');
          {$ENDIF}
          Exit;
        end;
      end;
    end;
  end;

  //Setting the Range of Color components
  LObj2 := TgtPDDictionary(TgtPDStream(LObj).GetDict).LookUp(PDF_RANGE);
  if assigned(LObj2) and (TgtPDArray(LObj2).GetLength = 2 * FNoOfComps) then
  begin
    for LI := 0 to FNoOfComps - 1 do
    begin
      LObj3 := TgtPDArray(LObj2).Get(2 * LI);
      FRangeMin[LI] := TgtPDInteger(LObj3).Value;
//      LObj3 := nil;
      LObj3 := TgtPDArray(LObj2).Get(2 * LI + 1);
      FRangeMax[LI] := TgtPDInteger(LObj3).Value;
    end;
  end
  else
  begin
    for LI := 0 to 3 do
    begin
      FRangeMin[LI] := 0;
      FRangeMax[LI] := 1;
    end;
  end;
end;

destructor TgtPDICCBasedColorSpace.Destroy;
begin
  if Assigned(FAlt) then
    FreeObject(FAlt);
end;

function TgtPDICCBasedColorSpace.GetAlt: TgtPDColorSpace;
begin
  Result := FAlt;
end;

procedure TgtPDICCBasedColorSpace.GetCMYK(Color: TgtColor;
  var CMYKColor: TgtCMYK);
begin
  FAlt.GetCMYK(Color, CMYKColor);
end;

procedure TgtPDICCBasedColorSpace.GetDefaultColor(var Color: TgtColor);
var
  LI: Integer;
begin
  for LI := 0 to FNoOfComps - 1 do
  begin
    if (FRangeMin[LI] > 0) then
      Color.Comps[LI] := DblToCol(FRangeMin[LI])
    else if (FRangeMax[LI] < 0) then
      Color.Comps[LI] := DblToCol(FRangeMax[LI])
    else
      Color.Comps[LI] := 0;
  end;
end;

procedure TgtPDICCBasedColorSpace.GetDefaultRanges(var DecodeLow,
  DecodeRange: TgtImageDecodeArray; MaxImgPixel: Double);
begin
  FAlt.GetDefaultRanges(DecodeLow, DecodeRange, MaxImgPixel);
end;

procedure TgtPDICCBasedColorSpace.GetGray(Color: TgtColor;
  var GrayColor: TgtGray);
begin
  FAlt.GetGray(Color, GrayColor);
end;

function TgtPDICCBasedColorSpace.GetMode: TgtColorSpaceMode;
begin
  Result := csICCBased;
end;

function TgtPDICCBasedColorSpace.GetNoOfComps: Integer;
begin
  Result := FNoOfComps;
end;

procedure TgtPDICCBasedColorSpace.GetRGB(Color: TgtColor;
  var RGBColor: TgtRGB);
begin
  FAlt.GetRGB(Color, RGBColor);
end;

procedure TgtPDICCBasedColorSpace.Update;
begin
  inherited;

end;

end.
