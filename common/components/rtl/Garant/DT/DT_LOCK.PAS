Unit Dt_Lock;

{ $Id: DT_LOCK.PAS,v 1.54 2016/05/26 14:01:24 voba Exp $ }

// $Log: DT_LOCK.PAS,v $
// Revision 1.54  2016/05/26 14:01:24  voba
// -k:623267081
//
// Revision 1.53  2016/05/17 11:59:35  voba
// -k:623081921
//
// Revision 1.52  2015/11/25 14:01:48  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.51  2015/08/31 08:45:24  lukyanets
// Убираем Range Check Error
//
// Revision 1.50  2015/06/09 13:19:48  voba
// -bf
//
// Revision 1.49  2015/06/08 12:44:00  voba
// -откатил изменеия
//
// Revision 1.48  2015/06/02 15:03:54  voba
// - переделка итератора по записям. Теперь пустые в подитеративную процедуру не передаются, стопзапись ставится внутри итератора
//
// Revision 1.47  2015/05/26 15:18:08  lukyanets
// Чистим залочки более гуманно
//
// Revision 1.46  2015/05/26 12:10:58  voba
// - k:600314998
//
// Revision 1.45  2015/04/06 08:46:28  lukyanets
// Изолируем Lock сервера
//
// Revision 1.44  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.43  2014/02/18 10:54:20  voba
//  k:236721575 (Атрибуты в EVD)
//
// Revision 1.42  2014/02/14 15:33:45  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.41  2013/06/11 08:04:01  fireton
// - function GetLockJournalName
//
// Revision 1.40  2011/07/20 08:02:37  voba
// - k : 236721575
//
// Revision 1.39  2009/12/23 08:33:43  voba
// - bug fix : проблемы с захватом семейства (таблица ctrl)
//
// Revision 1.38  2009/11/20 13:43:21  voba
// - bug fix: Tl3BuuferedFilter не корректно работает в режиме почитали, пописали, почитали. Пришлось сделать в DT_Jour собственную буфферизацию
//
// Revision 1.37  2009/11/18 10:17:25  voba
// - opt.
//
// Revision 1.36  2009/06/23 07:32:59  voba
// - стандартизация доступа к атрибутам
//
// Revision 1.35  2009/03/02 08:24:50  voba
// - заменил function FamTblName и  MainTblName на одну TblName с указанием Family
// - заменил  две verload function TablePassword на одну с указанием Family
//
// Revision 1.34  2008/12/17 11:10:39  voba
// - bug fix откручена проверка прав на удаления при залочке
//
// Revision 1.33  2008/03/20 09:48:36  lulin
// - cleanup.
//
// Revision 1.32  2008/02/22 16:57:41  lulin
// - упорядочиваем примеси.
//
// Revision 1.31  2008/02/07 14:44:41  lulin
// - класс _Tl3IDList переехал в собственный модуль.
//
// Revision 1.30  2007/12/18 08:42:54  fireton
// - пакетный захват (и отпускание) документов
//
// Revision 1.29  2007/11/22 14:38:58  fireton
// - приводим информацию о всех пользователей, захвативших документ
//
// Revision 1.28  2007/08/28 14:42:02  narry
// - range check error
//
// Revision 1.27  2007/08/14 20:25:14  lulin
// - bug fix: не собиралася Архивариус.
//
// Revision 1.26  2007/07/25 11:07:47  narry
// - возврат номера пользователя, захватившего документ
//
// Revision 1.25  2007/07/24 12:32:33  narry
// - рефакторинг системы сообщений
//
// Revision 1.24  2007/04/25 07:52:37  fireton
// - Рефакторинг. Уходим от прямых упоминаний имен таблиц в пользу перечислимых типов в DT_Types
//
// Revision 1.23  2007/03/26 09:34:03  fireton
// - изменился формат l3System.FreeLocalMem
//
// Revision 1.22  2006/11/16 10:48:31  fireton
// - подготовка к большому UserID
//
// Revision 1.21  2006/06/23 11:20:59  narry
// -merge
//
// Revision 1.20.22.1  2006/06/19 09:09:54  voba
// - add func LinkServer.GetSelfMask
//
// Revision 1.20  2005/10/17 11:29:54  voba
// no message
//
// Revision 1.19  2004/09/21 12:04:20  lulin
// - Release заменил на Cleanup.
//
// Revision 1.18  2004/09/14 15:58:14  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.17  2004/08/03 08:52:51  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.16  2004/06/22 13:55:39  step
// изменен тип выбрасываемого исключения в TLockServer.FullLockDoc
//
// Revision 1.15  2004/05/18 09:51:46  step
// change: GlobalHTServer.MaxFamilyID --> GlobalHTServer.FamilyTbl.MaxFamilyID;
//
// Revision 1.14  2004/05/18 09:12:46  step
// change: GlobalFamPaths[] --> GlobalHtServer.FamilyTbl.FamilyPath()
//
// Revision 1.13  2003/10/02 13:54:42  voba
// - new method:    PreventLockDoc
//
// Revision 1.12  2003/06/23 14:26:59  voba
// - переписал TLockServer.LockDoc, некорректно работала из-за раделения прав на гиперссылки, метки и блоки
//
// Revision 1.11  2003/04/16 09:17:03  voba
// - bug fix: неправильно тестировался флаг acfDelete.
//
// Revision 1.10  2003/01/21 11:27:13  demon
// - new behavior: процедура LockDoc теперь не позволяет захватить документ
// при получении 0 эффективной (LockMask) или разрешенной (MaxMask) маски прав.
//
// Revision 1.9  2001/09/17 06:52:17  demon
// - byg fix: before unlock family all other tbls now closed, and after unlock all opened
//
// Revision 1.8  2000/12/15 15:36:16  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

