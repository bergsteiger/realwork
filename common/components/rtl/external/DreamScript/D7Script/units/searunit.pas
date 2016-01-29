{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit searunit;

interface
{$I dc.inc}

uses
  {$IFNDEF CLX}
  Windows, Controls, Forms, ComCtrls, StdCtrls, ExtCtrls,
  {$ELSE}
  QControls, QForms, QStdCtrls, QExtCtrls, QComCtrls,
  {$ENDIF}
  dcsystem, SysUtils, Classes,  dcstring, dccommon, dcconsts, consts,  dcdreamlib, histed;

type
  TSrchDialog = class(TForm)
    PageControl: TPageControl;
    EditorFindPage: TTabSheet;
    LTexttFind: TLabel;
    OptionsGroup: TGroupBox;
    FileFindPage: TTabSheet;
    Label3: TLabel;
    FileSearchText: TDCHistoryEditor;
    GroupBox2: TGroupBox;
    FileCaseSense: TCheckBox;
    FileWholeWords: TCheckBox;
    FileRegExp: TCheckBox;
    GroupBox3: TGroupBox;
    SearchOpen: TRadioButton;
    SearchProject: TRadioButton;
    SearchDirectory: TRadioButton;
    GroupBox4: TGroupBox;
    Label2: TLabel;
    DirSpec: TComboBox;
    IncludeSubDirs: TCheckBox;
    g: TButton;
    CaseSens: TCheckBox;
    WholeWord: TCheckBox;
    RegExpr: TCheckBox;
    SearText: TDCHistoryEditor;
    Panel1: TPanel;
    OKBut: TButton;
    CancelBut: TButton;
    HelpBut: TButton;
    ScopeGroup: TRadioGroup;
    OriginGroup: TRadioGroup;
    DirectionGroup: TGroupBox;
    dirForward: TRadioButton;
    dirBackward: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OKButClick(Sender: TObject);
  public
    IntSearchOptions: TSearchOptions;
  end;

var
  SrchDialog: TSrchDialog;

implementation
{$R *.DFM}

{---------------------------------------------------}

procedure TSrchDialog.FormCreate(Sender: TObject);
begin
  SetFormFont(self);
  IntSearchOptions := TSearchOptions.Create;
  IntSearchOptions.Assign(GetSearchOptions);

  Caption :=                SFindText;
  EditorFindPage.Caption := SFind;
  LTexttFind.Caption :=     STextToFind;
  CaseSens.Caption :=       SCaseSensitive;
  WholeWord.Caption :=      SWholeWord;
  RegExpr.Caption :=        SRegExpr;
  DirectionGroup.Caption := SDirection;
  OptionsGroup.Caption  :=  SOptions;
  dirForward.Caption :=     SForward;
  dirBackward.Caption :=    SBackward;
  ScopeGroup.Caption :=     SScope;
  ScopeGroup.Items[0] :=    SGlobal;
  ScopeGroup.Items[1] :=    SSelText;
  OriginGroup.Caption :=    SOrigin;
  OriginGroup.Items[0] :=   SFromCursor;
  OriginGroup.Items[1] :=   SEntireScope;
  UpdateStandardButtons(OkBut, CancelBut, HelpBut);
  with IntSearchOptions do
  begin
    SearText.Text := TextToFind;
    CaseSens.Checked := CaseSensitive;
    WholeWord.Checked := WholeWordsOnly;
    RegExpr.Checked := RegularExpr;
    if Direction = sdBackward then
      dirBackward.Checked := True
    else
      dirForward.Checked := True;
    if Scope = ssSelectedText then
      ScopeGroup.ItemIndex := 1
    else
      ScopeGroup.ItemIndex := 0;
    if Origin = soEntireScope then
      OriginGroup.ItemIndex := 1
    else
      OriginGroup.ItemIndex := 0;
  end;
end;

{---------------------------------------------------}

procedure TSrchDialog.FormDestroy(Sender: TObject);
begin
  IntSearchOptions.Free;
end;

{---------------------------------------------------}

procedure TSrchDialog.OKButClick(Sender: TObject);
begin
  with IntSearchOptions do
  begin
    TextToFind := SearText.Text;
    CaseSensitive := CaseSens.Checked;
    WholeWordsOnly := WholeWord.Checked;
    RegularExpr := RegExpr.Checked;
    if dirBackward.Checked then
      Direction := sdBackward
    else
      Direction := sdForward;
    if ScopeGroup.ItemIndex = 1 then
      Scope := ssSelectedText
    else
      Scope := ssGlobal;
    if OriginGroup.ItemIndex = 1 then
      Origin := soEntireScope
    else
      Origin := soFromCursor;
  end;
  GetSearchOptions.Assign(IntSearchOptions);
  SearText.SaveHistory;
end;

{---------------------------------------------------}

end.
