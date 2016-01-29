unit Main;

{ $Id: Main.pas,v 1.1 2005/09/26 14:23:36 step Exp $ }
// $Log: Main.pas,v $
// Revision 1.1  2005/09/26 14:23:36  step
// занесено в cvs
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  HT_Const, HT_Dll, Mask, ToolEdit, ComCtrls, DbInfo;


type
  TFormMain = class(TForm)
   pTop: TPanel;
    bDoVerify: TButton;
   mLog: TMemo;
   IniFileDialog: TOpenDialog;
    labIniFile: TLabel;
    edIniFile: TEdit;
    bSelectIniFile: TButton;
    lbFamilyNames: TListBox;
    labDBList: TLabel;
    labGarantFolder: TLabel;
    labMainFolder: TLabel;
    bDoRepair: TButton;
   procedure bDoVerifyClick(Sender: TObject);
   procedure FormCreate(Sender: TObject);
   procedure AddToMemo(aStr: string);
   procedure bSelectIniFileClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
   f_DbInfo: TDbInfo;
   procedure ReadArchiIniFile(aArchiIniFile: string);
  public
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
 l3Base,
 l3FileUtils,
 //DbReformer,
 DbVerifier;

procedure TFormMain.AddToMemo(aStr: string);
begin
 if aStr <> '' then
  mLog.Lines.Add(aStr);
 Application.ProcessMessages;
end;

procedure TFormMain.bDoVerifyClick(Sender: TObject);
var
 l_SavedCursor: TCursor;
 l_DoRepair: Boolean;
begin
 f_DbInfo.CheckFolderVersions;
 l_DoRepair := Sender = bDoRepair;
 mLog.Clear;
 l_SavedCursor := Screen.Cursor;
 Screen.Cursor := crHourGlass;
 bDoVerify.Enabled := False;
 bDoRepair.Enabled := False;
 try

  with TDbVerifier.Create(f_DbInfo,
                          lbFamilyNames.Items[lbFamilyNames.ItemIndex],
                          AddToMemo) do
   try
    Execute(l_DoRepair);
   finally
    Free;
   end;

 finally
  bDoVerify.Enabled := True;
  bDoRepair.Enabled := True;
  Screen.Cursor := l_SavedCursor;
 end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
 l_Path: string;
begin
 IniFileDialog.InitialDir := Application.ExeName;

 l_Path := ConcatDirName(ExtractDirName(Application.ExeName), 'archi.ini');
 if FileExists(l_Path) then
 begin
  edIniFile.Text := l_Path;
  ReadArchiIniFile(edIniFile.Text);
 end;
end;

procedure TFormMain.bSelectIniFileClick(Sender: TObject);
begin
 if IniFileDialog.Execute then
 begin
  edIniFile.Text := IniFileDialog.FileName;
  ReadArchiIniFile(edIniFile.Text);
 end;
end;

procedure TFormMain.ReadArchiIniFile(aArchiIniFile: string);
begin
 edIniFile.Text := aArchiIniFile;

 if Assigned(f_DbInfo) then
  FreeAndNil(f_DbInfo);
 f_DbInfo := TDbInfo.Create(aArchiIniFile);

 // заполнение сведений о БД
 f_DbInfo.GetFamilyNames(lbFamilyNames.Items);
 if lbFamilyNames.Items.Count > 0 then
  lbFamilyNames.ItemIndex := 0;
 labGarantFolder.Caption := 'Папка Garant: ' + f_DbInfo.FamilyFolder;
 labMainFolder.Caption   := 'Папка Main  : '   + f_DbInfo.MainFolder;

 // вкл-выкл контролов
 bDoVerify.Enabled := True;
 bDoRepair.Enabled := True;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
 l3Free(f_DbInfo);
end;

end.

