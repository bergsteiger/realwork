unit Main;

{ $Id: Main.pas,v 1.24 2015/03/10 07:25:21 fireton Exp $ }
// $Log: Main.pas,v $
// Revision 1.24  2015/03/10 07:25:21  fireton
// - �� ���������� ProjectDefine.inc
//
// Revision 1.23  2013/12/24 07:03:05  fireton
// - ������ ������ ���� �������� ������ ���� ������ ������ �������
//
// Revision 1.22  2012/02/08 07:29:49  fireton
// - ����������� ���������� ������
//
// Revision 1.21  2011/12/12 14:02:52  fireton
// - DbReformer � DbInfo ��������� � DT
//
// Revision 1.20  2011/12/01 14:58:52  fireton
// - ��������� ���������
//
// Revision 1.19  2009/04/09 08:36:36  fireton
// - ���������� �����������
//
// Revision 1.18  2009/03/05 09:06:23  narry
// - ���������-���������� ������ � ����������� �� ������ ����
//
// Revision 1.17  2009/02/09 10:54:17  fireton
// - ������ ���� 131
//
// Revision 1.16  2007/03/12 11:19:12  fireton
// - ����� ������� � ��������� ���� ��� 64 ����
//
// Revision 1.15  2007/03/01 11:07:39  fireton
// - ��������� �� ������ ����� ����� ��������� ������������
//
// Revision 1.14  2007/02/22 15:00:58  fireton
// - ������� �� 64 ���� � HyTech
//
// Revision 1.13  2005/02/09 17:34:12  step
// ������ ������� ������ (�� ���������� �����)
//
// Revision 1.12  2005/02/08 16:47:20  step
// �������� ����� ������ ������ � ���������
//
// Revision 1.11  2004/10/25 16:08:12  step
// �������� TFormMain.AddToMemo
//
// Revision 1.10  2004/06/21 15:38:48  step
// �������� ����� archi.ini �� ������� ���������� �� ���������
//
// Revision 1.9  2004/05/25 15:43:48  step
// ������ �������� �������� "�� �����"
//
// Revision 1.8  2004/05/07 17:37:47  step
// ���� ������ �����������
//
// Revision 1.7  2004/05/05 16:07:03  step
// ��������� TDbInfo
//
// Revision 1.6  2004/04/28 13:45:46  step
// �������� ������ ���� ������������ �����
//
// Revision 1.5  2004/04/01 08:19:40  step
// new: procedure ApplyJournalActions - ���������� �������
// new: function DeleteLinkDictDuplicates - �������� ���������� ���� LNK_DICT
// new: function DeleteBadLinkToDict - �������� "�������" ������
//
// Revision 1.4  2004/03/05 09:08:50  step
// ������ �����������
//
// Revision 1.3  2004/03/04 18:03:10  step
// ��������� �������� ����������-��������������
//
// Revision 1.2  2004/03/02 15:47:00  step
// ���� ������ ���������
//
// Revision 1.1  2004/03/01 19:04:54  step
// ������� � CVS
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  HT_Const, HT_Dll, Mask, ToolEdit, ComCtrls, DT_DbInfo, XPMan;

{$I ProjectDefine.inc}

type
  TFormMain = class(TForm)
   pTop: TPanel;
   bDoUpdate: TButton;
   mLog: TMemo;
   labDbInfo: TLabel;
   mDbInfo: TMemo;
    labIniFile: TLabel;
    labUpdateInfo: TLabel;
    Bevel1: TBevel;
    edtBaseDir: TDirectoryEdit;
    XPManifest1: TXPManifest;
   procedure bDoUpdateClick(Sender: TObject);
   procedure FormCreate(Sender: TObject);
   procedure AddToMemo(const aStr: string);
   procedure FormDestroy(Sender: TObject);
    procedure edtBaseDirAfterDialog(Sender: TObject; var Name: String;
      var Action: Boolean);
  private
   f_DbInfo: TDbInfo;
   procedure InitPaths(aPath: string);
  public
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
 l3Base,
 l3IniFile,
 l3FileUtils,
 UpdateManager,
 DT_DbReformer;

