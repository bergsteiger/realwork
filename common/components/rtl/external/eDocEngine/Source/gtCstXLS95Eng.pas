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

unit gtCstXLS95Eng;

interface
uses
  Classes, Windows, Graphics, SysUtils, Math, gtCstDocEng, gtCstSpdEng, gtUtils3,
  gtConsts3, gtDocConsts, gtDocUtils, gtDocResStrs, Printers;

type

  TgtCustomExcel95Engine = class;

  TgtOnNeedSheetName = procedure(Sender: TgtCustomExcel95Engine; var SheetName:
    AnsiString; SheetNo: Integer) of object;

  PgtSheetItem = ^TgtSheetItem;
  TgtSheetItem = record
    FSheetName: AnsiString;
    FSheetOffset: Int64;
  end;


{ TgtExcelOLEStream }

  TgtExcelOLEStream = class(TObject)
  private
    FBATCount: Longint;
    FBATBlockCount: LongInt;
    FFirstBlockIndex: LongInt;
    FXBatCount: LongInt;
    FFirstXBatIndex: LongInt;
    FExcelStreamSize: Integer;

    procedure CalculateBATBlocks;
    procedure WriteHeader;
    procedure WriteBlocks;
    procedure WritePropertyBlock;
  public
    FStream: TMemoryStream;
    FExcelStream: TStream;
    constructor Create;
    destructor Destroy; override;
    procedure MakeExcelStream;
  end;

  TgtCellBorderStyle = (cbsNone, cbsThin, cbsMedium, cbsDashed, cbsDotted,
    cbsThick, cbsDouble, cbsHair);

  TgtCellBorder = class(TPersistent)
  private
    FEnabled: Boolean;
    FStyle: TgtCellBorderStyle;
    FColor: TColor;
    procedure SetEnabled(const Value: Boolean);
    procedure SetStyle(const Value: TgtCellBorderStyle);
    procedure SetColor(const Value: TColor);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default False;
    property Style: TgtCellBorderStyle read FStyle write SetStyle
      default cbsNone;
    property Color: TColor read FColor write SetColor default clBlack;
  end;

{ TgtExcelPreferences }

  TgtWorksheetPagesType = 0 .. MaxInt;

  TgtExcelPreferences = class(TgtSpreadSheetPreferences)
  private
    FPrintGridLines: Boolean;
    FPagesPerWorksheet: TgtWorksheetPagesType;
    FPageMargins: Boolean;
    FMetafileAsImage: Boolean;
    procedure SetPagesPerWorksheet(const Value: TgtWorksheetPagesType);
    procedure SetPageMargins(const Value: Boolean);
    procedure SetPrintGridLines(const Value: Boolean);
    procedure SetMetafileAsImage(const Value: Boolean);
  public
    constructor Create; override;
  published
    property PagesPerWorksheet: TgtWorksheetPagesType read FPagesPerWorksheet
      write SetPagesPerWorksheet default 0;
    property PrintGridLines: Boolean read FPrintGridLines
      write SetPrintGridLines default False;
    property PageMargins: Boolean read FPageMargins
      write SetPageMargins default False;
    property MetafileAsImage: Boolean read FMetafileAsImage
      write SetMetafileAsImage default False;
  end;

{ TgtCustomExcel95Engine }

  TgtCustomExcel95Engine = class(TgtCustomSpreadSheetEngine)
  private
    FExcelStream: TMemoryStream;
    FOutputStream: TStream;
    FSheetNamesSize: Int64;
    FSheetCount: Integer;
    FSpreadSheetItemList: TList;
    FOnNeedSheetName: TgtOnNeedSheetName;
    FCellBorder: TgtCellBorder;
    FMinRowNo: Integer;
    FMaxRowNo: Integer;
    FMinColNo: Integer;
    FMaxColNo: Integer;
    procedure WriteWindow1Record(AStream: TStream);
    procedure WriteWorkBookHeader(AStream: TStream);
    function GetPreferences: TgtExcelPreferences;
    procedure SetPreferences(const Value: TgtExcelPreferences);
    procedure SetCellBorder(const Value: TgtCellBorder);
    procedure InitDimensionVars;
  protected
    procedure Start; override;
    procedure BeginPage; override;
    procedure EndPage; override;
    procedure Finish; override;

    procedure EndSheet(SheetNo: Integer);
    procedure EncodeText(AObject: TgtTextItem); override;
    function GetFillStyle(AValue: Byte): Byte;
    procedure WriteBackgroundImage; virtual;

    property ExcelStream: TMemoryStream read FExcelStream write FExcelStream;

    function GetPreferencesClassName: TgtPreferencesClass; override;
    function ShowSetupModal: Word; override;
    procedure UpdateDimensionVars(const ARowNo, AColNo: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure BeginDoc; override;
    procedure NewPage; override;

    procedure TextBox(TextRect: TgtRect; Text: WideString;
      HAlignment: TgtHAlignment; VAlignment: TgtVAlignment); override;
    procedure SetColumnWidth(ColumnNumber: Integer; Width: Double); override;
    procedure NewSheet(AAddNewPage: Boolean = True); override;

    property TableSettings;
    property Frame;

  published
    property BackgroundImage;
		property BackgroundColor;
    property Pen;
    property Brush;

    property Preferences: TgtExcelPreferences read GetPreferences
      write SetPreferences;
    property OnNeedSheetName: TgtOnNeedSheetName read FOnNeedSheetName
      write FOnNeedSheetName;
    property CellBorder: TgtCellBorder read FCellBorder write SetCellBorder;
  end;


implementation
uses gtXLSEngDlg;

{ TgtCustomExcel95Engine }

procedure TgtCustomExcel95Engine.Start;
begin
  inherited;
  if FileExists(FileName) then SysUtils.DeleteFile(FileName);

  if not Preferences.OutputToUserStream then
  begin
    FOutputStream := CreateFile(FileName + '.' + FileExtension);
    EngineFileNames.Add(FileName + '.' + FileExtension);
  end
  else
    FOutputStream := UserStream;

  FExcelStream := TMemoryStream.Create;
  FSpreadSheetItemList := TList.Create;
  FSheetNamesSize := 0;
  FSheetCount := 0;
  InitDimensionVars;
  CreateResourceItems;
end;

procedure TgtCustomExcel95Engine.BeginPage;
begin
  inherited;
end;

constructor TgtCustomExcel95Engine.Create(AOwner: TComponent);
begin
  inherited;
  FileExtension := 'xls';
  FileDescription := SExcelDescription;
  ItemsToRender := [irText, irImage];
  ImageSettings.OutputImageFormat := ifMetafile;
  FCellBorder := TgtCellBorder.Create;
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 105);
{$ENDIF}
end;

destructor TgtCustomExcel95Engine.Destroy;
begin
  FCellBorder.Free;
  inherited;
end;

