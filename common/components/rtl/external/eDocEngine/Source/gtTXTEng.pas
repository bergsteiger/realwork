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

unit gtTXTEng;

interface

uses
	Classes, Windows, Graphics, SysUtils, gtCstDocEng, gtDocConsts, gtDocUtils,
  gtDocResStrs, gtUtils3;

type
	TgtTextLineSpacing = (
  	lsActual, lsOneBlank, lsTwoBlank, lsThreeBlank, lsFourBlank, lsFiveBlank
  );

	TgtTextEngine = class(TgtCustomDocumentEngine)
  private
    FXFactor: Double;
    FTextStream: TStream;
    FTextLines: TStringList;
    FTextTemp:  TStringList;
  	FSeparator: Char;
    FPrevY: Integer;
    FPageEndLines: Boolean;
    FSingleFile: Boolean;
    FLineSpacing: TgtTextLineSpacing;
    FColumnSpacing: Integer;
    FPageLineCount: Integer;
    FInsertPageBreaks: Boolean;
    FUseSeparator: Boolean;
    FContinuousMode: Boolean;
    procedure InitText;
    procedure EndText;

    procedure SetLineSpacing(const Value: TgtTextLineSpacing);
    procedure SetPageEndLines(const Value: Boolean);
    procedure SetSeparator(const Value: Char);
    procedure SetSingleFile(const Value: Boolean);
    procedure SetInsertPageBreaks(const Value: Boolean);
    procedure SetColumnSpacing(const Value: Integer);
    procedure SetUseSeparator(const Value: Boolean);
    procedure SetContinuousMode(const Value: Boolean);
  protected
  	function ShowSetupModal: Word; override;
{$IFNDEF gtRegistered}
    procedure PutTrialNote; override;
{$ENDIF}
    procedure EncodeText(AObject: TgtTextItem); override;
    procedure EndPage; override;
    procedure BeginPage; override;
    procedure Start; override;
    procedure Finish; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeginDoc; override;
    procedure EndDoc; override;
    procedure BeginPara; override;
    procedure NewPage; override;
    procedure EndPara; override;

    function BeginTable(X, Y: Double; NoColumns: Integer): TList; override;
    function NewRow(Height: Double): Double; override;
    function NewRow: Double; override;
    procedure EndTable; override;

    procedure PlayMetafile(Metafile: TMetafile); overload; override;
    procedure PlayMetafile(DestRect: TgtRect; Metafile: TMetafile); override;
    procedure PlayMetafile(X, Y: Double; Metafile: TMetafile);
      overload; override;

    procedure BeginHeader; override;
    procedure EndHeader; override;
    procedure ClearHeader; override;

    procedure BeginFooter; override;
    procedure EndFooter; override;
    procedure ClearFooter; override;

    procedure BeginWaterMark; override;
    procedure EndWaterMark; override;
    procedure ClearWaterMark; override;

    procedure BeginStamp; override;
    procedure EndStamp; override;
    procedure ClearStamp; override;

    function SaveEngineState: Integer; override;
    procedure RestoreEngineState(Index: Integer); override;
    procedure ClearEngineStates; override;

    procedure TextOut(X, Y: Double; Text: WideString); overload; override;
    procedure TextRect(Rect: TgtRect; X, Y: Double; Text: WideString); override;
    function TextOut(Text: WideString): Double; overload; override;
    procedure TextOut(ColumnNo: Integer; Text: WideString); overload; override;
    procedure TextBox(TextRect: TgtRect; Text: WideString;
      HAlignment: TgtHAlignment; VAlignment: TgtVAlignment);  override;

    procedure SetWorkingPage(PageNo: Integer); override;

    property TextFormatting;
    property TableSettings;

  published
    property DefaultFont;
    property Page;
		property Preferences;
    property FileName;
    property Separator: Char read FSeparator write SetSeparator default ',';
    property UseSeparator: Boolean read FUseSeparator
    	write SetUseSeparator default False;
    property PageEndLines: Boolean read FPageEndLines write SetPageEndLines
    	default False;
    property SingleFile: Boolean read FSingleFile write SetSingleFile
    	default True;
    property InsertPageBreaks: Boolean read FInsertPageBreaks
    	write SetInsertPageBreaks default True;
    property ColumnSpacing: Integer read FColumnSpacing write SetColumnSpacing;
    property LineSpacing: TgtTextLineSpacing read FLineSpacing
    	write SetLineSpacing default lsActual;
    property ContinuousMode: Boolean read FContinuousMode write SetContinuousMode
      default False;
    property OnNeedFileName;
  end;

