unit testunit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Spin;

type
  TForm1 = class(TForm)
    IsGarantInstalledButton: TButton;
    CommandGroupBox: TGroupBox;
    Label3: TLabel;
    CommandComboBox: TComboBox;
    CommandOpenNewCheckBox: TCheckBox;
    Label4: TLabel;
    CommandInfiniteCheckBox: TCheckBox;
    GarantProcessCommandButton: TButton;
    Label5: TLabel;
    GarantDemoProcessCommandButton: TButton;
    CommandTimeOutSpinEdit: TSpinEdit;
    LinkGroupBox: TGroupBox;
    Label1: TLabel;
    LinkMemo: TMemo;
    LinkOpenNewCheckBox: TCheckBox;
    Label2: TLabel;
    LinkTimeOutSpinEdit: TSpinEdit;
    LinkInfiniteCheckBox: TCheckBox;
    GarantShowLinkButton: TButton;
    Label6: TLabel;
    GarantDemoShowLinkButton: TButton;
    Label7: TLabel;
    CommandKeyEdit: TEdit;
    Label8: TLabel;
    LinkKeyEdit: TEdit;
    FromFileCheckBox: TCheckBox;
    vtLabel1: TLabel;
    OpenDialog1: TOpenDialog;
    CommandDirectoryEdit: TEdit;
    LinkDirectoryEdit: TEdit;
    XMLFileEdit: TEdit;
    XMLFileButton: TButton;
    CommandDirectoryButton: TButton;
    LinkDirectoryButton: TButton;
    procedure IsGarantInstalledButtonClick(Sender: TObject);
    procedure GarantProcessCommandButtonClick(Sender: TObject);
    procedure GarantShowLinkButtonClick(Sender: TObject);
    procedure GarantDemoProcessCommandButtonClick(Sender: TObject);
    procedure GarantDemoShowLinkButtonClick(Sender: TObject);
    procedure FromFileCheckBoxClick(Sender: TObject);
    procedure XMLFileEditChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure XMLFileButtonClick(Sender: TObject);
    procedure CommandDirectoryButtonClick(Sender: TObject);
    procedure LinkDirectoryButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateMemoFromFile;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
 nsIntegrationInterface,
 Filectrl
 ;

{$R *.dfm}

procedure TForm1.IsGarantInstalledButtonClick(Sender: TObject);
begin
 Case IsGarantInstalled of
  GI_OK: ShowMessage('GI_OK');
  GI_NOTFOUND: ShowMessage('GI_NOTFOUND');
 else
  raise Exception.Create('Unexpected result');
 end;
end;

procedure TForm1.GarantProcessCommandButtonClick(Sender: TObject);
var
 l_Time: DWORD;
begin
 if CommandInfiniteCheckBox.Checked then
  l_Time := INFINITE
 else
  l_Time := CommandTimeOutSpinEdit.Value;
 Case GarantProcessCommand(CommandComboBox.ItemIndex,CommandOpenNewCheckBox.Checked, l_Time) of
  GI_OK: ShowMessage('GI_OK');
  GI_INVALIDLINKFORMAT: ShowMessage('GI_INVALIDLINKFORMAT');
  GI_BUSY: ShowMessage('GI_BUSY');
  GI_TIMEOUT: ShowMessage('GI_TIMEOUT');
  GI_NOTFOUND: ShowMessage('GI_NOTFOUND');
  GI_USERDENYLOGIN: ShowMessage('GI_USERDENYLOGIN');
  GI_TOOMANYOPENWINDOWS: ShowMessage('GI_TOOMANYOPENWINDOWS');
 else
  raise Exception.Create('Unexpected result');
 end;
end;

procedure TForm1.GarantShowLinkButtonClick(Sender: TObject);
var
 l_Time: DWORD;
 l_Mem: Pointer;
 l_Size: Int64;
 l_Stream: TStream;
