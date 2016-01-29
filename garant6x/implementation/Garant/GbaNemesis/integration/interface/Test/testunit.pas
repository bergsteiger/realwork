unit testunit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, Spin, vtLabel, vtGroupBox;

type
  TForm1 = class(TForm)
    IsGarantInstalledButton: TButton;
    CommandGroupBox: TvtGroupBox;
    Label3: TvtLabel;
    CommandComboBox: TComboBox;
    CommandOpenNewCheckBox: TCheckBox;
    Label4: TvtLabel;
    CommandInfiniteCheckBox: TCheckBox;
    GarantProcessCommandButton: TButton;
    Label5: TvtLabel;
    GarantDemoProcessCommandButton: TButton;
    CommandDirectoryEdit: TDirectoryEdit;
    CommandTimeOutSpinEdit: TSpinEdit;
    LinkGroupBox: TvtGroupBox;
    Label1: TvtLabel;
    LinkMemo: TMemo;
    LinkOpenNewCheckBox: TCheckBox;
    Label2: TvtLabel;
    LinkTimeOutSpinEdit: TSpinEdit;
    LinkInfiniteCheckBox: TCheckBox;
    GarantShowLinkButton: TButton;
    Label6: TvtLabel;
    LinkDirectoryEdit: TDirectoryEdit;
    GarantDemoShowLinkButton: TButton;
    Label7: TvtLabel;
    CommandKeyEdit: TEdit;
    Label8: TvtLabel;
    LinkKeyEdit: TEdit;
    FromFileCheckBox: TCheckBox;
    vtLabel1: TvtLabel;
    XMLFileEdit: TFilenameEdit;
    procedure IsGarantInstalledButtonClick(Sender: TObject);
    procedure GarantProcessCommandButtonClick(Sender: TObject);
    procedure GarantShowLinkButtonClick(Sender: TObject);
    procedure GarantDemoProcessCommandButtonClick(Sender: TObject);
    procedure GarantDemoShowLinkButtonClick(Sender: TObject);
    procedure XMLFileEditAfterDialog(Sender: TObject; var Name: String;
      var Action: Boolean);
    procedure FromFileCheckBoxClick(Sender: TObject);
    procedure XMLFileEditChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
 nsIntegrationInterface
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
  l_Stream := TFileStream.Create(XMLFileEdit.FileName, fmOpenRead);
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
 Case GarantDemoProcessCommand(PChar(CommandDirectoryEdit.Text),PChar(CommandKeyEdit.Text),
 CommandComboBox.ItemIndex,CommandOpenNewCheckBox.Checked, l_Time) of
  GI_OK: ShowMessage('GI_OK');
  GI_INVALIDLINKFORMAT: ShowMessage('GI_INVALIDLINKFORMAT');
  GI_BUSY: ShowMessage('GI_BUSY');
  GI_TIMEOUT: ShowMessage('GI_TIMEOUT');
  GI_NOTFOUND: ShowMessage('GI_NOTFOUND');
  GI_ALREADYRUNNING: ShowMessage('GI_ALREADYRUNNING');
  GI_USERDENYLOGIN: ShowMessage('GI_USERDENYLOGIN');
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
 else
  raise Exception.Create('Unexpected result');
 end;
end;

procedure TForm1.XMLFileEditAfterDialog(Sender: TObject; var Name: String;
  var Action: Boolean);
begin
 if Action then
  LinkMemo.Lines.LoadFromFile(Name);
end;

procedure TForm1.FromFileCheckBoxClick(Sender: TObject);
begin
 XMLFileEdit.Enabled := FromFileCheckBox.Checked;
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
  if FileExists(XMLFileEdit.FileName) then
   LinkMemo.Lines.LoadFromFile(XMLFileEdit.FileName)
  else
   LinkMemo.Lines.Clear;
 end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
 ClientHeight := LinkGroupBox.Top + LinkGroupBox.Height + LinkGroupBox.Left;
 ClientWidth := LinkGroupBox.Width + 2*LinkGroupBox.Left;
end;

end.


