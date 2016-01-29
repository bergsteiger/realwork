unit dtbMain;

{ $Id: dtbMain.pas,v 1.7 2015/07/02 11:41:04 lukyanets Exp $ }

// $Log: dtbMain.pas,v $
// Revision 1.7  2015/07/02 11:41:04  lukyanets
// ��������� �������
//
// Revision 1.6  2014/10/08 13:07:25  lukyanets
// ��������� ��������� � ���������� �����
//
// Revision 1.5  2008/09/29 12:24:24  fireton
// - bugfix: ��������� ������������� ����
//
// Revision 1.4  2008/09/10 12:42:32  fireton
// - ��������������� �������� ���� �� ���������� �������
// - ����� ���������� ��������� ������ ��� �������������� ������
//
// Revision 1.3  2008/09/03 13:28:36  fireton
// - bugfix: �� ������������ ������
//
// Revision 1.2  2008/09/03 08:00:26  fireton
// - ������ ��� �� "[�������� �� ��������]"
//
// Revision 1.1  2008/09/02 15:04:02  fireton
// - ������ ������
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, StdCtrls;

type
  TMainForm = class(TForm)
    memLog: TMemo;
    Button1: TButton;
    XPManifest1: TXPManifest;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    f_AllDone: Boolean;
    { Private declarations }
    f_CSID_NEW: DWORD;
    f_FilesDone: Integer;
    procedure MsgToLog(aMsg: string);
    procedure CantStart(aMsg: string);
    function RenameOneTIF(const aFileName: String): Boolean;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
 l3Base,
 l3Types,
 l3IniFile,
 l3Tree_TLB,
 l3TreeInterfaces,
 l3FileUtils,

 daTypes,

 Dt_Types,
 DT_Const,
 DT_Dict,
 DT_Sab,
 DT_Serv,

 ddFileIterator,
 ddHTInit,

 vtDialogs
 ;


{$R *.dfm}

const
 sNewTitle = '[�������� �� ��������]';

procedure TMainForm.MsgToLog(aMsg: string);
begin
 memLog.Lines.Add(aMsg);
 l3System.Msg2Log(aMsg);
 Application.ProcessMessages;
end;

procedure TMainForm.CantStart(aMsg: string);
begin
 MsgToLog('�� ���� ������ ��������:');
 MsgToLog('  '+aMsg);
end;

procedure MyDelDir(FName : TFileName);
begin
 PureDir(FName);
 RmDir(FName);
end;

const
 tempdir     = '$TMPDIR6152$';
 tempdirnew  = '$TMPDIR7717$';
 tempfile    = 'file001';
 tempfilenew = 'file999';

function CheckImagePath(aDir: string): string;
var
 l_NewPath: string;
 l_F: File;
begin
 Result := '';
 {$I-}
 aDir := IncludeTrailingBackslash(aDir);
 try
  if DirExists(aDir+tempdir) then
   MyDelDir(aDir+tempdir);
  if DirExists(aDir+tempdirnew) then
   MyDelDir(aDir+tempdirnew);
 except
  Result := '���������� ������� ���� ��� �������������.';
  Exit;
 end;

 MkDir(aDir+tempdir);
 if IOResult <> 0 then
 begin
  Result := '���������� ������� �������������.';
  Exit;
 end;
 if not RenDir(aDir+tempdir, aDir+tempdirnew) then
 begin
  Result := '���������� ������������� �������������.';
  DelDir(aDir+tempdir);
  Exit;
 end;
 l_NewPath := IncludeTrailingBackslash(aDir+tempdirnew);
 AssignFile(l_F, l_NewPath+tempfile);
 Rewrite(l_F);
 if IOResult <> 0 then
 begin
  Result := '���������� ������� ����.';
  DelDir(ExcludeTrailingBackslash(l_NewPath));
  Exit;
 end;
 CloseFile(l_F);
 if not RenameFile(l_NewPath+tempfile, l_NewPath+tempfilenew) then
 begin
  Result := '���������� ������������� ����.';
  DelDir(ExcludeTrailingBackslash(l_NewPath));
  Exit;
 end;
 if FileSetAttr(l_NewPath+tempfilenew, faReadOnly or faArchive) <> 0 then
 begin
  Result := '���������� ������� �������� �����.';
  DelDir(ExcludeTrailingBackslash(l_NewPath));
  Exit;
 end;
 FileSetAttr(l_NewPath+tempfilenew, faArchive);
 if not DeleteFile(l_NewPath+tempfilenew) then
 begin
  Result := '���������� ������� ����.';
  Exit;
 end;
 RmDir(ExcludeTrailingBackslash(l_NewPath));
 if IOResult <> 0 then
  Result := '���������� ������� �������������.';
 {$I+}
