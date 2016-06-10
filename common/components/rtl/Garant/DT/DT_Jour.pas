Unit DT_Jour;

{ $Id: DT_Jour.pas,v 1.56 2016/06/09 08:51:57 voba Exp $ }

// $Log: DT_Jour.pas,v $
// Revision 1.56  2016/06/09 08:51:57  voba
// -k:623267081
//
// Revision 1.55  2016/05/26 14:01:24  voba
// -k:623267081
//
// Revision 1.54  2016/05/17 11:59:35  voba
// -k:623081921
//
// Revision 1.53  2015/06/08 12:44:07  voba
// -������� ��������
//
// Revision 1.49  2015/05/26 15:18:08  lukyanets
// ������ ������� ����� �������
//
// Revision 1.48  2015/05/26 12:10:58  voba
// - k:600314998
//
// Revision 1.47  2014/02/14 15:33:45  lulin
// - ����������� �� ������ ���������.
//
// Revision 1.46  2013/11/12 09:57:41  dinishev
// ����� Exception � ��������� � ������ ������� ��� �������� ���� - ��� ����� ���� ����� �����.
//
// Revision 1.45  2010/04/05 06:31:04  voba
// - remove debug checks
//
// Revision 1.44  2010/03/30 11:12:37  voba
// - ������� trunk ����� �� ������������ �����
//
// Revision 1.42  2010/03/25 09:44:49  voba
// K:197496324
//
// Revision 1.41  2010/03/25 09:43:49  voba
// K:197496324
//
// Revision 1.40  2010/03/22 18:12:52  voba
// no message
//
// Revision 1.39  2010/03/22 17:48:03  voba
// K:197496324
//
// Revision 1.38  2010/03/22 17:47:02  voba
// K:197496324
//
// Revision 1.37  2010/03/17 15:42:31  voba
// K:197496324
//
// Revision 1.35  2010/01/22 12:17:59  voba
// - enh : ���������� exeption ���� �� ������� ��������� ������
//
// Revision 1.34  2009/12/11 11:55:37  voba
// no message
//
// Revision 1.33  2009/12/10 15:59:05  voba
// - bug fi� ����� �������� ���� ����� ����������
//
// Revision 1.32  2009/11/20 13:51:56  voba
// - bug fix
//
// Revision 1.31  2009/11/20 13:43:21  voba
// - bug fix: Tl3BuuferedFilter �� ��������� �������� � ������ ��������, ��������, ��������. �������� ������� � DT_Jour ����������� ������������
//
// Revision 1.30  2009/11/18 10:14:12  voba
// - opt.
//
// Revision 1.29  2009/11/17 16:15:16  voba
// - ����� ����������� ������ ������� ��-�� ��������
//
// Revision 1.28  2009/10/14 11:07:27  voba
// - ����������� �� ���������� mg
//
// Revision 1.27  2008/02/20 11:41:02  lulin
// - bug fix: �� ��������� ����������.
//
// Revision 1.26  2008/02/04 15:22:57  lulin
// - bug fix: �� ���������� ������.
//
// Revision 1.25  2008/02/01 16:41:34  lulin
// - ���������� �������� ������.
//
// Revision 1.24  2007/11/22 14:38:58  fireton
// - �������� ���������� � ���� �������������, ����������� ��������
//
// Revision 1.23  2007/08/14 20:25:14  lulin
// - bug fix: �� ���������� ����������.
//
// Revision 1.22  2007/08/14 14:30:07  lulin
// - ������������ ����������� ������ ������.
//
// Revision 1.21  2007/03/26 09:34:03  fireton
// - ��������� ������ l3System.FreeLocalMem
//
// Revision 1.20  2005/10/17 11:30:35  voba
// no message
//
// Revision 1.19  2004/09/21 12:04:20  lulin
// - Release ������� �� Cleanup.
//
// Revision 1.18  2004/08/03 08:52:50  step
// ������ dt_def.pas �� DtDefine.inc
//
// Revision 1.17  2004/03/05 16:54:43  step
// ������ ����
//
// Revision 1.16  2004/02/16 10:54:54  step
// add: TAbstractJournal.ClearDeadRecs
//
// Revision 1.15  2003/10/31 17:20:43  voba
// - bug fix
//
// Revision 1.14  2003/10/18 12:43:39  voba
// -bug fix
//
// Revision 1.13  2003/10/02 13:53:37  voba
// -enhance: ������� ������� ���� �������, �������� ����� ��� dtlPrevent - ������������� ������ � ������ �������, �� ����������� ��� ������� �� �����
//
// Revision 1.12  2003/03/31 13:48:59  demon
// - new: �������� ������ �������, ���������� �� ��������� � 64�� �� 8��
//
// Revision 1.11  2002/12/24 13:02:00  law
// - change: ��������� Int64_Seek c �������� ������.
//
// Revision 1.10.4.1  2002/12/24 11:56:43  law
// - new behavior: ���������� 64-������ Seek ������ 32-�������.
//
// Revision 1.10  2002/02/11 14:30:49  voba
// -lib sincro : change some m0 modules to m2
//
// Revision 1.9  2000/12/15 15:36:16  law
// - ��������� ��������� Log.
//