Interface

uses
  l3Base,
  l3String,
  l3IDList,

  Dt_Types,
  Dt_Jour, //Dt_Jour2,
  dtIntf, Dt_Sab;

Type
 TLockRec = Record
             Journal: TAbstractJournal;
             Count  : LongInt;
            end;
 PFamilyLocks = ^TFamilyLocks;
 TFamilyLocks = Array[0..$fff] of TLockRec;

 TLockServer = Class(Tl3Base)
  private
   f_AllowClearLocks: Boolean;
  protected
   Locks    : PFamilyLocks;

   function  CompareSysData(Var OldSysData, NewSysData) : Boolean;
   procedure OpenJournal(aFamily : TFamilyID);
   procedure Cleanup; override;
  public
   constructor Create(anAllowClearLocks: Boolean); {$IfDef Win32} Reintroduce; {$endIf Win32}

   procedure BatchLockDoc(aFamily: TFamilyID; aDocList: ISab; aRightsNeeded: Longint; var theLockHandles: Il3IDList;
                          var theAcceptedDocs, theRejectedDocs: Il3IDList);
    overload;

   procedure BatchLockDoc(aFamily : TFamilyID; var aDocList : Il3IDList; aRightsNeeded: Longint;
                                   var theLockHandles : Il3IDList; var theRejectedDocs : Il3IDList);
    overload;


   procedure BatchUnlockDoc(aFamily: TFamilyID; aLockHandles: Il3IDList);
   procedure OptimizeMem;
   procedure ReallocLocks(NewMaxFamId : TFamilyID);
   procedure DelFamilyLocks(aFamily : TFamilyID);
   procedure InitFamilyLocks(aFamily : TFamilyID);

   function  LockDoc(aFamily : TFamilyID;
                     aDocID  : TDocID;
                     Var MaxMask,LockMask : LongInt) : TJLHandle;
   function  LockDocByMask(aFamily : TFamilyID; aDocID : TDocID; aMaxMask : LongInt; var aLockMask : LongInt) : TJLHandle;
   function  FullLockDoc(aFamily : TFamilyID;
                         aDocID  : TDocID) : TJLHandle;

   function  PreventLockDoc(aFamily : TFamilyID; aDocID  : TDocID) : TJLHandle;
   {* - Залочка для предотвращения захвата документа с другого компьютера.
    В случае если документ был захвачен с другого компьютера возвращает -1.
    Для повторного захвата с текущей станции прозрачна.}


   procedure UnLockDoc(aFamily : TFamilyID;
                       aLockHandle : TJLHandle);
   function  LockFamily(aFamily : TFamilyID) : boolean;
   procedure UnLockFamily(aFamily : TFamilyID);

   procedure WhoLockDoc(aFamily : TFamilyID;
                        aDocID : TDocID;
                        var Stations : TStationNameArray;
                        var UserIDs : TUserIDArray;
                        aIgnoredLockHandle : TJLHandle = -1);

   function HasMyLock(aFamily : TFamilyID; aDocID  : TDocID) : boolean;
   procedure CheckMyLock(aFamily : TFamilyID; lHasInSaveDir, lNeedOpen : Il3IDList);
 end;

