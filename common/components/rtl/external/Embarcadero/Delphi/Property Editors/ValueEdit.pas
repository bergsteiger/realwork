{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{                  Value Editor Dialog                  }
{*******************************************************}

unit ValueEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, StrEdit, Vcl.Menus, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.ValEdit;

type
  TValueEditDlg = class(TStrEditDlg)
    ValueListEditor1: TValueListEditor;
    procedure ValueListEditor1StringsChange(Sender: TObject);
    procedure ValueListEditor1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  protected
    function GetLines: TStrings; override;
    procedure SetLines(const Value: TStrings); override;
    function GetLinesControl: TWinControl; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

function TValueEditDlg.GetLinesControl: TWinControl;
begin
  Result := ValueListEditor1;
end;

function TValueEditDlg.GetLines: TStrings;
begin
  Result := ValueListEditor1.Strings;
end;

procedure TValueEditDlg.SetLines(const Value: TStrings);
begin
  ValueListEditor1.Strings := Value;
end;

procedure TValueEditDlg.ValueListEditor1StringsChange(Sender: TObject);
begin
  inherited;
  if Sender = ValueListEditor1 then FModified := True;
end;

procedure TValueEditDlg.ValueListEditor1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_ESCAPE then CancelButton.Click;
end;

end.
