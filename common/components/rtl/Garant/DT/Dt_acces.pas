Unit Dt_Acces;

{ $Id: Dt_acces.pas,v 1.47 2016/05/30 10:07:01 voba Exp $ }

// $Log: Dt_acces.pas,v $
// Revision 1.47  2016/05/30 10:07:01  voba
// -k:623913569
//
// Revision 1.46  2016/05/26 14:01:24  voba
// -k:623267081
//
// Revision 1.45  2016/05/17 11:59:35  voba
// -k:623081921
//
// Revision 1.44  2016/04/15 11:57:05  lukyanets
// Чистим протухший код
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.43  2015/11/25 14:01:48  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.42  2015/07/02 07:36:07  lukyanets
// Описываем словари
//
// Revision 1.41  2015/04/03 11:30:43  lukyanets
// Изолируем HT
//
// Revision 1.40  2014/08/26 10:23:14  lukyanets
// Считаем служебных суперпользователями
//
// Revision 1.39  2014/05/21 14:33:39  voba
// - cc
//
// Revision 1.38  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.37  2014/02/14 15:33:45  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.36  2013/10/30 10:36:40  voba
// - отказ от fSrchList
//
// Revision 1.35  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.34  2012/01/13 08:54:40  fireton
// - добавил новый и переименовал старый метод (проверка действий над документами)
//
// Revision 1.33  2011/11/29 09:02:23  voba
// - k : 236721575
//
// Revision 1.32  2011/07/20 07:52:06  voba
// - k : 236721575
//
// Revision 1.31  2010/09/28 13:06:08  fireton
// - Распределяем память для PAnsiChar своими средствами
//
// Revision 1.30  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.29  2009/07/22 11:27:27  narry
// - изменение доступа к DictServer
//
// Revision 1.28  2009/05/08 11:10:07  voba
// - заменил TblH на Handle
//
// Revision 1.27  2009/04/13 07:10:58  narry
// - разделение определения типов и реализации
//
// Revision 1.26  2009/03/02 07:54:52  voba
// - изменил список параметров у constructor TPrometTbl.Create
//
// Revision 1.25  2008/11/25 12:51:18  narry
// - рефакторинг
//
// Revision 1.24  2007/12/06 11:40:59  lulin
// - cleanup.
//
// Revision 1.23  2007/08/14 20:25:14  lulin
// - bug fix: не собиралася Архивариус.
//
// Revision 1.22  2007/08/14 19:31:56  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.21  2007/05/10 12:34:24  fireton
// - выдаем серверу максимальные права на документы
//
// Revision 1.20  2007/05/02 11:09:02  fireton
// - bug fix: Range Check error при попытке войти пользователем, не принадлежащим ни к одной группе пользователей
//
// Revision 1.19  2007/03/26 09:34:03  fireton
// - изменился формат l3System.FreeLocalMem
//
// Revision 1.18  2007/03/14 15:14:32  fireton
// - merge полезных штук из ветки b_archi_BigDictID
// - тип групп пользователей теперь не TDictID, а TUserGrID
// - подчищен код замены пароля пользователей
// - замена указателя на дин.массив для массива групп пользователей
//
// Revision 1.17  2007/02/22 14:33:53  narry
// - переход к 64 битам
//
// Revision 1.16  2004/09/21 12:04:21  lulin
// - Release заменил на Cleanup.
//
// Revision 1.15  2004/08/03 08:52:51  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.14  2004/07/01 14:14:26  voba
// - merge newCashe
//
// Revision 1.13.2.1  2004/06/17 18:03:48  step
// В методах TAbsHtTbl.AddRec и TAbsHtTbl.UpdRec убран параметр AbsNum.
//
// Revision 1.13  2004/05/18 09:51:46  step
// change: GlobalHTServer.MaxFamilyID --> GlobalHTServer.FamilyTbl.MaxFamilyID;
//
// Revision 1.12  2003/12/18 09:03:41  voba
// - code clean
//
// Revision 1.11  2003/12/17 16:24:45  voba
// -add function TestRightMaskForDocGroup
//
// Revision 1.10  2002/01/16 12:52:33  demon
// - rename table Access to Access2
//
// Revision 1.9  2001/11/21 12:51:36  demon
// - new: change access mask logic (Allow and Deny masks) and size (now LongInt)
//
// Revision 1.8  2001/07/06 14:38:14  demon
// - new behavior: add transactions to all massive operation of Add, Modify and Delete of tbl records
//
// Revision 1.7  2000/12/15 15:36:17  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