const
 LockServer : TLockServer = Nil;

function GetLockJournalName(const aFamily: TFamilyID): string;

Implementation

uses
  daDataProvider,
  daSchemeConsts,
  HT_Dll,
  HT_Const,
  l3Bits,
  l3RecList,
  Dt_Acces,
  Dt_Const,
  Dt_Doc,
  Dt_Serv,
  Dt_err,
  SysUtils,
  Dt_LinkServ
  ;

const
 JourPrefix = 'LOCK';

Constructor TLockServer.Create(anAllowClearLocks: Boolean);
Begin
 Inherited Create;
 l3System.GetLocalMem(Locks,(GlobalHtServer.FamilyTbl.MaxFamilyID+1)*SizeOf(TLockRec));
 l3FillChar(Locks^,(GlobalHtServer.FamilyTbl.MaxFamilyID+1)*SizeOf(TLockRec));
 f_AllowClearLocks := anAllowClearLocks;
end;

procedure TLockServer.BatchLockDoc(aFamily : TFamilyID; var aDocList : Il3IDList; aRightsNeeded: Longint;
                                   var theLockHandles : Il3IDList; var theRejectedDocs : Il3IDList);

 {procedure AddToRejected(aID: TDocID);
 begin
  if theRejectedDocs = nil then
   theRejectedDocs := Tl3IDList.Create;
  theRejectedDocs.Add(aID);
 end;
 }

//var
//  l_DocID               : TDocID;
//  l_LockHandle          : TJLHandle;
//  l_LockMask            : LongInt;
//  I                     : Integer;
//  lCnt                  : Integer;

begin
 if theLockHandles = nil then
  theLockHandles := l3MakeIDList
 else
  theLockHandles.Clear;

 //VV
 AccessServer.CanBeLocked(aFamily, aDocList, aRightsNeeded, theRejectedDocs);

 Locks^[aFamily].Journal.BatchLock(aDocList, aRightsNeeded, theRejectedDocs, theLockHandles);
 Inc(Locks^[aFamily].Count, theLockHandles.Count);

 {I := 0;
 lCnt := aDocList.Count;

 while I < lCnt do
 begin
  l_DocID := aDocList[I];
  l_LockHandle := LockDoc(aFamily, l_DocID, aRightsNeeded, l_LockMask);

  if (l_LockHandle > 0) and l3TestMask(l_LockMask, aRightsNeeded) then
  begin
   theLockHandles.Add(l_LockHandle);
   inc(I);
  end
  else
  begin
   UnLockDoc(aFamily, l_LockHandle);
   AddToRejected(l_DocID);
   aDocList.Delete(I);
   Dec(lCnt);
  end;
 end; // while
 }
end;

procedure TLockServer.BatchLockDoc(aFamily: TFamilyID; aDocList: ISab; aRightsNeeded: Longint; var theLockHandles: Il3IDList;
                                   var theAcceptedDocs, theRejectedDocs: Il3IDList);
begin
 theAcceptedDocs := dtMakeSortedIDListBySab(aDocList);
 BatchLockDoc(aFamily, theAcceptedDocs, aRightsNeeded, theLockHandles, theRejectedDocs);
end;