implementation

uses gtTXTEngDlg, Math;

const
	// Text: blank lines to leave before next line. }
	CTextAdvanceLines: array[TgtTextLineSpacing] of Integer = (0, 1, 2, 3, 4, 5);

{ TgtTextEngine }

constructor TgtTextEngine.Create(AOwner: TComponent);
begin
  inherited;
  FXFactor := 1;
  FYFactor := 1;
  FPageLineCount := 0;
  FPrevY := -1;
  Separator := ',';
  UseSeparator := False;
	PageEndLines := True;
  InsertPageBreaks := True;
  SingleFile := True;
  LineSpacing := lsActual;
  ColumnSpacing := 1;
	FileExtension := 'txt';
  Capabilities := [ckText];
  FileDescription := STextDescription;
  FContinuousMode := False;
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 106);
{$ENDIF}
end;

procedure TgtTextEngine.SetLineSpacing(const Value: TgtTextLineSpacing);
begin
	if UseSeparator then FLineSpacing := lsActual
  else FLineSpacing := Value;
end;

procedure TgtTextEngine.SetPageEndLines(const Value: Boolean);
begin
  FPageEndLines := Value;
end;

procedure TgtTextEngine.SetSeparator(const Value: Char);
begin
  FSeparator := Value;
end;

procedure TgtTextEngine.SetSingleFile(const Value: Boolean);
begin
  FSingleFile := Value;
end;

procedure TgtTextEngine.Start;
begin
  inherited;
  if Preferences.OutputToUserStream then
    FTextStream := UserStream;
  if SingleFile then InitText;
end;

procedure TgtTextEngine.Finish;
begin
  inherited;
  if SingleFile then EndText;
end;

procedure TgtTextEngine.BeginPage;
begin
  if (not SingleFile) then InitText;
end;

procedure TgtTextEngine.EndPage;
var
	LExtraLines, LI: Integer;
  LStr: String;