{$I DtDefine.inc}
{.$Define LockDebug}
Interface
Uses
 Dt_Types,
 //MGExFStr,MGBufStr,mgLckStr,
 SysUtils,
 l3Base,
 l3Stream,
 l3DatLst,
 l3IDList,
 l3RecList,
 l3BufferStream;

Const
 cHeaderSize = 12;
 cHeader  : Array[1..cHeaderSize] of Char = 'Lock Journal';
 cVersion : Char = #03;

type
 TIDType      = Longint;
 TSysData     = Longint;
 TdtLockType = (dtlUsual,dtlExclusive,dtlPrevent);
 {* - dtlUsual - �������,
      dtlExclusive - ������(�� ��������� ������� ������ �������� ���������),
      dtlPrevent - ������������� ������ � ������ �������, ��� ������� ������� ���������}

 PJourRec = ^TJourRec;
 TJourRec = packed record
  rStationName : Int64; //TStationID;
  rDocID       : TIDType;
  rLockType    : TdtLockType;
  rSysData     : TSysData;
 end;

 TdtJIAccessFunc = function(var aRec : TJourRec; aPos : Longint) : Boolean; register;

 TCompareSysDataFunc = function(Var OldSysData, NewSysData) : Boolean of object;

 EdtBrokenFileLock = class(Exception);

 TAbstractJournal = Class(Tl3Base)
  private
   fLockCnt      : LongInt;
   fJourFl       : Tl3NewBufferStream;
   fJourName     : TPathStr;

   fStName       : Int64;

   fHeaderSize   : LongInt;

   fCompareSysData  : TCompareSysDataFunc;

   function WriteLockRec(aPos : Longint; aRec : TJourRec; aNeedWriteStopLabel : boolean = false) : Longint;
  protected
   procedure BeforeRelease; override;
   procedure Cleanup; override;

   procedure IterateRecF(aFunc : TdtJIAccessFunc);

   procedure JFLock;
   procedure JFUnlock;

  public
   Constructor Create(aStationName  : TStationID;
                      aJourFullName : TPathStr); Reintroduce;

   function    Lock(aID : TIDType; var aSysData : TSysData; aLockType : TdtLockType = dtlUsual) : TJLHandle;
   procedure   BatchLock(var aDocList : Il3IDList; aRightsNeeded: TSysData; var aRejectedDocs : Il3IDList; var aLockHandles: Il3IDList);

   procedure   UnLock(aLH : TJLHandle);
   procedure   BatchUnLock(aLockHandles: Il3IDList);

   procedure   SetNewSysData(aLH : TJLHandle; var aSysData : TSysData);

   procedure   IterateLockRecF(aFunc : TdtJIAccessFunc);

   function    CheckLock(aID : TIDType; aLockInfoList : Tl3RecList; aIgnoredLockHandle : TJLHandle = -1): Boolean; overload;
   function    CheckLock(aID : TIDType; aStationName : Int64 = 0) : TJLHandle; overload;

   procedure   ClearDeadRecs(aActiveStations: Tl3StringDataList);
    // �������� �������, ���������� �� ������� ������� (���, ������� �� ������ � aActiveStations)
   procedure ClearBadJourRec;

   property    CompareSysData : TCompareSysDataFunc read fCompareSysData write fCompareSysData;
   property    StName : Int64 read fStName;
 end;

 function L2JIAccessFunc(Action: Pointer): TdtJIAccessFunc; register;

 const
 cStopLockType : TdtLockType = TdtLockType($ff); // ����������� ��������, ���������� ��� �� ������ ������� "�����" (��������) ���.