(* var
  l_RejCursor: ISabCursor;
  l_AccCursor: ISabCursor;

 procedure AddToRejected(aID: TDocID);
 var
  l_ID : TDocID;
 begin
  l_ID := aID;
  if theRejectedDocs <> nil then
   l_RejCursor.AddItem(@l_ID)
  else
  begin
   theRejectedDocs := MakeValueSet(aDocList.Table, fId_Fld, @l_ID, 1);
   l_RejCursor := theRejectedDocs.MakeSabCursor([fID_Fld], cmForward);
  end;
 end;

 procedure AddToAccepted(aID: TDocID);
 var
  l_ID : TDocID;
 begin
  l_ID := aID;
  if theAcceptedDocs <> nil then
   l_AccCursor.AddItem(@l_ID)
  else
  begin
   theAcceptedDocs := MakeValueSet(aDocList.Table, fId_Fld, @l_ID, 1);
   l_AccCursor := theAcceptedDocs.MakeSabCursor([fID_Fld], cmForward);
  end;
 end;

 function l_Iterator(aRec : Pointer): Boolean; register;
 var
  l_DocID     : TDocID;
  l_LockHandle: TJLHandle;
  l_MaxMask, l_LockMask : LongInt;
 begin
  Result := True;
  l_DocID := TDocID(aRec^);
  l_LockHandle := LockDoc(aFamily, l_DocID, l_MaxMask, l_LockMask);

  if l_LockHandle < 0 then
  begin
   AddToRejected(l_DocID);
   Exit;
  end;

  if not l3TestMask(l_LockMask, aRightsNeeded) then
  begin
   UnLockDoc(aFamily, l_LockHandle);
   AddToRejected(l_DocID);
   Exit;
  end;

  theLockHandles.Add(l_LockHandle);
  AddToAccepted(l_DocID);
 end;

var
 l_Proc : TdtRecAccessProc;

begin
 theLockHandles.Clear;
 theRejectedDocs := nil;
 theAcceptedDocs := nil;
 l_Proc := L2RecAccessProc(@l_Iterator);
 try
  aDocList.IterateRecords(l_Proc, [fId_Fld]);
 finally
  FreeRecAccessProc(l_Proc);
 end;
end;
*)

procedure TLockServer.BatchUnlockDoc(aFamily: TFamilyID; aLockHandles: Il3IDList);
begin
 if aLockHandles.Count = 0 then Exit;
 Locks^[aFamily].Journal.BatchUnLock(aLockHandles);
 Dec(Locks^[aFamily].Count, aLockHandles.Count);
 aLockHandles.Clear;
end;

procedure TLockServer.Cleanup;
Var
 I : TFamilyID;
Begin
 For I:=0 to GlobalHtServer.FamilyTbl.MaxFamilyID do
  If Locks^[I].Journal<>Nil then
  begin
   if f_AllowClearLocks then
    Locks^[I].Journal.ClearBadJourRec;
   l3Free(Locks^[I].Journal);
  end;
 l3System.FreeLocalMem(Locks);
 Inherited;
end;

function TLockServer.CompareSysData(Var OldSysData, NewSysData) : Boolean;
Begin
 if LongInt(OldSysData) = acFullBlock then
 begin
  Result := True;
  LongInt(NewSysData) := 0;
  exit;
 end;

 LongInt(NewSysData) := not LongInt(OldSysData) and LongInt(NewSysData);
 Result := (LongInt(NewSysData) = 0);
end;

procedure TLockServer.OptimizeMem;
Var
 I : TFamilyID;
Begin
 For I:=0 to GlobalHtServer.FamilyTbl.MaxFamilyID do
  If (Locks^[I].Count=0) and
     (Locks^[I].Journal<>Nil)
   then
    l3Free(Locks^[I].Journal);
end;

procedure TLockServer.ReallocLocks(NewMaxFamId : TFamilyID);
Begin
 l3System.ReAllocLocalMem(Locks,(NewMaxFAmID+1)*SizeOf(TLockRec));
end;

procedure TLockServer.DelFamilyLocks(aFamily : TFamilyID);
Begin
 If Assigned(Locks^[aFamily].Journal)
  then
   l3Free(Locks^[aFamily].Journal);
 Locks^[aFamily].Count:=0             
