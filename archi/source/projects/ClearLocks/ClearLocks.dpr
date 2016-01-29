program ClearLocks;

// ���������, ��������� ���������� � ������� TABLE_NAME, ���������� � ����������
// ���� �� ������� DEAD_STATION_NAME.
// ������ ����� ��������� ������ ���������� (��, ��� ���������� �������):
//   exe_name  DEAD_STATION_NAME  LOCKS_DIR  TABLE_FULLPATH
//   , ��� LOCKS_DIR - ������� �����, ������ ��� "...\��\share"
// ������ ������� - ���������������� HyTech �� ����� ������� �������,
// �������-������� �������� �������, ������� HyTech.

// �������� �����, ������������ ����������:
// 0 - ��� OK
// ������������� - ��� ��� ������ HT-�������.
// ������������� - ��. Dt_Types

{ $Id: ClearLocks.dpr,v 1.4 2004/04/19 12:27:11 step Exp $ }
// $Log: ClearLocks.dpr,v $
// Revision 1.4  2004/04/19 12:27:11  step
// �� ������ ������ ��� �������� ����� ����������
//
// Revision 1.3  2004/02/16 10:48:19  step
// ������� ��������
//
// Revision 1.2  2004/01/27 14:40:24  step
// �������� ����� ��������
//

uses
  System, SysUtils, Windows,
  Ht_Dll, HT_Const,
  Dt_Types;

{$R *.res}

var
 l_Init :Init;
 l_StationName: string;
 l_LocksDir: string;
 l_Table: string;
 l_TableHandle: THANDLE;
 l_TempPath: array[1 .. MAX_PATH] of Char;
 l_Transaction: TRID;

 procedure fn_OnIOError(fpFileName: PChar; nIoCode:    SmallInt; nDosError:  SmallInt); pascal;
 begin
  ExitCode := -1;
 end;

 procedure fn_OnHtError(nMessID: SmallInt); pascal;
 begin
  ExitCode := nMessID;
 end;

begin
 if ParamCount < 3 then
  ExitCode := cNotEnoughParamsForCLProcess
 else
 begin
  l_StationName := ParamStr(1);
  l_LocksDir := ParamStr(2);
  l_Table := ParamStr(3);
  if not DirectoryExists(l_LocksDir) then
   ExitCode := cCLProcessGetWrongFullBasePath
  else
  begin
   GetTempPath(MAX_PATH, @l_TempPath);
   FillChar(l_Init, SizeOf(l_Init), #0);
   with l_Init do
   begin
    nTableCnt      := 50;
    nTaskCnt       := 20;
    nHtCnt         := 4 + 20 * 6 + 1;
    nLockTimeOut   := 40;
    nPollDelay     := 40;
    nTransTimeOut  := 40;
    nTrsMode       := TRS_HARD;
    fpTmpPath      := @l_TempPath;
    fpNetPath      := PChar(l_LocksDir);
    fpTrtPath      := PChar(l_LocksDir);
    fpNetName      := PChar(l_StationName);
    fpfInfo        := Pointer(-1);
    fpfIoMess      := @fn_OnIOError;
    fpfErrMess     := @fn_OnHtError;
    fpfPiStart     := Pointer(-1);
    fpfPiDraw      := Pointer(-1);
    fpfPiStop      := Pointer(-1);
    fpfYield       := Pointer(-1);
    gHeapCtrl      := 1000000;
    gHeapTask      := 120000;
   end;

   if htInit(@l_Init, SizeOf(l_Init)) = 0 then
   begin
    // ��������-�������� �������
    if htTableOpen(PChar(l_Table), nil, nil, TAB_SHARE, l_TableHandle) = 0 then
    begin
     if htIsNeedToRoll(l_TableHandle, l_Transaction) > 0 then
      htRollBackTransaction(l_Transaction);

     htTableClose(l_TableHandle);
    end;

    htShut;
   end; // if htInit
  end; // if DirectoryExists
 end; // if ParamCount
end.
