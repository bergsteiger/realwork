{ *************************************************************************** }
{ }
{ Gnostice eDocEngine }
{ }
{ Copyright © 2002-2011 Gnostice Information Technologies Private Limited }
{ http://www.gnostice.com }
{ }
{ *************************************************************************** }

{ ------------------------------------ }
{ Editor Options }
{ ------------------------------------ }
{ }
{ Tab Stops = 2 }
{ Use Tab Character = True }
{ }
{ ------------------------------------ }

{$I gtDefines.inc}
{$I gtDocDefines.inc}
unit gtTIFFEng;

interface

uses
  Windows, Classes, Graphics, SysUtils, gtGDIPAPI, gtGDIPOBJ, gtGDIPUTIL,
  ActiveX, TypInfo, {$IFDEF WIN32} gtdzlib3, {$ENDIF} {$IFDEF WIN64}System.ZLib,
{$ENDIF} gtFilters3, gtDocConsts, gtCstGfxEng, gtDocResStrs, Dialogs,
  gtUtils3;

type
  TgtTIFFCompressionType = (ctNone, ctLZW, ctRLE, ctCCITT3, ctCCITT4);

  TgtTIFFEngine = class(TgtCustomGraphicsEngine)
  private
    FgdiplusToken: ULONG;
    FTIFFStream: TStream;
    FGrayscale: Boolean;
    FMultiPage: Boolean;
    FTIFFCompressionType: TgtTIFFCompressionType;
    FEncoderParameters: TEncoderParameters;
    FSaveParam, FCompressionParam: TEncoderValue;
    clsidTIFF: TGUID;
    FTiffFileName: String;
    MultiPageTIFFImage: TGPImage;
    procedure InitTIFF;
    procedure EndTIFF;
    procedure WriteWord(ABuf: array of word; AStream: TStream);
    procedure SetGrayscale(const Value: Boolean);
    procedure SetTIFFCompressionType(const Value: TgtTIFFCompressionType);
    procedure SetMultiPage(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  protected
    function ShowSetupModal: word; override;
    procedure EndPage; override;
    procedure Start; override;
    procedure Finish; override;
  published
    property Grayscale: Boolean read FGrayscale write SetGrayscale
      default False;
    property CompressionType: TgtTIFFCompressionType read FTIFFCompressionType
      write SetTIFFCompressionType default ctLZW;
    property MultiPage: Boolean read FMultiPage write SetMultiPage default True;
    property DocInfo;
  end;

implementation

uses gtCstDocEng, gtTIFFEngDlg, gtDocUtils;

{ TgtTIFFEngine }

procedure TgtTIFFEngine.Start;
begin
  inherited;
  if Preferences.OutputToUserStream then
    FTIFFStream := UserStream;

  FEncoderParameters.Count := 1;

  FEncoderParameters.Parameter[0].Guid := EncoderCompression;
  FEncoderParameters.Parameter[0].Type_ := EncoderParameterValueTypeLong;
  FEncoderParameters.Parameter[0].NumberOfValues := 1;
  FEncoderParameters.Parameter[0].Value := @FCompressionParam;

  // Initialize the one EncoderParameter object.
  FEncoderParameters.Parameter[1].Guid := EncoderSaveFlag;
  FEncoderParameters.Parameter[1].Type_ := EncoderParameterValueTypeLong;
  FEncoderParameters.Parameter[1].NumberOfValues := 1;
  FEncoderParameters.Parameter[1].Value := @FSaveParam;
  GetEncoderClsid('image/tiff', clsidTIFF);

  FCompressionParam := EncoderValueCompressionLZW;
  case CompressionType of
    ctNone:
      FCompressionParam := EncoderValueCompressionNone;
    ctRLE:
      FCompressionParam := EncoderValueCompressionRle;
    ctCCITT3:
      FCompressionParam := EncoderValueCompressionCCITT3;
    ctCCITT4:
      FCompressionParam := EncoderValueCompressionCCITT4;
  end;
  if MultiPage then
  begin
    FEncoderParameters.Count := 2;
    FSaveParam := EncoderValueMultiFrame;
  end;
  InitTIFF;
end;

constructor TgtTIFFEngine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  StartIGDIPlus(FgdiplusToken);
  FGrayscale := False;
  FTIFFCompressionType := ctLZW;
  FMultiPage := True;
  FileExtension := 'tif';
  FileDescription := STIFFDescription;
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 111);
{$ENDIF}
end;

destructor TgtTIFFEngine.Destroy;
begin
  inherited;
  StopIGDIPlus(FgdiplusToken);
end;

procedure TgtTIFFEngine.Finish;
begin
  inherited;
  if MultiPage then
    EndTIFF;
end;

procedure TgtTIFFEngine.EndPage;
var
  LIsMonochrome: Boolean;
  LEMFStream: TStream;
  LTIFFImage: TGPImage;
  LBitMap: TBitmap;
  LMemoryStream: TMemoryStream;
begin
  LBitMap := nil;
  LMemoryStream := nil;
  LTIFFImage := nil;
  LEMFStream := nil;
  inherited EndPage;
  try
    LEMFStream := TMemoryStream.Create;
    FMetafile.SaveToStream(LEMFStream);
    LEMFStream.Position := 0;
    LIsMonochrome := False;

    if (CompressionType = ctRLE) or (CompressionType = ctCCITT3) or
      (CompressionType = ctCCITT4) then
      LIsMonochrome := True;

    if (not MultiPage) then
      InitTIFF;
    if LIsMonochrome then
    begin
      LMemoryStream := TMemoryStream.Create;
      LBitMap := TBitmap.Create;
      LBitMap.Width := FMetafile.Width;
      LBitMap.Height := FMetafile.Height;
      LBitMap.PixelFormat := pf1bit;
      LBitMap.Canvas.Draw(0, 0, FMetafile);
      LBitMap.SaveToStream(LMemoryStream);
      if MultiPage and (CurrentPage = 1) then
        MultiPageTIFFImage :=
          TGPBitmap.Create(TStreamAdapter.Create(LMemoryStream, soReference))
      else
        LTIFFImage := TGPBitmap.Create(TStreamAdapter.Create(LMemoryStream,
          soReference));
    end
    else
    begin
      if MultiPage and (CurrentPage = 1) then
        MultiPageTIFFImage := TGPBitmap.Create(TStreamAdapter.Create(LEMFStream,
          soReference))
      else
        LTIFFImage := TGPBitmap.Create(TStreamAdapter.Create(LEMFStream,
          soReference));
    end;

    if MultiPage then
    begin
      if CurrentPage = 1 then
      begin
        MultiPageTIFFImage.Save(FTiffFileName + '.tif', clsidTIFF,
          @FEncoderParameters);
      end
      else
      begin
        FSaveParam := EncoderValueFrameDimensionPage;
        MultiPageTIFFImage.SaveAdd(LTIFFImage, @FEncoderParameters);
      end;
    end
    else if (not Preferences.OutputToUserStream) then
    begin
      LTIFFImage.Save(FTiffFileName + '.tif', clsidTIFF, @FEncoderParameters);
    end;
  finally
    if Assigned(LTIFFImage) then
      FreeAndNil(LTIFFImage);
    if Assigned(LEMFStream) then
      FreeAndNil(LEMFStream);
    if Assigned(LBitMap) then
      FreeAndNil(LBitMap);
    if Assigned(LMemoryStream) then
      FreeAndNil(LMemoryStream);
  end;
end;

procedure TgtTIFFEngine.EndTIFF;
begin
  if (not Preferences.OutputToUserStream) then
    FTIFFStream.Free;
  FSaveParam := EncoderValueFlush;
  MultiPageTIFFImage.SaveAdd(@FEncoderParameters);
  FreeAndNil(MultiPageTIFFImage);
end;

procedure TgtTIFFEngine.InitTIFF;
var
  LZero: Cardinal;
begin
  LZero := 0;
  if (not Preferences.OutputToUserStream) then
  begin
    if MultiPage then
    begin
      FTiffFileName := FileName;
      if Assigned(OnNeedFileName) then
        OnNeedFileName(Self, FTiffFileName, CurrentPage);
    end
    else
    begin
      FTiffFileName := FileName + IntToStr(CurrentPage);
      if Assigned(OnNeedFileName) then
        OnNeedFileName(Self, FTiffFileName, CurrentPage);
    end;
  end
  else if Preferences.OutputToUserStream then
  begin
    WriteWord([CByteOrder, CTIFFId], FTIFFStream);
    FTIFFStream.Write(LZero, 4);
  end;
end;

procedure TgtTIFFEngine.SetGrayscale(const Value: Boolean);
begin
  FGrayscale := Value;
end;

procedure TgtTIFFEngine.SetMultiPage(const Value: Boolean);
begin
  FMultiPage := Value;
end;

procedure TgtTIFFEngine.SetTIFFCompressionType(const Value
  : TgtTIFFCompressionType);
begin
  FTIFFCompressionType := Value;
end;

procedure TgtTIFFEngine.WriteWord(ABuf: array of word; AStream: TStream);
begin
  AStream.Write(ABuf, Sizeof(ABuf));
end;

function TgtTIFFEngine.ShowSetupModal: word;
begin
  with TgtTIFFEngineDlg.Create(nil) do
    try
      Engine := Self;
      Result := ShowModal;
    finally
      Free;
    end;
end;

end.