end;


procedure TMainForm.Button1Click(Sender: TObject);
var
 l_CSTbl: TDictionaryTbl;
 l_RecNo: Longint;
 l_CSID    : DWORD;
 l_Sab: ISab;
 l_ByteValue: Byte;
 l_Node: Il3Node;
 l_ImageStoragePath: ShortString;
 l_CSPathOld, l_CSPathNew: string;
 l_Iterator: TddFileIterator;
 l_StrValue: string;
 l_DictItem: TDictItem;
 l_LeafNode: TDictLeafNode;
 l_DirCheckStr: string;
begin
 Screen.Cursor := crHourGlass;
 Button1.Enabled := False;
 f_AllDone := True;
 try
  DictServer.Family := CurrentFamily;
  l_CSTbl := DictServer.DictTbl[da_dlCorSources];
  l_CSID := 0;
  l_RecNo := l_CSTbl.GetRecordIDByUniq(dtIDfld, l_CSID);
  if l_RecNo = 0 then
  begin
   CantStart('� ���� ����������� �������� "�� ��������" (ID = 0)');
   Exit;
  end;
  ServerConfig.Section := Dt_Const.BaseSection;
  ServerConfig.ReadParamStr('ImageStoragePath', l_ImageStoragePath);
  if not DirExists(l_ImageStoragePath) then
  begin
   CantStart('�� ������� ����� ������� ���������� (ImageStoragePath)');
   Exit;
  end;

  l_DirCheckStr := CheckImagePath(l_ImageStoragePath);
  if l_DirCheckStr <> '' then
  begin
   CantStart('������������ ���� �� ���������� �������� �������: '+l_DirCheckStr);
   Exit;
  end;

  try
   MsgToLog('�������� ����� ID');
   f_CSID_NEW := GlobalHtServer.FreeTbl[CurrentFamily].GetFree(FamTblNames[ftDtA]);
   MsgToLog(Format(' + ����� ID: %d', [f_CSID_NEW]));

   MsgToLog('������������ ������ � DT#A');
   l_CSTbl.GetFullRec(l_RecNo, True);
   l_CSTbl.PutToFullRec(dtIDFld, f_CSID_NEW);
   l_ByteValue := 1;
   l_StrValue := sNewTitle;
   l_CSTbl.PutToFullRec(dtIsPrivate, l_ByteValue);
   l_CSTbl.PutToFullRec(dtIsNonperiodic, l_ByteValue);
   l_CSTbl.PutToFullRec(dtNameRFld, l_StrValue);
   l_CSTbl.UpdFRec(l_RecNo);
   l_CSTbl.FreeRec(l_RecNo);


   MsgToLog('������������ ������ � DT#B');

   l_Sab := MakeSab(DictServer.DictTbl[da_dlPublisheds]);
   l_Sab.Select(piSourFld, l_CSID);
   l_Sab.ModifyRecs(piSourFld, f_CSID_NEW);
   l_Sab := nil;

   MsgToLog('���������� ID � ��������� ������');
   MsgToLog(' + �������� ������...');
   l_Node := DictServer.Dict[da_dlCorSources].FindNodeByID(0);
   if l_Node <> nil then
   begin
    (l_Node as Il3HandleNode).Handle := f_CSID_NEW;
    DictServer.Dict[da_dlCorSources].RootNode.Save(nil, True);
    MsgToLog(' + ID ������ � �������');
   end
   else
    MsgToLog(' - �� ������ ������ �������');

   MsgToLog('��������� ���� ������');
   DoneClientBaseEngine;

   MsgToLog('��������������� ����� �������');
   l_CSPathOld := IncludeTrailingBackslash(l_ImageStoragePath)+'@';
   if DirExists(l_CSPathOld) then
   begin
    MsgToLog(' + �������������� ����� "@"...');
    l_CSPathNew := IncludeTrailingBackslash(l_ImageStoragePath) + IntToStr(f_CSID_NEW);
    RenDir(l_CSPathOld, l_CSPathNew);
    MsgToLog(' + �������������� ������ �������...');
    l_Iterator := TddFileIterator.Create(nil);
    try
     l_Iterator.Directory := l_CSPathNew;
     l_Iterator.FileMask := '*.tif';
     l_Iterator.LoadFiles;
     MsgToLog(Format(' + %d ������ �������', [l_Iterator.FileList.Count]));
     f_FilesDone := 0;
     l_Iterator.IterateFiles(RenameOneTIF);
     if (f_FilesDone mod 100) <> 0 then
      MsgToLog(Format('   * %d ������ ����������', [f_FilesDone]));
    finally
     l3Free(l_Iterator);
    end;
   end
   else
    MsgToLog(' - ����� "@" �� ������� � ���������� '+l_ImageStoragePath);

  except
   on E: Exception do
   begin
    MsgToLog('������ ��� ���������� ��������');
    MsgToLog('�������: '+E.Message);
    MsgToLog('���������� ���������� �������� :(');
    Exit;
   end;
  end;
  if f_AllDone then
   MsgToLog('�������� ��������� �������')
  else
   MsgToLog('�������� ��������� � �������.')
 finally
  Screen.Cursor := crDefault;
  Button1.Enabled := True;
 end;
