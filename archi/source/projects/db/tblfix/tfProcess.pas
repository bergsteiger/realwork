unit tfProcess;

{ $Id: tfProcess.pas,v 1.2 2016/09/30 11:17:01 fireton Exp $ }

interface
uses
 HT_Const,
 l3ProtoObject;

type
 TtfProcessor = class(Tl3ProtoObject)
 private
  f_ReadPass: AnsiString;
  f_Struct    : array of HT_Const.ThtElementInfo;
  f_TableInfo : HT_Const.Table;
  f_TblName: AnsiString;
  f_WritePass: AnsiString;
  procedure InitHt;
  procedure CloseHt;
 protected
  procedure Cleanup; override;
 public
  constructor Create;
  procedure FixTable;
  procedure SetTable(const aTableName: AnsiString; const aReadPass: AnsiString = ''; const aWritePass: AnsiString = '');
 end;

procedure Msg(const aStr: AnsiString; const aCode: Integer = 0); 


implementation
uses
 Windows,
 HT_DLL,
 SysUtils,
 l3Base,
 l3Chars,
 l3String,
 l3FileUtils;

const
 cTempTableName = 'TFTMPTBL';

function DS(const aStr: string): string;
begin
 Result := l3ChangeCodePage(aStr, CP_RussianWin, CP_RussianDOS);
end;


procedure fn_OnIOError(fpFileName: PChar;
                       nIoCode:    SmallInt;
                       nDosError:  SmallInt); {$IFDEF HT_MODE64} stdcall {$ELSE} pascal {$ENDIF};
var
 l_Buff220: array[0..220] of Char;
begin
 htIOMessage(@l_Buff220);
 l3System.Msg2Log(l3ArrayToString(l_Buff220, 220));
end;

procedure fn_OnHtError(nMessID: SmallInt);  {$IFDEF HT_MODE64} stdcall {$ELSE} pascal {$ENDIF};
var
 l_Buff220: array[0..220] of Char;
begin
 // ������������ ������
 if nMessID in [
  72, // "������� ������������� � �����������" (��� ����� �� ������)
  25  // "Unique key doublet value found" - ��������� ��� ��������� ������,
      //   ��� ���� ��������� ��������� �������������, ��� ��� ����� �� ������������

 ] then
  Exit;

 htMessage(nMessID, @l_Buff220);
 l3System.Msg2Log(l3ArrayToString(l_Buff220, 220) + ' ��� ������: ' + IntToStr(nMessID));
end;

function fn_OnErrorRecord(nErrCode: SmallInt; fpRecord: Pointer; fpUser: Pointer): ERROR_MODE;
begin
 Result := ERROR_DELETE;
end;

constructor TtfProcessor.Create;
begin
 inherited;
 InitHt;
end;

procedure TtfProcessor.Cleanup;
begin
 CloseHt;
 inherited;
end;

procedure TtfProcessor.InitHt;
var
 l_Init :Init;
begin
 l3FillChar(l_Init, SizeOf(l_Init));
 with l_Init do
 begin
  nTableCnt      := 50;
  nTaskCnt       := 20;
  nHtCnt         := 4 + 20 * 6 + 1;
  nLockTimeOut   := 40;
  nPollDelay     := 40;
  nTransTimeOut  := 40;
  nTrsMode       := TRS_HARD;
  fpTmpPath      := nil;
  fpNetPath      := nil;
  fpTrtPath      := nil;
  fpNetName      := 'TBLFIXER';
  fpfInfo        := Pointer(-1);
  fpfIoMess      := @fn_OnIOError;
  fpfErrMess     := @fn_OnHtError;
  fpfPiStart     := Pointer(-1);
  fpfPiDraw      := Pointer(-1);
  fpfPiStop      := Pointer(-1);
  fpfYield       := Pointer(-1);
  gHeapCtrl      := 10000000;
  gHeapTask      := 120000;
 end;
 htGlobalInit(HInstance);
 htInit(@l_Init, SizeOf(l_Init));
end;

procedure TtfProcessor.CloseHt;
begin
try
 htShut;
 htGlobalShut;
except // ����� procedure TDbReformer.RecoverPriority; �������� ����� � ���� �������� � �� ������ ��������.
       //������� ��� � ����� ������ hytech ��� ��������
end;
end;

procedure TtfProcessor.FixTable;
var
 l_ErroneousRecCount: Integer;
 l_TableHandle: ThtTblHandle;
 l_TempTblName : AnsiString;
 l_TmpHandle: ThtTblHandle;
 l_Res: Integer;
 l_Sab: SAB;
 l_Zero: Int64;
