unit dt_DictSync;

interface
Uses
 l3Base,
 l3Types,

 daTypes,

 dt_Types,
 dt_AttrSchema
 ;

type
 TdtDictSync = class(Tl3Base)
 private
  f_CorrectLinks: Boolean;
  f_DictFileMask: string;
  f_DictFolder: String;
  f_DictID: TdaDictionaryType;
  f_ErrorMessage: string;
//  f_LnkFileMask: string;
  function DictLinkFile: String;
  procedure pm_SetDictID(const aValue: TdaDictionaryType);
 protected
  function ChangeDict(aProgressProc: Tl3ProgressProc): Boolean;
  function CheckDict(aProgressProc: Tl3ProgressProc): Boolean;
  function ExportDict(aProgressProc: Tl3ProgressProc): Boolean;
  function ImportDict(aProgressProc: Tl3ProgressProc): Boolean;
  function ManualCorrectLinks(aProgressProc: Tl3ProgressProc): Boolean;
  function LockBase(aProgressProc: Tl3ProgressProc): Boolean;
  function MakeBackup(aProgressProc: Tl3ProgressProc): Boolean;
  function RestoreBackup(aProgressProc: Tl3ProgressProc): Boolean;
  function UnlockBase(aProgressProc: Tl3ProgressProc): Boolean;
 public
  function Execute(aDictID: TdaDictionaryType; aDictFolder: String; aCorrectLinks: Boolean): Boolean;
  property ErrorMessage: string read f_ErrorMessage;
 end;

implementation

Uses
 daDataProvider,
 dt_DictExport, dt_DictImport, dt_Dict, dt_Const, dt_Link, dt_LinkServ,
 l3FileUtils, l3ShellUtils,
 SysUtils, Controls, Dialogs,
 ddHTInit, ddUtils, ddProcessDlg, ddClientBaseEngine;

function TdtDictSync.ChangeDict(aProgressProc: Tl3ProgressProc): Boolean;
var
 l_DestFolder{, l_Mask}: String;
 l_Res: Integer;
begin
 Result:= False;
 l_DestFolder:= ConcatDirName(g_BaseEngine.DataParams.DocStoragePath, 'garant');
// l_Mask:= ConcatDirName(l_DestFolder, f_LnkFileMask);
 // ������� �����
 LinkServer(CurrentFamily).Links[f_DictID].Table.DropTblData;
 // ��������� ������� �������

 DictServer(CurrentFamily).DictTbl[f_DictID].CloseTbl;
 try
  CopyFilesByMask(f_DictFolder, l_DestFolder, f_DictFileMask+'.*');
 finally
  DictServer(CurrentFamily).DictTbl[f_DictID].OpenTbl;
 end;
 DictServer(CurrentFamily).ReloadDict(f_DictID);

 Result:= True;
end;

function TdtDictSync.CheckDict(aProgressProc: Tl3ProgressProc): Boolean;
var
 l_DictFileName, l_CurrentFileName, l_EtalonFileName: String;
begin
 Result := False;
 l_DictFileName:= f_DictFileMask + '.hdt';
 l_CurrentFileName:= ConcatDirName(ConcatDirName(g_BaseEngine.DataParams.DocStoragePath, 'garant'), l_DictFileName);
 l_EtalonFileName:= ConcatDirName(f_DictFolder, l_DictFileName);
 Result:= SizeOfFile(l_CurrentFileName) <> SizeOfFile(l_EtalonFileName);
 if not Result then
  f_ErrorMessage:= '������� ������������� ����������';
end;

function TdtDictSync.Execute(aDictID: TdaDictionaryType; aDictFolder: String; aCorrectLinks: Boolean): Boolean;
var
 l_Dlg: TddProcessDialog;
begin
 pm_SetDictID(aDictID);
 f_DictFolder:= aDictFolder;
 f_CorrectLinks:= aCorrectLinks;
 Result:= False;
 f_ErrorMessage:= '';
 l_Dlg:= MakeProcessDialog(Format('����������� ������� "%s"', [cDLPassports[aDictID].rName]),
          NewProcess('������ ���� ��� ������������� �������������', LockBase, False,
          NewProcess('�������� ������� �� ������������ ����������', CheckDict, False,
          NewProcess('�������� ��������� ����� �������', MakeBackup, False,
          NewProcess('������� ������ �� �������� �������', ExportDict, True,
          NewProcess('������ ������� �� ���������', ChangeDict, False,
          NewProcess('������ ����������� ����� ������', ManualCorrectLinks, False,
          NewProcess('������ ������ �� ��������� �������', ImportDict, True,
          NewProcess('������������ ����', UnlockBase, False
          )))))))));
 try
  Result:= l_Dlg.Execute;
 finally
  l3Free(l_Dlg);
 end;
end;

function TdtDictSync.ExportDict(aProgressProc: Tl3ProgressProc): Boolean;
begin
 ExportDictLink(DictServer(CurrentFamily), f_DictID, DictLinkFile, False, aProgressProc, True);
 Result:= True;
end;

function TdtDictSync.DictLinkFile: String;
begin
 ForceDirectories(ConcatDirName(GetWindowsTempFolder, 'DictSync'));
 Result := ConcatDirName(GetWindowsTempFolder, 'DictSync\'+f_DictFileMask + '.txt');
end;

function TdtDictSync.ImportDict(aProgressProc: Tl3ProgressProc): Boolean;
begin
 Result:= ImportDictLink(DictLinkFile, CurrentFamily, f_DictID, False, False, False, aProgressProc);
 DelDir(ConcatDirName(GetWindowsTempFolder, 'DictSync'));
end;

function TdtDictSync.ManualCorrectLinks(aProgressProc: Tl3ProgressProc): Boolean;
begin
 Result:= True;
 if f_CorrectLinks then
 begin
  // �������� � ������������, ����� �� �� �������� ���� �������
  if IsPositiveResult(MessageDlg('�� ������ ������ ��������� � ���� ������?', mtConfirmation, [mbYes, mbNo], 0)) then
  begin
   // ������� ����� � ������ � ����� ������� �� ������
   FileExecute('explorer.exe', ExtractFilePath(DictLinkFile), '', esNormal);
   MessageDlg(Format('������� ��������� � ���� %s'^M'� ������� ������ OK ��� �����������.', [DictLinkFile]), mtInformation, [mbOk], 0);
  end;
 end;
end;

function TdtDictSync.LockBase(aProgressProc: Tl3ProgressProc): Boolean;
begin
 Result := GlobalDataProvider.LockAll;
 if Result then
  GlobalDataProvider.UnLockAll;
end;

function TdtDictSync.MakeBackup(aProgressProc: Tl3ProgressProc): Boolean;
begin
 // ����� ������� ����� ������� � ������
 Result:= True;
end;

function TdtDictSync.RestoreBackup(aProgressProc: Tl3ProgressProc): Boolean;
begin
 Result := GlobalDataProvider.LockAll;
 if Result then
  GlobalDataProvider.UnLockAll;
end;

procedure TdtDictSync.pm_SetDictID(const aValue: TdaDictionaryType);
begin
 if f_DictID <> aValue then
 begin
  f_DictID := aValue;
  f_DictFileMask:= FamTblNames[cDLPassports[f_DictID].rDict]+IntToHex(CurrentFamily, 3);
//  f_LnkFileMask:= FamTblNames[cDLPassports[f_DictID].rLink]+IntToHex(CurrentFamily, 3)
 end;
end;

function TdtDictSync.UnlockBase(aProgressProc: Tl3ProgressProc): Boolean;
begin
 Result:= True;
 //GlobalDataProvider.UnLockAll;
end;

end.
