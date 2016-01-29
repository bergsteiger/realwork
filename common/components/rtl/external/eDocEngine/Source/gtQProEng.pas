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

unit gtQProEng;

interface
uses
  Classes, Windows, Graphics, SysUtils, Math, gtCstDocEng, gtCstSpdEng,
  gtConsts3, gtDocConsts, gtDocUtils, gtDocResStrs;
  

type

  TgtQuattroProEngine = class(TgtCustomSpreadSheetEngine)
  private
    FOutputStream: TStream;
    FQProStream: TMemoryStream;

  protected
    procedure Start; override;
    procedure BeginPage; override;
    procedure EndPage; override;
    procedure Finish; override;
    procedure EncodeText(AObject: TgtTextItem); override;
    function AddColorToColorTable(AColor: TColor): Integer; override;
    function ShowSetupModal: Word; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
		property BackgroundColor;
    property Brush;

  end;


implementation
uses gtQProEngDlg;

{ TgtQuattroProEngine }

function TgtQuattroProEngine.AddColorToColorTable(AColor: TColor): Integer;
begin
  Result := inherited AddColorToColorTable(AColor);
  if Result > 15 then
    Result := 0;
end;

procedure TgtQuattroProEngine.Start;
var
  LFontIndex: Integer;
  LBrush: TBrush;
begin
  inherited;

  if not Preferences.OutputToUserStream then
  begin
    FOutputStream := CreateFile(FileName + '.' + FileExtension);
    EngineFileNames.Add(FileName + '.' + FileExtension);
  end
  else
    FOutputStream := UserStream;
    
  FQProStream := TMemoryStream.Create;
  CreateResourceItems;
  WriteRecord(CQpro_BOF, CQpro_BOF_LEN, [CQpro_REVISION], 2, FOutputStream);

  AddColorToColorTable(clWhite);
  LFontIndex := AddFontInfoToFontTable(DefaultFont) + 1;

  LBrush := TBrush.Create;
  LBrush.Color := BackgroundColor;
  AddCellInfoToCellXFTable(LFontIndex, haLeft, $2, LBrush);
  LBrush.Free;
end;

procedure TgtQuattroProEngine.BeginPage;
begin
  inherited;
end;

constructor TgtQuattroProEngine.Create(AOwner: TComponent);
begin
  inherited;
  FileExtension := 'wb1';
  FileDescription := SQuattroProDescription;
  Capabilities := [ckText];
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 107);
{$ENDIF}
end;

destructor TgtQuattroProEngine.Destroy;
begin

  inherited;
end;

procedure TgtQuattroProEngine.EncodeText(AObject: TgtTextItem);
var
  LFormatIndex, LFontIndex, LCellXFIndex: Integer;
  LCellType: TgtCellType;
  LTextAlign: TgtHAlignment;
  LString, LOriginalText: String;
  LATemp : AnsiString;
  LByte: Byte;
  LWord, LStringLength: Word;
  LNumber: Double;
begin
  inherited EncodeText(AObject);
  with AObject do
  begin
    LOriginalText := Lines[0];
    Lines[0] := ReplacePlaceHolders(Lines[0], True);
    LStringLength := 0;
    if Lines[0] = '' then exit;
    LTextAlign := haLeft;

    if AObject is TgtSheetTextItem then
    begin
      LCellType := TgtSheetTextItem(AObject).CellType;
      LTextAlign := TgtSheetTextItem(AObject).Alignment;
    end
    else
      LCellType := GetCellType(Lines[0]);

    LFontIndex := AddFontInfoToFontTable(Font) + 1;
    case LCellType of
      ctString:
        LFormatIndex := $02;
      ctCurrency:
        LFormatIndex := $30;
      ctTime:
        LFormatIndex := $0C;
      ctDate:
        LFormatIndex := $08;
      ctDateTime:
        LFormatIndex := $05;
      else
        LFormatIndex := $0;
    end;

    LCellXFIndex := (AddCellInfoToCellXFTable(LFontIndex, LTextAlign,
      LFormatIndex, Brush) + 1) shl 3;

    LString := '';
    if LCellType in [ctInteger, ctDouble] then
    begin
      LNumber := StrToFloat(GetNumberString(Trim(Lines[0])));
      WriteRecord(CQPro_NUMBER, CQPro_NUMBER_LENGTH, [0], 0,
        FQProStream);
    end
    else
    begin
      LString := Lines[0];
      LStringLength := Length(LString);
      if LStringLength > 250 then
        LStringLength := 250;
      WriteRecord(CQPro_STRING, LStringLength + CQPro_STRING_LEN + 1 , [0], 0,
        FQProStream);
    end;

    LByte := TgtFmTextItem(AObject).ColumnNo;

    FQProStream.Write(LByte, SizeOf(Byte));

    LByte := 0;
    FQProStream.Write(Lbyte,SizeOf(Byte));

    LWord := TgtFmTextItem(AObject).RowNo + FLastPageHeight;

    FQProStream.Write(LWord, SizeOf(Word));

    FQProStream.Write(LCellXFIndex, SizeOf(Word));

    if LString = '' then
      FQProStream.Write(LNumber, SizeOf(LNumber))
    else
    begin
      LByte := 0;
      FQProStream.Write(Lbyte,SizeOf(Byte));
      LATemp := AnsiString(LString);
      FQProStream.Write(LATemp[1], LStringLength + 1);
    end;
    Lines[0] := LOriginalText;
  end;