begin
 if Length(f_Struct) = 0 then
  Exit;
 l_TempTblName := ConcatDirName(ExtractFilePath(f_TblName), cTempTableName);
 DeleteFilesByMask('', l_TempTblName+'.*');
 Msg('������ ��������� �������');
 l_Res := htTableCreate(PAnsiChar(l_TempTblName), LPELEMENT(f_Struct), Length(f_Struct), nil, PAnsiChar(f_ReadPass),
  PAnsiChar(f_WritePass), TAB_CREATE or TAB_SHARE or TAB_ANSI, l_TmpHandle);
 if l_Res <> 0 then
 begin
  Msg('���-�� ����� �� ���.', l_Res);
  Exit;
 end;

 try
  Msg('��������� �������� �������...');
  l_Res := htTableOpen(PAnsiChar(f_TblName), PAnsiChar(f_ReadPass), PAnsiChar(f_WritePass), TAB_SHARE, l_TableHandle);
  if l_Res <> 0 then
  begin
   Msg('���-�� ����� �� ���.', l_Res);
   Exit;
  end;
  try
   l_Zero := 0;
   htSearch(nil, l_Sab, l_TableHandle, 0, GREAT, @l_Zero, nil); // Select all
   try
    Msg(Format('� �������� ������� %d �������.', [l_Sab.gFoundCnt]));
    Msg('�������� ������ �� ��������� �������...');
    l_Res := htResultsToTable(l_Sab, l_TmpHandle, nil, @fn_OnErrorRecord, nil, nil, 0, False, False);
    if l_Res < 0 then
    begin
     Msg('�� ���������� �����������. :(', l_Res);
     Exit;
    end;
    l_ErroneousRecCount := l_Res;
   finally
    htClearResults(l_Sab);
   end;
  finally
   htTableClose(l_TableHandle);
  end;
  htSearch(nil, l_Sab, l_TmpHandle, 0, GREAT, @l_Zero, nil); // Select all
  try
   Msg(Format('���� ����������� %d �������.', [l_Sab.gFoundCnt]));
  finally
   htClearResults(l_Sab);
  end;
  if l_ErroneousRecCount > 0 then
   Msg(Format('������� %d ���������� �������.', [l_ErroneousRecCount]));
 finally
  htTableClose(l_TmpHandle);
 end;
 Msg('��������� ������������ ��������� �������...');
 l_Res := htUpdateTable(PAnsiChar(l_TempTblName), PAnsiChar(f_ReadPass), PAnsiChar(f_WritePass), True, False);
 if l_Res <> 0 then
 begin
  Msg('������ �� ������...', l_Res);
  Exit;
 end;
 Msg('������� ������ �������...');
 l_Res := htDropTable(PAnsiChar(f_TblName), PAnsiChar(f_ReadPass), PAnsiChar(f_WritePass));
 if l_Res <> 0 then
 begin
  Msg('�� ���������...', l_Res);
  Exit;
 end;
 Msg('��������������� ����� �������...');
 l_Res := htTableRename(PAnsiChar(l_TempTblName), PAnsiChar(f_ReadPass), PAnsiChar(f_WritePass), PAnsiChar(f_TblName));
 if l_Res <> 0 then
 begin
  Msg('�� ���������������...', l_Res);
  Exit;
 end;
 Msg('�������! ������� ��������.');
end;

procedure Msg(const aStr: AnsiString; const aCode: Integer = 0);
var
 l_Code: AnsiString;
 l_Message: AnsiString;
begin
 if aCode <> 0 then
  l_Code := '   ��� ������: '+IntToStr(aCode)
 else
  l_Code := '';
 l_Message := aStr + l_Code;
 Writeln(DS(l_Message));
 l3System.Msg2Log(l_Message);
end;

procedure TtfProcessor.SetTable(const aTableName: AnsiString; const aReadPass: AnsiString = ''; const aWritePass: AnsiString = '');
var
 l_ElementCount: Integer;
 l_TableHandle: HT_Const.THANDLE;
 l_Res: Integer;
begin
 f_TblName := aTableName;
 f_ReadPass := aReadPass;
 f_WritePass := aWritePass;
 l_Res:= htTableOpen(PAnsiChar(aTableName), PAnsiChar(aReadPass), PAnsiChar(aWritePass), TAB_SHARE, l_TableHandle);
 Msg('����������� �������� �������...');
 if l_Res = 0 then
 begin
  try
   if htTableInfo(l_TableHandle, f_TableInfo) = 0 then
   begin
    l_ElementCount := f_TableInfo.nFieldCnt +
                      f_TableInfo.nGroupCnt +
                      f_TableInfo.nSubstrCnt;
    SetLength(f_Struct, l_ElementCount);
    htTableElementList(l_TableHandle, HT_Const.LPELEMENT(f_Struct));
   end;
  finally
   htTableClose(l_TableHandle);
  end;
 end
 else
  Msg('������ �������.', l_Res);
end;

end.