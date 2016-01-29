{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit replunit;

interface
{$I dc.inc}

uses
  {$IFNDEF CLX}
  Forms, StdCtrls, ExtCtrls, Controls,
  {$ELSE}
  QForms, QControls, QExtCtrls, QStdCtrls,
  {$ENDIF}
  Classes,  dcString, dcedit, histed;

type
  TReplDialog = class(TForm)
    LTexttFind: TLabel;
    OptionsGroup: TGroupBox;
    CaseSens: TCheckBox;
    WholeWord: TCheckBox;
    RegExpr: TCheckBox;
    SearText: TDCHistoryEditor;
    LReplWith: TLabel;
    ReplText: TDCHistoryEditor;
    PromptRepl: TCheckBox;
    ScopeGroup: TRadioGroup;
    OriginGroup: TRadioGroup;
    DirectionGroup: TGroupBox;
    dirForward: TRadioButton;
    dirBackward: TRadioButton;
    OKBut: TButton;
    ReplBut: TButton;
    CancelBut: TButton;
    HelpBut: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ReplButClick(Sender: TObject);
    procedure OKButClick(Sender: TObject);
  private
    procedure SaveOptions(AReplaceAll: Boolean);
  protected
  public
    IntSearchOptions:TSearchOptions;
  end;

var
  ReplDialog: TReplDialog;

implementation
uses
  dcSystem, dcCommon, dcConsts, Consts, dcdreamLib;
{$R *.DFM}

{---------------------------------------------------}

procedure TReplDialog.FormCreate(Sender: TObject);
begin
  SetFormFont(self);
  IntSearchOptions:=TSearchOptions.Create;
  IntSearchOptions.Assign(GetSearchOptions);

  Caption :=                SReplText;
  LTexttFind.Caption :=     STextToFind;
  LReplWith.Caption :=      SReplaceWith;
  CaseSens.Caption :=       SCaseSensitive;
  WholeWord.Caption :=      SWholeWord;
  RegExpr.Caption :=        SRegExpr;
  PromptRepl.Caption :=     SPropmtRepl;
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

  HelpBut.Visible := boolShowHelpButton;
  if not boolShowHelpButton then
  begin
    OkBut.Left := OkBut.Left + 80;
    ReplBut.Left := ReplBut.Left + 80;
    CancelBut.Left := CancelBut.Left + 80;
  end;
  OkBut.Caption := SOKButton;
  ReplBut.Caption := SReplAll;
  CancelBut.Caption := SCancelButton;
  HelpBut.Caption := SHelpButton;

  with IntSearchOptions do
  begin
    SearText.Text := TextToFind;
    ReplText.Text := ReplaceWith;
    CaseSens.Checked := CaseSensitive;
    WholeWord.Checked := WholeWordsOnly;
    RegExpr.Checked := RegularExpr;
    PromptRepl.Checked := PromptOnReplace;
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

procedure TReplDialog.FormDestroy(Sender: TObject);
begin
  IntSearchOptions.Free;
end;

{---------------------------------------------------}

procedure TReplDialog.SaveOptions(AReplaceAll: Boolean);
begin
  with IntSearchOptions do
  begin
    TextToFind := SearText.Text;
    ReplaceWith := ReplText.Text;
    CaseSensitive := CaseSens.Checked;
    WholeWordsOnly := WholeWord.Checked;
    RegularExpr := RegExpr.Checked;
    PromptOnReplace := PromptRepl.Checked;
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
    ReplaceAll := AReplaceAll;
  end;
  GetSearchOptions.Assign(IntSearchOptions);
end;

{---------------------------------------------------}

procedure TReplDialog.ReplButClick(Sender: TObject);
begin
  {$IFNDEF CLX}
  UpdateEditors(Self);
  {$ENDIF}
  SaveOptions(True);
end;

{---------------------------------------------------}

procedure TReplDialog.OKButClick(Sender: TObject);
begin
  SaveOptions(False);
  SearText.SaveHistory;
  ReplText.SaveHistory;
end;

end.
