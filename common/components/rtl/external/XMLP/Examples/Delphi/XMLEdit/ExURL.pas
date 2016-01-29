{*********************************************************}
{* XMLPartner: ExURL.PAS 2.56                            *}
{* Copyright (c) TurboPower Software Co 2002             *}
{* All rights reserved.                                  *}
{*********************************************************}
{* XMLPartner: XML Editor URL Edit form                  *}
{*********************************************************}
unit ExURL;

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
  QDialogs,
  QForms,
{$ENDIF}
  SysUtils,
  Classes;


type
  TURLForm = class(TForm)
    Label1: TLabel;
    UrlEdit: TEdit;
    Label2: TLabel;
    FtpUserIdEdit: TEdit;
    Label3: TLabel;
    FtpPasswordEdit: TEdit;
    OkBtn: TButton;
    CancelBtn: TButton;
    Label4: TLabel;
    procedure OkBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function GetFTPPassword : string;
    function GetFTPUser : string;
    function GetURL : string;

    procedure SetFTPPassword(const aPassword : string);
    procedure SetFTPUser(const aUser : string);
    procedure SetURL(const aURL : string);
  public
    { Public declarations }
    property FTPPassword : string read GetFTPPassword write SetFTPPassword;
    property FTPUser : string read GetFTPUser write SetFTPUser;
    property URL : string read GetURL write SetURL;
  end;

var
  URLForm: TURLForm;

implementation

{$R *.dfm}

procedure TURLForm.OkBtnClick(Sender: TObject);
begin
  if UrlEdit.Text = '' then
  begin
    MessageDlg('The URL cannot be blank.', mtError, [mbOk], 0);
    ModalResult := mrNone;
  end;
end;
{--------}
function TURLForm.GetFTPPassword : string;
begin
  Result := FTPPasswordEdit.Text;
end;
{--------}
function TURLForm.GetFTPUser : string;
begin
  Result := FTPUserIDEdit.Text;
end;
{--------}
function TURLForm.GetURL : string;
begin
  Result := URLEdit.Text;
end;
{--------}
procedure TURLForm.SetFTPPassword(const aPassword : string);
begin
  FTPPasswordEdit.Text := aPassword;
end;
{--------}
procedure TURLForm.SetFTPUser(const aUser : string);
begin
  FTPUserIDEdit.Text := aUser;
end;
{--------}
procedure TURLForm.SetURL(const aURL : string);
begin
  URLEdit.Text := aURL;
end;

procedure TURLForm.FormShow(Sender: TObject);
begin
  URLEdit.SetFocus;
end;

end.
