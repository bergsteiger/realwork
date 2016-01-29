{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2011 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

{$I gtDefines.inc}
{$I gtDocDefines.inc}

unit gtPNGEng;

interface
uses
  Classes, Graphics, gtCstDocEng, gtCstGfxEng, SysUtils,
  gtDocConsts, {$IFDEF WIN32} gtdzlib3{$ENDIF} {$IFDEF WIN64}
  System.ZLib{$ENDIF}, gtFilters3, gtclasses3, gtDocResStrs;

type
  TgtPercentage = 0..100;

  TgtPNGColorType = (ctGrayscale, ctRGB, ctRGBA, ctGrayAlpha);

  TgtPNGTxtKeyWord = (tkTitle, tkAuthor, tkDescription, tkCopyright, tkCreateTime,
    tkSoftware, tkDisclaimer, tkWarning, tkSource, tkComment);

  TgtPNGUnitSpecifier = (usNone, usMeter);

  TgtPNGPixelDimensions = class(TPersistent)
  private
    FEnabled: Boolean;
    FXPixelsPerUnit, FYPixelsPerUnit: Cardinal;
    FUnitSpecifier: TgtPNGUnitSpecifier;
    procedure SetEnabled(const Value: Boolean);
    procedure SetUnitSpecifier(const Value: TgtPNGUnitSpecifier);
    procedure SetXPixelsPerUnit(const Value: Cardinal);
    procedure SetYPixelsPerUnit(const Value: Cardinal);
  public
    constructor Create;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property XPixelsPerUnit: Cardinal read FXPixelsPerUnit
      write SetXPixelsPerUnit default 1;
    property YPixelsPerUnit: Cardinal read FYPixelsPerUnit
      write SetYPixelsPerUnit default 1;
    property UnitSpecifier: TgtPNGUnitSpecifier read FUnitSpecifier
      write SetUnitSpecifier default usNone;
  end;

  TgtPNGTransparency = class(TPersistent)
  private
    FColorType: TgtPNGColorType;
    FEnabled: Boolean;
    FImageAlpha: 0..255;
    FTransColor: TColor;
    function GetAlphaPercent: TgtPercentage;
    procedure SetAlphaPercent(const Value: TgtPercentage);
    procedure SetEnabled(const Value: Boolean);
    procedure SetTransColor(const Value: TColor);
  public
    constructor Create(AColorType: TgtPNGColorType);
    function GetAlphaValue: Byte;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property ImageAlpha: TgtPercentage read GetAlphaPercent
    	write SetAlphaPercent default 0;
    property TransColor: TColor read FTransColor write SetTransColor
    	default clWhite;
  end;

  TgtPNGEngine = class(TgtCustomGraphicsEngine)
  private
    FCrcTable : array[0..255] of Cardinal;
    FTransparency: TgtPNGTransparency;
    FPixelDimensions: TgtPNGPixelDimensions;
    FColorType: TgtPNGColorType;
    {procedure WritetEXt(AStream: TgtExtMemStream; AKeyword: TgtPNGTxtKeyWord;
      AString: String);}
    procedure WritezTXt(AStream: TgtExtMemStream; AKeyword: TgtPNGTxtKeyWord;
      AString : String);
    procedure SetColorType(const Value: TgtPNGColorType);
    procedure SetTransparency(const Value: TgtPNGTransparency);
    procedure GetRGB(const AColor: Integer; out ARed, AGreen, ABlue: Byte);
    function GetCRC(AStream: TgtExtMemStream): Cardinal;
    procedure SetPixelDimensions(const Value: TgtPNGPixelDimensions);
  protected
    procedure EndPage; override;
    function ShowSetupModal: Word; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ColorType: TgtPNGColorType read FColorType write SetColorType
      default ctRGB;
    property Transparency: TgtPNGTransparency read FTransparency
      write SetTransparency;
    property PixelDimensions: TgtPNGPixelDimensions read FPixelDimensions
      write SetPixelDimensions;
    property DocInfo;
    Property FileExtension;
    Property FileDescription;
  end;

implementation

uses gtPNGEngDlg, gtDocUtils;

const
  CDataSize : Cardinal = 10240;
  CPNGColorType : array[TgtPNGColorType] of Byte = (0, 2, 6, 4);
  CPNGUnitSpecifier : array[TgtPNGUnitSpecifier] of Byte = (0, 1);
  CPNGTxtKeyWord : array[TgtPNGTxtKeyWord] of String =
    ('Title', 'Author', 'Description', 'Copyright', 'Creation Time',
    'Software', 'Disclaimer', 'Warning', 'Source', 'Comment');

{ TgtPNGEngine }

constructor TgtPNGEngine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FColorType := ctRGB;
  FTransparency := TgtPNGTransparency.Create(FColorType);
  FPixelDimensions := TgtPNGPixelDimensions.Create;
  FileExtension := 'png';
  FileDescription := SPNGDescription;
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 112);
{$ENDIF}
end;

