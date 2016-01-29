{*********************************************************}
{* XMLPartner: ExProcIn.PAS 2.56                         *}
{* Copyright (c) TurboPower Software Co 2002             *}
{* All rights reserved.                                  *}
{*********************************************************}
{* XMLPartner: XML Editor Processing Instruction form    *}
{*********************************************************}
unit ExProcIn;

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
{$ENDIF}
{$IFDEF LINUX}
  QForms,
  QDialogs,
  QStdCtrls,
  QControls,
{$ENDIF}
  SysUtils,
  Classes;

type
  TPIForm = class(TForm)
    Label1: TLabel;
    PINameEdit: TEdit;
    Label2: TLabel;
    PIValueEdit: TEdit;
    OkBtn: TButton;
    CancelBtn: TButton;
    procedure OkBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PIForm: TPIForm;

implementation

{$R *.dfm}

procedure TPIForm.OkBtnClick(Sender: TObject);
begin
  PINameEdit.Text := Trim(PINameEdit.Text);
  if PINameEdit.Text = '' then
  begin
    MessageDlg('Processing instruction name cannot be blank!', mtError, [mbOk], 0);
    ModalResult := mrNone;
  end;
end;

end.
