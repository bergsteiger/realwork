unit a2UserFindWindow;

{ $Id: a2UserFindWindow.pas,v 1.1 2006/02/07 15:05:06 fireton Exp $}

// $Log: a2UserFindWindow.pas,v $
// Revision 1.1  2006/02/07 15:05:06  fireton
// - поиск пользователей
//
// Revision 1.4  2005/01/18 12:56:39  fireton
// - добавлены теги CVS
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfrmFind = class(TForm)
    Label1: TLabel;
    btnFindName: TButton;
    Bevel1: TBevel;
    edFindID: TComboBox;
    Label2: TLabel;
    btnFindID: TButton;
    Bevel2: TBevel;
    edFindLogin: TComboBox;
    Label3: TLabel;
    btnFindLogin: TButton;
    edFindName: TComboBox;
    btnCancel: TButton;
    procedure edFindNameEnter(Sender: TObject);
    procedure edFindIDEnter(Sender: TObject);
    procedure edFindLoginEnter(Sender: TObject);
    procedure btnFindNameClick(Sender: TObject);
    procedure btnFindIDClick(Sender: TObject);
    procedure btnFindLoginClick(Sender: TObject);
    procedure edFindNameChange(Sender: TObject);
    procedure edFindIDChange(Sender: TObject);
    procedure edFindLoginChange(Sender: TObject);
  private
    f_Context: string;
    { Private declarations }
  public
    property Context: string read f_Context;
    { Public declarations }
  end;

var
  frmFind: TfrmFind;

implementation

{$R *.dfm}

procedure TfrmFind.edFindNameEnter(Sender: TObject);
begin
 btnFindName.Default := True;
 btnFindID.Default := False;
 btnFindLogin.Default := False;
end;

procedure TfrmFind.edFindIDEnter(Sender: TObject);
begin
 btnFindName.Default := False;
 btnFindID.Default := True;
 btnFindLogin.Default := False;
end;

procedure TfrmFind.edFindLoginEnter(Sender: TObject);
begin
 btnFindName.Default := False;
 btnFindID.Default := False;
 btnFindLogin.Default := True;
end;

procedure TfrmFind.btnFindNameClick(Sender: TObject);
begin
 with edFindName do
 begin
  f_Context := Text;
  Items.Add(Text);
 end;
 ModalResult := -1;
end;

procedure TfrmFind.btnFindIDClick(Sender: TObject);
begin
 with edFindID do
 begin
  f_Context := Text;
  Items.Add(Text);
 end;
 ModalResult := -2;
end;

procedure TfrmFind.btnFindLoginClick(Sender: TObject);
begin
 with edFindLogin do
 begin
  f_Context := Text;
  Items.Add(Text);
 end;
 ModalResult := -3;
end;

procedure TfrmFind.edFindNameChange(Sender: TObject);
begin
 btnFindName.Enabled := edFindName.Text <> '';
end;

procedure TfrmFind.edFindIDChange(Sender: TObject);
begin
 btnFindID.Enabled := edFindID.Text <> '';
end;

procedure TfrmFind.edFindLoginChange(Sender: TObject);
begin
 btnFindLogin.Enabled := edFindLogin.Text <> '';
end;

end.