destructor TgtPNGEngine.Destroy;
begin
  FTransparency.Free;
  FPixelDimensions.Free;
  inherited;
end;

procedure TgtPNGEngine.EndPage;
var
  LN: Integer;
  LC, LI, LJ, LDataLeft: Cardinal;
  LImgStream, LTmpStream, LDatTmpStream, LPNGStream, LMem : TgtExtMemStream;
  LL : LongInt;
  LEncodedStream: TMemoryStream;
  LFlateFilter: TgtFlateFilter;
  LBitmap: TBitmap;
  LLen, LSize: Cardinal;
  LRed, LGreen, LBlue: Byte;
  LFileName: String;
begin
  inherited;
  LPNGStream := TgtExtMemStream.Create;
  LDatTmpStream := TgtExtMemStream.Create;
  LMem := TgtExtMemStream.Create;
  LBitmap := TBitmap.Create;
  try
    LBitmap.Width := Round(FMetafile.Width * ScaleX);
    LBitmap.Height := Round(FMetafile.Height * ScaleY);

    with LBitmap do
      Canvas.StretchDraw(Rect(0, 0, Width, Height), FMetafile);

    (* Initialize CRC Table *)
    for LN := 0 to 255 do
    begin
      LC := Cardinal(LN);
      for LI := 0 to 7 do
      begin
        if (LC and 1) <> 0 then LC := ($edb88320) xor (LC shr 1)
        else LC := LC shr 1;
        FCrcTable[LN] := LC;
      end;
    end;
    LPNGStream.WriteByteArray([137,80,78,71,13,10,26,10]);

    (* Write the header chunk *)
    LMem.WriteString('IHDR');
    LMem.WriteULongArray([Round(Pages[CurrentPage - 1].Settings.Width),
      Round(Pages[CurrentPage - 1].Settings.Height)]);
    LMem.WriteByteArray([8, CPNGColorType[ColorType], 0, 0, 0]);
    LPNGStream.WriteULong(13);
    LPNGStream.CopyFrom(LMem, 0);
    LPNGStream.WriteULong(GetCRC(LMem));
    LMem.Clear;

    (* uncompressed text chunk(s) if needed *)

    if FPixelDimensions.Enabled then
    begin
	    (* physical pixel dimensions chunk *)
      LMem.WriteString('pHYs');
      LMem.WriteULongArray([FPixelDimensions.XPixelsPerUnit,
        FPixelDimensions.YPixelsPerUnit]);
      LMem.WriteByte(CPNGUnitSpecifier[FPixelDimensions.UnitSpecifier]);
      LPNGStream.WriteULong(9);
	    LPNGStream.CopyFrom(LMem, 0);
      LPNGStream.WriteULong(GetCRC(LMem));
      LMem.Clear;
    end;

    if ((ColorType = ctRGB) or (ColorType = ctGrayscale)) then
    begin
      (* Write transparency chunk *)
      GetRGB(FTransparency.TransColor, LRed, LGreen, LBlue);
      LMem.WriteString('tRNS');
      case ColorType of
  	    ctGrayscale:
        begin
          LLen := 2;
          LMem.WriteUShort((LRed+LGreen+LBlue) div 3);
        end;
      else
      begin
        LLen := 6;
        LMem.WriteUShortArray([LRed, LGreen, LBlue]);
      end;
      end;
      LPNGStream.WriteULong(LLen);
			LPNGStream.CopyFrom(LMem, 0);
      LPNGStream.WriteULong(GetCRC(LMem));
      LMem.Clear;
    end;

    LImgStream := TgtExtMemStream.Create;
    LTmpStream := TgtExtMemStream.Create;
    (* To Do: Speed up the loop *)
    for LI := 0 to (LBitmap.Height - 1) do
    begin
    	(* Preceeding Filter Bit : Always 0 in this case *)
      LImgStream.WriteByte(0);
      for LJ := 0 to (LBitmap.Width - 1) do
      begin
        LL := LBitmap.Canvas.Pixels[LJ,LI];
        case ColorType of
        ctRGB:
          LImgStream.WriteByteArray([((LL shl 24) shr 24),((LL shl 16) shr 24),(LL shr 16)]);
        ctRGBA:
          LImgStream.WriteByteArray(
            [((LL shl 24) shr 24),((LL shl 16) shr 24),(LL shr 16),
              FTransparency.GetAlphaValue]);
        ctGrayscale:
          LImgStream.WriteByte((((LL shl 24) shr 24)+((LL shl 16) shr 24)+(LL shr 16)) div 3);
        ctGrayAlpha:
          LImgStream.WriteByteArray(
            [(((LL shl 24) shr 24)+((LL shl 16) shr 24)+(LL shr 16)) div 3,
              FTransparency.GetAlphaValue]);
        end;
      end;
    end;
    LFlateFilter := TgtFlateFilter.Create;
    (* Currently only type of compression allowed is Flate *)
    LEncodedStream := LFlateFilter.Encode(LImgStream, clMax);
    LTmpStream.CopyFrom(LEncodedStream, 0);
    LEncodedStream.Free;

    LFlateFilter.Free;
    LTmpStream.Position := 0;
    (* Make each data chunk <= CDataSize since Maximum is defined *)
    for LI := 1 to ((LTmpStream.Size div CDataSize)+1) do
    begin
      LDatTmpStream.Clear;
      if (LI=((LTmpStream.Size div CDataSize)+1)) then
        LDataLeft := (LTmpStream.Size mod CDataSize)
      else
        LDataLeft := CDataSize;
      LDatTmpStream.CopyFrom(LTmpStream, LDataLeft);
      (* Compressed image data chunk *)
      LSize := LDatTmpStream.Size;
      LDatTmpStream.Position := 0;
      LMem.WriteString('IDAT');
      LMem.CopyFrom(LDatTmpStream, 0);
      LPNGStream.WriteULong(LSize);
			LPNGStream.CopyFrom(LMem, 0);
      LPNGStream.WriteULong(GetCRC(LMem));
      LMem.Clear;
    end;
    LTmpStream.Free;
    LImgStream.Free;
    LDatTmpStream.Free;
{
    (* Time chunk *)
    LNow := Now;
    LMem.WriteString('tIME');
    LMem.WriteUShort(YearOf(LNow));
    LMem.WriteByteArray([MonthOf(LNow), DayOf(LNow), HourOf(LNow),
    	MinuteOf(LNow), SecondOf(LNow)]);
    LPNGStream.WriteULong(7);
    LPNGStream.CopyFrom(LMem, 0);
    LPNGStream.WriteULong(GetCRC(LMem));
    LMem.Clear;
}
    (* Ziped-text chunk(s) *)
    WritezTXt(LPNGStream, tkTitle, DocInfo.Title);
    WritezTXt(LPNGStream, tkAuthor, DocInfo.Author);
    WritezTXt(LPNGStream, tkSoftware, DocInfo.Creator);
    WritezTXt(LPNGStream, tkCopyright, CCopyright);
    WritezTXt(LPNGStream, tkDescription, DocInfo.Subject);
    WritezTXt(LPNGStream, tkComment,DocInfo.Keywords);

    (* Write end chunk *)
    LMem.WriteString('IEND');
    LPNGStream.WriteULong(0);
    LPNGStream.CopyFrom(LMem, 0);
    LPNGStream.WriteULong(GetCRC(LMem));

    if Preferences.OutputToUserStream then
      UserStream.CopyFrom(LPNGStream, 0)
    else
    begin
    	LFileName := FileName + IntToStr(CurrentPage);
	    if Assigned(OnNeedFileName) then
      	OnNeedFileName(Self, LFileName, CurrentPage);
      try
        LPNGStream.SaveToFile(LFileName + '.' + FileExtension);
      except
        CancelCreate;
        raise EFileCreateError.Create(SFileCreateError);
      end;
      EngineFileNames.Add(LFileName + '.' + FileExtension);
    end;
  finally
    LMem.Free;
    LBitmap.Free;
    LPNGStream.Free;
  end;