end;

function GetLockJournalName(const aFamily: TFamilyID): string;
begin
 if aFamily = MainTblsFamily then
  Result := GlobalHtServer.FamilyTbl.FamilyPath(aFamily)+JourPrefix+'.jor'
 else
  Result := GlobalHtServer.FamilyTbl.FamilyPath(aFamily)+JourPrefix+IntToHex(aFamily,3)+'.jor';
end;

procedure TLockServer.OpenJournal(aFamily : TFamilyID);
Var
 CurName : ShortString;
Begin
 CurName := GetLockJournalName(aFamily);
 Locks^[aFamily].Journal:=TAbstractJournal.Create(GlobalHtServer.CurStationName, CurName);
 Locks^[aFamily].Journal.CompareSysData:=CompareSysData;
 if f_AllowClearLocks then
  Locks^[aFamily].Journal.ClearBadJourRec;
end;

procedure TLockServer.InitFamilyLocks(aFamily : TFamilyID);
begin
 if Locks^[aFamily].Journal = nil then
  OpenJournal(aFamily);
end;

function TLockServer.LockDoc(aFamily : TFamilyID;aDocID : TDocID;
                             var MaxMask,LockMask : LongInt) : TJLHandle;
begin
 (* Получение максимальной маски прав для данного aDocID *)
 MaxMask := AccessServer.GetMask(aFamily, aDocID);
 Result := LockDocByMask(aFamily, aDocID, MaxMask, LockMask);
end;

function TLockServer.LockDocByMask(aFamily : TFamilyID; aDocID : TDocID; aMaxMask : LongInt; var aLockMask : LongInt) : TJLHandle;
var
 lSaveLockMask : Longint;

begin
 Result := -1;

 if Locks^[aFamily].Journal = nil then
  OpenJournal(aFamily);

 (* Дополнение маски прав до непротиворечивого состояния *)
 if (aMaxMask and acgTextDependMask <> 0) then
  aLockMask := aMaxMask or acgTextDependMask
 else
  aLockMask := aMaxMask;

 if aLockMask = 0 then Exit;

 (* Попытка захвата документа с заданной маской прав *)
 Result := Locks^[aFamily].Journal.Lock(aDocID, aLockMask);

 lSaveLockMask := aLockMask;

 if (Result = -1) then Exit;

 (* если не удалось захватить все права, связанные с редактированием текста, то срезаем остальные*)
 if (aLockMask and acgTextDependMask <> acgTextDependMask) then
  aLockMask := aLockMask and not acgTextDependMask;

 (* восстанавливаем разрешенный объем прав *)
 aLockMask := aLockMask and aMaxMask;

 (* Освобождение захваченного документа, если маска после захвата получилась равной 0 *)
 if (aLockMask = 0) then
 begin
  Locks^[aFamily].Journal.UnLock(Result);
  Result := -1;
 end
 else
  if lSaveLockMask <> aLockMask then
  (*корректируем объем захваченных прав*)
   Locks^[aFamily].Journal.SetNewSysData(Result, aLockMask);
end;

function TLockServer.FullLockDoc(aFamily : TFamilyID;
                                 aDocID  : TDocID) : TJLHandle;
var
 CurMask : LongInt;
begin
 Result:=-1;

 if Locks^[aFamily].Journal=nil then
  OpenJournal(aFamily);

 //CurMask := AccessServer.GetSelfMask;

 CurMask := acFullBlock;
 try
  Result:=Locks^[aFamily].Journal.Lock(aDocID, CurMask, dtlExclusive);
  if Result<>-1 then Inc(Locks^[aFamily].Count);
 except
  Result:=-1;
 end;
end;

function  TLockServer.PreventLockDoc(aFamily : TFamilyID; aDocID  : TDocID) : TJLHandle;
var
 lCurMask : longint;
begin
 Result := -1;
 if Locks^[aFamily].Journal=nil then
  OpenJournal(aFamily);

 lCurMask := acFullBlock;
 try
  Result := Locks^[aFamily].Journal.Lock(aDocID, lCurMask, dtlPrevent);
  if Result <> -1 then Inc(Locks^[aFamily].Count);
 except
  Result := -1;
 end;