Interface
Uses
 Dt_ATbl,
 Dt_Types,
 l3Base,
 l3LongintList,
 l3IDList,
 csClient;

const
 mskUsGr_fld  = 1;
 mskFamID_fld = 2;
 mskDocGr_fld = 3;
 mskMask_fld  = 4;
 mskUG_F_key  = 5;
 mskF_DG_key  = 6;
 mskThree_key = 7;
Type
 TMaskTbl = Class(TPrometTbl)
  public
   constructor Create; Reintroduce;

   procedure   GetFamilyMasksForUG(aFamily : TFamilyID;
                                   aUG_ID  : TUserGrID; aBuf : PAnsiChar; MaxDocGroup : TDictID);
   procedure   GetFamilyMasks(aFamily : TFamilyID;aBuf : PAnsiChar;MaxDocGroup : TDictID);
   procedure   UpdateMask(aFamily : TFamilyID; aUG_ID  : TUserGrID;
                          aDG_ID : TDictID;NewMask : TTblMask);
   procedure   DelUserGroup(aUG_ID : TUserGrID);
 end;

 PMaskArr = ^TMaskArr;
 TMaskArr = Array[0..$fff] of TTblMask;

 PFamilyMasks = ^TFamilyMasks;
 TFamilyMasks = Array[0..$fff] of PAnsiChar;

 TAccessServer = Class(Tl3Base)
  public
   fMaskTbl     : TMaskTbl;
  private
   f_CSClient: TcsClient;
   f_NonEditableDicts: LongInt;
   procedure GetNonEditableDicts;
   function    GetMaskArr(aFamily : TFamilyID; aDocGr : TDictID) : TTblMask;
   procedure pm_SetCSClient(const Value: TcsClient);
  protected
   fFamilyMasks : PFamilyMasks;
   procedure   Cleanup; override;
  public
   constructor Create; Reintroduce;
   function    GetRightMask(aFamily : TFamilyID; aDocID : TDocID) : TTblMask; overload;
   function    GetRightMask(aFamily : TFamilyID; aAccGr : TDictID; aIsIncluded : boolean) : TTblMask; overload;
   function    TestRightsMaskForDocGroup(aFamily : TFamilyID; aDocGr : TDictID; aRightMask : integer) : Boolean;
   procedure   ReLoadMaskArr(aFamily : TFamilyID);

   function    GetSelfMask(aFamily : TFamilyID{ = CurrentFamily}) : Word;
   function    GetMask(aFamily : TFamilyID; aDoc : TDocID) : LongInt;

   procedure   CanBeLocked(aFamily : TFamilyID; var aDocList : Il3IDList;
                                     aRightsNeeded: Longint; var aRejectedDocs : Il3IDList);
   // проверяет права на редактирование для пачки доков

   property    CSClient: TcsClient read f_CSClient write pm_SetCSClient;
   property    Mask[Family : TFamilyID; DocGr : TDictID] : TTblMask read GetMaskArr; default;
   property    NonEditableDicts: LongInt read f_NonEditableDicts;
 end;

var
 AccessServer : TAccessServer;
{

 Маска прав

 Группа документов в семействе

 NameAttr = $0001; (1)
 Text     = $0002; (2)
 Hyper    = $0004; (4)
 KeyWord  = $0008; (8)
 Class    = $0010; (16)

 Все семейство целиком

 DocGroup = $0001; (1)

 }

Implementation
Uses
 daDataProvider,
 daTypes,
 daSchemeConsts,
 DIALOGS,
 l3String,
 HT_Const,
 Dt_Const,
 dt_AttrSchema,
 Dt_Err,
 dtIntf,
 dt_Sab,
 Dt_LinkServ, Dt_Link,
 Dt_Dict, DT_Log,
 DT_Userconst,
 HT_Dll,
 SysUtils,
 Dt_Serv,
 l3Bits, ddServerTask, csQueryTypes;

(***************** TMaskTbl ***********************)
constructor TMaskTbl.Create;
begin
 Inherited Create(MainTblsFamily, Ord(mtAccess));
end;

procedure TMaskTbl.GetFamilyMasksForUG(aFamily : TFamilyID;
                                       aUG_ID  : TUserGrID;
                                       aBuf : PAnsiChar;
                                       MaxDocGroup : TDictID);