Implementation

Uses
 vtDebug,
 Classes,
 l3Types, l3MinMax,
 m0Const,
 m2xltlib,
 Dt_Const;

const
 sJourFileBroken = '�������� �������� ��������� ����� �������!'#13+'��������� � ��������������.';
 sJourFileBrokenP = '�������� ��������� ����� �������'#13+'��������� � ��������������. P=%d';

 //cStopLockType : TdtLockType = TdtLockType($ff); // ����������� ��������, ���������� ��� �� ������ ������� "�����" (��������) ���.

{$IFDEF LOCKDEBUG}
procedure Check(aHandle : TJLHandle);
begin
 Assert(((aHandle - 13) mod 17) = 0, Format(sJourFileBrokenP, [aHandle]));
end;
{$ENDIF LOCKDEBUG}

function L2JIAccessFunc(Action: Pointer): TdtJIAccessFunc; register;
asm
 jmp  l3LocalStub
end;{asm}

procedure FreeJIAccessFunc(var Stub: TdtJIAccessFunc); register;
asm
 jmp  l3FreeLocalStub
end;{asm}

function MakeLockRec(aStationName : Int64; aDocID : TIDType; aLockType : TdtLockType; aSysData : TSysData) : TJourRec;
begin
 With Result do
 begin
  rStationName := aStationName;
  rDocID       := aDocID;
  rLockType    := aLockType;
  rSysData     := aSysData;
 end;
end;

Constructor TAbstractJournal.Create(aStationName  : TStationID;
                                    aJourFullName : TPathStr);
Var
 TmpVer : Char;
 lStream : Tl3FileStream;
begin
 Inherited Create;
 fHeaderSize := cHeaderSize + 1;

 m2XLTConvertBuff(@aStationName, SizeOf(TStationID), Cm2XLTANSI2UPPER);
 fStName := PInt64(@aStationName)^;

 fJourName:=aJourFullName;

 if not FileExists(fJourName) then
 begin
  lStream := Tl3FileStream.Create(fJourName, l3_fmFullShareCreateReadWrite);
  lStream.Write(cVersion, 1);
  lStream.Write(cHeader, cHeaderSize);
 end
 else
 begin
  lStream := Tl3FileStream.Create(fJourName, l3_fmFullShareReadWrite);
  lStream.ReadBuffer(TmpVer, 1);

  if TmpVer <> cVersion then
  begin
   l3Free(fJourFl);
   lStream := Tl3FileStream.Create(fJourName, l3_fmFullShareCreateReadWrite);
   lStream.Write(cVersion, 1);
   lStream.Write(cHeader, cHeaderSize);
  end;
 end;

 try
  fJourFl := Tl3NewBufferStream.Create(lStream);
 finally
  l3Free(lStream);
 end;

 fLockCnt := 0;
end;

procedure TAbstractJournal.BeforeRelease;
begin
 //try
  //ClearBadJourRec;
 //finally
  Inherited;
 //end;
end;

procedure TAbstractJournal.Cleanup;
begin
 l3Free(fJourFl);
 Inherited;
end;

procedure TAbstractJournal.JFLock;
begin
 if fLockCnt = 0 then
  if not Tl3FileStream(fJourFl.InnerStream).Lock(1, cHeaderSize, 3*60*1000 {3 ���}) then
   raise Exception.Create('������ �������� ����������.');
 Inc(fLockCnt);
end;

procedure TAbstractJournal.JFUnlock;
begin
 Dec(fLockCnt);
 if fLockCnt = 0 then
 begin
  fJourFl.Flush;
  Tl3FileStream(fJourFl.InnerStream).UnLock(1, cHeaderSize);
 end;
end;