end;

(* Calculate the CRC for given stream of data *)
function TgtPNGEngine.GetCRC(AStream: TgtExtMemStream): Cardinal;
var
  LI : Integer;
  LSize: Int64;
  LBytes : array of Byte;
begin
  LSize := AStream.Size;
  SetLength(LBytes, Integer(LSize));
  AStream.Position := 0;
  Result := $FFFFFFFF;
  for LI := 0 to (LSize - 1) do
  begin
     Result := FCrcTable[(Result xor AStream.ReadByte) and $FF] xor (Result shr 8);
  end;
  Result := Result xor $FFFFFFFF;
  AStream.Position := 0;
end;

procedure TgtPNGEngine.GetRGB(const AColor: Integer; out ARed, AGreen, ABlue: Byte);
begin
  ABlue := Byte(AColor shr 16);
  AGreen := Byte((AColor shl 16) shr 24);
  ARed := Byte((AColor shl 24) shr 24);
end;

procedure TgtPNGEngine.SetColorType(const Value: TgtPNGColorType);
begin
  FColorType := Value;
end;

procedure TgtPNGEngine.SetPixelDimensions(const Value: TgtPNGPixelDimensions);
begin
  FPixelDimensions := Value;
end;

procedure TgtPNGEngine.SetTransparency(const Value: TgtPNGTransparency);
begin
  FTransparency := Value;