Type
 TMaskSrchRec = Record
                 UsGr : TUserGrID;
                 Fam  : TFamilyID;
                end;
 TMaskReadRec = Record
                 DocGr : TDictID;
                 Mask  : TTblMask;
                end;
const
 FldCount = 2;
 FldArr : Array[1..FldCount] of SmallInt =(mskDocGr_fld,mskMask_fld);
var
 SrchRec  : TMaskSrchRec;
 ReadRec  : TMaskReadRec;
 tmpSab,
 Masks    : Sab;
 MinMask  : TTblMask;
 I        : TDictID;
 SortFld  : SmallInt;
 ReadRes  : Boolean;
begin
 SrchRec.Fam:=aFamily;
 SrchRec.UsGr:=aUG_ID;
 //RefreshSrchList;
 htSearch(nil,tmpSab,Handle,mskUG_F_key,EQUAL,@SrchRec,nil);
 Try
  SortFld:=mskF_DG_key;
  Ht(htSortResults(Masks,tmpSab,@SortFld,1));
  Try
   Ht(htOpenResults(Masks,ROPEN_READ,@FldArr,FldCount));
   Try
    ReadRes := HTBLen(htReadResults(Masks,@ReadRec,SizeOf(ReadRec))) > 0;
    if ReadRes and (ReadRec.DocGr = 0) then
     MinMask:=ReadRec.Mask
    else
     MinMask:=0;
    For I:=0 to MaxDocGroup - 1 do
     begin
      if ReadRes then
       begin
        if ReadRec.DocGr = I then
         begin
          PMaskArr(aBuf)^[I]:=PMaskArr(aBuf)^[I] or ReadRec.Mask;
          ReadRes:=HTBLen(htReadResults(Masks,@ReadRec,SizeOf(ReadRec)))<>0;
         end
        else
         PMaskArr(aBuf)^[I]:=PMaskArr(aBuf)^[I] or MinMask;
       end
      else
       PMaskArr(aBuf)^[I]:=PMaskArr(aBuf)^[I] or MinMask;
     end;
   finally
    htCloseResults(Masks);
   end;
  finally
   htClearResults(Masks);
  end;
 finally
  htClearResults(tmpSab);
 end;
end;

procedure TMaskTbl.GetFamilyMasks(aFamily : TFamilyID;aBuf : PAnsiChar;MaxDocGroup : TDictID);
var
 I            : TUserGrID;
 l_GroupsCount: Integer;
begin
 l_GroupsCount := Length(GlobalHtServer.CurUserGr);
 if l_GroupsCount > 0 then
  for I := 0 to Pred(l_GroupsCount) do
   GetFamilyMasksForUG(aFamily, GlobalHtServer.CurUserGr[I], aBuf, MaxDocGroup);
end;

procedure TMaskTbl.UpdateMask(aFamily : TFamilyID;
                              aUG_ID  : TUserGrID;
                              aDG_ID  : TDictID;
                              NewMask : TTblMask);
var
 AbsNum  : LongInt;
 RecH    : RHANDLE;
 OldMask : TTblMask;
begin
 ClearFullRec;
 PutToFullRec(mskFamID_fld,aFamily);
 PutToFullRec(mskDocGr_fld,aDG_ID);
 PutToFullRec(mskUsGr_fld,aUG_ID);
 //RefreshSrchList;
 AbsNum:=htRecordByUniq(nil,Handle,mskThree_key,fFullRecord,@RecH);
 if AbsNum=0 then
  begin
   PutToFullRec(mskMask_fld,NewMask);
   AddFRec;
  end
 else
  begin
   GetFullRec(AbsNum,True);
   try
    GetFromFullRec(mskMask_fld,OldMask);
    if OldMask<>NewMask then
     begin
      PutToFullRec(mskMask_fld,NewMask);
      UpdFRec(AbsNum)
     end;
   finally
    FreeRec(AbsNum);
   end;
  end;
end;

procedure TMaskTbl.DelUserGroup(aUG_ID : TUserGrID);
var
 TmpList : SAB;
begin
 l3FillChar(TmpList,SizeOf(SAB));
 //RefreshSrchList;

 htSearch(nil,TmpList,Handle,mskUsGr_fld,EQUAL,@aUG_ID,nil);
 Try
  if (TmpList.gFoundCnt<>0) then
   if StartTA then
    try
     Ht(htDeleteRecords(TmpList));
     SuccessTA;
    except
     RollBackTA;
     raise;
    end;

 finally
  htClearResults(TmpList);
 end;
end;

(***************** TAccessServer *****************)

