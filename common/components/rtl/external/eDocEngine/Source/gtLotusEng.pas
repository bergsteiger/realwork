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

unit gtLotusEng;

interface
uses
  Classes, Windows, Graphics, SysUtils, Math, gtCstDocEng, gtCstSpdEng,
  gtConsts3, gtDocConsts, gtDocUtils, gtDocResStrs;

type

  TgtLotusEngine = class(TgtCustomSpreadSheetEngine)
  private
    FOutputStream: TStream;
    FLotusStream: TMemoryStream;
  protected
    procedure Start; override;
    procedure BeginPage; override;
    procedure EndPage; override;
    procedure Finish; override;

    procedure EncodeText(AObject: TgtTextItem); override;
    function ShowSetupModal: Word; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;


implementation
uses gtLotusEngDlg;

{ TgtLotusEngine }

procedure TgtLotusEngine.Start;
begin
  inherited;

  if not Preferences.OutputToUserStream then
  begin
    FOutputStream := CreateFile(FileName + '.' + FileExtension);
    EngineFileNames.Add(FileName + '.' + FileExtension);
  end
  else
    FOutputStream := UserStream;

  FLotusStream := TMemoryStream.Create;
  WriteRecord(CLOTUS_BOF, CLOTUS_BOF_LEN, [CLOTUS_REVISION], 2, FOutputStream);
end;

procedure TgtLotusEngine.BeginPage;
begin
  inherited;

end;

constructor TgtLotusEngine.Create(AOwner: TComponent);
begin
  inherited;
  FileExtension := 'WK1';
  FileDescription := SLotusDescription;
  Capabilities := [ckText];
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 108);
{$ENDIF}
end;

destructor TgtLotusEngine.Destroy;
begin

  inherited;
end;

procedure TgtLotusEngine.EncodeText(AObject: TgtTextItem);
var
  LByte, LTemp: Byte;
  LS, LOriginalText: String;
  LATemp : AnsiString;
  LWord: Word;
  LCellType: TgtCellType;
  LDouble: Double;
begin
  LS := '';
  inherited;
  LOriginalText := AObject.Lines[0];
  AObject.Lines[0] := ReplacePlaceHolders(AObject.Lines[0], True);
  if Aobject.Lines[0] <> '' then
    with AObject do
    begin
      LS := Lines[0];
      if AObject is TgtSheetTextItem then
        LCellType := TgtSheetTextItem(AObject).CellType
      else
        LCellType := GetCellType(Lines[0]);

      case LCellType of
        ctCurrency:
          LByte := $A0;
        ctInteger:
          LByte := $80;
        ctDouble:
        begin
          LByte := $80;
          LTemp := Pos({$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DecimalSeparator, LS);
          if LTemp <> 0 then
            LByte :=  LByte + Length(LS) - Pos({$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DecimalSeparator, LS);
        end;
        else
          LByte := $F5;
      end;

      if LCellType in [ctCurrency, ctInteger, ctDouble] then
        WriteRecord(CLOTUS_NUMBER, 13, [0], 0, FLotusStream)
      else
        WriteRecord(CLOTUS_STRING, Length(LS) + CLOTUS_STRING_LEN + 1 , [0],
          0, FLotusStream);

      FLotusStream.Write(LByte, SizeOf(Byte));

      LWord := TgtFmTextItem(AObject).ColumnNo;

      FLotusStream.Write(LWord, SizeOf(Word));

      LWord := TgtFmTextItem(AObject).RowNo + FLastPageHeight;

      FLotusStream.Write(LWord, SizeOf(Word));

      if LCellType in [ctCurrency, ctInteger, ctDouble] then
      begin
        LDouble := StrToFloat(GetNumberString(Trim(LS)));
        FLotusStream.Write(LDouble, SizeOf(LDouble));
      end
      else
      begin
        LByte := 27;
        FLotusStream.Write(LByte, SizeOf(Byte));
        LATemp := AnsiString(LS);
        FLotusStream.Write(LATemp[1], Length(LS) + 1);
      end;
    end;
  AObject.Lines[0] := LOriginalText;
end;

procedure TgtLotusEngine.Finish;
var
  LWord: Word;
begin
  inherited;
  MeasurementUnit := muPixels; // to get dimension in pixels from PageSettings
  with Page do
  begin
    WriteRecord(CLOTUS_PAGE, CLOTUS_PAGE_LENGTH, [0], 0, FOutputStream);

    LWord := Round(LeftMargin);
    FOutputStream.Write(LWord, SizeOf(Word));

    LWord := Round(RightMargin);
    FOutputStream.Write(LWord, SizeOf(Word));

    LWord := Round(Height);
    FOutputStream.Write(LWord, SizeOf(Word));

    LWord := Round(TopMargin);
    FOutputStream.Write(LWord, SizeOf(Word));

    LWord := Round(BottomMargin);
    FOutputStream.Write(LWord, SizeOf(Word));
  end;

  FOutputStream.CopyFrom(FLotusStream, 0);
  WriteRecord(CLOTUS_EOF, CLOTUS_EOF_LEN, [0], 0, FOutputStream); // End of the file
  if not Preferences.OutputToUserStream then
  begin
    FOutputStream.Free;
    FOutputStream := nil;
  end;
  FLotusStream.Free;
end;

procedure TgtLotusEngine.EndPage;
begin
  inherited;

end;

function TgtLotusEngine.ShowSetupModal: Word;
begin
  with TgtLotusEngineDlg.Create(nil) do
  try
    Engine := Self;
    Result := ShowModal;
  finally
    Free;
  end;
end;

end.