end;

procedure TgtQuattroProEngine.Finish;

  procedure WriteFontToStream(AFont: TFont);
  var
    LFontAttrib: Word;
    LFontSize: Word;
    LFontName: String;
    LATemp : AnsiString;
  begin
    LFontAttrib := 0;
    AddColorToColorTable(AFont.Color);
    WriteRecord(CQPro_Font, CQPro_Font_LENGTH, [0], 0, FOutputStream);
    LFontSize := AFont.Size;
    FOutputStream.Write(LFontSize, SizeOf(LFontSize));

    if fsBold  in AFont.Style then
      LFontAttrib := LFontAttrib or 1;
    if fsItalic in AFont.Style then
      LFontAttrib := LFontAttrib or 2;
    if fsUnderline in AFont.Style then
      LFontAttrib := LFontAttrib or 4;
    if fsStrikeOut in AFont.Style then
      LFontAttrib := LFontAttrib or 32;

    FOutputStream.Write(LFontAttrib, SizeOf(LFontAttrib));
    LFontName := AFont.Name;
    LATemp := AnsiString(LFontName);
    FOutputStream.Write(LATemp, 32);
  end;

  procedure WritePaletteRecord;
  var
    I: Integer;
    LColor: TColor;
    LColorRGB: LongInt;
    ColorAttrib: array [0..3] of Byte;
  begin
    WriteRecord(CQPro_Color, 64, [0], 0, FOutputStream);
    for I := 0 to 15 do
    begin
      if I < FColorTable.Count then
      begin
        LColor := TColor(FColorTable.Objects[I]);
        LColorRGB := ColorToRGB(LColor);
      end
      else
        LColorRGB := 0;

      ColorAttrib[0] := LColorRGB and $FF;
      ColorAttrib[1] := (LColorRGB shr 8) and $FF;
      ColorAttrib[2] := (LColorRGB shr 16) and $FF;
      ColorAttrib[3] := 0;
      FOutputStream.Write(ColorAttrib, Sizeof(ColorAttrib));
    end;
  end;

  procedure WriteCellXFRecord(AFontIndex, AFormatIndex: Word;
    AFontAlign: TgtHAlignment; ABrush: TBrush);
  var
    LCellAttrib: array [1..12] of Byte;
    LValue: Word;
    I: Integer;
  begin
    for I := Low(LCellAttrib) to High(LCellAttrib) do
      LCellAttrib[I] := 0;

    WriteRecord(CQPro_CellAttrib, 12, [0], 0, FOutputStream);
    LCellAttrib[1] := AFormatIndex and $FF;

    case AFontAlign of
      haRight:
        LCellAttrib[2] := 3;
      haCenter:
        LCellAttrib[2] := 2;
      else
        LCellAttrib[2] := 1;
    end;

    LValue := 256;

    LValue := LValue + AddColorToColorTable(clWhite) shl 4;
    if ABrush <> nil then
      LValue := LValue + AddColorToColorTable(ABrush.Color);

    if AFontIndex <= FFontTable.Count then
      LValue := LValue + (AddColorToColorTable
        (TFont(FFontTable.Objects[AFontIndex - 1]).Color)) shl 12;

    LCellAttrib[3] := LValue and $FF;
    LCellAttrib[4] := (LValue shr 8) and $FF;
    LCellAttrib[5] := AFontIndex;
    LCellAttrib[7] := 255;
    FOutputStream.Write(LCellAttrib, SizeOf(LCellAttrib))
  end;

var
  I: Integer;
  LCellAttrib: TgtCellAttrib;
begin

  for I := 0 to FFontTable.Count - 1 do
  begin
   WriteFontToStream(TFont(FFontTable.Objects[I]));
    TFont(FFontTable.Objects[I]).Free;
  end;

  WritePaletteRecord;

  for I := 0 to FCellXFTable.Count - 1 do
  begin
		LCellAttrib := TgtCellAttrib(FCellXFTable.Objects[I]);
		WriteCellXFRecord(LCellAttrib.FontIndex, LCellAttrib.FormatIndex,
      LCellAttrib.Alignment, LCellAttrib.Brush);
		LCellAttrib.Free;
  end;


  WriteRecordByte(CQPro_BOP, CQPro_BOP_LEN, [0], 1, FOutputStream);
  FOutputStream.CopyFrom(FQProStream, 0);
  WriteRecordByte(CQPro_EOP, CQPro_EOP_LEN, [0], 1, FOutputStream);

  WriteRecord(CQpro_EOF, CQpro_EOF_LEN, [0], 0, FOutputStream);
  if not Preferences.OutputToUserStream then
  begin
    FOutputStream.Free;
    FOutputStream := nil;
  end;
  FQProStream.Free;
  FreeResourceItems;

  inherited;
end;

procedure TgtQuattroProEngine.EndPage;
begin
  inherited;
end;

function TgtQuattroProEngine.ShowSetupModal: Word;
begin
  with TgtQuattroProEngineDlg.Create(nil) do
  try
    Engine := Self;
    Result := ShowModal;
  finally
    Free;
  end;
end;

end.
