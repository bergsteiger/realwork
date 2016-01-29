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

unit gtExHTMLEng;

interface

uses
  Classes, Windows, Graphics, SysUtils,
  gtConsts3, gtDocConsts, gtDocUtils, gtCstDocEng,
  gtCstPlnEng, gtCstHTMLEng;

type
  TgtTOCPageSettings = class(TPersistent)
  private
    FItemFont, FTitleFont: TFont;
    FTitle: String;
    FTitleAlignment: TgtHAlignment;
    procedure SetTitleFont(const Value: TFont);
    procedure SetItemFont(const Value: TFont);
  protected
  public
    constructor Create;
    destructor Destroy; override;
  published
    property ItemFont: TFont read FItemFont write SetItemFont;
    property TitleFont: TFont read FTitleFont write SetTitleFont;
    property Title: String read FTitle write FTitle;
    property TitleAlignment: TgtHAlignment read FTitleAlignment
      write FTitleAlignment default haCenter;
  end;

  TgtExHTMLEngine = class(TgtCustomHTMLEngine)
  private
    FTOCPageSettings: TgtTOCPageSettings;
    function GetFontString(AFont: TFont): String;
    procedure SetTOCPageSettings(const Value: TgtTOCPageSettings);
  protected
    procedure InsertAnchors(AStream: TStream); override;
    procedure EncodeTOC; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function AddTOCItem(Caption: WideString; ParentNode, PageNumber: Integer;
      Top: Double): Integer; overload; override;
    function AddTOCItem(Caption: WideString; ParentNode: Integer; URL: String)
      : Integer; overload; override;
  published
    property TOCPageSettings: TgtTOCPageSettings read FTOCPageSettings
      write SetTOCPageSettings;
  end;

implementation

uses Math;

const

  (* Horizontal alignment for the title. *)
  CAlignText: array [TgtHAlignment] of String = ('left', 'right', 'center',
    'justify', 'general');

  { TgtTOCSettings }

constructor TgtTOCPageSettings.Create;
begin
  FItemFont := TFont.Create;
  FTitleFont := TFont.Create;
  FTitle := 'Table Of Contents';
  FTitleAlignment := haCenter;
end;

destructor TgtTOCPageSettings.Destroy;
begin
  FItemFont.Free;
  FTitleFont.Free;
  inherited;
end;

procedure TgtTOCPageSettings.SetItemFont(const Value: TFont);
begin
  FItemFont.Assign(Value);
end;

procedure TgtTOCPageSettings.SetTitleFont(const Value: TFont);
begin
  FTitleFont.Assign(Value);
end;

{ TgtExHTMLEngine }

constructor TgtExHTMLEngine.Create(AOwner: TComponent);
begin
  inherited;
  TOCPageSettings := TgtTOCPageSettings.Create;
end;

destructor TgtExHTMLEngine.Destroy;
begin
  TOCPageSettings.Free;
  inherited;
end;

(* Create Table of Contents page *)
procedure TgtExHTMLEngine.EncodeTOC;
var
  LTOCStream: TFileStream;
  LI: Integer;
  LS, LString: String;
  LATemp: AnsiString;

  (* Get the HTML String representing the specified item in the FTOCItemList *)
  function GetListItem(AIndex: Integer): String;
  var
    LJ: Integer;
    LS1: String;
  begin
    with TgtTOCItem(FTOCItemList.Items[AIndex]) do
    begin
      Result := '<a href="';
      if (URL = '') then
      begin
        if (Preferences.SingleFile) then
          LString := EngineFileNames[0]
        else
          LString := EngineFileNames[PageNumber - 1];
        Result := Result + LString + '#gtTOC' + IntToStr(AIndex);
      end
      else
        Result := Result + URL;
      Result := Result + '" style="' +
        GetFontString(TOCPageSettings.ItemFont) + '">';

      LS1 := Title;
      if not((Font.Charset = ANSI_CHARSET) or ((Font.Charset = DEFAULT_CHARSET)
        and (GetACP = CANSIWinCode))) then
      begin
        LS1 := '';
        for LJ := 1 to Length(Title) do
          if (Ord(Title[LJ]) > 256) and (Title[LJ] <> CR) and
            (Title[LJ] <> LF) then
            LS1 := LS1 + '&#' + IntToStr(Ord(Title[LJ])) + ';'
          else
            LS1 := LS1 + Title[LJ];
        Title := LS1;
      end;
      Result := Result + Title + '</a>';
    end;
  end;

(*
  Recursive function that creates HTML code for items in the
  Table of Contents page using <ul> ... </ul>
*)
  function GetSubNodes(ANode: Integer): String;
  var
    LJ: Integer;
    LSubNodes: String;
  begin
    Result := '';
    if (ANode = FTOCItemList.Count - 1) then
      Exit;
    for LJ := 0 to (FTOCItemList.Count - 1) do
    begin
      with TgtTOCItem(FTOCItemList.Items[LJ]) do
      begin
        if (ParentNode = ANode) then
        begin
          Result := Result + '<li>' + GetListItem(LJ);
          LSubNodes := GetSubNodes(LJ);
          if (LSubNodes <> '') then
            Result := Result + '<ul style="list-style-type: none">' + LSubNodes
              + '</ul>' + '</li>' + CRLF
          else
            Result := Result + '</li>' + CRLF;
        end;
      end;
    end;
  end;