end;

{
(* Uncompressed Text chunk *)
procedure TgtPNGEngine.WritetEXt(AStream: TgtExtMemStream;
	AKeyword: TgtPNGTxtKeyWord; AString: String);
var
  LMem : TgtExtMemStream;
begin
  LMem := TgtExtMemStream.Create;
  LMem.WriteString('tEXt' + CPNGTxtKeyWord[AKeyword]);
  LMem.WriteByte(0);
  LMem.WriteString(AString);
  AStream.WriteULong(LMem.Size - 4);
	AStream.CopyFrom(LMem, 0);
  AStream.WriteULong(GetCRC(LMem));
  LMem.Free;
end;
}

function TgtPNGEngine.ShowSetupModal: Word;
begin
  with TgtPNGEngineDlg.Create(nil) do
  try
    Engine := Self;
    Result := ShowModal;
  finally
    Free;
  end;
end;

(* Compressed Text chunk *)
procedure TgtPNGEngine.WritezTXt(AStream: TgtExtMemStream;
	AKeyword: TgtPNGTxtKeyWord; AString: String);
var
  LMem : TgtExtMemStream;
  LFlateFilter: TgtFlateFilter;
  LStr: String;
begin
  LFlateFilter := TgtFlateFilter.Create;
  LStr := LFlateFilter.Encode(AString, clMax);
  LFlateFilter.Free;
  LMem := TgtExtMemStream.Create;
  LMem.WriteString(AnsiString('zTXt' + CPNGTxtKeyWord[AKeyword]));
  LMem.WriteByteArray([0, 0]);
  LMem.WriteString(AnsiString(LStr));
  AStream.WriteULong(LMem.Size - 4);
	AStream.CopyFrom(LMem, 0);
  AStream.WriteULong(GetCRC(LMem));
  LMem.Free;
end;

{ TgtPNGTransparency }

constructor TgtPNGTransparency.Create(AColorType: TgtPNGColorType);
begin
  FEnabled := False;
  FImageAlpha := 0;
  FTransColor := clWhite;
  FColorType := AColorType;
end;

(* Get Transparency in percentage *)
function TgtPNGTransparency.GetAlphaPercent: TgtPercentage;
begin
  Result := Integer(FImageAlpha * 100 div 255);
end;

(* Get Alpha value between 0 and 255 *)
function TgtPNGTransparency.GetAlphaValue: Byte;
begin
  Result := FImageAlpha;
end;

procedure TgtPNGTransparency.SetAlphaPercent(const Value: TgtPercentage);
begin
  FImageAlpha := (Value * 255) div 100;
end;

procedure TgtPNGTransparency.SetEnabled(const Value: Boolean);
begin
  if ((FColorType = ctRGB) or (FColorType = ctGrayscale)) then
    FEnabled := Value
  else FEnabled := True;
end;

procedure TgtPNGTransparency.SetTransColor(const Value: TColor);
begin
  FTransColor := Value;
end;

{ TgtPNGPixelDimensions }

constructor TgtPNGPixelDimensions.Create;
begin
  FEnabled := False;
  FXPixelsPerUnit := 1;
  FYPixelsPerUnit := 1;
  FUnitSpecifier := usNone;
end;

procedure TgtPNGPixelDimensions.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

procedure TgtPNGPixelDimensions.SetUnitSpecifier(
  const Value: TgtPNGUnitSpecifier);
begin
  FUnitSpecifier := Value;
end;

procedure TgtPNGPixelDimensions.SetXPixelsPerUnit(const Value: Cardinal);
begin
  FXPixelsPerUnit := Value;
end;

procedure TgtPNGPixelDimensions.SetYPixelsPerUnit(const Value: Cardinal);
begin
  FYPixelsPerUnit := Value;
end;

end.
