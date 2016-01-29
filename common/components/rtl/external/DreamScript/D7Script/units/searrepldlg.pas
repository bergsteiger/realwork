{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit searrepldlg;

interface
{$I dc.inc}
uses
  {$IFNDEF CLX}
  Windows, Graphics, Controls, Forms, Buttons, ExtCtrls, StdCtrls,
  {$ELSE}
  Types, QForms, QControls, QStdCtrls, QExtCtrls, QButtons, QGraphics,
  {$ENDIF}
  SysUtils, Classes,  dcedit, histed, dcconsts, dcstring, ComCtrls;


type
  TFrmSearRepl = class(TForm)
    PageControl: TPageControl;
    EditorFindPage: TTabSheet;
    LTexttFind: TLabel;
    SearText: TDCHistoryEditor;
    EditorReplacePage: TTabSheet;
    Label1: TLabel;
    LReplWith: TLabel;
    SearText1: TDCHistoryEditor;
    ReplText: TDCHistoryEditor;
    GotoTab: TTabSheet;
    InputLabel: TLabel;
    LineEd: TEdit;
    GotoBox: TListBox;
    Label4: TLabel;
    ExPanel: TPanel;
    Panel2: TPanel;
    ExBtn: TBitBtn;
    FindBtn: TButton;
    ReplBtn: TButton;
    ReplAllBtn: TButton;
    CloseBtn: TButton;
    InfoLbl: TLabel;
    InfoLbl1: TLabel;
    InfoLbl2: TLabel;
    GoToBtn: TButton;
    gbxOptions: TGroupBox;
    RegExpr: TCheckBox;
    WholeWord: TCheckBox;
    CaseSens: TCheckBox;
    gbxDirection: TGroupBox;
    dirBackward: TRadioButton;
    dirForward: TRadioButton;
    gbxScope: TGroupBox;
    ScopeGlobal: TRadioButton;
    ScopeSelected: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure ExBtnClick(Sender: TObject);
    procedure FindBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure ReplBtnClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure GoToBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    FPanHeight  : integer;
    FTempBitmap : TBitmap;
    procedure AssignOptions;
    procedure ShowInfo(const s : string);
  public
    IntSearchOptions : TSearchOptions;
    procedure MakeSearchVisible(ARect : TRect);
    procedure SetActiveIndex(Index : integer);
    { Public declarations }
  end;

var
  FrmSearRepl: TFrmSearRepl;
  CurrentFindSource : TCustomMemoSource = nil;
implementation

{$R *.DFM}
uses
  dccommon;
  
type
  TMSource = class(TCustomMemoSource);

procedure TFrmSearRepl.ShowInfo(const s : string);
begin
  InfoLbl.Caption := s;
  InfoLbl1.Caption := s;
  InfoLbl2.Caption := s;
end;

procedure TFrmSearRepl.MakeSearchVisible(ARect : TRect);
var
  R : TRect;
begin
  IntersectRect(R, ARect, BoundsRect);
  if not IsRectEmpty(R) then
  begin
    if ARect.Bottom + Height < Screen.Height then
      Top := ARect.Bottom
    else
      Top := ARect.Top - Height;
  end;
end;

procedure TFrmSearRepl.FormCreate(Sender: TObject);
begin
  FTempBitmap := TBitmap.Create;

  with FTempBitmap do
  begin
    Width := ExBtn.Glyph.Width;
    Height := ExBtn.Glyph.Height;
    Assign(ExBtn.Glyph);
  end;

  SetFormFont(self);
  FPanHeight := ExPanel.Height;
  IntSearchOptions := TSearchOptions.Create;
  IntSearchOptions.Assign(GetSearchOptions);

  Caption :=                sFindAndRepl;
  EditorFindPage.Caption := SFind;
  EditorReplacePage.Caption := sReplace;
  LTexttFind.Caption :=     STextToFind;
  Label1.Caption :=         STextToFind;
  gbxOptions.Caption :=     SOptions;
  gbxDirection.Caption :=   SDirection;
  gbxScope.Caption :=       SScope;
  CaseSens.Caption :=       SCaseSensitive;
  WholeWord.Caption :=      SWholeWord;
  RegExpr.Caption :=        SRegExpr;
  dirForward.Caption :=     SForward;
  dirBackward.Caption :=    SBackward;
  ScopeGlobal.Caption :=    SGlobal;
  ScopeSelected.Caption :=  SSelText;
  FindBtn.Caption :=        sFind;
  ReplBtn.Caption :=        sReplace;
  ReplAllBtn.Caption :=     sReplAll;
  CloseBtn.Caption   :=     sClose;
  GotoTab.Caption :=        SCapGotoLineNumber;
  GoToBtn.Caption :=        sGoTo;
  GotoBox.ItemIndex :=      0;
  GotoBox.Items[0] :=       sLine;
  GotoBox.Items[1] :=       sBookMark;

  ShowInfo('');


  with IntSearchOptions do
  begin
    SearText.Text := TextToFind;
    SearText1.Text := TextToFind;
    CaseSens.Checked := CaseSensitive;
    WholeWord.Checked := WholeWordsOnly;
    RegExpr.Checked := RegularExpr;
    if Direction = sdBackward then
      dirBackward.Checked := True
    else
      dirForward.Checked := True;
    if Scope = ssSelectedText then
      ScopeSelected.Checked := True
    else
      ScopeGlobal.Checked := True;
  end;

  ExBtnClick(Self);
end;

procedure TFrmSearRepl.ExBtnClick(Sender: TObject);
var
  R : TRect;
begin
  ExPanel.Visible := not ExPanel.Visible;
  with ExBtn.Glyph do
  begin
    R := Rect(0, 0, Width div 2, Height);
    if ExPanel.Visible then
      OffsetRect(R, Width div 2, 0);
    Canvas.CopyRect(Rect(0, 0, Width div 2, Height), FTempBitmap.Canvas, R);
  end;
  if ExPanel.Visible then
  begin
    ExBtn.Caption := sLessButton;
    Height := Height + FPanHeight;
  end
  else
  begin
    ExBtn.Caption := sMoreButton;
    Height := Height - FPanHeight;
  end;
end;

procedure TFrmSearRepl.AssignOptions;
begin
  with IntSearchOptions do
  begin

    if PageControl.ActivePage = EditorReplacePage then
      TextToFind := SearText1.Text
    else
      TextToFind := SearText.Text;

    ReplaceWith := ReplText.Text;
    CaseSensitive := CaseSens.Checked;
    WholeWordsOnly := WholeWord.Checked;
    RegularExpr := RegExpr.Checked;
    if dirBackward.Checked then
      Direction := sdBackward
    else
      Direction := sdForward;
    if ScopeSelected.Checked then
      Scope := ssSelectedText
    else
      Scope := ssGlobal;
    Origin := soFromCursor;
    PromptOnReplace := false;
  end;
  GetSearchOptions.Assign(IntSearchOptions);
end;

procedure TFrmSearRepl.FindBtnClick(Sender: TObject);
begin
  if Assigned(CurrentFindSource) then
  begin
    AssignOptions;
    if not CurrentFindSource.Find then
      ShowInfo(Format(SErrNotFound, [GetSearchOptions.DisplayTextToFind]))
    else
      ShowInfo('');
  end;
end;

procedure TFrmSearRepl.CloseBtnClick(Sender: TObject);
begin
  AssignOptions;
  Close;
end;

procedure TFrmSearRepl.ReplBtnClick(Sender: TObject);
var
  AReplAll : boolean;
  res      : boolean;
  cnt      : integer;
begin
  if Assigned(CurrentFindSource) then
  begin
    AReplAll := Sender = ReplAllBtn;
    IntSearchOptions.ReplaceAll := AReplAll;
    AssignOptions;
    res := CurrentFindSource.Replace;
    cnt := TMSource(CurrentFindSource).ReplacedCount;
    if not (res or AReplAll) or (AReplAll and (cnt = 0)) then
      ShowInfo(Format(SErrNotFound, [GetSearchOptions.DisplayTextToFind]))
    else
    if AReplAll then
      ShowInfo(Format(sReplacements, [TMSource(CurrentFindSource).ReplacedCount]))
    else
      ShowInfo('');
  end;
end;

procedure TFrmSearRepl.SetActiveIndex(Index : integer);
begin
  {$IFDEF D5}
  PageControl.ActivePageIndex := Index;
  {$ELSE}
  with PageControl do
    ActivePage := Pages[Index];
  {$ENDIF}
  case Index  of
    0 : SearText.SetFocus;
    1 : SearText1.SetFocus;
    2 : LineEd.SetFocus;
  end;
  PageControlChange(Self);
end;

procedure TFrmSearRepl.PageControlChange(Sender: TObject);
var
  Index : integer;
begin
  {$IFDEF D5}
  Index := PageControl.ActivePageIndex;
  {$ELSE}
  Index := PageControl.ActivePage.PageIndex;
  {$ENDIF}
  ExBtn.Enabled := Index <> 2;
  FindBtn.Enabled := Index <> 2;
  ReplAllBtn.Visible := Index <> 2;
  ReplBtn.Enabled :=  Index = 1;
  ReplAllBtn.Enabled := Index = 1;
  GoToBtn.Visible := Index = 2;

  FindBtn.Default := Index = 0;
  ReplBtn.Default := Index = 1;
  GoToBtn.Default := Index = 2;

  if (Index = 2) and ExPanel.Visible then
    ExBtnClick(Self);
  ShowInfo('');  
end;

procedure TFrmSearRepl.GoToBtnClick(Sender: TObject);
var
  Index : integer;
  Pt    : TPoint;
begin
  if CurrentFindSource <> nil then
    with CurrentFindSource do
    begin
      Index := StrToInt(LineEd.Text);
      if GotoBox.ItemIndex = 0 then
      begin
        JumpToLine(Index);
        ShowInfo('');
      end
      else
        if FindBookMark(TBookMarkNumber(Index), Pt) then
        begin
          CaretPoint := Pt;
          ShowInfo('');
        end
        else
          ShowInfo(Format(sErrBookmarNotFound, [Index]));
    end;
end;

procedure TFrmSearRepl.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmSearRepl.FormDestroy(Sender: TObject);
begin
  FrmSearRepl := nil;
  FTempBitmap.Free;
end;

end.