constructor TAccessServer.Create;
begin
 Inherited Create;
 l3System.GetLocalMemZ(fFamilyMasks,(GlobalHTServer.FamilyTbl.MaxFamilyID+1)*SizeOf(PAnsiChar));
 fMaskTbl:=TMaskTbl.Create;
end;

procedure TAccessServer.Cleanup;
var
 I : TFamilyID;
begin
 l3Free(fMaskTbl);
 for I:=0 to GlobalHTServer.FamilyTbl.MaxFamilyID do
  if fFamilyMasks^[I]<>nil then
   l3StrDispose(fFamilyMasks^[I]);
 l3System.FreeLocalMem(fFamilyMasks);
 Inherited;
end;

procedure TAccessServer.GetNonEditableDicts;
begin
 f_NonEditableDicts:= 0;
 {$IFDEF RemoteDict}
 if (CSClient <> nil) and CSClient.IsStarted then
 begin
  with TddNonEditableDictsRequest.Create(nil) do
  try
   if CSClient.Exec(qtGetNonEditableDicts, SaveToPipe) then
    f_NonEditableDicts:= DictsMask;
  finally
   Free;
  end;
 end;
 {$ENDIF}
end;

procedure TAccessServer.ReLoadMaskArr(aFamily : TFamilyID);
var
 MaxItem : TDictID;
begin
 if fFamilyMasks^[aFamily]<>nil then
  l3StrDispose(fFamilyMasks^[aFamily]);
 if aFamily<>MainTblsFamily then
 begin
  MaxItem:=DictServer(aFamily).DictTbl[da_dlAccGroups].GetMaxID+1;
 end
 else
  MaxItem:=GlobalHTServer.FamilyTbl.MaxFamilyID+1;
 fFamilyMasks^[aFamily] := l3StrAlloc(MaxItem*SizeOf(TTblMask));
 l3FillChar(fFamilyMasks^[aFamily]^,MaxItem*SizeOf(TTblMask));
 fMaskTbl.GetFamilyMasks(aFamily,fFamilyMasks^[aFamily],MaxItem);
end;

function TAccessServer.GetMaskArr(aFamily : TFamilyID;aDocGr : TDictID) : TTblMask;
begin
 if GlobalDataProvider.CurUserIsServer then
  Result := TTblMask(cMaxRightsMask)
 else
 begin
  if fFamilyMasks^[aFamily] = nil then
   ReLoadMaskArr(aFamily);
  Result:=PMaskArr(fFamilyMasks^[aFamily])^[aDocGr];
 end;
end;

procedure TAccessServer.pm_SetCSClient(const Value: TcsClient);
begin
 if f_CSClient <> Value then
 begin
  f_CSClient := Value;
 end; // f_CSClient <> Value
end;

function TAccessServer.TestRightsMaskForDocGroup(aFamily : TFamilyID; aDocGr : TDictID; aRightMask : integer) : Boolean;
begin
 with TTblMaskRec(Mask[aFamily, aDocGr]) do
  Result := l3TestMask((AllowMask and not DenyMask), aRightMask);
end;

function TAccessServer.GetRightMask(aFamily : TFamilyID; aAccGr : TDictID; aIsIncluded : boolean) : TTblMask;
var
 lMask  : TTblMask;
begin
 Result := 0;
 lMask := {AccessServer.}Mask[MainTblsFamily, aFamily];
 TLongWord(Result).HiWord := TTblMaskRec(lMask).AllowMask and not TTblMaskRec(lMask).DenyMask;

 lMask := AccessServer[aFamily, aAccGr];
 if aIsIncluded then
  lMask := lMask or Mask[aFamily, agIncludedGroup]
 else
  lMask := lMask or Mask[aFamily, agNotIncludedGroup];

 TLongWord(Result).LoWord := TTblMaskRec(lMask).AllowMask and not TTblMaskRec(lMask).DenyMask;
end;

function TAccessServer.GetRightMask(aFamily : TFamilyID; aDocID : TDocID) : TTblMask;
var
 lAccGr : TDictID;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 begin
  Result := False;
  lAccGr := PInteger(aItemPtr)^;
 end;

var
 lIsIncluded : boolean;
 lSab : ISab;
 lRAProcStub : TdtRecAccessProc;