end;

function TMainForm.RenameOneTIF(const aFileName: String): Boolean;
var
 l_Dir: string;
 l_Name: string;
 l_NewFileName : string;
 l_Msg: string;
begin
 Result := True;
 l_Dir := ExtractFilePath(aFileName);
 l_Name := ExtractFileName(aFileName);
 l_Name := Format('[%d] %s', [f_CSID_NEW, l_Name]);
 l_NewFileName := l_Dir + l_Name;
 if not RenameFile(aFilename, l_NewFileName) then
 begin
  FileSetAttr(aFileName, faArchive);
  if not RenameFile(aFileName, l_NewFileName) then
  begin
   l_Msg := '������ �������������� ����� '+aFileName;
   MsgToLog(l_Msg);
   if vtMessageDlg(l3CStr(l_Msg+'. ����������?'), mtError, [mbYes, mbAbort]) = mrAbort then
   begin
    f_AllDone := False;
    Result := False;
   end;
  end
  else
   Inc(f_FilesDone);
 end
 else
  Inc(f_FilesDone);
 if (f_FilesDone mod 100) = 0 then
  MsgToLog(Format('   * %d ������ ����������', [f_FilesDone]));
end;

procedure TMainForm.FormShow(Sender: TObject);
var
 l_Str: ShortString;
begin
 ServerConfig.Section := Dt_Const.FamilySection;
 ServerConfig.ReadParamStr('FamilyPath', l_Str);
 MsgToLog('���� � ���� ������   : '+l_Str);
 ServerConfig.Section := Dt_Const.BaseSection;
 ServerConfig.ReadParamStr('ImageStoragePath', l_Str);
 MsgToLog('���� � ������ �������: '+l_Str);
end;

end.