procedure TgtCustomExcel95Engine.EncodeText(AObject: TgtTextItem);
var
  LFormatIndex, LFontIndex, LCellXFIndex: Integer;
  LCellType: TgtCellType;
  LTextAlign: TgtHAlignment;
  LBuf: array[0..1] of Word;
  LXLSString, LS: String;
  LATemp : AnsiString;
  LStringSize, LWCellXFIndex: Word;
  LCellData: Extended;
  LWordWrap: Boolean;

 //For Trailing -ve Sign
 function WPStrIsNumeric(const s: String): boolean;
  var i :integer; s1, s2 :String;
  begin
    result := false;
    s1 := trim(s); { no leading or trailing blanks }
    s2 := '';
    for i := 1 to length(s1) do
    {$IFDEF gtDelphi2009Up}
       if not (SysUtils.CharInSet(s1[i],['.',',','-'])) { no formatting characters }
    {$ELSE}
       if not (s1[i] in ['.',',','-']) { no formatting characters }
    {$ENDIF}

          then s2 := s2 + s1[i];
    if (length(s2) = 0) then exit; { blank isn't numeric }
    for i := 1 to length(s2) do
    {$IFDEF gtDelphi2009Up}
      if not (SysUtils.CharInSet(s2[i],['0'..'9'])) then
    {$ELSE}
      if not (s2[i] in ['0'..'9']) then
    {$ENDIF}
     exit;
    result := true;
  end;

begin
  inherited EncodeText(AObject);
  // Eliminate the item marked for exclusion
  // This item was overwritten by another item (with same x, y) so we don't want
  // to encode it (else we get a "Data may have been lost" error)
  if TgtFmTextItem(AObject).ColumnNo = -1 then
    Exit;
  with AObject do
  begin
    LFormatIndex := $0;
    LTextAlign := haGeneral;
    LS := Trim(ReplacePlaceHolders(Lines[0], True));

    if LS = '' then Exit;
    //For Trailing -ve Sign
    if WPStrIsNumeric(LS)
      and (Length(Trim(LS)) > 0)
      and (Copy(Trim(LS),Length(Trim(LS)),1) = '-') then
    begin
        LS := Trim(LS);
        LS := '-' + Copy(LS, 1, Length(LS)-1);
    end;

    LWordWrap := Preferences.WordWrap;
    if AObject is TgtSheetTextItem then
    begin
      LCellType := TgtSheetTextItem(AObject).CellType;
      LTextAlign := TgtSheetTextItem(AObject).Alignment;
      LWordWrap := TgtSheetTextItem(AObject).WordWrap;
    end
    else
      LCellType := GetCellType(LS);

    LFontIndex := AddFontInfoToFontTable(Font) + 5;
    case LCellType of
      ctString: // General
        LFormatIndex := $0;
      ctInteger:
        LFormatIndex := $1;
      ctDouble:
        LFormatIndex := $2;
      ctInteger_TS:
        LFormatIndex := $3;
      ctDouble_TS:
        LFormatIndex := $4;
      ctCurrency:
        LFormatIndex := $7;
      ctTime:
        LFormatIndex := $13;
      ctDate:
        LFormatIndex := $0f;
      ctDateTime:
        LFormatIndex := $16;
      ctPercentage:
        LFormatIndex := $9;
      ctPercentage_FP:
        LFormatIndex := $a;
      end;
    LCellXFIndex := AddCellInfoToCellXFTable(LFontIndex, LTextAlign,
      LFormatIndex, Brush, LWordWrap) + $10;
    LXLSString := '';
    LStringSize := 0; LCellData := 0.0;

    with TgtFmTextItem(AObject) do
    begin
      LBuf[0] := RowNo + FLastPageHeight;
      LBuf[1] := ColumnNo;
      UpdateDimensionVars(RowNo + FLastPageHeight, ColumnNo);
    end;

    if LCellType in [ctInteger, ctDouble, ctCurrency, ctInteger_TS, ctDouble_TS] then
    begin
      WriteRecord(cExcel_Cell_Double, cExcel_Rec_Size_Cell_Double,
        [0], 0, FExcelStream);
       // to convert an integer in parenthesis to negetive nos
      If ( (LS[1]='(') and (LS[Length(LS)]=')')) then
      begin
        LS := ReplaceString(LS, '(', '-');
        LS := ReplaceString(LS, ')', '');
      end;
      LCellData := StrToFloat(GetNumberString(LS));
    end
    else if (LCellType in [ctTime, ctDate, ctDateTime]) then
    begin
      WriteRecord(cExcel_Cell_Double, cExcel_Rec_Size_Cell_Double,
        [0], 0, FExcelStream);
      LCellData := StrToDateTime(LS);
    end
    else if (LCellType in [ctPercentage, ctPercentage_FP]) then
    begin
      WriteRecord(cExcel_Cell_Double, cExcel_Rec_Size_Cell_Double,
        [0], 0, FExcelStream);
      LS := LeftStr(LS, Length(LS) - 1);
      LCellData := StrToFloat(GetNumberString(LS))/100;
    end
    else
    begin
      LStringSize := Length(LS);
      if LStringSize > 255 then LStringSize := 255;
      LXLSString := LS;
      WriteRecord(cExcel_Cell_Label,
        LStringSize + cExcel_Rec_Size_Cell_Label , [0], 0, FExcelStream);
    end;

    LWCellXFIndex := Word(LCellXFIndex);
    FExcelStream.Write(LBuf, SizeOf(LBuf));
    FExcelStream.Write(LWCellXFIndex, 2); // size of word
    if LXLSString = '' then
      FExcelStream.Write(LCellData, SizeOf(Double))
    else
    begin
      FExcelStream.Write(LStringSize, sizeof(LStringSize));
      LATemp := AnsiString(LXLSString);
      FExcelStream.Write(LATemp[1], LStringSize);
    end;
  end;
end;

procedure TgtCustomExcel95Engine.Finish;
var
  LStream: TgtExcelOLEStream;
  I: Integer;
begin

  with Preferences do
  if (PagesPerWorksheet = 0) or ((PageCount mod PagesPerWorksheet)<> 0) then
  begin
    Inc(FSheetCount);
    EndSheet(FSheetCount);
  end;

  FExcelStream.Size := 0;
  FExcelStream.Position := 0;
  WriteWorkBookHeader(FExcelStream);
  FExcelStream.CopyFrom(FOutputStream, 0);

  LStream := TgtExcelOLEStream.Create;
  LStream.FExcelStream := FExcelStream;
  LStream.MakeExcelStream;

  FOutputStream.Size := 0;
	FOutputStream.Position := 0;
  FOutputStream.CopyFrom(LStream.FStream, 0);

  if not Preferences.OutputToUserStream then
    FreeAndNil(FOutputStream);

  FreeAndNil(FExcelStream);

  for I := 0 to FSpreadSheetItemList.Count - 1 do
   Dispose(PgtSheetItem(FSpreadSheetItemList[I]));
  FreeAndNil(FSpreadSheetItemList);

  FreeResourceItems;
  FreeAndNil(LStream);
  inherited;
end;

procedure TgtCustomExcel95Engine.EndPage;
var
  LHeight: Integer;
begin
  inherited;
  with Pages[CurrentPage - 1].Settings do
    LHeight := Round(Round(Height) / FDefaultCellHeight);

  with Preferences do
  if (((PagesPerWorksheet <> 0) and ((CurrentPage mod PagesPerWorksheet) = 0))
    or ((FLastPageHeight + LHeight) > 65536)) then
  (* 65536: Max number of rows supported by Excel *)
  begin
    Inc(FSheetCount);
    EndSheet(FSheetCount);
  end;
end;

procedure TgtCustomExcel95Engine.EndSheet(SheetNo: Integer);
const
  Win2Rec_Sheet1: array [0..13] of Byte = ($3e, $02, $0a, $00, $b6, $06, $00,
    $00, $00, $00, $00,	$00, $00, $00);
  Win2Rec_Sheet2n: array [0..13] of Byte = ($3e, $02, $0a, $00, $b6, $00, $00,
    $00, $00, $00, $00,	$00, $00, $00);
//  RowRec: array[0..19] of Byte = ($08, $02, $10, $00, $06, $00, $02, $00,
//    $03, $00, $d2, $00, $00, $00, $00, $00, $00, $00, $00, $00);

  CPaperSizeTable: array[TgtPaperSize] of Word = (1, 2, 3, 4, 5, 6, 7, 8, 9,
    10, 11, 12, 13, 14, 15, 16, 17, 18, 20, 21, 22, 23, 24, 25, 26, 27, 28,
    29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 42, 0);
var
  LSheetItem: PgtSheetItem;
  I: Integer;
  LColWidth: PgtColumnWidth;
  LByte: Byte;
  E: Double;
  LSheetName: AnsiString;
  LOrientation, LCopies: Word;
begin
  // Worksheet BOF
  WriteRecord(cExcel_BIFF7, 8,
		[$0500, cExcel_DocType, $24d7, $07cd], 8, FOutputStream);

  // ColInfo - set custom column widths
  for I := 0 to FColWidths.Count - 1 do
  begin
    LColWidth := pgtColumnWidth(FColWidths[I]);

    WriteRecord(CExcel_ColInfo, 11, [LColWidth.FCoumnNumber,
      LColWidth.FCoumnNumber, Round(LColWidth.Fwidth * 256), $F, 0],
      10, FOutputStream);
    LByte := 0;
    FOutputStream.Write(LByte, SizeOf(LByte));
  end;

  //Page setup: $A1
  if (Page.Orientation = poLandscape) then
    LOrientation := 0
  else
    LOrientation := 2;
  WriteRecord(CExcel_Setup, 34, [CPaperSizeTable[Page.PaperSize], 100, 1, 1, 1,
    LOrientation, 600, 600], 16, FOutputStream);
  //Header height in IEEE format
  E := 0;
  FOutputStream.Write(E, 8);
  //Footer height in IEEE format
  FOutputStream.Write(E, 8);
  //Number of copies = 1
  LCopies := 1;
  FOutputStream.Write(LCopies, 2);

  // Max needs to be 1 more than the max used. Will become 0 if worksheet is empty
  Inc(FMaxRowNo);
  Inc(FMaxColNo);

  // Handle empty worksheet condition, else Min will be maxint and Excel will complain
  FMinRowNo := Min(FMinRowNo, FMaxRowNo);
  FMinColNo := Min(FMinColNo, FMaxColNo);

  // Dimensions
  WriteRecord(cExcel_DIM, cExcel_Rec_Size_DIM,
    [FMinRowNo, FMaxRowNo, FMinColNo, FMaxColNo, 0], 10, FOutputStream);

  // Page Margins
  if Preferences.PageMargins then
  with Page do
  begin
    E := (LeftMargin * NativeConversionFactor) / CPixelsPerInch;
    WriteRecord(cExcel_LeftMargin, 8, [0], 0, FOutputStream);
    FOutputStream.Write(E, 8);

    E := (RightMargin * NativeConversionFactor) / CPixelsPerInch;
    WriteRecord(cExcel_RightMargin, 8, [0], 0, FOutputStream);
    FOutputStream.Write(E, 8);

    E := (TopMargin * NativeConversionFactor) / CPixelsPerInch;
    WriteRecord(cExcel_TopMargin, 8, [0], 0, FOutputStream);
    FOutputStream.Write(E, 8);

    E := (BottomMargin * NativeConversionFactor) / CPixelsPerInch;
    WriteRecord(cExcel_BottomMargin, 8, [0], 0, FOutputStream);
    FOutputStream.Write(E, 8);
  end;

  // Print grid lines
  if Preferences.PrintGridLines then
    WriteRecord($2B, 4, [1, 0], 4, FOutputStream);

  WriteBackgroundImage;

  // Row - description
//  FOutputStream.Write(RowRec, SizeOf(RowRec));

  // Worksheet cell data
  FOutputStream.CopyFrom(FExcelStream, 0);
  FExcelStream.Clear;

  // Windows1
  WriteWindow1Record(FOutputStream);

  // Windows2
  if SheetNo = 1 then
    FOutputStream.Write(Win2Rec_Sheet1, SizeOf(Win2Rec_Sheet1))
  else
    FOutputStream.Write(Win2Rec_Sheet2n, SizeOf(Win2Rec_Sheet2n));

  // Worksheet - EOF
  WriteRecord(cExcel_EOF, cExcel_Rec_Size_EOF, [0], 0, FOutputStream);

  with FSpreadSheetItemList do
  begin
    New(LSheetItem);
    LSheetItem^.FSheetOffset := FOutputStream.Size;

    LSheetName := AnsiString('Sheet' + IntToStr(FSheetCount));

    if (Assigned(FOnNeedSheetName)) then
      FOnNeedSheetName(Self, LSheetName, FSheetCount);

    for I := 0 to FSpreadSheetItemList.Count - 1 do
    if PgtSheetItem((Items[I]))^.FSheetName = LSheetName then
    begin
      LSheetName := AnsiString('Sheet' + IntToStr(FSheetCount));
      Break;
    end;

    LSheetItem^.FSheetName := LSheetName;
    Add(LSheetItem);
  end;

  FLastPageHeight := 0;
  FPrevRowNo := 0;
  InitDimensionVars;
end;

function TgtCustomExcel95Engine.GetFillStyle(AValue: Byte): Byte;
begin
  Result := 0;
  case AValue of
    05:
      Result := $08;
    06:
      Result := $0f;
    07:
      Result := $09;
    04:
      Result := $07;
    02:
      Result := $0b;
    00:
      Result := $01;
    03:
      Result := $0c;
  end;
end;

procedure TgtCustomExcel95Engine.NewPage;
begin
  inherited;

end;

procedure TgtCustomExcel95Engine.SetColumnWidth(ColumnNumber: Integer;
  Width: Double);
begin
  inherited;

end;

procedure TgtCustomExcel95Engine.TextBox(TextRect: TgtRect; Text: WideString;
  HAlignment: TgtHAlignment; VAlignment: TgtVAlignment);
begin
  inherited;

end;

procedure TgtCustomExcel95Engine.UpdateDimensionVars(const ARowNo,
  AColNo: Integer);
begin
  FMinRowNo := Min(FMinRowNo, ARowNo);
  FMaxRowNo := Max(FMaxRowNo, ARowNo);
  FMinColNo := Min(FMinColNo, AColNo);
  FMaxColNo := Max(FMaxColNo, AColNo);
end;

procedure TgtCustomExcel95Engine.WriteWindow1Record(AStream: TStream);
const
  Win1Rec: array [0..21] of Byte = ($3d, $00, $12, $00, $e0, $01,$78, $00, $5b,
   $3b, $fa, $23, $38, $00, $00, $00, $00, $00, $01, $00, $58, $02);
begin
  AStream.Write(Win1Rec, SizeOf(Win1Rec));
end;

procedure TgtCustomExcel95Engine.WriteWorkBookHeader(AStream: TStream);

    function GetFontFamily(AFont: TFont): Byte;
    var
      DisplayDC: HDC;
      TxtMetric: TTEXTMETRIC;
    begin
      Result := FF_DONTCARE;
      DisplayDC := GetDC(0);
      if (DisplayDC <> 0) then
      begin
        if (SelectObject(DisplayDC, AFont.Handle) <> 0) then
          if (GetTextMetrics(DisplayDC, TxtMetric)) then
            Result := (TxtMetric.tmPitchAndFamily and $F0) shr 4;
        ReleaseDC(0, DisplayDC);
      end;
    end;

    procedure WriteFontToStream(AFont: TFont);
    var
      S: String;
      LATemp : AnsiString;
      FontAttribute: array[6..18] of Byte;
      FontHeight: Word;
      ColorIndex, ColorValue, I: Integer;
    begin
      ColorIndex := -1;
      with AFont do
      begin
        if(Preferences.UseDefaultPalette) then
        begin
          ColorValue := ColorToRGB(Color);
          for I := 0 to FColorArraySize - 1 do
          begin
            if(FColorArray[I] = ColorValue) then
            begin
              ColorIndex := I + 8;
              Break;
            end;
          end;
        end
        else
        begin
          S := ColorToString(Color);
          ColorIndex := FColorTable.IndexOf(S) + 8;
        end;
        FontAttribute[6] := 0;
        if fsItalic in Style then
          FontAttribute[6] := FontAttribute[6] + 2;
        if fsStrikeOut in Style then
          FontAttribute[6] := FontAttribute[6] + 8;
        FontAttribute[7] := 0;
        FontAttribute[8] := ColorIndex and $FF;
        FontAttribute[9] := (ColorIndex shr 8) and $FF;
        FontAttribute[10] := $90;
        FontAttribute[11] := $01;
        if fsBold in Style then
        begin
          FontAttribute[10] := $BC;
          FontAttribute[11] := $02;
        end;
        FontAttribute[12] := 0;
        FontAttribute[13] := 0;
        FontAttribute[14] := 0;
        if fsUnderline in Style then
          FontAttribute[14] := 1;
        FontAttribute[15] := GetFontFamily(AFont);
        FontAttribute[16] := CharSet;
        if Charset = DEFAULT_CHARSET then
          FontAttribute[16] := GetDefFontCharSet;
        FontAttribute[17] := 0;
        S := Name;
        FontAttribute[18] := Length(S);
        WriteRecord(49, Length(S) + 15, [0], 0, AStream);
        FontHeight := 20 * Abs(Size);  // GP
        AStream.Write(FontHeight, Sizeof(FontHeight));
        AStream.Write(FontAttribute, Sizeof(FontAttribute));
        LATemp := AnsiString(S);
        AStream.Write(LATemp[1], Length(S));
      end;
    end;

    procedure WriteFormatRecords;
    const
      // Standard built-in number formats
      A: array [0..367] of Byte = (
        $1e, $04, $1a, $00, $05, $00, $17, $22, $24, $22, $23, $2c, $23, $23, $30, $5f,
        $29, $3b, $5c, $28, $22, $24, $22, $23, $2c, $23, $23, $30, $5c, $29,
        $1e, $04, $1f, $00, $06, $00, $1c, $22, $24, $22, $23, $2c, $23, $23, $30, $5f,
        $29, $3b, $5b, $52, $65, $64, $5d, $5c, $28, $22, $24, $22, $23, $2c, $23, $23,
        $30, $5c, $29,
        $1e, $04, $20, $00, $07, $00, $1d, $22, $24, $22, $23, $2c, $23, $23, $30, $2e,
        $30, $30, $5f, $29, $3b, $5c, $28, $22, $24, $22, $23, $2c, $23, $23, $30, $2e,
        $30, $30, $5c, $29,
        $1e, $04, $25, $00, $08, $00, $22, $22, $24, $22, $23, $2c, $23, $23, $30, $2e,
        $30, $30, $5f, $29, $3b, $5b, $52, $65, $64, $5d, $5c, $28, $22, $24, $22, $23,
        $2c, $23, $23, $30, $2e, $30, $30, $5c, $29,
        $1e, $04, $35, $00, $2a, $00, $32, $5f, $28, $22, $24, $22, $2a, $20, $23, $2c,
        $23, $23, $30, $5f, $29, $3b, $5f, $28, $22, $24, $22, $2a, $20, $5c, $28, $23,
        $2c, $23, $23, $30, $5c, $29, $3b, $5f, $28, $22, $24, $22, $2a, $20, $22, $2d,
        $22, $5f, $29, $3b, $5f, $28, $40, $5f, $29,
        $1e, $04, $2c, $00, $29, $00, $29, $5f, $28, $2a, $20, $23, $2c, $23, $23, $30,
        $5f, $29, $3b, $5f, $28, $2a, $20, $5c, $28, $23, $2c, $23, $23, $30, $5c, $29,
        $3b, $5f, $28, $2a, $20, $22, $2d, $22, $5f, $29, $3b, $5f, $28, $40, $5f, $29,
        $1e, $04, $3d, $00, $2c, $00, $3a, $5f, $28, $22, $24, $22, $2a, $20, $23, $2c,
        $23, $23, $30, $2e, $30, $30, $5f, $29, $3b, $5f, $28, $22, $24, $22, $2a, $20,
        $5c, $28, $23, $2c, $23, $23, $30, $2e, $30, $30, $5c, $29, $3b, $5f, $28, $22,
        $24, $22, $2a, $20, $22, $2d, $22, $3f, $3f, $5f, $29, $3b, $5f, $28, $40, $5f,
        $29,
        $1e, $04, $34, $00, $2b, $00, $31, $5f, $28, $2a, $20, $23, $2c, $23, $23, $30,
        $2e, $30, $30, $5f, $29, $3b, $5f, $28, $2a, $20, $5c, $28, $23, $2c, $23, $23,
        $30, $2e, $30, $30, $5c, $29, $3b, $5f, $28, $2a, $20, $22, $2d, $22, $3f, $3f,
        $5f, $29, $3b, $5f, $28, $40, $5f, $29);
        (*
        $1e, $04, $0a, $00, $00, $00, $07, $47, $65, $6e, $65, $72, $61, $6c, {General-0}
        $1e, $04, $04, $00, $00, $00, $01, $30,                               {Integer-1}
        $1e, $04, $07, $00, $00, $00, $04, $30, $2e, $30, $30,                {Double-2}
        $1e, $04, $08, $00, $00, $00, $05, $23, $2c, $23, $23, $30,           {Integer_TS-3}
        $1e, $04, $0b, $00, $00, $00, $08, $23, $2c, $23, $23, $30, $2e, $30, $30, {Double_TS-4}
        $1e, $04, $1a, $00, $00, $00, $17, $22, $24, $22, $23, $2c, $23, $23, $30, $5f,
        $29, $3b, $5c, $28, $22, $24, $22, $23, $2c, $23, $23, $30, $5c, $29, {Currency-5}
        $1e, $04, $1f, $00, $00, $00, $1c, $22, $24, $22, $23, $2c, $23, $23, $30, $5f,
        $29, $3b, $5b, $52, $65, $64, $5d, $5c, $28, $22, $24, $22, $23, $2c, $23, $23,
        $30, $5c, $29,                                                        {Currency-6}
        $1e, $04, $20, $00, $00, $00, $1d, $22, $24, $22, $23, $2c, $23, $23, $30, $2e,
        $30, $30, $5f, $29, $3b, $5c, $28, $22, $24, $22, $23, $2c, $23, $23, $30, $2e,
        $30, $30, $5c, $29,                                                   {Currency-7}
        $1e, $04, $25, $00, $00, $00, $22, $22, $24, $22, $23, $2c, $23, $23, $30, $2e,
        $30, $30, $5f, $29, $3b, $5b, $52, $65, $64, $5d, $5c, $28, $22, $24, $22, $23,
        $2c, $23, $23, $30, $2e, $30, $30, $5c, $29,                          {Currency-8}
        $1e, $04, $05, $00, $00, $00, $02, $30, $25,                          {0%-9}
        $1e, $04, $08, $00, $00, $00, $05, $30, $2e, $30, $30, $25,           {0.00%-0a}
        $1e, $04, $0b, $00, $00, $00, $08, $30, $2e, $30, $30, $45, $2b, $30, $30, {0.00E+00-0b}
        $1e, $04, $09, $00, $00, $00, $06, $23, $5c, $20, $3f, $2f, $3f,      {# ?/?-0c}
        $1e, $04, $0b, $00, $00, $00, $08, $23, $5c, $20, $3f, $3f, $2f, $3f, $3f, {# ??/??-0d}
        $1e, $04, $09, $00, $00, $00, $08, $6d, $2f, $64, $2f, $79, $79,      {m/d/yy-0e}
        $1e, $04, $0d, $00, $00, $00, $0a, $64, $5c, $2d, $6d, $6d, $6d, $5c, $2d,
        $79, $79,                                                             {d-mmm-yy-0f}
        $1e, $04, $09, $00, $00, $00, $06, $64, $5c, $2d, $6d, $6d, $6d,      {d-mmm-10}
        $1e, $04, $0a, $00, $00, $00, $07, $6d, $6d, $6d, $5c, $2d, $79, $79, {mmm-yy-11}
        $1e, $04, $0e, $00, $00, $00, $0b, $68, $3a, $6d, $6d, $5c, $20, $41, $4d, $2f,
        $50, $4d,                                                             {h:mm AM/PM-12}
        $1e, $04, $11, $00, $00, $00, $0e, $68, $3a, $6d, $6d, $3a, $73, $73, $5c, $20,
        $41, $4d, $2f, $50, $4d,                                              {h:mm:ss AM/PM-13}
        $1e, $04, $07, $00, $00, $00, $04, $68, $3a, $6d, $6d,                {h:mm-14}
        $1e, $04, $0a, $00, $00, $00, $07, $68, $3a, $6d, $6d, $3a, $73, $73, {h:mm:ss-15}
        $1e, $04, $0f, $00, $00, $00, $0e, $6d, $2f, $64, $2f, $79, $79, $5c, $20, $68,
        $3a, $6d, $6d,                                                       {m/d/yy h:mm-16}
        *)
    begin
      AStream.Write(A, SizeOf(A));
    end;

    procedure WriteStyleXFRecord(AFontIndex: Integer; AStyleNo: Integer);
    var
      CellAttributes: array [4..19] of Byte;
    begin
      CellAttributes[4] := 0;
      CellAttributes[5] := 0;
      CellAttributes[6] := 0;
      CellAttributes[7] := 0;
      CellAttributes[8] := $F5;
      CellAttributes[9] := $FF;
      CellAttributes[10] := $20;
      CellAttributes[11] := $F4;
      if AStyleNo = 0 then
        CellAttributes[11] := 0;
      CellAttributes[12] := $20;
      CellAttributes[13] := $C0;
      CellAttributes[14] := 0;
      CellAttributes[15] := 0;
      CellAttributes[16] := 0;
      CellAttributes[17] := 0;
      CellAttributes[18] := 0;
      CellAttributes[19] := 0;
      WriteRecord(224, Sizeof(CellAttributes), [0], 0, AStream);
      AStream.Write(CellAttributes, Sizeof(CellAttributes));
    end;

    procedure WriteCellXFRecord(AFontIndex, AFormatIndex: Integer;
      AFontAlign: TgtHAlignment; AWrapText: Boolean; ABrush: TBrush);
    var
      CellAttributes: array [4..19] of Byte;
      I: Integer;
      LColor, LValue1: Word;
    begin
      LValue1 := 0;
      for I := Low(CellAttributes) to High(CellAttributes) do
        CellAttributes[I] := 0;

      CellAttributes[4] := (AFontIndex and $FF);
      CellAttributes[5] := ((AFontIndex shr 8) and $FF);
      CellAttributes[6] := (AFormatIndex and $FF);
      CellAttributes[7] := ((AFormatIndex shr 8) and $FF);
      CellAttributes[8] := 01;
      CellAttributes[9] := 0;

      // default = general(0) - already initialized
      if AFontAlign = haRight then
        CellAttributes[10] := $3
      else if AFontAlign = haCenter then
        CellAttributes[10] := $2
      else if AFontAlign = haLeft then
        CellAttributes[10] := $1;

      if AWrapText then
        CellAttributes[10] := CellAttributes[10] or $8;
      CellAttributes[11] := 0;

      if (ABrush <> nil) and (ABrush.Color <> BackgroundColor) then
      begin
        LColor := ( 8 + AddColorToColorTable(clWhite)) shl 7;
        LColor := LColor + (8 + AddColorToColorTable(ABrush.Color));
        LValue1 := LValue1 + GetFillStyle(Byte(ABrush.Style));
      end
      else
        LColor := $C0;
      CellAttributes[12] := LColor and $FF;
      CellAttributes[13] := $20; //(LColor shr 8) and $FF;
      CellAttributes[14] := LValue1 and $FF;
      CellAttributes[14] := CellAttributes[14] and $3F;
      CellAttributes[15] := (LValue1 shr 8) and $FF;

      if CellBorder.Enabled = True then
      begin
        LColor := 8 + AddColorToColorTable(CellBorder.Color);
        case CellBorder.Style of
          cbsNone:
          begin
            CellAttributes[15] := LColor and $FF;
            CellAttributes[15] := CellAttributes[15] shl 1;
            CellAttributes[15] := CellAttributes[15] and $FE;
            CellAttributes[16] := 0;
            CellAttributes[17] := LColor and $FF;
            CellAttributes[17] := CellAttributes[17] shl 1;
            CellAttributes[17] := CellAttributes[17] and $FE;
            CellAttributes[18] := LColor and $FF;
            CellAttributes[18] := CellAttributes[18] or ((LColor and 1) shr 7);
						CellAttributes[19] := (LColor shr 1)and $FF;
          end;

          cbsThin:
          begin
            CellAttributes[14] := CellAttributes[14] or $40;
            CellAttributes[15] := LColor and $FF;
            CellAttributes[15] := CellAttributes[15] shl 1;
            CellAttributes[15] := CellAttributes[15] and $FE;
            CellAttributes[16] := 1;
            CellAttributes[16] := CellAttributes[16] or 8;
            CellAttributes[16] := CellAttributes[16] or $40;
            CellAttributes[17] := LColor and $FF;
            CellAttributes[17] := CellAttributes[17] shl 1;
            CellAttributes[17] := CellAttributes[17] and $FE;
            CellAttributes[18] := LColor and $EF;
            CellAttributes[18] := CellAttributes[18] or ((LColor and 01) shr 7);
            CellAttributes[19] := (LColor shr 1) and $FF;
          end;

          cbsMedium:
          begin
            CellAttributes[14] := Cellattributes[14] or $80;
            CellAttributes[15] := LColor and $FF;
            CellAttributes[15] := CellAttributes[15] shl 1;
            CellAttributes[15] := CellAttributes[15] and $FE;
            CellAttributes[16] := 2;
            CellAttributes[16] := CellAttributes[16] or $10;
            CellAttributes[16] := CellAttributes[16] or $80;
            CellAttributes[17] := LColor and $FF;
            CellAttributes[17] := CellAttributes[17] shl 1;
            CellAttributes[17] := CellAttributes[17] and $FE;
            CellAttributes[18] := LColor and $FF;
            CellAttributes[18] := CellAttributes[18] or ((LColor and 1) shr 7);
            CellAttributes[19] := (LColor shr 1) and $FF;
          end;

          cbsDashed:
          begin
            CellAttributes[14] := CellAttributes[14] or $C0;
            CellAttributes[15] := LColor and $FF;
            CellAttributes[15] := CellAttributes[15] shl 1;
            Cellattributes[15] := CellAttributes[15] and $FE;
            CellAttributes[16] := 3;
            CellAttributes[16] := CellAttributes[16] or $18;
            CellAttributes[16] := CellAttributes[16] or $C0;
            CellAttributes[17] := LColor and $FF;
            CellAttributes[17] := CellAttributes[17] shl 1;
            CellAttributes[17] := CellAttributes[17] and $FE;
            CellAttributes[18] := LColor and $FF;
            CellAttributes[18] := CellAttributes[18] or ((LColor and 1) shr 7);
            CellAttributes[19] := (LColor shr 1) and $FF;
          end;

          cbsDotted:
          begin
            CellAttributes[15] := LColor and $FF;
            CellAttributes[15] := CellAttributes[15] shl 1;
            CellAttributes[15] := CellAttributes[15] or 1;
            CellAttributes[16] := 4;
            CellAttributes[16] := CellAttributes[16] or $20;
            CellAttributes[17] := LColor and $FF;
            CellAttributes[17] := CellAttributes[17] shl 1;
            CellAttributes[17] := CellAttributes[17] or 1;
            CellAttributes[18] := LColor and $FF;
            CellAttributes[18] := CellAttributes[18] or ((LColor and 1) shr 7);
            CellAttributes[19] := (LColor shr 1) and $FF;
          end;

          cbsThick:
          begin
            CellAttributes[14] := CellAttributes[14] or $40;
            CellAttributes[15] := LColor and $FF;
            CellAttributes[15] := CellAttributes[15] shl 1;
            CellAttributes[15] := CellAttributes[15] or 1;
            CellAttributes[16] := 5;
            CellAttributes[16] := CellAttributes[16] or $28;
            CellAttributes[16] := CellAttributes[16] or $40;
            CellAttributes[17] := LColor and $FF;
            CellAttributes[17] := CellAttributes[17] shl 1;
            CellAttributes[17] := CellAttributes[17] or 1;
            CellAttributes[18] := LColor and $FF;
            CellAttributes[18] := CellAttributes[18] or ((LColor and 1) shr 7);
            CellAttributes[19] := (LColor shr 1) and $FF;
          end;

          cbsDouble:
          begin
            CellAttributes[14] := CellAttributes[14] or $80;
            CellAttributes[15] := LColor and $FF;
            CellAttributes[15] := CellAttributes[15] shl 1;
            CellAttributes[15] := CellAttributes[15] or 1;
            CellAttributes[16] := 6;
            CellAttributes[16] := CellAttributes[16] or $30;
            CellAttributes[16] := CellAttributes[16] or $80;
            CellAttributes[17] := LColor and $FF;
            CellAttributes[17] := CellAttributes[17] shl 1;
            CellAttributes[17] := CellAttributes[17] or 1;
            CellAttributes[18] := LColor and $FF;
            CellAttributes[18] := CellAttributes[18] or ((LColor and 1) shr 7);
            CellAttributes[19] := (LColor shr 1) and $FF;
          end;

          cbsHair:
          begin
            CellAttributes[14] := CellAttributes[14] or $C0;
            CellAttributes[15] := LColor and $FF;
            CellAttributes[15] := CellAttributes[15] shl 1;
            Cellattributes[15] := CellAttributes[15] or 1;
            CellAttributes[16] := 7;
            CellAttributes[16] := CellAttributes[16] or $38;
            CellAttributes[16] := CellAttributes[16] or $C0;
            CellAttributes[17] := LColor and $FF;
            CellAttributes[17] := CellAttributes[17] shl 1;
            CellAttributes[17] := CellAttributes[17] or 1;
            CellAttributes[18] := LColor and $FF;
            CellAttributes[18] := CellAttributes[18] or ((LColor and 1) shr 7);
            CellAttributes[19] := (LColor shr 1) and $FF;
          end;
        end;
      end;

      WriteRecord(224, Sizeof(CellAttributes), [0], 0, AStream);
      AStream.Write(CellAttributes, Sizeof(CellAttributes));
    end;

    procedure WriteStyleRecord;
    var
      StyleAttrib: array [4..7] of Byte;
    begin
      StyleAttrib[4] := 0;
      StyleAttrib[5] := $80;
      StyleAttrib[6] := 0;
      StyleAttrib[7] := $FF;
      WriteRecord($293, 4, [0], 0, AStream);
      AStream.Write(StyleAttrib, SizeOf(StyleAttrib));
    end;

    procedure WritePaletteRecord;
    var
      ColorCount: Word;
      I: Integer;
      Color: TColor;
      ColorRGB: LongInt;
      ColorAttrib: array [0..3] of Byte;
    begin
      if(Preferences.UseDefaultPalette)then
      begin
        ColorCount := FColorArraySize ;
        WriteRecord(146, (FColorArraySize) * 4 + 2, [0], 0, AStream);
        AStream.Write(ColorCount, SizeOf(ColorCount));
        for I := 0 to FColorArraySize -1 do
        begin
          ColorRGB := FColorArray[I];
          ColorAttrib[0] := ColorRGB and $FF;
          ColorAttrib[1] := (ColorRGB shr 8) and $FF;
          ColorAttrib[2] := (ColorRGB shr 16) and $FF;
          ColorAttrib[3] := 0;
          AStream.Write(ColorAttrib, Sizeof(ColorAttrib));
        end;
      end
      else
      begin
        ColorCount := FColorTable.Count;
        WriteRecord(146, ColorCount * 4 + 2, [0], 0, AStream);
        AStream.Write(ColorCount, SizeOf(ColorCount));
        for I := 0 to FColorTable.Count - 1 do
        begin
          Color := TColor(FColorTable.Objects[I]);
          ColorRGB := ColorToRGB(Color);
          ColorAttrib[0] := ColorRGB and $FF;
          ColorAttrib[1] := (ColorRGB shr 8) and $FF;
          ColorAttrib[2] := (ColorRGB shr 16) and $FF;
          ColorAttrib[3] := 0;
          AStream.Write(ColorAttrib, Sizeof(ColorAttrib));
        end;
      end;
    end;

    procedure WriteSheetInfo(AStreamSize: Int64; ASheetNo: Integer);
    var
      S: AnsiString;
      LATemp : AnsiString;
      SheetAttrib: array[4..10] of Byte;
      BOFPos: Int64;
    begin
      with FSpreadSheetItemList do
      begin
        S := PgtSheetItem((Items[ASheetNo]))^.FSheetName;
        FSheetNamesSize := FSheetNamesSize - Length(S);
        BOFPos := AStream.Size + Length(S) + 15 + 11 * (Count - ASheetNo - 1)
         + AStreamSize + FSheetNamesSize;
        SheetAttrib[4] := BOFPos and $FF;
        SheetAttrib[5] := (BOFPos shr 8) and $FF;
        SheetAttrib[6] := (BOFPos shr 16) and $FF;
        SheetAttrib[7] := (BOFPos shr 24) and $FF;
        SheetAttrib[8] := 0;
        SheetAttrib[9] := 0;
        SheetAttrib[10] := Length(S);
        // BOUNDSHEET
        WriteRecord($85, Length(S) + SizeOf(SheetAttrib), [0], 0, AStream);
        AStream.Write(SheetAttrib, SizeOf(SheetAttrib));
        LATemp := AnsiString(S);
        AStream.Write(LATemp[1], Length(S));
      end;
    end;
var
  I: Integer;
	CellAttrib: TgtCellAttrib;
  S: AnsiString;
//  LBrush: TBrush;
const
  LByte: array[0..0] of Byte = (0);
begin
  // Workbook header BOF
  WriteRecord(cExcel_BIFF7, 8,[$0500, $0005, $24d7, $07cd], 8, AStream);
  // INTERFACEHDR
//	WriteRecord($E1, 0, [0], 0, AStream);
  // MMS
//	WriteRecord($C1, 2, [0], 2, AStream);
  // INTERFACEEND
//	WriteRecord($E2, 0, [0], 0, AStream);
  // WRITEACCESS
  WriteRecord($5C, 112, [0], 0, AStream);
  AStream.Write(LByte, 1);
  S := StringOfChar(AnsiChar(' '), 111);
  AStream.Write(S[1], Length(S));
  // CodePage
	WriteRecord($42, 2, [GetACP], 2, AStream);
  // FNGROUPCOUNT
  // WINDOWPROTECT
  // PROTECT
  // PASSWORD

  // WINDOW1
  WriteWindow1Record(AStream);
  // 1904 Date system
//	WriteRecord($22, 2, [0], 2, AStream);

  AddColorToColorTable(DefaultFont.Color);
  // Font
  for I := 1 to 4 do
    WriteFontToStream(DefaultFont);
	for I := 0 to FFontTable.Count - 1 do
	begin
    WriteFontToStream(TFont(FFontTable.Objects[I]));
		TFont(FFontTable.Objects[I]).Free;
	end;
  // Format
//  WriteFormatRecords;

  // XF - Extended format
	for I := 0 to 14 do
		WriteStyleXFRecord(0, I);

  // Default CellXFRec
  WriteCellXFRecord(0, 0, haGeneral, Preferences.WordWrap, nil);

//  LBrush := TBrush.Create;
//  try
//    LBrush.Color := BackgroundColor;
//    if ColorToRGB(LBrush.Color) = ColorToRGB(clWindow) then
//      WriteCellXFRecord(0, 0, haGeneral, Preferences.WordWrap, nil)
//    else
//      WriteCellXFRecord(0, 0, haGeneral, Preferences.WordWrap, LBrush);
//  finally
//    FreeAndNil(LBrush);
//  end;

	for I := 0 to FCellXFTable.Count - 1 do
	begin
		CellAttrib := TgtCellAttrib(FCellXFTable.Objects[I]);
		WriteCellXFRecord(CellAttrib.FontIndex, CellAttrib.FormatIndex,
      CellAttrib.Alignment, CellAttrib.WordWrap, CellAttrib.Brush);
		CellAttrib.Free;
	end;

  // Style
  WriteStyleRecord;
  // Palette
  WritePaletteRecord;

  // Boundsheet
  with FSpreadSheetItemList do
  begin
    for I := 0 to Count -1 do
    begin
      S := PgtSheetItem((Items[I]))^.FSheetName;
      FSheetNamesSize := FSheetNamesSize + Length(S);
    end;
    WriteSheetInfo(0, 0);
    for I := 0 to Count - 2 do
      WriteSheetInfo(PgtSheetItem((Items[I]))^.FSheetOffset, I + 1);
  end;

	// Workbook header EOF
	WriteRecord(CExcel_EOF, CExcel_Rec_Size_EOF, [0], 0, AStream);
end;

procedure TgtCustomExcel95Engine.WriteBackgroundImage;
begin
{ Encoded in case of Pro }
end;

function TgtCustomExcel95Engine.GetPreferences: TgtExcelPreferences;
begin
  Result := TgtExcelPreferences(inherited Preferences);
end;

function TgtCustomExcel95Engine.GetPreferencesClassName: TgtPreferencesClass;
begin
  Result := TgtExcelPreferences;
end;

procedure TgtCustomExcel95Engine.SetPreferences(
  const Value: TgtExcelPreferences);
begin
  inherited Preferences := Value;
end;

function TgtCustomExcel95Engine.ShowSetupModal: Word;
begin
  with TgtExcelEngineDlg.Create(nil) do
  try
    Engine := Self;
    Result := ShowModal;
  finally
    Free;
  end;
end;

procedure TgtCustomExcel95Engine.BeginDoc;
begin
  inherited;
end;

procedure TgtCustomExcel95Engine.SetCellBorder(const Value: TgtCellBorder);
begin
  FCellBorder := Value;
end;

procedure TgtCustomExcel95Engine.NewSheet(AAddNewPage: Boolean);
begin
  inherited;
  if (AAddNewPage) then NewPage;
  Inc(FSheetCount);
  EndSheet(FSheetCount);
end;

procedure TgtCustomExcel95Engine.InitDimensionVars;
begin
  FMinRowNo := MaxInt;
  FMaxRowNo := -1;
  FMinColNo := MaxInt;
  FMaxColNo := -1;
end;

{ TgtExcelOLEStream }

procedure TgtExcelOLEStream.CalculateBATBlocks;
var
  E: Extended;
begin
	FFirstXBATIndex := -2;
	FFirstBlockIndex := 1;
	FBATBlockCount := 1;
	FXBatCount := 0;

	FExcelStreamSize := ((FExcelStream.Size div 512) + 1) * 512;
	if FExcelStreamSize < 4096 then
		FExcelStreamSize := 4096;
	FBatCount := Ceil((FExcelStreamSize + CSummaryInfoSize +
		CDocumentSummaryInfoSize) / 512);
	FBatCount := FBatCount + FBATBlockCount;

	if FBatCount > 128 then
	begin
		FBATBlockCount := FBATBlockCount + Ceil((FBATCount / 128));
		FBatCount := FBatCount + Ceil((FBATCount / 128));
	end;

	if FBATBlockCount > 109 then
	begin
		FXBatCount :=  Ceil((FBATBlockCount - 109) / 128);
    FFirstXBatIndex := FBatCount - FBATBlockCount ;
    FBatCount :=  FBatCount + FXBatCount;
    E := (FBATBlockCount + FXBatCount - 1) / 128;
    FBATBlockCount := FBATBlockCount + Ceil(E);
    FBatCount := FBatCount + Ceil(E)
	end;
end;

{------------------------------------------------------------------------------}

constructor TgtExcelOLEStream.Create;
begin
	inherited;
  FStream := TMemoryStream.Create;
end;

{------------------------------------------------------------------------------}

destructor TgtExcelOLEStream.Destroy;
begin
  FreeAndNil(FStream);
	inherited;
end;

{------------------------------------------------------------------------------}

procedure TgtExcelOLEStream.MakeExcelStream;
begin
	CalculateBATBlocks;
	WriteHeader;
	WriteBlocks;
	WritePropertyBlock;
end;

{------------------------------------------------------------------------------}

procedure TgtExcelOLEStream.WriteBlocks;
const
  CSummaryInfo: array[0..216] of byte =
    ($fe, $ff, $00, $00, $05, $01, $02, $00, $00, $00, $00, $00, $00, $00, $00,
     $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $e0, $85,
     $9f, $f2, $f9, $4f, $68, $10, $ab, $91, $08, $00, $2b, $27, $b3, $d9, $30,
     $00, $00, $00, $b0, $00, $00, $00, $07, $00, $00, $00, $01, $00, $00, $00,
     $40, $00, $00, $00, $04, $00, $00, $00, $48, $00, $00, $00, $08, $00, $00,
     $00, $60, $00, $00, $00, $12, $00, $00, $00, $78, $00, $00, $00, $0c, $00,
     $00, $00, $90, $00, $00, $00, $0d, $00, $00, $00, $9c, $00, $00, $00, $13,
     $00, $00, $00, $a8, $00, $00, $00, $02, $00, $00, $00, $e4, $04, $00, $00,
     $1e, $00, $00, $00, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
     $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
     $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
     $00, $00, $00, $1e, $00, $00, $00, $10, $00, $00, $00, $65, $44, $6f, $63,
     $45, $6e, $67, $69, $6e, $65, $20, $56, $43, $4c, $00, $00, $40, $00, $00,
     $00, $00, $ca, $8e, $bf, $77, $ad, $ca, $01, $40, $00, $00, $00, $80, $bb,
     $b1, $37, $89, $ad, $ca, $01, $03);
  CDocSummaryInfo: array[0..198] of byte =
    ($fe, $ff, $00, $00, $05, $01, $02, $00, $00, $00, $00, $00, $00, $00, $00,
     $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $02, $d5,
     $cd, $d5, $9c, $2e, $1b, $10, $93, $97, $08, $00, $2b, $2c, $f9, $ae, $30,
     $00, $00, $00, $9c, $00, $00, $00, $06, $00, $00, $00, $01, $00, $00, $00,
     $38, $00, $00, $00, $0f, $00, $00, $00, $40, $00, $00, $00, $0b, $00, $00,
     $00, $54, $00, $00, $00, $10, $00, $00, $00, $5c, $00, $00, $00, $0d, $00,
     $00, $00, $64, $00, $00, $00, $0c, $00, $00, $00, $77, $00, $00, $00, $02,
     $00, $00, $00, $e4, $04, $00, $00, $1e, $00, $00, $00, $0c, $00, $00, $00,
     $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $0b, $00, $00,
     $00, $00, $00, $00, $00, $0b, $00, $00, $00, $00, $00, $00, $00, $1e, $10,
     $00, $00, $01, $00, $00, $00, $07, $00, $00, $00, $53, $68, $65, $65, $74,
     $31, $00, $0c, $10, $00, $00, $02, $00, $00, $00, $1e, $00, $00, $00, $0b,
     $00, $00, $00, $57, $6f, $72, $6b, $73, $68, $65, $65, $74, $73, $00, $03,
     $00, $00, $00, $01);
var
	APos: Integer;
	AStream: TMemoryStream;
begin
	APos := FStream.Position;
	AStream := TMemoryStream.Create;
	try
		AStream.Size := (FBATCount * 512) { - CSummaryInfoSize -
			CDocumentSummaryInfoSize} - (FBATBlockCount * 512);
		FillChar(AStream.Memory^, AStream.Size, 0);
		FStream.CopyFrom(AStream, 0);
	finally
		FreeAndNil(AStream);
	end;

	FStream.Position := APos;
  // Book Stream
	FStream.CopyFrom(FExcelStream, 0);

	FStream.Position := FExcelStreamSize + 512;
  // SummaryInfo Stream
	FStream.Write(CSummaryInfo, SizeOf(CSummaryInfo));

	FStream.Position := FExcelStreamSize + CSummaryInfoSize + 512;
  // DocSummaryInfo Stream
	FStream.Write(CDocSummaryInfo, SizeOf(CDocSummaryInfo));
end;

{------------------------------------------------------------------------------}

procedure TgtExcelOLEStream.WriteHeader;
const
	FileTypeID: array[0..7] of Byte =
		($D0, $CF, $11, $E0, $A1, $B1, $1A, $E1);
var
	I: Integer;
	AWord: Word;
	ALongInt: LongInt;
begin
	// $0000
	FStream.Write(FileTypeID, SizeOf(FileTypeID));
	// $0008
	ALongInt := $0;
	FStream.Write(ALongInt, 4);
	// $000C
	ALongInt := $0;
	FStream.Write(ALongInt, 4);
	// $0010
	ALongInt := $0;
	FStream.Write(ALongInt, 4);
	// $0014
	ALongInt := $0;
	FStream.Write(ALongInt, 4);
	// $0018
	AWord := $003b;
	//AWord := $003E;
	FStream.Write(AWord, 2);
	// $001A
	AWord := $0003;
	FStream.Write(AWord, 2);
	// $001C
	AWord := $FFFE;
	FStream.Write(AWord, 2);
	// $001E
	AWord := $0009;
	FStream.Write(AWord, 2);
	// $0020
	ALongInt := $0006;
	FStream.Write(ALongInt, 2);
	// $0022
	ALongInt := $0;
	FStream.Write(ALongInt, 2);
	// $0024
	ALongInt := $0;
	FStream.Write(ALongInt, 4);
	// $0028
	ALongInt := $0;
	FStream.Write(ALongInt, 4);

	// $002C
	ALongInt := FBATBlockCount;
	FStream.Write(ALongInt, 4);
	// $0030
	ALongInt := FBATCount;
	FStream.Write(ALongInt, 4);

	// $0034
	ALongInt := $0;
	FStream.Write(ALongInt, 4);
	// $0038
	ALongInt := $00001000;
	FStream.Write(ALongInt, 4);
	// $003C
	ALongInt := -2;
	FStream.Write(ALongInt, 4);
	// $0040      --- Changed - GP
	ALongInt := 0;
	FStream.Write(ALongInt, 4);
	// $0044
	ALongInt := FFirstXBatIndex;
	FStream.Write(ALongInt, 4);
	// $0048
	ALongInt := FXBatCount;
	FStream.Write(ALongInt, 4);
	// $004C
  If  FBATBlockCount <= 109 then
  begin
    for I := 1 to FBATBlockCount do
    begin
      ALongInt := FBATCount - 1{Header} - FBATBlockCount + I;
      FStream.Write(ALongInt, 4);
    end;

    for I := 1 to ((512 - $4C) div 4) - FBATBlockCount do
    begin
      ALongInt := -1;
      FStream.Write(ALongInt, 4);
    end;
  end
  else
  for I := 1 to 109 do
  begin
    ALongInt := FBATCount - 1{Header} - FBATBlockCount + I;
    FStream.Write(ALongInt, 4);
  end;
end;

{------------------------------------------------------------------------------}

procedure TgtExcelOLEStream.WritePropertyBlock;
  function  chartohex(chr: Char):integer;
  begin
    Result := byte(chr);
    if Result < 65  then
      Result := Result - 48
    else
      Result := Result - 55;
  end;

  Procedure StringtoHex(Astr:String);
  var
    I: Integer;
    Value: Byte;
  begin
    I :=1;
    Astr := UpperCase(Astr);
    while I <= Length(Astr) do
    begin
        Value := chartohex(Astr[I]);
        Value := value*16 + chartohex(Astr[I + 1]);
        FStream.Write(value , 1);
        Inc(I, 2);
    end
  end;
var
	I: Integer;
	ALongInt: LongInt;
	AStream: TMemoryStream;
	ABuf: array[1..512] of Byte;
begin
  AStream := TMemoryStream.Create;
	try
    FillChar(ABuf, 512, $FF);
    FStream.Position := FFirstXBatIndex * 512  + 512;
    For I := 1 to  FXBatCount do
      FStream.Write(ABuf, 512);

    FStream.Position := FFirstXBatIndex * 512  + 512;
    for I := 110 to FBATBlockCount do
    begin
      ALongInt := FBATCount - 1{Header} - FBATBlockCount + I;
      FStream.Write(ALongInt, 4);
    end;

    FStream.Position := FBATCount * 512 + 512;
    StringtoHex(COLEPadBytes);
		FStream.Position := (FBATCount - FBATBlockCount) * 512 + 512;
		FillChar(ABuf, 512, $FF);
		for I := 1 to FBATBlockCount do
		begin
			FStream.Write(ABuf, 512);
		end;

		FStream.Position := (FBATCount - FBATBlockCount) *  512 + 512;
		for I := 1 to FBATCount - FBATBlockCount - FXBatCount  do
		begin
			ALongInt := I;
			if (I = (FExcelStreamSize div 512)) or
          (I = ((FExcelStreamSize + CSummaryInfoSize) div 512)) or
          (I = ((FExcelStreamSize + CSummaryInfoSize + CDocumentSummaryInfoSize) div 512)) then
        ALongInt := -2;
			FStream.Write(ALongInt, 4);
		end;

    for I := 1 to FXBatCount do
		begin
			ALongInt := -4;
			FStream.Write(ALongInt, 4);
		end;

		for I := 1 to FBATBlockCount do
		begin
			ALongInt := -3;
			FStream.Write(ALongInt, 4);
		end;

		ALongInt := -2;
		FStream.Write(ALongInt, 4);

    // Update Book stream size
    FStream.Position :=	512 + FExcelStreamSize + CSummaryInfoSize +
			CDocumentSummaryInfoSize + ( (FXBatCount + FBATBlockCount) * 512) + 248;
		ALongInt := FExcelStreamSize; // -- GP
		FStream.Write(ALongInt, 4);

    // Update SummaryInfo start sect
    FStream.Position :=	512 + FExcelStreamSize + CSummaryInfoSize +
			CDocumentSummaryInfoSize + ((FXBatCount + FBATBlockCount) * 512) + 372;
    ALongInt := (FExcelStreamSize) div 512;
    FStream.Write(ALongInt, 4);

    // Update DocSummaryInfo start sect
    FStream.Position :=	512 + FExcelStreamSize + CSummaryInfoSize +
			CDocumentSummaryInfoSize + ((FXBatCount + FBATBlockCount) * 512) + 500;
    ALongInt := (FExcelStreamSize + CSummaryInfoSize) div 512;
    FStream.Write(ALongInt, 4);
	finally
		FreeAndNil(AStream);
  end;
end;

{ TgtExcelPreferences }

constructor TgtExcelPreferences.Create;
begin
  inherited;
  FPageMargins := False;
  FPrintGridLines := False;
  FPagesPerWorksheet := 0;
  ApplyAlignment := False;
  MultiPass := False;
  WordWrap := False;
  UseDefaultPalette := False;
  ContinuousMode := False;
end;

procedure TgtExcelPreferences.SetMetafileAsImage(const Value: Boolean);
begin
  FMetafileAsImage := Value;
end;

procedure TgtExcelPreferences.SetPageMargins(const Value: Boolean);
begin
  FPageMargins := Value;
end;

procedure TgtExcelPreferences.SetPagesPerWorksheet(
  const Value: TgtWorksheetPagesType);
begin
  FPagesPerWorksheet := Value;
end;

procedure TgtExcelPreferences.SetPrintGridLines(const Value: Boolean);
begin
  FPrintGridLines := Value;
end;


{ TgtCellBorder }

constructor TgtCellBorder.Create;
begin
  FEnabled := False;
  FStyle := cbsNone;
  FColor := clBlack;
end;

destructor TgtCellBorder.Destroy;
begin

  inherited;
end;

procedure TgtCellBorder.SetColor(const Value: TColor);
begin
	FColor := Value;
end;

procedure TgtCellBorder.SetEnabled(const Value: Boolean);
begin
	FEnabled := Value;
end;

procedure TgtCellBorder.SetStyle(const Value: TgtCellBorderStyle);
begin
	FStyle := Value;
end;

end.
