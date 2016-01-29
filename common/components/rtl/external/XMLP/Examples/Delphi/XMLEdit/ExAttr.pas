{*********************************************************}
{* XMLPartner: ExAttr.PAS 2.56                           *}
{* Copyright (c) TurboPower Software Co 2002             *}
{* All rights reserved.                                  *}
{*********************************************************}
{* XMLPartner: XML Editor Attribute Edit form            *}
{*********************************************************}
unit ExAttr;

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
  ExProps,
  SysUtils,
  Classes;

type
  TAttributeForm = class(TForm)
    OkBtn: TButton;
    CancelBtn: TButton;
    Label1: TLabel;
    AttrNameEdit: TEdit;
    Label2: TLabel;
    AttrValueEdit: TEdit;
    procedure OkBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AttributeForm: TAttributeForm;

implementation

{$IFDEF WIN32}
{$R *.dfm}
{$ENDIF}
{$IFDEF LINUX}
{$R *.xfm}
{$ENDIF}

procedure TAttributeForm.OkBtnClick(Sender: TObject);
begin
  AttrNameEdit.Text := Trim(AttrNameEdit.Text);
  if AttrNameEdit.Text = '' then
  begin
    MessageDlg('Attribute name cannot be blank!', mtError, [mbOk], 0);
    ModalResult := mrNone;
  end;
end;

end.