end;

procedure TLockServer.UnLockDoc(aFamily : TFamilyID;aLockHandle : TJLHandle);
Begin
 If aLockHandle > 0 then
  begin
   Locks^[aFamily].Journal.UnLock(aLockHandle);
   If Locks^[aFamily].Count<>0 then
    Dec(Locks^[aFamily].Count);
  end;
end;

function TLockServer.LockFamily(aFamily : TFamilyID) : boolean;
begin
 if aFamily = MainTblsFamily then
  Result := GlobalDataProvider.LockAll
 else
 begin
  GlobalHtServer.CloseAllTbls(aFamily);
  try
   try
    GlobalHtServer.Family[aFamily].Lock(TAB_PRIVATE);
    Result := True;
   except
    Result := false;
   end;
  finally
   GlobalHtServer.OpenClosedTbls;
  end;
 end;
end;

procedure TLockServer.UnLockFamily(aFamily : TFamilyID);
begin
 if aFamily = MainTblsFamily then
  GlobalDataProvider.UnLockAll
 else
 begin
  GlobalHtServer.CloseAllTbls(aFamily);
  try
   GlobalHtServer.Family[aFamily].Unlock;
  finally
   GlobalHtServer.OpenClosedTbls;
  end;
 end;
end;

procedure TLockServer.WhoLockDoc(aFamily : TFamilyID;aDocID  : TDocID;
                                 var Stations : TStationNameArray;
                                 var UserIDs  : TUserIDArray;
                                 aIgnoredLockHandle : TJLHandle = -1);
var
 l_LockList : Tl3RecList;//of TJourRec
 I: Integer;
begin
 Stations := nil;
 UserIDs  := nil;
 if Locks^[aFamily].Journal = nil then
  OpenJournal(aFamily);

 l_LockList := Tl3RecList.Create(SizeOf(TJourRec));
 try
  if Locks^[aFamily].Journal.CheckLock(aDocID, l_LockList,aIgnoredLockHandle) then
   begin
    SetLength(Stations, l_LockList.Count);
    SetLength(UserIDs, l_LockList.Count);
    for I := 0 to Pred(l_LockList.Count) do
    begin
     Stations[I]:=l3ArrayToString(PJourRec(l_LockList.ItemSlot(I)).rStationName, SizeOf(TStationID));
     // Придется пока считать, что все пользователи без исключения в качестве имени станции используют свой номер в Hex
     UserIDs[I]:= TUserID(StrToIntDef('$'+Stations[I], 0));
    end;
   end;
 finally
  l3Free(l_LockList);
 end;
end;

function TLockServer.HasMyLock(aFamily : TFamilyID; aDocID  : TDocID) : boolean;
begin
 Result := Locks^[aFamily].Journal.CheckLock(aDocID) <= 0;
end;

procedure TLockServer.CheckMyLock(aFamily : TFamilyID; lHasInSaveDir, lNeedOpen : Il3IDList);
var
 lStName : Int64;

 function lJIAccessProc(var aRec : TJourRec; aPos : Longint) : Boolean;
 var
  lIdx : Integer;
 begin
  //Result := True;

  Result := not ((aRec.rStationName = cDelStationID) and (aRec.rLockType = cStopLockType)); // метка окончания полезной части файла
  if not Result then Exit;

  if (aRec.rStationName = lStName) then
  begin
   lIdx := lHasInSaveDir.IndexOf(aRec.rDocID);
   if lIdx >= 0 then
   begin
    lNeedOpen.Add(lHasInSaveDir[lIdx]);
    lHasInSaveDir.Delete(lIdx);
   end
   else
    Locks^[aFamily].Journal.Unlock(aPos);
  end;
 end;

begin
 lStName := Locks^[aFamily].Journal.StName;

 Locks^[aFamily].Journal.IterateLockRecF(L2JIAccessFunc(@lJIAccessProc));

 //Result := Locks^[aFamily].Journal.CheckLock(aDocID) <= 0;
end;


end.