begin
  if FTOCItemList = nil then
    Exit;
  LTOCStream := TFileStream.Create(FileName + '_TOC.htm', fmCreate);
  FAttachmentList.Add(FileName + '_TOC.htm');
  (* Initial HTML header *)
  // LS := '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 transitional//EN">' + CRLF +
  // '<html> <head>' + CRLF +
  // '<title>' + TOCPageSettings.Title + '</title>' + CRLF +
  // '<meta HTTP-EQUIV="Content-Style-Type" CONTENT="text/css" CHARSET="' +
  // (*
  // Get active chatacter code page and encode so that non English characters
  // such as Eastern European & Asian characters show up properly.
  // *)
  // GetISOCharSet(GetACP) + '"></meta>' + CRLF +
  // '<meta NAME="Producer" CONTENT="Gnostice eDocEngine v' + CVersion +
  // '"></meta>' + CRLF +
  // '</head>' + CRLF +
  // '<body bgcolor = "#FFFFFF">' + CRLF +
  // '<h2 align="' + CAlignText[TOCPageSettings.TitleAlignment] +
  // '" style="' + GetFontString(TOCPageSettings.TitleFont) +
  // '">' + TOCPageSettings.Title + '</h2>' + CRLF;
  LS := '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">'
    + CRLF + '<html>' + CRLF + '<head>' + CRLF + '<title>' +
    TOCPageSettings.Title + '</title>' + CRLF +
    '<meta http-equiv="Content-Type" content="text/html;charset=' +
    GetISOCharSet(GetACP) + '" ' + '>' + CRLF +
    '<meta http-equiv="Content-Style-Type" content="text/css;charset=' +

  (*
    Get active chatacter code page and encode so that non English characters
    such as Eastern European & Asian characters show up properly
  *)
    GetISOCharSet(GetACP) + '" ' + '>' + CRLF +
    '<meta name="Producer" content="Gnostice eDocEngine v' + CVersion + '" ' +
    '>' + CRLF + '</head>' + CRLF + '<body bgcolor = "#FFFFFF">' + CRLF +
    '<h2 align="' + CAlignText[TOCPageSettings.TitleAlignment] + '" style="' +
    GetFontString(TOCPageSettings.TitleFont) + '">' + TOCPageSettings.Title +
    '</h2>' + CRLF;
  LATemp := AnsiString(LS);
  LTOCStream.Write(LATemp[1], Length(LS));

  (*
    Initiate the recursive function GetSubNodes for each root item
    in the FTOCItemList
  *)
  LS := '<ul style="list-style-type: none">';
  for LI := 0 to FTOCItemList.Count - 1 do
  begin
    with TgtTOCItem(FTOCItemList.Items[LI]) do
    begin
      (* Root item *)
      if (ParentNode = -1) then
      begin
        LS := LS + '<li>' + GetListItem(LI);
        LString := GetSubNodes(LI);
        if (LString <> '') then
          LS := LS + '<ul style="list-style-type: none">' + LString + '</ul>' +
            '</li>' + CRLF
        else
          LS := LS + '</li>' + CRLF;
      end;
    end;
  end;
  LS := LS + '</ul>' + CRLF + '</body>' + CRLF + '</html>';
  LATemp := AnsiString(LS);
  LTOCStream.Write(LATemp[1], Length(LS));
  LTOCStream.Free;
end;

(* Get Font information *)
function TgtExHTMLEngine.GetFontString(AFont: TFont): String;
begin
  Result := 'font: ' + GetFontCSS(AFont);
end;

(*
  Insert the target anchors into the HTML stream passed for Table
  of Contents links
*)
procedure TgtExHTMLEngine.InsertAnchors(AStream: TStream);
var
  LI, LY: Integer;
  LS: String;
  LATemp: AnsiString;
begin
  for LI := 0 to (FTOCItemList.Count - 1) do
  begin
    with TgtTOCItem(FTOCItemList.Items[LI]) do
    begin
      if (PageNumber = CurrentPage) then
      begin
        (*
          Calculate the exact Y position from the top of the document
          depending on SingleFile. Currently no effect since TOC is
          used only with SingleFile = False
        *)
        LY := (Round(Y) + (CPageEndLineWidth + Round(Pages[PageNumber - 1]
          .Settings.Height) * (PageNumber - 1)) * Ord(Preferences.SingleFile));
        LS := '<a style="position: absolute; ' + 'top: ' + IntToStr(LY) +
          'px;" ' + 'name="gtTOC' + IntToStr(LI) + '">&nbsp;</a>' + CRLF;
        LATemp := AnsiString(LS);
        AStream.Write(LATemp[1], Length(LS));
      end;
    end;
  end;
end;

function TgtExHTMLEngine.AddTOCItem(Caption: WideString; ParentNode: Integer;
  URL: String): Integer;
begin
  Result := inherited AddTOCItem(Caption, ParentNode, URL);
end;

function TgtExHTMLEngine.AddTOCItem(Caption: WideString;
  ParentNode, PageNumber: Integer; Top: Double): Integer;
begin
  Result := inherited AddTOCItem(Caption, ParentNode, PageNumber, Top);
end;

procedure TgtExHTMLEngine.SetTOCPageSettings(const Value: TgtTOCPageSettings);
begin
  FTOCPageSettings := Value;
end;

end.
