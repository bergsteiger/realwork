unit fcLinesEditor;
{
//
// Property editor for line editing
//
// Copyright (c) 1999 by Woll2Woll Software
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, fcCommon, ComCtrls;

type
  TLinesEditorForm = class(TForm)
    OKButton: TButton;
    CancelButton: TButton;
    GroupBox1: TGroupBox;
    LinesMemo: TMemo;
    LinesLabel: TLabel;
    procedure LinesMemoChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function fcExecuteLinesEditor(Lines: TStringList): Boolean;
function fcExecuteTextEditor(Component: TPersistent; PropName: string;
  ACaption: string): Boolean;

var
  LinesEditorForm: TLinesEditorForm;

implementation

{$R *.DFM}

function fcExecuteLinesEditor(Lines: TStringList): Boolean;
begin
  result := False;
  with TLinesEditorForm.Create(nil) do
  begin
    LinesMemo.Lines.Assign(Lines);
    if ShowModal = mrOK then
    begin
      Lines.Assign(LinesMemo.Lines);
      result := True;
    end;
    Free;
  end;
end;

function fcExecuteTextEditor(Component: TPersistent; PropName: string;
  ACaption: string): Boolean;
begin
  result := False;
  with TLinesEditorForm.Create(nil) do
  begin
    Caption := ACaption;
    LinesMemo.Text := fcGetStrProp(Component, PropName);
    if ShowModal = mrOK then
    begin
      fcSetStrProp(Component, PropName, LinesMemo.Text);
      result := True;
    end;
    Free;
  end;
end;

procedure TLinesEditorForm.LinesMemoChange(Sender: TObject);
begin
  LinesLabel.Caption := 'Lines: ' + InttoStr(LinesMemo.Lines.Count);
end;

end.