begin
 // get AccGr
 lSab := MakeSab(LinkServer(aFamily).Attribute[atAccGroups]);
 lSab.Select(lnkDocIDFld, aDocID);
 if lSab.Count > 0 then
 begin
  lRAProcStub := L2RecAccessProc(@lRecAccessProc);
  try
   lSab.IterateRecords(lRAProcStub, [lnkDictIDFld]);
  finally
   FreeRecAccessProc(lRAProcStub);
  end;
 end
 else
  lAccGr := 0;

 //get lIsIncluded
 lIsIncluded := LinkServer(aFamily).LogBook.IsDocHadAction(aDocID, acIncluded);

 Result := GetRightMask(aFamily, lAccGr, lIsIncluded);
end;

function TAccessServer.GetSelfMask(aFamily : TFamilyID {= CurrentFamily}) : Word;
var
 lMask  : TTblMaskRec;
begin
 lMask := TTblMaskRec(AccessServer[MainTblsFamily, aFamily]);

 Result := lMask.AllowMask and not lMask.DenyMask;
end;

function TAccessServer.GetMask(aFamily : TFamilyID; aDoc : TDocID) : LongInt;
var
 Bodies  : Sab;
 lGroup  : TDictID;
 lGrMask : TTblMask;
begin
 Result := 0;
 lGrMask := Mask[MainTblsFamily, aFamily];
 TLongWord(Result).HiWord := TTblMaskRec(lGrMask).AllowMask and not TTblMaskRec(lGrMask).DenyMask;

 lGrMask := 0;
 LinkServer(aFamily).Links[da_dlAccGroups].GetNodes(aDoc, Bodies);
  if Bodies.gFoundCnt<>0 then
  begin
   Ht(htOpenResults(Bodies, ROPEN_READ, nil, 0));
   try
    while htReadResults(Bodies ,@lGroup, SizeOf(TDictID))<>0 do
     lGrMask := lGrMask or Mask[aFamily, lGroup];
   finally
    htCloseResults(Bodies);
   end;
  end
 else
  lGrMask := Mask[aFamily, 0];

 if LinkServer(aFamily).LogBook.IsDocHadAction(aDoc, acIncluded) then
  lGrMask := lGrMask or Mask[aFamily, agIncludedGroup]
 else
  lGrMask := lGrMask or Mask[aFamily, agNotIncludedGroup];

 TLongWord(Result).LoWord := TTblMaskRec(lGrMask).AllowMask and
                           not TTblMaskRec(lGrMask).DenyMask;
end;


procedure TAccessServer.CanBeLocked(aFamily : TFamilyID; var aDocList : Il3IDList;
                                    aRightsNeeded: Longint; var aRejectedDocs : Il3IDList);


 procedure CheckByAccGroup(var aIDList : Il3IDList; aInclMask : TTblMask);
 var
  lListSab         : ISab;
  lAccGrSab        : ISab;
  lIntList         : Il3IDList;
  I                : Integer;
  lMask            : TTblMaskRec;
 begin
  if aDocList.Count <= 0 then Exit;

  // так нельзя, запрет в AccGr не отработаем
  //lMask := TTblMaskRec(aInclMask);
  //if l3TestMask((lMask.AllowMask and not lMask.DenyMask), aRightsNeeded) then
  // exit; // если разрешено по aInclMask, то значит всем разрешено б


  lAccGrSab := MakeValueSet(LinkServer(aFamily).Links[da_dlAccGroups], lnkDocIDFld, aIDList);
  lAccGrSab.RecordsByKey;

  //проверяем маску для доков без AccGroups
  lMask := TTblMaskRec(Mask[aFamily, 0] or aInclMask);
  if not l3TestMask((lMask.AllowMask and not lMask.DenyMask), aRightsNeeded) then
    //ищем доки без AccGroups и выкидываем в Rejected
   begin
    lListSab := MakeSabCopy(lAccGrSab);
    lListSab.ValuesOfKey(lnkDocIDFld);

    lIntList := l3MakeIDList;
    try
     dtCopyValuesSabToList(lListSab, lIntList);

     lIntList.InvertList(aIDList);
     aRejectedDocs.MergeList(lIntList);
     aDocList.SubtractList(lIntList);
    finally
     lIntList := nil;
    end;
   end;

  //ищем все AccGroups присутствующие в aIDList
  if lAccGrSab.Count > 0 then
  begin
   lIntList := l3MakeIDList;
   try
    lAccGrSab.ValuesOfKey(lnkDictIDFld);
    dtCopyValuesSabToList(lAccGrSab, lIntList);

    // цикл по найденным AccGroups
    for I := Pred(lIntList.Count) downto 0 do
    begin // проверка маски для конкретной группы
     lMask := TTblMaskRec(Mask[aFamily, lIntList[I]] or aInclMask);
     if l3TestMask((lMask.AllowMask and not lMask.DenyMask), aRightsNeeded) then
      lIntList.Delete(I);
    end;

    if lIntList.count <= 0 then Exit;

    //для оставшихся ищем доки с ними и и выкидываем в Rejected
    lAccGrSab := MakeValueSet(LinkServer(aFamily).Links[da_dlAccGroups], lnkDictIDFld, lIntList);
    lAccGrSab.RecordsByKey;
    lAccGrSab.ValuesOfKey(lnkDocIDFld);
    lListSab := MakeValueSet(LinkServer(aFamily).Links[da_dlAccGroups], lnkDocIDFld, aIDList);
    lAccGrSab.AndSab(lListSab);

    lIntList.Clear;
    dtCopyValuesSabToList(lAccGrSab, lIntList);

    aRejectedDocs.MergeList(lIntList);
    aDocList.SubtractList(lIntList);
   finally
    lIntList := nil;
   end;
  end;
 end;