procedure TAbstractJournal.IterateRecF(aFunc : TdtJIAccessFunc);
var
 lBuff : array[0..1000] of TJourRec;
 lBuffCnt : Integer;
 lStreamPos : Int64;
 lRSize : Integer;
 I : Integer;

begin
 try
  fJourFl.Seek(fHeaderSize, soBeginning);

  while true do
  begin
   lStreamPos := fJourFl.Position;
   lRSize := fJourFl.Read(lBuff, SizeOf(lBuff));

   if lRSize = 0 then // ���� ��������
    Exit;

   if (lRSize mod SizeOf(TJourRec)) <> 0 then
    raise EdtBrokenFileLock.Create(sJourFileBroken);

   lBuffCnt := lRSize div SizeOf(TJourRec);

   for I := 0 to pred(lBuffCnt) do
    if not aFunc(lBuff[I], lStreamPos + I * SizeOf(TJourRec)) then
      exit;

   // ����������� �������, ������� ����� ��������� � �������������� �������
   fJourFl.Seek(lStreamPos + lRSize, soBeginning);
  end;

 finally
  FreeJIAccessFunc(aFunc);
 end;
end;

procedure TAbstractJournal.IterateLockRecF(aFunc : TdtJIAccessFunc);
begin
JFLock;
 try
  {$IFDEF LOCKDEBUG}
   check(fJourFl.Size);
  {$ENDIF LOCKDEBUG}
  IterateRecF(aFunc);
  {$IFDEF LOCKDEBUG}
   check(fJourFl.Size);
  {$ENDIF LOCKDEBUG}
 finally
  JFUnlock;
 end;
end;

procedure TAbstractJournal.ClearBadJourRec;

 function lJIAccessProc(var aRec : TJourRec; aPos : Longint) : Boolean;
 begin
  Result := not ((aRec.rStationName = cDelStationID) and (aRec.rLockType = cStopLockType)); // ����� ��������� �������� ����� �����
  if not Result then Exit;

  if aRec.rStationName = fStName then
   begin
    aRec.rStationName := cDelStationID;
    fJourFl.Seek(aPos, soBeginning);
    try
     fJourFl.Write(aRec, SizeOf(TJourRec));
    except
     raise EdtBrokenFileLock.Create(sJourFileBroken);
    end;
   end;
 end;

begin
 JFLock;
 try
  {$IFDEF LOCKDEBUG}
   check(fJourFl.Size);
  {$ENDIF LOCKDEBUG}
  IterateRecF(L2JIAccessFunc(@lJIAccessProc));
  {$IFDEF LOCKDEBUG}
   check(fJourFl.Size);
  {$ENDIF LOCKDEBUG}
 finally
  JFUnlock;
 end;
end;

procedure TAbstractJournal.ClearDeadRecs(aActiveStations: Tl3StringDataList);

 function lJIAccessProc(var aRec : TJourRec; aPos : Longint) : Boolean;
 var
  l_Tmp: Longint;
 begin
  Result := not ((aRec.rStationName = cDelStationID) and (aRec.rLockType = cStopLockType)); // ����� ��������� �������� ����� �����
  if not Result then Exit;

  if not aActiveStations.FindStr(@(aRec.rStationName), l_Tmp) then
  begin
   aRec.rStationName := cDelStationID;
   fJourFl.Seek(aPos, soBeginning);
   try
    fJourFl.Write(aRec, SizeOf(TJourRec));
   except
    raise EdtBrokenFileLock.Create(sJourFileBroken);
   end;
  end;
 end;

begin
 // ��� �� �������� ������ ��� � rStationName ��� ���� �� �����, FindStr �� ������.
 // ����� aActiveStations ���������� �� Reclist
 Assert(false, 'TAbstractJournal.ClearDeadRecs');

 JFLock;
 try
  {$IFDEF LOCKDEBUG}
   check(fJourFl.Size);
  {$ENDIF LOCKDEBUG}
  IterateRecF(L2JIAccessFunc(@lJIAccessProc));
  {$IFDEF LOCKDEBUG}
   check(fJourFl.Size);
  {$ENDIF LOCKDEBUG}
 finally
  JFUnlock;
 end;
end;

