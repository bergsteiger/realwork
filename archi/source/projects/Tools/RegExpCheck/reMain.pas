unit reMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XPMan, OvcBase, afwControlPrim, afwBaseControl,
  afwControl, nevControl, evCustomEditorWindowPrim, evCustomEditorWindow,
  evCustomEditorWindowModelPart, evMultiSelectEditorWindow,
  evCustomEditorModelPart, evCustomEditor, evEditorWithOperations,
  evCustomMemo, evMemo;

type
  TMainForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    lbTagParts: TListBox;
    Label3: TLabel;
    lblResult: TLabel;
    btnStart: TButton;
    XPManifest1: TXPManifest;
    cbCaseSensitive: TCheckBox;
    memText: TMemo;
    cbNoCRLF: TCheckBox;
    memRegExp: TevMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure EditsChange(Sender: TObject);
  private
    { Private declarations }
    procedure DisplayResult(const aIsSuccess: Boolean; const aDisp: string);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
 l3String,
 l3IniFile,
 l3RegEx, l3StringListPrim;

const
 cTextOpt   = 'Text';
 cRegexpOpt = 'Regexp';
 cCaseOpt   = 'CaseSensitive';
 cCRLFOpt   = 'NoCRLF';
 cPreferencesSectionName = 'Preferences';
 cTextSectionName = 'CheckText';

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
var
 l_Ini: TCfgList;
begin
 l_Ini := TCfgList.Create;
 try
  l_Ini.Section := cTextSectionName;
  l_Ini.ReadParamList(cTextOpt, memText.Lines);
  l_Ini.Section := cPreferencesSectionName;
  memRegExp.Text := l_Ini.ReadParamStrDef(cRegexpOpt, '');
  cbCaseSensitive.Checked := l_Ini.ReadParamBoolDef(cCaseOpt, False);
  cbNoCRLF.Checked := l_Ini.ReadParamBoolDef(cCRLFOpt, False);
 finally
  FreeAndNil(l_Ini);
 end;
 memRegExp.TextSource.DocumentContainer.DocumentLimits.TextParaLimit := 1;
end;

procedure TMainForm.btnStartClick(Sender: TObject);
var
 I: Integer;
 l_Ini: TCfgList;
 l_RegExp: Tl3RegularSearch;
 l_MP: Tl3MatchPosition;
 l_Str: string;
begin
 l_Ini := TCfgList.Create;
 try
  l_Ini.Section := cTextSectionName;
  l_Ini.WriteParamList(cTextOpt, memText.Lines);
  l_Ini.Section := cPreferencesSectionName;
  l_Ini.WriteParamStr(cRegexpOpt, memRegExp.Text);
  l_Ini.WriteParamBool(cCaseOpt, cbCaseSensitive.Checked);
  l_Ini.WriteParamBool(cCRLFOpt, cbNoCRLF.Checked);
 finally
  FreeAndNil(l_Ini);
 end;
 lbTagParts.Clear;
 memText.SelLength := 0;
 l_RegExp := Tl3RegularSearch.Create;
 try
  l_RegExp.IgnoreCase := not cbCaseSensitive.Checked;
  l_RegExp.IgnoreCRLF := cbNoCRLF.Checked;
  l_RegExp.SearchPattern := memRegExp.Text;
  try
   if l_RegExp.SearchInString(l3PCharLen(memText.Text), l_MP) then
   begin
    DisplayResult(True, 'Match!');
    memText.SelStart := l_MP.StartPos;
    memText.SelLength := l_MP.Length;

    for I := 0 to l_RegExp.TagParts.Count - 1 do
    begin
     l_Str := l3PCharLen2String(l_RegExp.TagParts.ItemW[I]);
     lbTagParts.Items.Add(Format('%d : %s', [I, l_Str]));
    end;
   end
   else
    DisplayResult(False, 'No match...');
  except
   on El3RegExError do
    DisplayResult(False, 'ERROR');
  end;
 finally
  FreeAndNil(l_RegExp);
 end;
end;

procedure TMainForm.DisplayResult(const aIsSuccess: Boolean; const aDisp: string);
begin
 lblResult.Visible := True;
 if aIsSuccess then
  lblResult.Font.Color := clGreen
 else
  lblResult.Font.Color := clMaroon;
 lblResult.Caption := aDisp; 
end;

procedure TMainForm.EditsChange(Sender: TObject);
begin
 lblResult.Visible := False;
 lbTagParts.Clear;
end;

end.
