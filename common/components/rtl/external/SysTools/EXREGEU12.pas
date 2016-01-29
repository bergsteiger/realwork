unit EXREGEU12;

interface

uses
  SysUtils,
  {$IFDEF WIN32}
  Windows,
  {$ELSE}
  WinTypes,
  WinProcs,
  {$ENDIF}
  Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StBase, StRegEx, StdCtrls, Buttons, Gauges;

type
  TForm1 = class(TForm)
    gbOptions: TGroupBox;
    cbSelect: TCheckBox;
    cbIgnoreCase: TCheckBox;
    cbLineNumbers: TCheckBox;
    cbxModOnly: TCheckBox;
    cbxCountOnly: TCheckBox;
    Label1: TLabel;
    edtSourceFile: TEdit;
    Label2: TLabel;
    edtDestFile: TEdit;
    Memo1: TMemo;
    lblSelAvoid: TLabel;
    lblMatch: TLabel;
    lblReplace: TLabel;
    lblLPS: TLabel;
    Button1: TButton;
    sbSource: TSpeedButton;
    sbDest: TSpeedButton;
    OpenDialog1: TOpenDialog;
    Gauge1: TGauge;
    StRegEx1: TStRegEx;
    edtSelAvoid: TEdit;
    edtMatch: TEdit;
    edtReplace: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure SelectFile(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure StRegEx1Progress(Sender: TObject; Percent: Word);
    procedure StRegEx1Match(Sender: TObject; Position: TMatchPosition);
  private
    { Private declarations }
  public
    { Public declarations }

    ACount : Cardinal;


    StRegExClass  : TStStreamRegEx;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses
  StStrS;

procedure TForm1.SelectFile(Sender: TObject);
begin
  if (Sender = sbSource) then begin
    OpenDialog1.Title := 'Source File';
    OpenDialog1.Options := OpenDialog1.Options + [ofFileMustExist];
    if OpenDialog1.Execute then
      edtSourceFile.Text := OpenDialog1.FileName;
  end else begin
    OpenDialog1.Title := 'Destination File';
    OpenDialog1.Options := OpenDialog1.Options - [ofFileMustExist];
    if OpenDialog1.Execute then
      edtDestFile.Text := OpenDialog1.FileName;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ACount := 0;

  StRegEx1.SelAvoidPattern.Clear;
  StRegEx1.MatchPattern.Clear;
  StRegEx1.ReplacePattern.Clear;

  StRegEx1.SelAvoidPattern.Add(edtSelAvoid.Text);
  StRegEx1.MatchPattern.Add(edtMatch.Text);
  StRegEx1.ReplacePattern.Add(edtReplace.Text);


  if cbxModOnly.Checked then
    StRegEx1.OutputOptions := StRegEx1.OutputOptions + [ooModified]
  else
    StRegEx1.OutputOptions := StRegEx1.OutputOptions - [ooModified];
  if cbxCountOnly.Checked then
    StRegEx1.OutputOptions := StRegEx1.OutputOptions + [ooCountOnly]
  else
    StRegEx1.OutputOptions := StRegEx1.OutputOptions - [ooCountOnly];

  if (TrimS(edtSourceFile.Text) = '') or
     ((TrimS(edtDestFile.Text) = '') and (not (ooCountOnly in StRegEx1.OutputOptions))) then begin
    MessageDlg('Source and/or Destination file cannot be blank',
               mtError, [mbOK], 0);
    Exit;
  end;

  if not (FileExists(TrimS(edtSourceFile.Text))) then begin
    MessageDlg('Source file not found', mtError, [mbOK], 0);
    Exit;
  end;

  if (StRegEx1.SelAvoidPattern.Count = 0) and
     (StRegEx1.MatchPattern.Count = 0) then begin
    MessageDlg('You must specify a SelAvoid or Match Pattern',
               mtError, [mbOK], 0);
    Exit;
  end;

  StRegEx1.IgnoreCase := cbIgnoreCase.Checked;
  StRegEx1.Avoid := not cbSelect.Checked;
  StRegEx1.LineNumbers := cbLineNumbers.Checked;
  StRegEx1.InputFile := TrimS(edtSourceFile.Text);
  StRegEx1.OutputFile := edtDestFile.Text;

  lblSelAvoid.Caption := 'Sel/Avoid: 0';
  lblMatch.Caption    := 'Match: 0';
  lblReplace.Caption  := 'ReplaceL 0';
  lblLPS.Caption      := 'Lines/Sec: 0';

  Screen.Cursor := crHourglass;
  try
    StRegEx1.Execute;
  finally
    Screen.Cursor := crDefault;
  end;

  Memo1.Clear;
  if (not (ooCountOnly in StRegEx1.OutputOptions)) then
    Memo1.Lines.LoadFromFile(edtDestFile.Text);

  lblSelAvoid.Caption := 'Sel/Avoid: ' + IntToStr(StRegEx1.LinesSelected);
  lblMatch.Caption    := 'Match: ' + IntToStr(StRegEx1.LinesMatched);
  lblReplace.Caption  := 'Replace: ' + IntToStr(StRegEx1.LinesReplaced);
  lblLPS.Caption      := 'Lines/Sec: ' + IntToStr(StRegEx1.LinesPerSecond);
end;

procedure TForm1.StRegEx1Progress(Sender: TObject; Percent: Word);
begin
  if ((Percent mod 2) = 0) and (Gauge1.Progress <> Percent) then
    Gauge1.Progress := Percent;
end;


procedure TForm1.StRegEx1Match(Sender: TObject; Position: TMatchPosition);
begin
  Inc(ACount);
  Caption := IntToStr(Position.LineNum);
  Application.ProcessMessages;
end;

end.
