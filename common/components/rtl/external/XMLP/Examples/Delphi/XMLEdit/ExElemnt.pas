{*********************************************************}
{* XMLPartner: ExElemnt.PAS 2.56                         *}
{* Copyright (c) TurboPower Software Co 2002             *}
{* All rights reserved.                                  *}
{*********************************************************}
{* XMLPartner: XML Editor Element Edit form              *}
{*********************************************************}
unit ExElemnt;

interface

uses
{$IFDEF WIN32}
  Windows,
  Messages,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  Grids,
{$ENDIF}
{$IFDEF LINUX}
  QStdCtrls,
  QControls,
  QForms,
  QDialogs,
{$ENDIF}
  SysUtils,
  Classes;

type
  TElementForm = class(TForm)
    Label1: TLabel;
    NameEdit: TEdit;
    OkBtn: TButton;
    CancelBtn: TButton;
    procedure OkBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ElementForm: TElementForm;

implementation

{$R *.dfm}

procedure TElementForm.OkBtnClick(Sender: TObject);
begin
  NameEdit.Text := Trim(NameEdit.Text);
  if NameEdit.Text = '' then begin
    MessageDlg('Element name cannot be blank!', mtError, [mbOk], 0);
    ModalResult := mrNone;
  end;
end;

procedure TElementForm.FormShow(Sender: TObject);
begin
  NameEdit.SetFocus;
end;

end.