begin
 if LinkInfiniteCheckBox.Checked then
  l_Time := INFINITE
 else
  l_Time := LinkTimeOutSpinEdit.Value;
 if FromFileCheckBox.Checked then
 begin
  l_Stream := TFileStream.Create(XMLFileEdit.Text, fmOpenRead);
  try
   l_Size := l_Stream.Size + 1;
   GetMem(l_Mem, l_Size);
   FillChar(l_Mem^, l_Size, #0);
   l_Stream.ReadBuffer(l_Mem^, l_Stream.Size);
   if StrComp(PChar(l_Mem), PChar(LinkMemo.Lines.Text)) <> 0 then
    ShowMessage('Strings is DIFFER !!!');
   if StrLen(PChar(l_Mem)) <> l_Stream.Size then
    ShowMessage('Buffer length is DIFFER !!!');
  finally
   FreeAndNil(l_Stream);
  end;
 end
 else
 begin
  l_Size := 0;
  l_Mem := PChar(LinkMemo.Lines.Text);
 end;
 try
  Case GarantShowLink(PChar(l_Mem),LinkOpenNewCheckBox.Checked, l_Time) of
   GI_OK: ShowMessage('GI_OK');
   GI_INVALIDLINKFORMAT: ShowMessage('GI_INVALIDLINKFORMAT');
   GI_BUSY: ShowMessage('GI_BUSY');
   GI_TIMEOUT: ShowMessage('GI_TIMEOUT');
   GI_NOTFOUND: ShowMessage('GI_NOTFOUND');
   GI_SYSTEMERROR: ShowMessage('GI_SYSTEMERROR');
   GI_QUERYPARAMSHASABSENTVALUES: ShowMessage('GI_QUERYPARAMSHASABSENTVALUES');
   GI_USERDENYLOGIN: ShowMessage('GI_USERDENYLOGIN');
   GI_TOOMANYOPENWINDOWS: ShowMessage('GI_TOOMANYOPENWINDOWS');
  else
   raise Exception.Create('Unexpected result');
  end;
 finally
  if l_Size > 0 then
   FreeMem(l_Mem, l_Size);
 end;
end;

procedure TForm1.GarantDemoProcessCommandButtonClick(Sender: TObject);
var
 l_Time: DWORD;
begin
 if CommandInfiniteCheckBox.Checked then
  l_Time := INFINITE
 else
  l_Time := CommandTimeOutSpinEdit.Value;
 Case GarantDemoProcessCommand(PChar(CommandDirectoryEdit.Text), PChar(CommandKeyEdit.Text),
 CommandComboBox.ItemIndex,CommandOpenNewCheckBox.Checked, l_Time) of
  GI_OK: ShowMessage('GI_OK');
  GI_INVALIDLINKFORMAT: ShowMessage('GI_INVALIDLINKFORMAT');
  GI_BUSY: ShowMessage('GI_BUSY');
  GI_TIMEOUT: ShowMessage('GI_TIMEOUT');
  GI_NOTFOUND: ShowMessage('GI_NOTFOUND');
  GI_ALREADYRUNNING: ShowMessage('GI_ALREADYRUNNING');
  GI_USERDENYLOGIN: ShowMessage('GI_USERDENYLOGIN');
  GI_TOOMANYOPENWINDOWS: ShowMessage('GI_TOOMANYOPENWINDOWS');
 else
  raise Exception.Create('Unexpected result');
 end;
end;

procedure TForm1.GarantDemoShowLinkButtonClick(Sender: TObject);
var
 l_Time: DWORD;
begin
 if LinkInfiniteCheckBox.Checked then
  l_Time := INFINITE
 else
  l_Time := LinkTimeOutSpinEdit.Value;
 Case GarantDemoShowLink(PChar(CommandDirectoryEdit.Text),PChar(LinkKeyEdit.Text),
 PChar(LinkMemo.Lines.Text),LinkOpenNewCheckBox.Checked, l_Time) of
  GI_OK: ShowMessage('GI_OK');
  GI_INVALIDLINKFORMAT: ShowMessage('GI_INVALIDLINKFORMAT');
  GI_BUSY: ShowMessage('GI_BUSY');
  GI_TIMEOUT: ShowMessage('GI_TIMEOUT');
  GI_NOTFOUND: ShowMessage('GI_NOTFOUND');
  GI_ALREADYRUNNING: ShowMessage('GI_ALREADYRUNNING');
  GI_SYSTEMERROR: ShowMessage('GI_SYSTEMERROR');
  GI_QUERYPARAMSHASABSENTVALUES: ShowMessage('GI_QUERYPARAMSHASABSENTVALUES');
  GI_USERDENYLOGIN: ShowMessage('GI_USERDENYLOGIN');
  GI_TOOMANYOPENWINDOWS: ShowMessage('GI_TOOMANYOPENWINDOWS');
 else
  raise Exception.Create('Unexpected result');
 end;
end;

procedure TForm1.FromFileCheckBoxClick(Sender: TObject);
begin
 XMLFileEdit.Enabled := FromFileCheckBox.Checked;
 XMLFileButton.Enabled := FromFileCheckBox.Checked;
 LinkMemo.ReadOnly := FromFileCheckBox.Checked;
 UpdateMemoFromFile;
end;

procedure TForm1.XMLFileEditChange(Sender: TObject);
begin
 UpdateMemoFromFile;
end;

procedure TForm1.UpdateMemoFromFile;
begin
 if FromFileCheckBox.Checked then
 begin
  if FileExists(XMLFileEdit.Text) then
   LinkMemo.Lines.LoadFromFile(XMLFileEdit.Text)
  else
   LinkMemo.Lines.Clear;
 end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
 ClientHeight := LinkGroupBox.Top + LinkGroupBox.Height + LinkGroupBox.Left;
 ClientWidth := LinkGroupBox.Width + 2*LinkGroupBox.Left;
end;

procedure TForm1.XMLFileButtonClick(Sender: TObject);
begin
 if OpenDialog1.Execute then
 begin
  XMLFileEdit.Text := OpenDialog1.FileName;
  LinkMemo.Lines.LoadFromFile(OpenDialog1.FileName);
 end;
end;

procedure TForm1.CommandDirectoryButtonClick(Sender: TObject);
var
 Dir: String;
begin
 Dir := CommandDirectoryEdit.Text;
 if SelectDirectory('Select folder', '', Dir) then
  CommandDirectoryEdit.Text := Dir;
end;

procedure TForm1.LinkDirectoryButtonClick(Sender: TObject);
var
 Dir: String;
begin
 Dir := LinkDirectoryEdit.Text;
 if SelectDirectory('Select folder', '', Dir) then
  LinkDirectoryEdit.Text := Dir;
end;

end.