begin
  if UseSeparator then
  begin
    LStr := '';
    for LI := 0 to FTextTemp.Count - 1 do
    begin
      LStr := LStr + String(RemoveTerminalCRLF(AnsiString(FTextTemp.Strings[LI])));
      if (LI <> (FTextTemp.Count - 1)) then
        LStr := LStr + Separator;
      if (ColumnSpacing >= 0) then
        LStr := LStr + StringOfChar(' ', (ColumnSpacing + 1));
    end;
    FTextLines.Add(LStr);
    FTextTemp.Clear;
  end;
  if (not ContinuousMode) then
  begin
    LExtraLines := Round(Pages[CurrentPage - 1].Settings.Height / FYFactor);
    if (SingleFile) then LExtraLines := LExtraLines * CurrentPage;
    LExtraLines := LExtraLines - FTextLines.Count;
    while (LExtraLines > 0) do
    begin
      FTextLines.Add('');
      Dec(LExtraLines);
    end;
  end;
  if (SingleFile and PageEndLines and (not UseSeparator)) then
  	FTextLines.Add(StringOfChar('-', Round(Pages[CurrentPage - 1].Settings.Width / FXFactor)));
  if InsertPageBreaks then FTextLines.Add(#12);
  if (SingleFile and (FTextLines <> nil)) then
		FPageLineCount := FTextLines.Count;
  if (not SingleFile) then EndText;
  inherited;
end;

procedure TgtTextEngine.EncodeText(AObject: TgtTextItem);
var
	LX, LY, LI: Integer;
  LStr, LText, LOriginalText: String;
  LFlag:  Boolean;

  function GetTextForWidth(Text: WideString; AWidth: Double): String;
  var
    LI: Integer;
  begin
    Result := '';
    for LI := 1 to Length(Text) do
    begin
      if TextSize(Result, Font).cx <= AWidth then
        Result := Result + Text[LI]
      else
        Break;
    end;
  end;

begin
  inherited;
  LOriginalText := AObject.Lines.Strings[0];
  with AObject do
    if IsClipRect then
      Lines.Strings[0] := GetTextForWidth(Lines.Strings[0], (ClipRect.Right - ClipRect.Left));

  AObject.Lines.Strings[0] := ReplacePlaceHolders(AObject.Lines.Strings[0], True);
  LText := String(RemoveTerminalCRLF(AnsiString(AObject.Lines.Strings[0])));
  LX := Ceil(AObject.X / FXFactor);
  if (ColumnSpacing >= 0) then LX := LX * (ColumnSpacing + 1);
  LY := (Ceil(AObject.Y / FYFactor) * (CTextAdvanceLines[FLineSpacing] + 1)) +
  	FPageLineCount;
  if (LY >= (CurrentPage * Round(Pages[CurrentPage - 1].Settings.Height / FYFactor))) then Exit;
  if UseSeparator then
  begin
    LFlag := False;
  	if (FPrevY = LY) then
    begin
    	for LI := 0 to FTextTemp.Count - 1 do
      begin
        if (TgtTextItem(FTextTemp.Objects[LI]).X < AObject.X) then
          Continue
        else
        begin
          LFlag := True;
          Break;
        end;
      end;
      if (not LFlag) then
        FTextTemp.AddObject(LText, TObject(AObject))
      else
        FTextTemp.InsertObject(LI , LText, AObject);
    end
    else
    begin
    	for LI := 0 to FTextTemp.Count - 1 do
      begin
        LStr := LStr + String(RemoveTerminalCRLF(AnsiString(FTextTemp.Strings[LI])));
        if (LI <> (FTextTemp.Count - 1)) then
          LStr := LStr + Separator;
        if (ColumnSpacing >= 0) then
          LStr := LStr + StringOfChar(' ', (ColumnSpacing + 1));
      end;
      FTextLines.Add(LStr);
      FPrevY := LY;
      FTextTemp.Clear;
      FTextTemp.AddObject(LText, AObject);
    end;
  end
  else
  begin
    if (LY >= FTextLines.Count) then
    begin
      LI := FTextLines.Count;
      while (LI < LY) do
      begin
        FTextLines.Add('');
        Inc(LI);
      end;
      FTextLines.Add(StringOfChar(' ', LX) + LText);
    end
    else
    begin
      LStr := String(RemoveTerminalCRLF(AnsiString(FTextLines.Strings[LY])));
      if LX > Length(LStr) then
        LStr := LStr + StringOfChar(' ', LX - Length(LStr))
      else
      begin
//        LStr := LStr + StringOfChar(' ', Length(LStr) - LX);
//        LX := LX + (Length(LStr) - LX);
        System.Delete(LStr, LX, Length(AObject.Lines.Strings[0]));
      end;
      System.Insert(LText, LStr, LX);
      FTextLines[LY] := LStr;
    end;
  end;
  AObject.Lines.Strings[0] := LOriginalText;
end;

procedure TgtTextEngine.InitText;
var
	LSize: TSize;
  LFileName: String;
begin
  if (not Preferences.OutputToUserStream) then
  begin
    if SingleFile then
    begin
    	LFileName := FileName;
      if Assigned(OnNeedFileName) then
      	OnNeedFileName(Self, LFileName, CurrentPage);
      FTextStream := CreateFile(LFileName + '.' + FileExtension);
      EngineFileNames.Add(LFileName + '.' + FileExtension);
    end
    else
    begin
    	LFileName := FileName + IntToStr(CurrentPage);
      if Assigned(OnNeedFileName) then
      	OnNeedFileName(Self, LFileName, CurrentPage);
      FTextStream := CreateFile(LFileName + '.' + FileExtension);
      EngineFileNames.Add(LFileName + '.' + FileExtension);
    end;
  end
  else FTextStream := UserStream;
  FTextLines := TStringList.Create;
  LSize := TextSize('W', DefaultFont);
  FXFactor := LSize.cx;
  FYFactor := LSize.cy;
  FPageLineCount := 0;
  FPrevY := -1;
end;

procedure TgtTextEngine.EndText;
var
  LATemp: AnsiString;
begin
  LATemp := AnsiString (FTextLines.Text);
  FTextStream.Write(LATemp[1], Length(FTextLines.Text));
  if (not Preferences.OutputToUserStream) then FTextStream.Free;
  FTextLines.Free;
end;

procedure TgtTextEngine.BeginFooter;
begin
  inherited;

end;

procedure TgtTextEngine.BeginHeader;
begin
  inherited;

end;

procedure TgtTextEngine.BeginPara;
begin
  inherited;

end;

function TgtTextEngine.BeginTable(X, Y: Double; NoColumns: Integer): TList;
begin
	Result := inherited BeginTable(X, Y, NoColumns);
end;

procedure TgtTextEngine.BeginWaterMark;
begin
  inherited;

end;

procedure TgtTextEngine.BeginStamp;
begin
  inherited;

end;

procedure TgtTextEngine.EndFooter;
begin
  inherited;

end;

procedure TgtTextEngine.EndHeader;
begin
  inherited;

end;

procedure TgtTextEngine.EndPara;
begin
  inherited;

end;

procedure TgtTextEngine.EndTable;
begin
  inherited;

end;

procedure TgtTextEngine.EndWaterMark;
begin
  inherited;

end;

procedure TgtTextEngine.EndStamp;
begin
  inherited;

end;

function TgtTextEngine.NewRow(Height: Double): Double;
begin
	Result := inherited NewRow(Height);
end;

function TgtTextEngine.NewRow: Double;
begin
  Result := inherited NewRow;
end;

procedure TgtTextEngine.PlayMetafile(X, Y: Double; Metafile: TMetafile);
begin
  inherited;

end;

procedure TgtTextEngine.PlayMetafile(Metafile: TMetafile);
begin
  inherited;

end;

procedure TgtTextEngine.TextOut(X, Y: Double; Text: WideString);
begin
  inherited;

end;

procedure TgtTextEngine.TextBox(TextRect: TgtRect; Text: WideString;
  HAlignment: TgtHAlignment; VAlignment: TgtVAlignment);
begin
  inherited;

end;

function TgtTextEngine.TextOut(Text: WideString): Double;
begin
  Result := inherited TextOut(Text);
end;

procedure TgtTextEngine.NewPage;
begin
  inherited;

end;

destructor TgtTextEngine.Destroy;
begin
  inherited;
end;

procedure TgtTextEngine.TextOut(ColumnNo: Integer; Text: WideString);
begin
  inherited;

end;

procedure TgtTextEngine.BeginDoc;
begin
  inherited;
  FTextTemp := TStringList.Create;
end;

procedure TgtTextEngine.EndDoc;
begin
  inherited;
  FTextTemp.Free;
end;

procedure TgtTextEngine.SetInsertPageBreaks(const Value: Boolean);
begin
  FInsertPageBreaks := Value;
end;

procedure TgtTextEngine.SetColumnSpacing(const Value: Integer);
begin
  FColumnSpacing := Value;
end;

function TgtTextEngine.ShowSetupModal: Word;
begin
  with TgtTextEngineDlg.Create(nil) do
  try
    Engine := Self;
    Result := ShowModal;
  finally
    Free;
  end;
end;

procedure TgtTextEngine.SetUseSeparator(const Value: Boolean);
begin
  FUseSeparator := Value;
  FSortTextItems := Value;
  if Value then FLineSpacing := lsActual;
end;

procedure TgtTextEngine.SetWorkingPage(PageNo: Integer);
begin
  inherited;

end;

procedure TgtTextEngine.TextRect(Rect: TgtRect; X, Y: Double;
  Text: WideString);
begin
  inherited;

end;

{$IFNDEF gtRegistered}
procedure TgtTextEngine.PutTrialNote;
begin
  PutTrialNoteOnTop;
end;
{$ENDIF}

procedure TgtTextEngine.ClearFooter;
begin
  inherited;

end;

procedure TgtTextEngine.ClearHeader;
begin
  inherited;

end;

procedure TgtTextEngine.ClearStamp;
begin
  inherited;

end;

procedure TgtTextEngine.ClearWaterMark;
begin
  inherited;

end;

procedure TgtTextEngine.PlayMetafile(DestRect: TgtRect;
  Metafile: TMetafile);
begin
  inherited;

end;

procedure TgtTextEngine.ClearEngineStates;
begin
  inherited;

end;

procedure TgtTextEngine.RestoreEngineState(Index: Integer);
begin
  inherited;

end;

function TgtTextEngine.SaveEngineState: Integer;
begin
  Result := inherited SaveEngineState;
end;

procedure TgtTextEngine.SetContinuousMode(const Value: Boolean);
begin
  FContinuousMode := Value;
end;

end.
