
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{ Copyright (c) 1995-2001 Borland Software Corporation  }
{                                                       }
{*******************************************************}

unit Dbedit;

{$R-}

interface

uses SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Buttons, StdCtrls, DB, DBTables;

type
  TDBEditForm = class(TForm)
    GroupBox1: TGroupBox;
    Label4: TLabel;
    DatabaseName: TEdit;
    Label1: TLabel;
    AliasName: TComboBox;
    Label2: TLabel;
    DriverName: TComboBox;
    Label3: TLabel;
    DatabaseParams: TMemo;
    DefaultsButton: TButton;
    ClearButton: TButton;
    GroupBox3: TGroupBox;
    LoginPrompt: TCheckBox;
    KeepConnection: TCheckBox;
    OkButton: TButton;
    CancelButton: TButton;
    HelpButton: TButton;
    procedure AliasNameChange(Sender: TObject);
    procedure AliasNameDropDown(Sender: TObject);
    procedure DriverNameChange(Sender: TObject);
    procedure DriverNameDropDown(Sender: TObject);
    procedure DefaultsButtonClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
  private
    Database: TDatabase;
    function Edit: Boolean;
  end;

function EditDatabase(ADatabase: TDatabase): Boolean;

implementation

{$R *.dfm}

uses bdeconst, TypInfo, LibHelp, BDE;

function EditDatabase(ADatabase: TDatabase): Boolean;
begin
  with TDBEditForm.Create(Application) do
  try
    Database := ADatabase;
    Result := Edit;
  finally
    Free;
  end;
end;

function TDBEditForm.Edit: Boolean;
begin
  Caption := Format(SDBCaption, [Database.Owner.Name, DotSep, Database.Name]);
  DatabaseName.Text := Database.DatabaseName;
  AliasName.Text := Database.AliasName;
  DriverName.Text := Database.DriverName;
  DatabaseParams.Lines := Database.Params;
  LoginPrompt.Checked := Database.LoginPrompt;
  KeepConnection.Checked := Database.KeepConnection;
  Result := False;
  if ShowModal = mrOk then
  begin
    Database.DatabaseName := DatabaseName.Text;
    if DriverName.Text <> '' then
      Database.DriverName := DriverName.Text
    else
      Database.AliasName := AliasName.Text;
    Database.Params := DatabaseParams.Lines;
    Database.LoginPrompt := LoginPrompt.Checked;
    Database.KeepConnection := KeepConnection.Checked;
    Result := True;
  end;
end;

procedure TDBEditForm.AliasNameChange(Sender: TObject);
begin
  DriverName.Text := '';
end;

procedure TDBEditForm.AliasNameDropDown(Sender: TObject);
begin
  AliasName.Items.Clear;
  Database.Session.GetAliasNames(AliasName.Items);
end;

procedure TDBEditForm.DriverNameChange(Sender: TObject);
begin
  AliasName.Text := '';
end;

procedure TDBEditForm.DriverNameDropDown(Sender: TObject);
begin
  DriverName.Items.Clear;
  Database.Session.GetDriverNames(DriverName.Items);
end;

procedure TDBEditForm.DefaultsButtonClick(Sender: TObject);
var
  AddPassword: Boolean;
begin
  DatabaseParams.Clear;
  AddPassword := False;
  if DriverName.Text <> '' then
  begin
    Database.Session.GetDriverParams(DriverName.Text, DatabaseParams.Lines);
    AddPassword := DriverName.Text <> szCFGDBSTANDARD;
  end else
    if AliasName.Text <> '' then
    begin
      Database.Session.GetAliasParams(AliasName.Text, DatabaseParams.Lines);
      AddPassword := Database.Session.GetAliasDriverName(AliasName.Text) <> szCFGDBSTANDARD;
    end;
  if AddPassword then DatabaseParams.Lines.Add('PASSWORD=');
end;

procedure TDBEditForm.ClearButtonClick(Sender: TObject);
begin
  DatabaseParams.Clear;
end;

procedure TDBEditForm.OkButtonClick(Sender: TObject);
begin
  ModalResult := mrNone;
  try
    Database.ValidateName(DatabaseName.Text);
  except
    DatabaseName.SetFocus;
    raise;
  end;
  if Database.Connected then
  begin
    if MessageDlg(SDisconnectDatabase, mtConfirmation,
      mbOkCancel, 0) <> mrOk then Exit;
    Database.Close;
  end;
  ModalResult := mrOk;
end;

procedure TDBEditForm.FormCreate(Sender: TObject);
begin
  HelpContext := hcDDataBaseEdit;
end;

procedure TDBEditForm.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.
