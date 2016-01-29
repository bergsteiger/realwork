{*******************************************************}
{                                                       }
{       Delphi Visual Component Library                 }
{       Strings Editor Dialog                           }
{                                                       }
{       Copyright (c) 1999-2001 Borland Software Corp.  }
{                                                       }
{*******************************************************}

unit StringsEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StrEdit, Menus, StdCtrls, ExtCtrls, ComCtrls, ActnPopup;

type
  TStringsEditDlg = class(TStrEditDlg)
    GroupBox1: TGroupBox;
    LineCount: TLabel;
    Memo: TRichEdit;
    procedure Memo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UpdateStatus(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    SingleLine: string;
    MultipleLines: string;
  protected
    function GetLines: TStrings; override;
    procedure SetLines(const Value: TStrings); override;
    function GetLinesControl: TWinControl; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses DesignConst;

function TStringsEditDlg.GetLinesControl: TWinControl;
begin
  Result := Memo;
end;

procedure TStringsEditDlg.Memo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then CancelButton.Click;
end;

procedure TStringsEditDlg.UpdateStatus(Sender: TObject);
var
  Count: Integer;
  LineText: string;
begin
  if Sender = Memo then FModified := True;
  Count := Memo.Lines.Count;
  if Count = 1 then LineText := SingleLine
  else LineText := MultipleLines;
  LineCount.Caption := Format('%d %s', [Count, LineText]);
end;

procedure TStringsEditDlg.FormCreate(Sender: TObject);
begin
  inherited;
  SingleLine := srLine;
  MultipleLines := srLines;
end;

function TStringsEditDlg.GetLines: TStrings;
begin
  Result := Memo.Lines;
end;

procedure TStringsEditDlg.SetLines(const Value: TStrings);
begin
  Memo.Lines.Assign(Value);
end;

end.
