{*********************************************************}
{* XMLPartner: ExCommnt.PAS 2.56                         *}
{* Copyright (c) TurboPower Software Co 2002             *}
{* All rights reserved.                                  *}
{*********************************************************}
{* XMLPartner: XML Editor Comment Edit form              *}
{*********************************************************}
unit ExCommnt;

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
  QStdCtrls,
  QControls,
  QForms,
{$ENDIF}
  SysUtils,
  Classes;
  
type
  TCommentForm = class(TForm)
    Label1: TLabel;
    CommentEdit: TEdit;
    OkBtn: TButton;
    CancelBtn: TButton;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CommentForm: TCommentForm;

implementation

{$IFDEF WIN32}
{$R *.dfm}
{$ENDIF}
{$IFDEF LINUX}
{$R *.xfm}
{$ENDIF}

procedure TCommentForm.FormShow(Sender: TObject);
begin
  CommentEdit.SetFocus;
end;

end.