procedure TAbstractJournal.BatchLock(var aDocList : Il3IDList; aRightsNeeded: TSysData; var aRejectedDocs : Il3IDList; var aLockHandles: Il3IDList);
 var
  lLockedList : Il3IDList;
  lNeedWriteStopLabel : boolean;
  lListIndex : Integer;

 function lCheckRights(aOldSysData, aNewSysData : TSysData) : Boolean;
 begin
  Result := (aOldSysData = acFullBlock) or ((aOldSysData and aNewSysData) <> 0);
 end;

 function lCheckRightProc(var aRec : TJourRec; aPos : Longint) : Boolean;
 begin
  Result := not ((aRec.rStationName = cDelStationID) and (aRec.rLockType = cStopLockType)); // ����� ��������� �������� ����� �����
  if not Result then Exit;

  if (aRec.rStationName <> cDelStationID) and lCheckRights(aRec.rSysData, aRightsNeeded) then
   lLockedList.Add(aRec.rDocID);
 end;

 function lWriteLockProc(var aRec : TJourRec; aPos : Longint) : Boolean;
 begin
  if (aRec.rStationName = cDelStationID) and (aRec.rLockType = cStopLockType) then // ����� ��������� �������� ����� �����
   lNeedWriteStopLabel := True;

  Result := lListIndex < Pred(aDocList.Count);

  if (aRec.rStationName = cDelStationID) then
  begin
   WriteLockRec(aPos, MakeLockRec(fStName, aDocList[lListIndex], dtlUsual {aLockType}, aRightsNeeded), lNeedWriteStopLabel and Result);
   aLockHandles.Add(aPos);
   Inc(lListIndex);
  end;
 end;

var
 lTime : Cardinal;
begin
 lLockedList := l3MakeIDList;

 JFLock;
 lTime := dbgStartTimeCounter;
 try
  //��������� ������ ����������� � ���������� �������
  IterateRecF(L2JIAccessFunc(@lCheckRightProc));
  lLockedList.AndList(aDocList);

  aRejectedDocs.MergeList(lLockedList);
  aDocList.SubtractList(lLockedList);

  if aDocList.Count = 0 then exit;
  //���������� ������� ������
  lListIndex := 0;
  lNeedWriteStopLabel := false;
  lTime := dbgStartTimeCounter;
  IterateRecF(L2JIAccessFunc(@lWriteLockProc));
  while lListIndex < aDocList.Count do // ���������� �����
  begin
   WriteLockRec(-1, MakeLockRec(fStName, aDocList[lListIndex], dtlUsual {aLockType}, aRightsNeeded));
   Inc(lListIndex);
  end;
 finally
  l3System.Msg2Log('BatchLock  = %S', [dbgFinishTimeCounter(lTime)]);
  JFUnlock;
 end;
end;

function TAbstractJournal.WriteLockRec(aPos : Longint; aRec : TJourRec; aNeedWriteStopLabel : boolean) : Longint;
 begin
   if aPos = -1 then
   begin
    fJourFl.Seek(0, soEnd);
    {$IFDEF LOCKDEBUG}
     Check(fJourFl.Position);
    {$ENDIF LOCKDEBUG}
   end
   else
   begin
    fJourfl.Seek(aPos, soBeginning);
    {$IFDEF LOCKDEBUG}
     Check(fJourFl.Position);
    {$ENDIF LOCKDEBUG}
   end;

   Result := fJourFl.Position;
   fJourFl.Write(aRec, SizeOf(TJourRec));

   if aNeedWriteStopLabel and (fJourFl.Position < fJourFl.Size) then
   begin
    with aRec do
    begin
     rStationName := cDelStationID;
     rDocID := 0;
     rLockType := cStopLockType;
    end;
    fJourFl.Write(aRec, SizeOf(TJourRec));
   end;
 end;