var
 lInclMask        : TTblMask;
 lNInclMask       : TTblMask;
 lIsInclRejected  : boolean;
 lIsNInclRejected : boolean;
 lListSab         : ISab;
 lInclList        : Il3IDList;
 lAction          : TLogActionType;

begin
 if TLongWord(aRightsNeeded).HiWord > 0 then
 begin
  if not l3TestMask(GetSelfMask(aFamily), TLongWord(aRightsNeeded).HiWord) then // просили собственные права редактировать (AccGr), а нельзя
  begin
   l3Free(aRejectedDocs);
   aRejectedDocs := aDocList; // весь список в Rejected
   aDocList := l3MakeIDList; // пустой
   Exit;
  end;
  aRightsNeeded := aRightsNeeded and $FFFF; //  в дальнейших вычислениях self права не нужны
 end;

 if aRightsNeeded = 0 then // вычислять нечего (можно все)
  Exit;

 lInclMask := Mask[aFamily, agIncludedGroup];
 lIsInclRejected  := l3TestPartMask(TTblMaskRec(lInclMask).DenyMask, aRightsNeeded); //если явный запрет, то дальше можно не считать

 lNInclMask := Mask[aFamily, agNotIncludedGroup];
 lIsNInclRejected  := l3TestPartMask(TTblMaskRec(lNInclMask).DenyMask, aRightsNeeded); //если явный запрет, то дальше можно не считать

 // если нельзя редактировать подключенные и неподключенные, то нельзя ничего
 if lIsInclRejected and lIsNInclRejected then
 begin
  l3Free(aRejectedDocs);
  aRejectedDocs := aDocList; // весь список в Rejected
  aDocList := l3MakeIDList; // пустой
  Exit;
 end;

 // ищем подключенные
 lListSab := MakeValueSet(LinkServer(aFamily).LogBook, lgDocID_Key, aDocList);
 try
  lListSab.RecordsByKey;
  lAction := acIncluded;
  lListSab.SubSelect(lgAction_key, lAction);
  lListSab.ValuesOfKey(lgDocID_Key);
  lInclList := l3MakeIDList;
  dtCopyValuesSabToList(lListSab, lInclList);
 finally
  lListSab := nil;
 end;

 if lInclList.Count > 0 then
 begin
  if lIsInclRejected then //запрещены подк
  begin
   aDocList.SubtractList(lInclList); //aDocList := aDocList - lIntList;
   aRejectedDocs.MergeList(lInclList); // aRejectedDocs := aRejectedDocs + lIntList;
  end
  else
  begin
   // подключенные явно не запрещены, но могут быть и не разрешены
   // обрабатываем по группам доступа с учетом lInclMask
   CheckByAccGroup(lInclList, lInclMask);
  end;
 end;

 lInclList.InvertList(aDocList);
 if lInclList.Count > 0 then
 begin
  if lIsNInclRejected then //запрещены НЕподк
  begin
   aDocList.SubtractList(lInclList); //aDocList := aDocList - lIntList;
   aRejectedDocs.MergeList(lInclList); // aRejectedDocs := aRejectedDocs + lIntList;
  end
  else
  begin
   // подключенные явно не запрещены, но могут быть и не разрешены
   // обрабатываем по группам доступа с учетом lInclMask
   CheckByAccGroup(lInclList, lNInclMask);
  end;
 end;

end;

end.