{$IFNDEF HT_MODE64}
const
 cWarnMessage = '��������!'#10#13'��� ��������� ��������� ���� �� ������ 113 ��� MAIN � 114 ��� GARANT.'+
            ' ��� ����, ����� �������� ���� �� ����� ������� ������, ����������� ��������� DbUpdate64.';
{$ENDIF}            

procedure TFormMain.AddToMemo(const aStr: string);
begin
 if aStr <> '' then
  mLog.Lines.Add(aStr);
 Application.ProcessMessages;
end;

procedure TFormMain.bDoUpdateClick(Sender: TObject);
var
 l_SavedCursor: TCursor;
begin
 mLog.Clear;
 l_SavedCursor := Screen.Cursor;
 Screen.Cursor := crHourGlass;
 bDoUpdate.Enabled := False;
 try
  with TUpdateManager.Create(f_DbInfo, AddToMemo) do
   try
    Execute;
   finally
    Free;
   end;
 finally
  {$IFNDEF HT_MODE64}
  AddToMemo(cWarnMessage);
  {$ENDIF}
  bDoUpdate.Enabled := True;
  Screen.Cursor := l_SavedCursor;
 end;
 
 // ���������� �������� � ��
 mDbInfo.Text := f_DbInfo.Data;
 // ���-���� ���������
 bDoUpdate.Enabled := (f_DbInfo.MainFolderVersion < TUpdateManager.MaxMainVersion) or
                       (f_DbInfo.FamilyFolderVersion < TUpdateManager.MaxGarantVersion);

end;

procedure TFormMain.FormCreate(Sender: TObject);
var
 l_Ini: TCfgList;
 l_Path: string;
begin
 l_Ini := TCfgList.Create;
 try
  l_Ini.Section := 'Configuration';
  l_Path := l_Ini.ReadParamStrDef('BasePath', '');
  edtBaseDir.Text := l_Path;
  InitPaths(l_Path);
 finally
  l3Free(l_Ini);
 end;

 labUpdateInfo.Caption := SysUtils.Format('��������� ��������� ����������'#13#10 +
                                          '���� ���������� �� ������ %d �'#13#10 +
                                          '���������������� ���� �� ������ %d',
                                          [TUpdateManager.MaxGarantVersion,
                                           TUpdateManager.MaxMainVersion]);
end;

procedure TFormMain.InitPaths(aPath: string);

var
 l_Ini: TCfgList;
begin
 if aPath = '' then
  Exit;
 try
  if Assigned(f_DbInfo) then
   FreeAndNil(f_DbInfo);
  f_DbInfo := TDbInfo.Make(aPath);
 
  // ���������� �������� � ��
  mDbInfo.Text := f_DbInfo.Data;
 
  mLog.Clear;
 
  {$IFDEF HT_MODE64}
  if (f_DbInfo.MainFolderVersion < 113) or (f_DbInfo.FamilyFolderVersion < 114) then
  begin
   AddToMemo('��������� DbUpdate64 ��������� ����, ������� � ������ 113 ��� MAIN � 114 ��� GARANT.'+
             ' �������� ���� �� ��������� �������� c ������� ��������� DbUpdate, � ����� ����� ��������� ���.');
   bDoUpdate.Enabled := False;
  end;
  {$ELSE}
  if (f_DbInfo.MainFolderVersion >= 113) and (f_DbInfo.FamilyFolderVersion >= 114) then
  begin
   AddToMemo(cWarnMessage);
   bDoUpdate.Enabled := False;
  end;
  {$ENDIF}

  // ���-���� ���������
  bDoUpdate.Enabled := (f_DbInfo.MainFolderVersion < TUpdateManager.MaxMainVersion) or
                       (f_DbInfo.FamilyFolderVersion < TUpdateManager.MaxGarantVersion);

  l_Ini := TCfgList.Create;
  try
   l_Ini.Section := 'Configuration';
   l_Ini.WriteParamStr('BasePath', aPath);
  finally
   l3Free(l_Ini);
  end;

 except
  on E: EDBInfoError do
   MessageDlg(E.Message, mtError, [mbOK], 0);
 end;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
 l3Free(f_DbInfo);
end;

procedure TFormMain.edtBaseDirAfterDialog(Sender: TObject;
  var Name: String; var Action: Boolean);
begin
 if Action then
  InitPaths(Name);
end;

end.