function  TAbstractJournal.Lock(aID : TIDType; var aSysData : TSysData; aLockType : TdtLockType = dtlUsual) : TJLHandle;
var
 lSavePos : Longint;
 //lLastFreeChunkPos : Longint;  // ��������� �� ����� �� ������
 lNeedWriteStopLabel : boolean;
 lLockFailure : boolean; //��� ���-�� ��������
 lAlreadyLock : boolean; // ����� ���� �������

 function lJIAccessProc(var aRec : TJourRec; aPos : Longint) : Boolean;
 begin
  Result := True;

  if aRec.rStationName <> cDelStationID then
  begin
   //lLastFreeChunkPos := -1;
   if aRec.rDocID = aID then
   begin
    if (aRec.rLockType = dtlPrevent) and (aRec.rStationName = fStName) then
     Exit;  //���� Prevent ������� ��� �� ������

    if (aRec.rLockType = dtlPrevent) //����� Prevent �������, � � ���� �� ��� ��������� ����
       or
       (aLockType = dtlExclusive) //������� �� Prevent (����� �� ������ ������), � �� ������ � ����������
       or
       (aRec.rLockType = dtlExclusive) then //Exclusive �������
     begin
      Result := False; // ����� ������������
      lLockFailure := True;
     end
     else
      if (aLockType = dtlUsual) then //(aRec.LockType = dtlUsual) and //��� � ��� �������, �. �. ��������� ���� ������� ���������� ����
       begin
        if (aRec.rStationName = fStName) then //���, � ����������� ������ ��� ������ �����������
        begin
         Result := False; // ����� ������������
         lAlreadyLock := True;
         aSysData := aRec.rSysData; // ������� �� �� �����, ��� � � ������� ���
         lSavePos := aPos;
        end
        else // �����
         if (not Assigned(fCompareSysData) or fCompareSysData(aRec.rSysData, aSysData)) then //��� ����� ��� ���������
         begin
          Result := False; // ����� ������������
          lLockFailure := True;
         end;
     end; //if ((aLockType = dtlUsual)
   end; //if aRec.rDocID = aID then
  end
  else //aRec.rStationName <> cDelStationID
  begin
   if lSavePos = -1 then
   begin
    lSavePos := aPos;
    lNeedWriteStopLabel := (aRec.rLockType = cStopLockType); // ����� ����������� ����� ��������� �������� ����� �����
   end;

   if (aRec.rLockType = cStopLockType) then // ����� ��������� �������� ����� �����
    Result := False; // ����� ������������
  end;
 end;

 {$IFDEF LOCKDEBUG}
var
 lSaveSize : Integer;
 {$ENDIF LOCKDEBUG}

begin
 Result := -1;
 lLockFailure := False;
 lAlreadyLock := False;
 lSavePos := -1;
 lNeedWriteStopLabel := false;
 //lLastFreeChunkPos := -1;
 JFLock;
 {$IFDEF LOCKDEBUG}
 check(fJourFl.Size);
 //l3System.Msg2Log('Lock Size = %d', [fJourFl.Size  - 13 div 17]);
 lSaveSize := fJourFl.Size;
 {$ENDIF LOCKDEBUG}

 try
  try
   IterateRecF(L2JIAccessFunc(@lJIAccessProc));

   if lLockFailure then
    Exit;

   if lAlreadyLock then
   begin
    Result := lSavePos;
    Exit;
   end;

   Result := WriteLockRec(lSavePos, MakeLockRec(fStName, aID, aLockType, aSysData), lNeedWriteStopLabel);

  finally
   If Result = -1 then
   {$IFDEF LOCKDEBUG}
    try
   {$ENDIF LOCKDEBUG}
    l3FillChar(aSysData, SizeOf(aSysData));
   {$IFDEF LOCKDEBUG}
    except
     l3System.Msg2Log('Lock �������� � l3FillChar');
     Raise;
    end;
   {$ENDIF LOCKDEBUG}
  end;

  {$IFDEF LOCKDEBUG}
  check(fJourFl.Size);
  try
   if lSaveSize = fJourFl.Size then
    l3System.Msg2Log('Lock Size = %d, LH = %d', [(fJourFl.Size - 13) div 17, (Result - 13) div 17])
   else
    l3System.Msg2Log('Lock Size = %d > %d, LH = %d', [(lSaveSize - 13) div 17, (fJourFl.Size - 13) div 17, (Result - 13) div 17]);
  except
   l3System.Msg2Log('Lock �������� � l3System.Msg2Log');
   l3System.Msg2Log('Lock ss = %d', [lSaveSize]);
   l3System.Msg2Log('Lock lh = %d', [Result]);
   l3System.Msg2Log('Lock s = %d',  [fJourFl.Size]);
   Raise;
  end;
  {$ENDIF LOCKDEBUG}
 finally
  JFUnlock;
 end;
