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

unit gtSLKEng;

interface

uses
  Classes, Windows, Graphics, SysUtils, Math, gtCstDocEng, gtCstSpdEng,
  gtConsts3, gtDocConsts, gtDocUtils, gtDocResStrs;

type
  TgtSYLKEngine = class(TgtCustomSpreadSheetEngine)
  private
    FOutputStream: TStream;
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

uses gtSLKEngDlg, gtUtils3;

{ TgtSYLKEngine }

procedure TgtSYLKEngine.Start;
var
  LS : String;
  LATemp : AnsiString;
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

  LS := 'ID;P' + DocInfo.Creator + CRLF;
  LATemp := AnsiString(LS);
  FOutputStream.Write(LATemp[1], Length(LS));
end;

procedure TgtSYLKEngine.BeginPage;
begin
  inherited;

end;

constructor TgtSYLKEngine.Create(AOwner: TComponent);
begin
  inherited;
  FileExtension := 'slk';
  FileDescription := SSYLKDescription;
  Capabilities := [ckText];
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 110);
{$ENDIF}
end;

destructor TgtSYLKEngine.Destroy;
begin

  inherited;
end;

procedure TgtSYLKEngine.EncodeText(AObject: TgtTextItem);
var
  LS, LS2, LText, LOriginalText: String;
  LATemp : AnsiString;
  LCellType: TgtCellType;
  LTextAlign: TgtHAlignment;
begin
  inherited;
  if Aobject.Lines[0] <> '' then
  with AObject do
  begin
    LOriginalText := Lines[0];
    Lines[0] := ReplacePlaceHolders(Lines[0], True);
    LTextAlign := haLeft;

    if AObject is TgtSheetTextItem then
    begin
      LCellType := TgtSheetTextItem(AObject).CellType;
      LTextAlign := TgtSheetTextItem(AObject).Alignment;
    end
    else
      LCellType := GetCellType(Lines[0]);

    LText := ReplaceString(Trim(Lines[0]), ';', ';;');
    LS2 := 'F;F';

    with AObject as TgtFmTextItem do
      LS :=  'C;X' + IntToStr(ColumnNo + 1) + ';Y' +
        IntToStr(FLastPageHeight + RowNo + 1) + ';K';

      // 1 is added because SYLK origin is (1, 1)
      
    if LCellType in [ctInteger, ctDouble] then
    begin
      LS := LS + GetNumberString(LText) + CRLF;
      LS2 := LS2 + 'F';
      if LCellType in [ctDouble] then
        LS2 := LS2 + IntToStr(Length(LText) - Pos({$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DecimalSeparator, LText))
      else
        LS2 := LS2 + '0';
    end
    else
    begin
      LS := LS + '"' + LText + '"' + CRLF;
      LS2 := LS2 +  'G0';
    end;
    LATemp := AnsiString(LS);
    FOutputStream.Write(LATemp[1], Length(LS));
    case LTextAlign of
      haRight:
        LS2 := LS2 + 'R';
      haCenter:
        LS2 := LS2 + 'C';
      else
        LS2 := LS2 + 'L';
    end;
    LS2 := LS2 + CRLF;
    LATemp := AnsiString(LS2);
    FOutputStream.Write(LATemp[1], Length(LS2));
    Lines[0] := LOriginalText;
  end;
end;

procedure TgtSYLKEngine.Finish;
var
  LS : String;
  LATemp : AnsiString;
begin
  inherited;
  LS := 'E' + CRLF;
  LATemp := AnsiString(LS);
  FOutputStream.Write(LAtemp[1], Length(LS));
  if not Preferences.OutputToUserStream then
  begin
    FOutputStream.Free;
    FOutputStream := nil;
  end;
end;

procedure TgtSYLKEngine.EndPage;
begin
  inherited;

end;

function TgtSYLKEngine.ShowSetupModal: Word;
begin
  with TgtSYLKEngineDlg.Create(nil) do
  try
    Engine := Self;
    Result := ShowModal;
  finally
    Free;
  end;
end;

end.

