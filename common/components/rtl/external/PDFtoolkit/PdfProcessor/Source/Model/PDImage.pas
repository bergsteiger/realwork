{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDImage;

interface

uses
  Classes, gtObject, PDBaseObject, PDXObject, PDColorSpace, Stream, PDTypes, PDAltImage,
  PDElement, PDImageColorMap, PDState, PDImageStream,  ExtCtrls, Graphics;

type
  TgtIntentType = (itAbsoluteColorimetric, itRelativeColorimetric,
    itSaturation, itPerceptual);

  TgtOutFormat = (ofBMP, ofPPM, ofPBM, ofJPEG);

  TgtColorKeyRange = record
    MinRange: array[0..2] of Double;
    MaxRange: array[0..2] of Double;
  end;

  TgtPDImage = class(TgtPDXObject)
  private
    FWidth: Integer;
    FHeight: Integer;
    FBitsPerComponent: Integer;
    FImageMask: Integer;
    FHasImageMask: Boolean;
    FColorSpace: TgtPDColorSpace;
    FColorMap: TgtPDImageColorMap;
    FIntentType: TgtIntentType;
    FState: TgtPDState;
    FSoftMask: TgtPDImage;
    FSoftMaskStream: TgtStream;
    FIsInlineImage: Boolean;
    FMaskStream: TStream;
    FMask: TgtPDImage;
    FHasColorKeyMask: Boolean;
    FColorKeyRange: TgtColorKeyRange;

    function GetBitsPerComponent: Integer;
    function GetHeight: Integer;
    function GetImageMask: Boolean;
    function GetIntentType: TgtIntentType;
    function GetInterpolate: Boolean;
    function GetWidth: Integer;
    function GetColorSpace: TgtPDColorSpace;
    function GetImageType: TgtStreamType;
    function GetColorMap: TgtPDImageColorMap;
    function GetSoftmask: TgtPDImage;
    function GetAlphaComp: Integer;
    function GetIsInlineImage: Boolean;
    function GetMask: TgtPDImage;
    function GetMaskImage: TStream;
    function GetHasColorKeyMask: Boolean;

    procedure SetBitsPerComponent(const Value: Integer);
    procedure SetHeigth(const Value: Integer);
    procedure SetImageDecodeArray(const Value: TgtImageDecodeArray);
    procedure SetImageMask(const Value: Boolean);
    procedure SetIntentType(const Value: TgtIntentType);
    procedure SetInterpolate(const Value: Boolean);
    procedure SetWidth(const Value: Integer);
    procedure SetIsInlineImage(Value: Boolean);


    procedure GetImageWithImageMask(var ABitmapImage: TBitmap;
      AImageStr: TgtPDImageStream; AColorMap: TgtPDImageColorMap);
    procedure GetMaskedImage(var ABitmapImage: TBitmap;
      AImageStr: TgtPDImageStream; AColorMap: TgtPDImageColorMap);
    procedure GetImageWithColorKeyMask(var ABitmapImage: TBitmap;
      AImageStr: TgtPDImageStream; AColorMap: TgtPDImageColorMap);
    procedure GetSoftMaskedImage(var ABitmapImage: TBitmap;
      AImageStr: TgtPDImageStream; AColorMap: TgtPDImageColorMap);
    procedure GetRGBImage(var ABitmapImage: TBitmap;
      AImageStr: TgtPDImageStream; AColorMap: TgtPDImageColorMap);
    procedure GetGrayScaleImage(var ABitmapImage: TBitmap;
      AImageStr: TgtPDImageStream; AColorMap: TgtPDImageColorMap);
  public
    Decode: TgtImageDecodeArray;
    constructor Create(AParentDoc: TgtObject; AResource: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
    destructor Destroy; override;

    procedure SaveToStream(Stream: TStream; JpegAsJpeg: Boolean;
      var OutFormat: TgtOutFormat); overload;
    procedure SaveToStream(Stream: TStream; const OutFormat:
      TgtOutFormat); overload;
    procedure SetState(Value: TgtPDState);


    property Width: Integer read GetWidth write SetWidth;
    property Height: Integer read GetHeight write SetHeigth;
    property BitsPerComponent: Integer read GetBitsPerComponent write SetBitsPerComponent;
    property Intent: TgtIntentType read GetIntentType write SetIntentType;
    property ImageMask: Boolean read GetImageMask write SetImageMask;
    property ColorSpace: TgtPDColorSpace read GetColorSpace;
    property ImageType: TgtStreamType read GetImageType;
    property ColorMap: TgtPDImageColorMap read GetColorMap;
    property IsInlineImage: Boolean read GetIsInlineImage write SetIsInlineImage;
    property Interpolate: Boolean read GetInterpolate write SetInterpolate;
    property SoftMask: TgtPDImage read GetSoftmask;
    property AlphaComp: Integer read GetAlphaComp;
    property Mask: TgtPDImage read GetMask;
    property MaskImage: TStream read GetMaskImage;
    property HasColorKeyMask: Boolean read GetHasColorKeyMask;
  end;

function ColorToByte(X: TgtColorMapComp): Integer; {$IFDEF VCL9ORABOVE} inline; {$ENDIF}

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  gtMethods, PDDictionary, PDStream, gtConstants, PDInteger,
  PDBoolean, DCTStream, SysUtils, PDPage, PDResource, PDName,
  PDIndexedColorSpace, JPXStream, gtTypes, PDArray, PDReal;

{ TgtPDImage }

constructor TgtPDImage.Create(AParentDoc: TgtObject; AResource: TgtPDElement;
  ABaseObject: TgtPDBaseObject);
var
  I: Integer;
begin
  FParentDoc := AParentDoc;
  FParentElement := AResource;
  FBaseObject := ABaseObject;

  FWidth := -1;
  FHeight := -1;
  FImageMask := -1;
  FBitsPerComponent := -1;
  FColorMap := nil;
  FColorSpace := nil;
  FState := nil;
  FSoftMask := nil;
  FMask := nil;
  FMaskStream := nil;
  FSoftMaskStream := nil;
  FIsInlineImage := False;
  FHasColorKeyMask := False;
  FHasImageMask := False;

  for I := 0 to 2 do
  begin
    FColorKeyRange.MinRange[I] := 0;
    FColorKeyRange.MaxRange[I] := 0;
  end;

  for I := Low(Decode) to High(Decode) do
    Decode[I] := -1;
end;

destructor TgtPDImage.Destroy;
begin
  if Assigned(FColorSpace) then
    FreeObject(FColorSpace);
  if Assigned(FColorMap) then
    FColorMap.Free;
  if Assigned(FSoftMask) then
    FreeObject(FSoftMask);
  if Assigned(FMask) then
    FreeObject(FMask);
  if Assigned(FMaskStream) then
    FreeObject(FMaskStream);
  inherited;
end;

function TgtPDImage.GetAlphaComp: Integer;
begin
  if Assigned(FSoftMaskStream) then
  begin
    Result := FSoftMaskStream.GetChar;
    Exit;
  end;
  Result := -1;
end;

function TgtPDImage.GetBitsPerComponent: Integer;
var
  LImgDict: TgtPDDictionary;
  LObj: TgtPDBaseObject;
begin
  Result := -1;
  if FBitsPerComponent = -1 then
  begin
    if Assigned(FBaseObject) and FBaseObject.IsStream then
    begin
      LImgDict := TgtPDStream(FBaseObject).GetDict as TgtPDDictionary;
      if Assigned(LImgDict) then
      begin
        LObj := LImgDict.LookUp(PDF_BITSPERCOMP);
        if not Assigned(LObj) then
          LObj := LImgDict.LookUp(PDF_BPC);
        if LObj.IsInteger then
          FBitsPerComponent := TgtPDInteger(LObj).Value
        else
        begin
          {$IFDEF DEBUG}
          Logger.LogError('BitsPerComponent entry is not a valid integer in %s', [TagName]);
          {$ENDIF}
          Exit;
        end;
      end
      else
      begin
        {$IFDEF DEBUG}
        Logger.LogError('Error while analyising %s', [TagName]);
        {$ENDIF}
        Exit;
      end;
    end
    else
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Invalid image stream object found while analysing %s', [TagName]);
      {$ENDIF}
      Exit;
    end;
  end;

  if (FBitsPerComponent = -1) and ImageMask then
    FBitsPerComponent := 1;


  Result := FBitsPerComponent;
end;

function TgtPDImage.GetColorMap: TgtPDImageColorMap;
var
  LObj, LObj2: TgtPDBaseObject;
begin
  if not Assigned(FColorMap) then
  begin
    //get Decode object
    LObj2 := nil;
    if FBaseObject.IsStream then
    begin
      LObj := TgtPDStream(FBaseObject).GetDict;
      LObj2 := TgtPDDictionary(LObj).LookUp(PDF_DECODE);
      if not Assigned(LObj2) then
        LObj2 := TgtPDDictionary(LObj).LookUp(PDF_D);
    end;
    FColorMap := TgtPDImageColorMap.Create(BitsPerComponent, LObj2, ColorSpace);
  end;

  Result := FColorMap;
end;

function TgtPDImage.GetColorSpace: TgtPDColorSpace;
var
  LImgDict: TgtPDDictionary;
  LObj: TgtPDBaseObject;
  LRes: TgtPDResource;
begin
  LRes := nil;
  if not Assigned(FColorSpace) then
  begin
    if Assigned(FBaseObject) and FBaseObject.IsStream then
    begin
      LImgDict := TgtPDStream(FBaseObject).GetDict as TgtPDDictionary;
      if Assigned(LImgDict) then
      begin
        LObj := LImgDict.LookUp(PDF_COLORSPACE);
        if not Assigned(LObj) then
          LObj := LImgDict.LookUp(PDF_CS);
        if Assigned(LObj) then
        begin
          FColorSpace := TgtPDColorSpace.MakeColorSpace(LObj);
          if (not Assigned(FColorSpace)) and (LObj.IsName) then
          begin
            if FParentElement is TgtPDResource then
              LRes := FParentElement as TgtPDResource
            else if FParentElement is TgtPDPage then
              LRes := TgtPDPage(FParentElement).Resource;
            if Assigned(LRes) then
            begin
              Result := LRes.LookUpColorSpace(TgtPDName(LObj).Value);
              Exit;
            end;
          end;
        end;
      end;
    end;
  end;
  Result := FColorSpace;
end;

procedure TgtPDImage.GetGrayScaleImage(var ABitmapImage: TBitmap;
  AImageStr: TgtPDImageStream; AColorMap: TgtPDImageColorMap);
var
  ScanLine: PByteArray;
  LLineIndex, LCol, LX, LI, LNoOfComps: Integer;
  LLine: Bytes;
  LInt: Byte;
  LGray: TgtGray;
begin
  LNoOfComps := AColorMap.GetNumberOfPixelComps;
  ABitmapImage.PixelFormat := pf8bit;
  ABitmapImage.Height := Height;
  ABitmapImage.Width := Width;
  for LI := 0 to FHeight - 1 do
  begin
    LLine := AImageStr.GetLine;
    ScanLine := ABitmapImage.ScanLine[LI];
    LLineIndex := 0;
    LCol := 0;
    for LX := 0 to FWidth - 1 do
    begin
      AColorMap.GetGray(LLine, LLineIndex, LGray);
      LInt := ColorToByte(LGray);
      ScanLine[LCol] := LInt;
      Inc(LCol);
      LLineIndex := LLineIndex + LNoOfComps;
    end;
  end;
end;

function TgtPDImage.GetHasColorKeyMask: Boolean;
begin
  Result := FHasColorKeyMask;
end;

function TgtPDImage.GetHeight: Integer;
var
  LImgDict: TgtPDDictionary;
  LObj: TgtPDBaseObject;
begin
  Result := -1;
  if FHeight = -1 then
  begin
    if Assigned(FBaseObject) and FBaseObject.IsStream then
    begin
      LImgDict := TgtPDStream(FBaseObject).GetDict as TgtPDDictionary;
      if Assigned(LImgDict) then
      begin
        LObj := LImgDict.LookUp(PDF_HEIGHT);
        if not Assigned(LObj) then
          LObj := LImgDict.LookUp(PDF_H);
        if Assigned(LObj) and LObj.IsInteger then
          FHeight := TgtPDInteger(LObj).Value
        else
        begin
          Result := -1;
          {$IFDEF DEBUG}
          Logger.LogError('Height entry is not a valid integer in %s', [TagName]);
          {$ENDIF}
          Exit;
        end;
      end
      else
      begin
        {$IFDEF DEBUG}
        Logger.LogError('Error while analyising %s', [TagName]);
        {$ENDIF}
        Exit;
      end;
    end
    else
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Invalid image stream found while analysing %s', [TagName]);
      {$ENDIF}
      Exit;
    end;
  end;

  if FHeight = -1 then
    FHeight := 0;

  Result := FHeight;
end;
{
function TgtPDImage.GetImageDecodeArray: TgtImageDecodeArray;
begin
  Result := Decode;
end;
}

function TgtPDImage.GetImageType: TgtStreamType;
begin
  if FBaseObject.IsStream then
    Result := TgtPDStream(FBaseObject).GetStream.GetType
  else
  Result := stWeird;
end;

procedure TgtPDImage.GetImageWithColorKeyMask(var ABitmapImage: TBitmap;
  AImageStr: TgtPDImageStream; AColorMap: TgtPDImageColorMap);
var
  ScanLine: PByteArray;
  LLineIndex, LNoOfComps, LCol, LX, LI: Integer;
  LLine: Bytes;
  LInt, LIndexByte: Byte;
  LRGB: TgtRGB;
  LGray: TgtGray;
  LIndexArray: AnsiString;
begin
  //Get Number of pixel components
  LNoOfComps := AColorMap.GetNumberOfPixelComps;
  if LNoOfComps = 1 then
  begin
    ABitmapImage.PixelFormat := pf8bit;
    ABitmapImage.Height := Height;
    ABitmapImage.Width := Width;
    for LI := 0 to FHeight - 1 do
    begin
      LLine := AImageStr.GetLine;
      ScanLine := ABitmapImage.ScanLine[LI];
      LLineIndex := 0;
      LCol := 0;
      for LX := 0 to FWidth - 1 do
      begin
        LInt := Byte(LLine[LLineIndex]);
        if ColorSpace.GetMode = csIndexed then
        begin
          TgtPDIndexedColorSpace(ColorSpace).GetIndexArray(LIndexArray);
          //If the byte in the image stream lies in the range given in the mask,
          //then Mask it (don't paint)
          if (LIndexByte >= FColorKeyRange.MinRange[0]) and (LIndexByte <= FColorKeyRange.MaxRange[0]) then
            LInt := 255;
        end
        else if (LInt >= FColorKeyRange.MinRange[0]) and (LInt <= FColorKeyRange.MaxRange[0]) then
          LInt := 255;
        ScanLine[LCol] := LInt;
        Inc(LCol);
        LLineIndex := LLineIndex + LNoOfComps;
      end;
    end;
    FHasImageMask := True;
  end
  else
  begin
    ABitmapImage.PixelFormat := pf24bit;
    ABitmapImage.Height := Height;
    ABitmapImage.Width := Width;
    for LI := 0 to FHeight - 1 do
    begin
      LLine := AImageStr.GetLine;
      ScanLine := ABitmapImage.ScanLine[LI];
      LLineIndex := 0;
      LCol := 0;
      for LX := 0 to FWidth - 1 do
      begin
        AColorMap.GetRGB(LLine, LLineIndex, LRGB);
        LInt := ColorToByte(LRGB.B);
        if (LInt >= FColorKeyRange.MinRange[0]) and (LInt <= FColorKeyRange.MaxRange[0]) then
          LInt := 255;
        ScanLine[LCol] := LInt;
        LInt := ColorToByte(LRGB.G);
        if (LInt >= FColorKeyRange.MinRange[1]) and (LInt <= FColorKeyRange.MaxRange[1]) then
          LInt := 255;
        ScanLine[LCol + 1] := LInt;
        LInt := ColorToByte(LRGB.R);
        if (LInt >= FColorKeyRange.MinRange[2]) and (LInt <= FColorKeyRange.MaxRange[2]) then
          LInt := 255;
        ScanLine[LCol + 2] := LInt;
        Inc(LCol, 3);
        LLineIndex := LLineIndex + LNoOfComps;
      end;
    end;
  end;

end;

procedure TgtPDImage.GetImageWithImageMask(var ABitmapImage: TBitmap;
  AImageStr: TgtPDImageStream; AColorMap: TgtPDImageColorMap);
var
  ScanLine: PByteArray;
  LLineIndex, LNoOfComps, LCol, LX, LI: Integer;
  LLine: Bytes;
  LInt: Byte;
  LGray: TgtGray;
  LRGB: TgtRGB;
begin
  //Since the image requires to store the alpha value, pixel format
  //should be 32 bit
  ABitmapImage.PixelFormat := pf32bit;
  ABitmapImage.Height := Height;
  ABitmapImage.Width := Width;
  //Get Number of pixel components
  LNoOfComps := AColorMap.GetNumberOfPixelComps;
  for LI := 0 to FHeight - 1 do
  begin
    LLine := AImageStr.GetLine;
    ScanLine := ABitmapImage.ScanLine[LI];
    LLineIndex := 0;
    LCol := 0;
    for LX := 0 to FWidth - 1 do
    begin
      AColorMap.GetGray(LLine, LLineIndex, LGray);
      LInt := ColorToByte(LGray);
      if (LInt = 0) then
      begin
        //Getting current fill color to map the image bytes
        FState.GetFillRGB(LRGB);
        LInt := ColorToByte(LRGB.B);
        ScanLine[LCol] := LInt;
        LInt := ColorToByte(LRGB.G);
        ScanLine[LCol + 1] := LInt;
        LInt := ColorToByte(LRGB.R);
        ScanLine[LCol + 2] := LInt;
        ScanLine[LCol + 3] := 255;
      end
      else
      begin
        //Otherwise the value from the image stream
        ScanLine[LCol] := LInt;
        ScanLine[LCol + 1] := LInt;
        ScanLine[LCol + 2] := LInt;
        ScanLine[LCol + 3] := 0;
      end;
      Inc(LCol, 4);
      LLineIndex := LLineIndex + LNoOfComps;
    end;
  end;
end;

function TgtPDImage.GetImageMask: Boolean;
var
  LImgDict: TgtPDDictionary;
  LObj: TgtPDBaseObject;
  LValue: Boolean;
begin
  Result := FHasImageMask;
  if FImageMask = -1 then
  begin
    FImageMask := 0;
    if Assigned(FBaseObject) and FBaseObject.IsStream then
    begin
      LImgDict := TgtPDStream(FBaseObject).GetDict as TgtPDDictionary;
      if Assigned(LImgDict) then
      begin
        LObj := LImgDict.LookUp(PDF_IMAGEMASK);
        if not Assigned(LObj) then
          LObj := LImgDict.LookUp(PDF_IM);
        if Assigned(LObj) and LObj.IsBoolean then
        begin
          LValue := TgtPDBoolean(LObj).Value;
          if LValue then
          begin
            FImageMask := 1;
            FHasImageMask := True;
          end;
        end
      end
      else
      begin
        {$IFDEF DEBUG}
        Logger.LogError('Error while analyising %s', [TagName]);
        {$ENDIF}
        Exit;
      end;
    end
    else
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Invalid image stream found while analysing %s', [TagName]);
      {$ENDIF}
      Exit;
    end;
  end;
  Result := FHasImageMask;
end;

function TgtPDImage.GetIsInlineImage: Boolean;
begin
  Result := FIsInlineImage;
end;

function TgtPDImage.GetMask: TgtPDImage;
var
  LObj, LObj2: TgtPDBaseObject;
  LI, LIndex: Integer;
begin
  LIndex := 0;
  if not Assigned(FMask) then
  begin
    LObj := TgtPDDictionary(TgtPDStream(FBaseObject).GetDict).LookUp(PDF_MASK);
    if Assigned(LObj) and LObj.IsStream then
    begin
      FMask := TgtPDImage.Create(FParentDoc, FParentElement, LObj);
      FMask.FMaskStream := TMemoryStream.Create();
      FMask.SetState(FState);
      FMask.SaveToStream(FMask.FMaskStream, ofBMP);
    end
    else if Assigned(LObj) and LObj.IsArray then
    begin
      FHasColorKeyMask := True;
      LI := 0;
      while (LI < TgtPDArray(LObj).GetLength) do
      begin
        LObj2 := TgtPDArray(LObj).Get(LI);
        if LObj2.IsInteger then
          FColorKeyRange.MinRange[LIndex] := TgtPDInteger(LObj2).Value
        else
          FColorKeyRange.MinRange[LIndex] := TgtPDReal(LObj2).Value;

        LObj2 := TgtPDArray(LObj).Get(LI + 1);
        if LObj2.IsInteger then
          FColorKeyRange.MaxRange[LIndex] := TgtPDInteger(LObj2).Value
        else
          FColorKeyRange.MaxRange[LIndex] := TgtPDReal(LObj2).Value;
        Inc(LI, 2);
        Inc(LIndex);
      end;
    end;
  end;
  Result := FMask;
end;

procedure TgtPDImage.GetMaskedImage(var ABitmapImage: TBitmap;
  AImageStr: TgtPDImageStream; AColorMap: TgtPDImageColorMap);
var
  ScanLine: PByteArray;
  LLineIndex, LNoOfComps, LCol, LX, LI: Integer;
  LLine: Bytes;
  LInt: Byte;
  LRGB: TgtRGB;
begin
  LNoOfComps := AColorMap.GetNumberOfPixelComps;

  //Usual RGB image will be 24 bit pixel format
  ABitmapImage.PixelFormat := pf24bit;

  ABitmapImage.Height := Height;
  ABitmapImage.Width := Width;
  //Creates a Mask image from Mask stream and load that image
  ABitmapImage.LoadFromStream(FMask.MaskImage);
  for LI := 0 to ABitmapImage.Height - 1 do
  begin
    ScanLine := ABitmapImage.ScanLine[LI];
    LLine := AImageStr.GetLine;
    LLineIndex := 0;
    LCol := 0;
    for LX := 0 to ABitmapImage.Width - 1 do
    begin
      LInt := ScanLine[LCol];
      //Check if the byte is otherthan white, if yes map the byte from
      //image stream. Otherwise leave as it is
      if not LInt = 255 then
      begin
        AColorMap.GetRGB(LLine, LLineIndex, LRGB);
        LInt := ColorToByte(LRGB.B);
        ScanLine[LCol] :=  LInt;
        LInt := ColorToByte(LRGB.G);
        ScanLine[LCol + 1] := LInt;
        LInt := ColorToByte(LRGB.R);
        ScanLine[LCol + 2] := LInt;
      end;
      Inc(LCol, 4);
      LLineIndex := LLineIndex + LNoOfComps;
    end;
  end;
end;

function TgtPDImage.GetMaskImage: TStream;
begin
  FMaskStream.Position := 0;
  Result := FMaskStream;
end;

procedure TgtPDImage.GetRGBImage(var ABitmapImage: TBitmap;
  AImageStr: TgtPDImageStream; AColorMap: TgtPDImageColorMap);
var
  ScanLine: PByteArray;
  LLineIndex, LNoOfComps, LCol, LX, LI: Integer;
  LLine: Bytes;
  LInt: Byte;
  LRGB: TgtRGB;
begin
  LNoOfComps := AColorMap.GetNumberOfPixelComps;
  //Usual RGB image will be 24 bit pixel format
  ABitmapImage.PixelFormat := pf24bit;

  ABitmapImage.Height := Height;
  ABitmapImage.Width := Width;
  for LI := 0 to FHeight - 1 do
  begin
    LLine := AImageStr.GetLine;
    ScanLine := ABitmapImage.ScanLine[LI];
    LLineIndex := 0;
    LCol := 0;
    for LX := 0 to FWidth - 1 do
    begin
      AColorMap.GetRGB(LLine, LLineIndex, LRGB);
      LInt := ColorToByte(LRGB.B);
      ScanLine[LCol] := LInt;
      LInt := ColorToByte(LRGB.G);
      ScanLine[LCol + 1] := LInt;
      LInt := ColorToByte(LRGB.R);
      ScanLine[LCol + 2] := LInt;
      Inc(LCol, 3);
      LLineIndex := LLineIndex + LNoOfComps;
    end;
  end;
end;

function TgtPDImage.GetIntentType: TgtIntentType;
begin
  Result := FIntentType;
end;

function TgtPDImage.GetInterpolate: Boolean;
begin
  Result := False;
end;

function TgtPDImage.GetSoftmask: TgtPDImage;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FSoftMask) then
  begin
    if Assigned(FBaseObject) and FBaseObject.IsStream then
    begin
      LObj := TgtPDDictionary(TgtPDStream(FBaseObject).GetDict).LookUp(PDF_SMASK);
      if Assigned(LObj) then
      begin
        FSoftMask := TgtPDImage.Create(FParentDoc, FParentElement, LObj);
        FSoftMask.FSoftMaskStream := TgtPDStream(LObj).GetStream;
        FSoftMask.FSoftMaskStream.Reset;
      end;
    end;
  end;
  Result := FSoftMask;
end;

procedure TgtPDImage.GetSoftMaskedImage(var ABitmapImage: TBitmap;
  AImageStr: TgtPDImageStream; AColorMap: TgtPDImageColorMap);
var
  ScanLine: PByteArray;
  LLineIndex, LNoOfComps, LCol, LX, LI: Integer;
  LLine: Bytes;
  LInt: Byte;
  LRGB: TgtRGB;
begin
  LNoOfComps := AColorMap.GetNumberOfPixelComps;
  ABitmapImage.PixelFormat := pf32bit;
  ABitmapImage.Height := Height;
  ABitmapImage.Width := Width;
  for LI := 0 to FHeight - 1 do
  begin
    LLine := AImageStr.GetLine;
    ScanLine := ABitmapImage.ScanLine[LI];
    LLineIndex := 0;
    LCol := 0;
    for LX := 0 to FWidth - 1 do
    begin
      AColorMap.GetRGB(LLine, LLineIndex, LRGB);
      LInt := ColorToByte(LRGB.B);
      ScanLine[LCol] := LInt;
      LInt := ColorToByte(LRGB.G);
      ScanLine[LCol + 1] := LInt;
      LInt := ColorToByte(LRGB.R);
      ScanLine[LCol + 2] := LInt;
      //Alpha component for the Image
      LInt := SoftMask.AlphaComp;
      if not (LInt = ENDOFFILE) then
        ScanLine[LCol + 3] := LInt
      else
        ScanLine[LCol + 3] := 255;
      Inc(LCol, 4);
      LLineIndex := LLineIndex + LNoOfComps;
    end;
  end;
end;

function TgtPDImage.GetWidth: Integer;
var
  LImgDict: TgtPDDictionary;
  LObj: TgtPDBaseObject;
begin
  Result := -1;
  if FWidth = -1 then
  begin
    if Assigned(FBaseObject) and FBaseObject.IsStream then
    begin
      LImgDict := TgtPDStream(FBaseObject).GetDict as TgtPDDictionary;
      if Assigned(LImgDict) then
      begin
        LObj := LImgDict.LookUp(PDF_WIDTH);
        if not Assigned(LObj) then
          LObj := LImgDict.LookUp(PDF_W);
        if LObj.IsInteger then
          FWidth := TgtPDInteger(LObj).Value
        else
        begin
          Result := 0;
          {$IFDEF DEBUG}
          Logger.LogError('Width entry is not a valid integer in %s', [TagName]);
          {$ENDIF}
          Exit;
        end;
      end
      else
      begin
        {$IFDEF DEBUG}
        Logger.LogError('Error while analyising %s', [TagName]);
        {$ENDIF}
        Exit;
      end;
    end
    else
    begin
      {$IFDEF DEBUG}
      Logger.LogError('Invalid image stream found while analysing %s', [TagName]);
      {$ENDIF}
      Exit;
    end;
  end;

  if FWidth = -1 then
    FWidth := 0;

  Result := FWidth;

end;

function ColorToByte(X: TgtColorMapComp): Integer;
begin
  Result := Integer(((X shl 8) - X + $8000) shr 16);
end;

procedure TgtPDImage.SaveToStream(Stream: TStream; JpegAsJpeg: Boolean;
  var OutFormat: TgtOutFormat);
var
  LStream: TgtStream;
  Ch, Ch2, LSize, LCol: Integer;
  LHeader: AnsiString;
  LLine: Bytes;
  LImageStr: TgtPDImageStream;
  LRGB: TgtRGB;
  LLineIndex: Integer;
  LI, LX, LJ: Integer;
  LInt: Byte;
  LBitmapImage: TBitmap;
  ScanLine: PByteArray;
  LColorMap: TgtPDImageColorMap;
  LNoComps: Integer;
begin
  LImageStr := nil;
  if (JpegAsJpeg and (GetImageType = stDCT)) and ((BitsPerComponent = 1) or
    (ColorSpace.GetNoOfComps = 3)) then
  begin
    if FIsInlineImage then
    begin
      LBitmapImage := TBitmap.Create();
      LBitmapImage.PixelFormat := pf24bit;
      LBitmapImage.Height := Height;
      LBitmapImage.Width := Width;
      LImageStr := TgtPDImageStream.Create(TgtPDStream(FBaseObject).GetStream,
        FWidth, ColorSpace.GetNoOfComps, FBitsPerComponent);
      LImageStr.Reset;
      LColorMap := ColorMap;
      LNoComps := LColorMap.GetNumberOfPixelComps;
      for LI := 0 to FHeight - 1 do
      begin
        LLine := LImageStr.GetLine;
        ScanLine := LBitmapImage.ScanLine[LI];
        LLineIndex := 0;
        LCol := 0;
        for LX := 0 to FWidth - 1 do
        begin
          LColorMap.GetRGB(LLine, LLineIndex, LRGB);
          LInt := ColorToByte(LRGB.B);
          ScanLine[LCol] := LInt;
          LInt := ColorToByte(LRGB.G);
          ScanLine[LCol + 1] := LInt;
          LInt := ColorToByte(LRGB.R);
          ScanLine[LCol + 2] := LInt;
          LLineIndex := LLineIndex + LNoComps;
          Inc(LCol, 3);
        end;
      end;
      LBitmapImage.SaveToStream(Stream);
      FreeObject(LBitmapImage);
      FreeObject(LImageStr);
    end
    else
    begin
      LStream := TgtDCTStream(TgtPDStream(FBaseObject).GetStream).Stream;
      LStream.Reset;
      Ch := LStream.GetChar;
      while Ch <> -1 do
      begin
        Stream.Write(Ch, 1);
        Ch := LStream.GetChar;
      end;
      OutFormat := ofJPEG;
      LStream.Close;
    end;
  end
  else if ((BitsPerComponent = 1) and (ColorSpace.GetNoOfComps = 1)) then
  begin
    LHeader := 'P4' + #13 + Format('%d %d', [Width, Height]) + #13;
    Stream.Write(LHeader[1], Length(LHeader));

    LStream := TgtPDStream(FBaseObject).GetStream;
    LStream.Reset;

    LSize := Round(Height * ((Width + 7) / 8));
    for LJ := 0 to LSize - 1 do
    begin
      Ch := LStream.GetChar;
      Ch := Ch xor $FF;
      Stream.Write(Ch, 1);
    end;
    LStream.Close;
    OutFormat := ofPBM;
  end
  else
  begin
    LBitmapImage := TBitmap.Create;
    LBitmapImage.PixelFormat := pf24bit;
    LBitmapImage.Height := Height;
    LBitmapImage.Width := Width;

    LImageStr := TgtPDImageStream.Create(TgtPDStream(FBaseObject).GetStream,
      FWidth, ColorSpace.GetNoOfComps, FBitsPerComponent);
    LImageStr.Reset;
    LColorMap := ColorMap;
    LNoComps := LColorMap.GetNumberOfPixelComps;

    for LI := 0 to FHeight - 1 do
    begin
      LLine := LImageStr.GetLine;
      ScanLine := LBitmapImage.ScanLine[LI];
      LLineIndex := 0;
      LCol := 0;
      for LX := 0 to FWidth - 1 do
      begin
        LColorMap.GetRGB(LLine, LLineIndex, LRGB);
        LInt := ColorToByte(LRGB.B);
        ScanLine[LCol] := LInt;
        LInt := ColorToByte(LRGB.G);
        ScanLine[LCol + 1] := LInt;
        LInt := ColorToByte(LRGB.R);
        ScanLine[LCol + 2] := LInt;
        LLineIndex := LLineIndex + LNoComps;
        Inc(LCol, 3);
      end;
    end;
    LBitmapImage.SaveToStream(Stream);
    FreeObject(LBitmapImage);
    FreeObject(LImageStr);
    OutFormat := ofBMP;
  end;
  Stream.Position := 0;
end;

procedure TgtPDImage.SaveToStream(Stream: TStream;
  const OutFormat: TgtOutFormat);
var
  LImageStr: TgtPDImageStream;
  LBitmapImage: TBitmap;
  ScanLine: PByteArray;
  LLineIndex, LCol, LX, LI: Integer;
  LLine: Bytes;
  LInt: Byte;
  LRGB: TgtRGB;
  LGray: TgtGray;
  LNoOfComps, LColorComps: Integer;
  LColorMap: TgtPDImageColorMap;
  LJPXStream: TgtStream;
  LColor: TgtColor;
begin
  LImageStr := nil;
  LColorComps := 1;
  LBitmapImage := nil;
  if OutFormat = ofBMP then
  begin
    LBitmapImage := TBitmap.Create;
    if Assigned(ColorSpace) then
    begin
      LNoOfComps := ColorSpace.GetNoOfComps;
      if ColorSpace.GetMode = csIndexed then
        LColorComps := TgtPDIndexedColorSpace(ColorSpace).GetBase.GetNoOfComps;
    end
    else
      LNoOfComps := 1;

    if GetImageType = stJPX then
    begin
      LJPXStream := TgtPDStream(FBaseObject).GetStream;
      LJPXStream.Reset;

      LBitmapImage.PixelFormat := pf24bit;
      LBitmapImage.Height := Height;
      LBitmapImage.Width := Width;

      for LI := 0 to FHeight - 1 do
      begin
        ScanLine := LBitmapImage.ScanLine[LI];
        LCol := 0;
        for LX := 0 to FWidth - 1 do
        begin
          LInt := LJPXStream.GetChar;
          ScanLine[LCol + 2] := LInt;
          LInt := LJPXStream.GetChar;
          ScanLine[LCol + 1] := LInt;
          LInt := LJPXStream.GetChar;
          ScanLine[LCol] := LInt;
          Inc(LCol, 3);
        end;
      end;
      Stream.Position := 0;
      LBitmapImage.SaveToStream(Stream);
    end
    else
    begin
      LImageStr := TgtPDImageStream.Create(TgtPDStream(FBaseObject).GetStream,
        Width, LNoOfComps, BitsPerComponent);
      LImageStr.Reset;
      LColorMap := ColorMap;
      LNoOfComps := LColorMap.GetNumberOfPixelComps;

      if ((BitsPerComponent = 1) and (LNoOfComps = 1)) and (LColorComps = 1) then
      begin
        //In an Image Dict if ImageMask entry is true, then we need to check each
        //byte of the image and see if it is 0(Zero means black). If it is Zero,
        //then we need to get the current fill color and set the byte with that color
        if ImageMask then
        begin
          GetImageWithImageMask(LBitmapImage, LImageStr, LColorMap);
        end
        else
        begin
          //If it is not a Image with ImageMask, then it is a usual Gray scale image
          GetGrayScaleImage(LBitmapImage, LImageStr, LColorMap);
        end;
      end
      else //RGB images
      begin
        //If in a Image Dict if there is a Mask entry present, then we need to
        //create an Image using the Mask Stream and in the Mask stream if a byte
        //is not 255(White) then map that byte with the byte from the Image stream
        if Assigned(Mask) or HasColorKeyMask then
        begin
          if HasColorKeyMask then
            GetImageWithColorKeyMask(LBitmapImage, LImageStr, LColorMap)
          else
            GetMaskedImage(LBitmapImage, LImageStr, LColorMap);
        end
        //If there is a SoftMask entry present in an Image stream then, each
        //SoftMask byte will defines the alpha component for RGB in the actual Image Stream
        else if Assigned(SoftMask) then
        begin
          GetSoftMaskedImage(LBitmapImage, LImageStr, LColorMap);
        end
        else
        begin
          //Otherwise its a usual RGB image
          GetRGBImage(LBitmapImage, LImageStr, LColorMap);
        end;
      end;
      Stream.Position := 0;
      LBitmapImage.SaveToStream(Stream);
      FreeObject(LImageStr);
    end;
  end;
  if Assigned(LBitmapImage) then
    FreeObject(LBitmapImage);
end;

procedure TgtPDImage.SetBitsPerComponent(const Value: Integer);
begin
  FBitsPerComponent := Value;
end;

procedure TgtPDImage.SetHeigth(const Value: Integer);
begin
  FHeight := Value;
end;

procedure TgtPDImage.SetImageDecodeArray(const Value: TgtImageDecodeArray);
begin
  Decode := Value;
end;

procedure TgtPDImage.SetImageMask(const Value: Boolean);
begin

end;

procedure TgtPDImage.SetIsInlineImage(Value: Boolean);
begin
  FIsInlineImage := Value;
end;

procedure TgtPDImage.SetIntentType(const Value: TgtIntentType);
begin
  FIntentType := Value;
end;

procedure TgtPDImage.SetInterpolate(const Value: Boolean);
begin

end;

procedure TgtPDImage.SetState(Value: TgtPDState);
begin
  FState := Value;
end;

procedure TgtPDImage.SetWidth(const Value: Integer);
begin
  FWidth := Value;
end;

end.