end;

procedure TAbstractJournal.SetNewSysData(aLH : TJLHandle; var aSysData : TSysData);
begin
 {$IFDEF LOCKDEBUG}
 check(aLH);
 check(fJourFl.Size);
 Assert(fJourFl.Size > aLH, 'NewSysData: aLH outside Size');
 {$ENDIF LOCKDEBUG}

 JFLock;
 try
  fJourFl.Seek(aLH + Longint(@(PJourRec(nil)^.rSysData)) {SysDataOffset} ,soBeginning);
  fJourFl.Write(aSysData, SizeOf(TSysData));
  {$IFDEF LOCKDEBUG}
   Check(fJourFl.Size);
  {$ENDIF LOCKDEBUG}
 finally
  JFUnlock;
 end;
end;

procedure TAbstractJournal.UnLock(aLH : TJLHandle);
begin
 {$IFDEF LOCKDEBUG}
  check(aLH);
  check(fJourFl.Size);
  Assert(fJourFl.Size > aLH, 'UnLock: aLH outside Size');
  l3System.Msg2Log('UnLock Size = %d, LH = %d', [(fJourFl.Size - 13) div 17, (aLH - 13) div 17]);
 {$ENDIF LOCKDEBUG}
 JFLock;
 try
  fJourFl.Seek(aLH, soBeginning);
  fJourFl.Write(cDelStationID, SizeOf(cDelStationID));
  {$IFDEF LOCKDEBUG}
   Check(fJourFl.Size);
  {$ENDIF LOCKDEBUG}
 finally
  JFUnlock;
 end;
end;

procedure TAbstractJournal.BatchUnLock(aLockHandles: Il3IDList);
var
 I : Integer;
 lTime : Cardinal;
begin
 if aLockHandles.Count = 0 then Exit;
 JFLock;
 lTime := dbgStartTimeCounter;
 try
  for I := 0 to pred(aLockHandles.Count) do
  begin
   fJourFl.Seek(TJLHandle(aLockHandles[I]), soBeginning);
   fJourFl.Write(cDelStationID, SizeOf(cDelStationID));
  end;
 finally
  l3System.Msg2Log('BatchUnLock  = %S', [dbgFinishTimeCounter(lTime)]);
  JFUnlock;
 end;
end;

function TAbstractJournal.CheckLock(aID : TIDType; aLockInfoList : Tl3RecList; aIgnoredLockHandle : TJLHandle = -1) : Boolean;

 function lJIAccessProc(var aRec : TJourRec; aPos : Longint) : Boolean;
 begin
  Result := not ((aRec.rStationName = cDelStationID) and (aRec.rLockType = cStopLockType)); // ����� ��������� �������� ����� �����
  if not Result then Exit;

  if (aRec.rStationName <> cDelStationID) and (aPos <> aIgnoredLockHandle) and (aRec.rDocID = aID) then
   aLockInfoList.Add(aRec);
 end;

begin
 aLockInfoList.Count := 0;

 JFLock;
 try
  IterateRecF(L2JIAccessFunc(@lJIAccessProc));
 finally
  JFUnlock;
 end;

 Result := aLockInfoList.Count > 0;
end;

function TAbstractJournal.CheckLock(aID : TIDType; aStationName : Int64 = 0) : TJLHandle;

 var
  lResult : TJLHandle absolute Result;

 function lJIAccessProc(var aRec : TJourRec; aPos : Longint) : Boolean;
 begin
  Result := not ((aRec.rStationName = cDelStationID) and (aRec.rLockType = cStopLockType)); // ����� ��������� �������� ����� �����
  if not Result then Exit;

  if (aRec.rStationName = aStationName) and (aRec.rDocID = aID) then
  begin
   lResult := aPos;
   Result := false; // ����� ������������
  end;
 end;

begin
 Result := -1;
 if aStationName = 0 then
  aStationName := fStName;

 JFLock;
 try
  IterateRecF(L2JIAccessFunc(@lJIAccessProc));
 finally
  JFUnlock;
 end;

 end;

end.
