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

unit gtDIFEng;

interface
uses
  Classes, Windows, Graphics, SysUtils, Math, gtCstDocEng, gtCstSpdEng,
  gtConsts3, gtDocConsts, gtDocUtils, gtDocResStrs;

type

  TgtDIFEngine = class(TgtCustomSpreadSheetEngine)
  private
    FOutputStream: TStream;
    FDIFStream: TMemoryStream;
    FLastRowNo, FLastColumnNo : Integer;
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
uses gtDIFEngDlg;

{ TgtDIFEngine }

procedure TgtDIFEngine.Start;
var
  LS: String;
  LATemp : AnsiString;
begin
  inherited;

  if not Preferences.OutputToUserStream then
  begin
    FOutputStream := CreateFile(FileName + '.' + FileExtension);
    EngineFileNames.Add(FileName + '.' + FileExtension);
  end
  else
    FOutputStream := UserStream;

  FDIFStream := TMemoryStream.Create;
  LS := 'TABLE' + CRLF + '0, 1' + CRLF + '""' + CRLF;
  LATemp := AnsiString(LS);
  FOutputStream.Write(LATemp[1], Length(LS));
  FLastRowNo := 0;
  FLastColumnNo := 0;
end;

procedure TgtDIFEngine.BeginPage;
begin
  inherited;
end;

constructor TgtDIFEngine.Create(AOwner: TComponent);
begin
  inherited;
  FileExtension := 'DIF';
  FileDescription := SDIFDescription;
  Capabilities := [ckText];
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 109);
{$ENDIF}
end;

destructor TgtDIFEngine.Destroy;
begin

  inherited;
end;

procedure TgtDIFEngine.EncodeText(AObject: TgtTextItem);
var
  LS, LOriginalText: String;
  LATemp : AnsiString;
  LCellType: TgtCellType;
  LX, LY: Integer;
begin

  {
      Since DIF does not support X and Y Positioning empty BOT and data records
      should be inserted, to achive cell positioning
      Review Once
  }

  inherited;
  LS := '';
  with AObject do
  begin
    LOriginalText := Lines[0];
    Lines[0] := ReplacePlaceHolders(Lines[0], True);
    if AObject is TgtSheetTextItem then
      LCellType := TgtSheetTextItem(AObject).CellType
    else
      LCellType := GetCellType(Lines[0]);

    LX := TgtFmTextItem(AObject).ColumnNo;
    LY := TgtFmTextItem(AObject).RowNo + FLastPageHeight;

    if  FLastRowNo < LY then
    begin
      while FLastRowNo < LY do
      begin
        LS := LS + '-1, 0' + CRLF + 'BOT' + CRLF;
        Inc(FLastRowNo);
      end;
      FLastColumnNo := 0;
    end;

    while FLastColumnNo < (LX - 1) do
    begin
      LS := LS + '1, 0' + CRLF + '""' + CRLF;
      Inc(FLastColumnNo);
    end;
    FLastColumnNo := Round(LX);
    
    if LCellType in [ctInteger, ctDouble] then
      LS := LS + '0, ' + Trim(Lines[0]) + CRLF + 'V' + CRLF
    else
      LS := LS + '1, 0' + CRLF + '"' + Trim(Lines[0]) + '"' + CRLF;
    LATemp := AnsiString(LS);
    FDIFStream.Write(LATemp[1],Length(LS));
    Lines[0] := LOriginalText;
  end;
end;

procedure TgtDIFEngine.Finish;
var
  LS: String;
  LATemp : AnsiString;
begin
  inherited;

 LS := LS + 'DATA' + CRLF + '0, 0' + CRLF + '""' + CRLF;
 LATemp := AnsiString(LS);
 FOutputStream.Write(LATemp[1], Length(LS));

 FOutputStream.CopyFrom(FDIFStream,0);

 LS := '-1, 0' + CRLF + 'EOD' + CRLF ;
 LATemp := AnsiString(LS);
 FOutputStream.Write(LATemp[1], Length(LS));
  
  if not Preferences.OutputToUserStream then
  begin
    FOutputStream.Free;
    FOutputStream := nil;
  end;
  FDIFStream.Free;
end;

procedure TgtDIFEngine.EndPage;
begin
  inherited;

end;


function TgtDIFEngine.ShowSetupModal: Word;
begin
  with TgtDIFEngineDlg.Create(nil) do
  try
    Engine := Self;
    Result := ShowModal;
  finally
    Free;
  end;
end;

end.

