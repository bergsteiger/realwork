unit Dt_Alarm;

{ $Id: Dt_Alarm.pas,v 1.29 2013/10/30 10:36:40 voba Exp $ }

// $Log: Dt_Alarm.pas,v $
// Revision 1.29  2013/10/30 10:36:40  voba
// - ����� �� fSrchList
//
// Revision 1.28  2012/02/01 12:00:49  voba
// -k : 333546936
//
// Revision 1.27  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.26  2009/06/23 07:32:58  voba
// - �������������� ������� � ���������
//
// Revision 1.25  2009/06/08 13:23:24  voba
// - enh. ���������� ���������. ��������� �� ��������������� atDateNumsChDate, atRelHLink,
//
// Revision 1.24  2009/05/19 12:20:48  voba
// - ���������� ���������
//
// Revision 1.23  2009/05/08 11:10:07  voba
// - ������� TblH �� Handle
//
// Revision 1.22  2009/03/02 07:55:24  voba
// - ������� ������ ���������� � constructor TPrometTbl.Create
//
// Revision 1.21  2007/11/15 14:19:21  voba
// - chng. procedure procedure TAlarmTbl.DelDocAlarm ����� �������� �� DocID = 0
//
// Revision 1.20  2007/08/14 20:25:14  lulin
// - bug fix: �� ���������� ����������.
//
// Revision 1.19  2007/08/14 19:31:55  lulin
// - ������������ ������� ������.
//
// Revision 1.18  2007/08/14 14:30:08  lulin
// - ������������ ����������� ������ ������.
//
// Revision 1.17  2007/06/28 11:16:25  voba
// - refact. ����� �� function TAbstractList.GetItem ������ ��������
//
// Revision 1.16  2007/05/25 15:26:18  voba
// - DeleteRecsByKeys ������ ���������� ���������� ��������� � ��������� exception � ������ ������
//
// Revision 1.15  2007/04/25 07:52:37  fireton
// - �����������. ������ �� ������ ���������� ���� ������ � ������ ������������ ����� � DT_Types
//
// Revision 1.14  2007/04/10 11:11:25  voba
// - del procedure GetDocAlarmsIDList
//
// Revision 1.13  2007/02/22 09:19:39  voba
// - ren DelRecsOnKeys -> DeleteRecsByKeys, _move this to TdtTable
//
// Revision 1.12  2007/01/15 10:48:48  voba
// - add  procedure   DelAlarmsinDiapason
//
// Revision 1.11  2004/09/14 15:58:14  lulin
// - ������ ������ Str_Man - ����������� ������ ���� - l3String.
//
// Revision 1.10  2004/08/03 08:52:51  step
// ������ dt_def.pas �� DtDefine.inc
//
// Revision 1.9  2004/07/01 14:14:26  voba
// - merge newCashe
//
// Revision 1.8.14.1  2004/06/17 18:03:48  step
// � ������� TAbsHtTbl.AddRec � TAbsHtTbl.UpdRec ����� �������� AbsNum.
//
// Revision 1.8  2004/03/05 16:50:12  step
// ������ ����
//
// Revision 1.7  2003/12/05 16:56:32  voba
// -code clean
//
// Revision 1.6  2003/04/28 13:26:11  voba
// - bug fix �� ������������ ���������������� ��������
//
// Revision 1.5  2003/04/21 15:21:57  voba
// - bug fix: ������������� ������ ����� ������
//
// Revision 1.4  2003/03/18 17:04:59  demon
// - new behavior: �������� AddDocAlarm ������ ��������� � ���� �������
// add � edit.
//
// Revision 1.3  2003/03/14 12:32:48  demon
// - ��������� ��������, ������������ ��� �������� ������ �
// ������ ������.
//
// Revision 1.2  2003/03/13 13:00:46  demon
// - new: ��������� ������� ��� ���������� �������� ��������
//
// Revision 1.1  2003/03/12 15:46:54  demon
// - new: ������ ������ TAlarmTbl? � ������� ����������������� ��� ���������
// ���������������� "��������������" ("���������").
//

{$I DtDefine.inc}

interface
uses
 l3Base,
 l3DatLst, l3Date,
 HT_Const,
 Dt_Types, Dt_Const,
 Dt_ATbl, dt_Sab,
 dt_Link;
const
 (* ��������� ��� ����� ������� *)
 alDocID            = 1;
 alRecID            = 2;
 alStart            = 3;
 alComment          = 4;
 alRec_Key          = 5; {���������� ����}

 AlarmReadFldCount = 3;
 AlarmReadFldArr : Array[1..AlarmReadFldCount] of SmallInt = (alRecID,alStart,
                                                              alComment);
type
 (* ��������� ������ "��������������" *)
 PAlarmRec = ^TAlarmRec;
 TAlarmRec = record
              RecID   : Byte;
              Start   : TStDate;
              Comment : Array[1..1000] of Char;
             end;

 TAlarmTbl = class(TDocAttrTbl)
  public
   constructor Create(aFamID : TFamilyID); reintroduce;

   procedure GetDocAlarmsList(aDocID : TDocID; aList : Tl3CustomDataList);
   (* ��������� ��������� ���������������� ������ �������� TAlarmFullRec, ���
      ���������, ���������� � property DocID *)

   procedure   AddDocAlarm(aDocID : TDocID; aInterval : PAlarmRec);
   (* ��������� ��������� ����� ��� ��������� ������������ (� ����������� ��
      �������� RecID) "��������������" ��� ���������, ���������� � property DocID *)

   procedure   DelDocAlarm(aDocID : TDocID; aRecID : Byte);
   (* ��������� ������� ���� �� "��������������" ��� ���������, ���������� �
      property DocID*)

   procedure   DelAlarmsinDiapason(aStart, aFinish : TStDate);
   (* ������� ��� �������������� � ��������� ��� *)

   //function    FindDocs(aStart, aFinish : TStDate) : SAB;
   (* ����� ����������, ������� �������������� � ��������� ��� *)

   //function    FindDocAlarmRec(aRecID : Byte;var AbsNum : LongInt) : Boolean;
   (* �������� ��� ������ ���������� ������ � ������� � ���������� �� AbsNum *)

   (* �������� ��� ��������� ������� *)
   function    GetAlarmsOnDoc(aDocID : TDocID) : Sab;
   //function    GetAlarmsOnDocs(aDocSab : Sab) : Sab;

 end;

implementation
uses SysUtils,
     HT_Dll,
     dt_DictConst,
     dt_AttrSchema,
     Dt_List,Dt_Err;

(******************************** TAlarmTbl *********************************)

type
 (* ���������� ���� ��� ������ �� ������� *)
 TAlrmRec_key = record
                 DocID   : TDocID;
                 RecID   : Byte;
                end;

constructor TAlarmTbl.Create(aFamID : TFamilyID);
var
 CurName : ShortString;
begin
 if aFamID=MainTblsFamily then
  Abort;
 inherited Create(aFamID, atAlarms);
end;

procedure TAlarmTbl.GetDocAlarmsList(aDocID : TDocID; aList : Tl3CustomDataList);
var
 TmpSab,
 DocAlarms   : Sab;
 TmpMode     : TOpenMode;
 AlarmsList  : TAbstractList;
 I           : Word;
 SortFld     : SmallInt;
begin
 if (aDocID = 0) then
  raise EHtErrors.CreateInt(ecNotAssigned);

 aList.Clear;
 with fTable do
 begin
  htSearch(nil, tmpSab, Handle, alDocID, Equal, @aDocID, nil);
 end;
 if tmpSab.gFoundCnt > 1 then
 begin
  SortFld:=alStart;
  htSortResults(DocAlarms,TmpSab,@SortFld,1);
  htClearResults(tmpSab);
 end
 else
  DocAlarms:=tmpSab;
 try
  if DocAlarms.gFoundCnt<>0 then
  begin
   aList.DataSize:=SizeOf(TAlarmRec);
   with TmpMode do
   begin
    openMode:=ROPEN_READ;
    FldArr:=@AlarmReadFldArr;
    Count:=AlarmReadFldCount;
   end;
   AlarmsList:=TAbstractList.Create(@DocAlarms,TmpMode);
   try
    AlarmsList.ReadForvard:=True;
    for I:=0 to AlarmsList.Count-1 do
     aList.Add(AlarmsList.GetItem(I));
   finally
    l3Free(AlarmsList);
   end;
  end;
 finally
  htClearResults(DocAlarms);
 end;
end;

procedure TAlarmTbl.AddDocAlarm(aDocID : TDocID; aInterval : PAlarmRec);
var
 TmpSab   : Sab;
 AbsNum   : LongInt;
 RecH     : RHANDLE;
 tmpPChar : PChar;
begin
 if (aDocID = 0) then
  raise EHtErrors.CreateInt(ecNotAssigned);

 with fTable do
 if aInterval^.RecID = cUndefDictIDByte then
 begin
  htSearch(nil, tmpSab, Handle, alDocID, Equal, @aDocID, nil);
  if tmpSab.gFoundCnt <> 0 then
  begin
   Ht(htKeyMaximum(tmpSab,alRecID,@(aInterval^.RecID)));
   Inc(aInterval^.RecID);
  end
  else
   aInterval^.RecID:=1;

  ClearFullRec;
  PutToFullRec(alDocID,aDocID);
  PutToFullRec(alRecID,aInterval^.RecID);
  PutToFullRec(alStart,aInterval^.Start);
  tmpPChar:=@(aInterval^.Comment);
  PutToFullRec(alComment,tmpPChar);
  AddFRec;
 end
 else
 begin
  ClearFullRec;
  PutToFullRec(alDocID,aDocID);
  PutToFullRec(alRecID,aInterval^.RecID);
  AbsNum:=Ht(htRecordByUniq(nil,Handle,alRec_Key,FullRecord,@RecH));
  if AbsNum <> 0 then
  begin
   GetFullRec(AbsNum,True);
   try
     PutToFullRec(alStart,aInterval^.Start);
     tmpPChar:=@(aInterval^.Comment);
     PutToFullRec(alComment,tmpPChar);

     UpdFRec(AbsNum);
   finally
    FreeRec(AbsNum);
   end;
  end
  else // ������������� ������� �� ������ - ������� �����
  begin
   PutToFullRec(alStart,aInterval^.Start);
   tmpPChar:=@(aInterval^.Comment);
   PutToFullRec(alComment,tmpPChar);

   AddFRec;
  end;
 end;
end;

procedure TAlarmTbl.DelDocAlarm(aDocID : TDocID;  aRecID : Byte);
var
 AbsNum  : LongInt;
 RecH    : RHANDLE;
begin
 if (aDocID = 0) then
  raise EHtErrors.CreateInt(ecNotAssigned);
 with fTable do
 begin
  ClearFullRec;
  PutToFullRec(alDocID, aDocID);
  PutToFullRec(alRecID, aRecID);
  AbsNum:=Ht(htRecordByUniq(nil,Handle,alRec_Key,FullRecord,@RecH));
  if AbsNum <> 0 then
   DelRec(AbsNum);
 end;
end;

procedure TAlarmTbl.DelAlarmsinDiapason(aStart, aFinish : TStDate);
var
 TmpSab : Sab;
begin
 htSearch(nil, tmpSab, fTable.Handle, alStart, In_Range, @aStart, @aFinish);
 try
  if (TmpSab.gFoundCnt <> 0) then
   Ht(htDeleteRecords(TmpSab));
 finally
  htClearResults(TmpSab);
 end;
end;

{function TAlarmTbl.FindDocs(aStart, aFinish : TStDate) : SAB;
var
 tmpSab1 : SAB;
begin
 RefreshSrchList;

 // ��������� ���� ����������, ������� �������������� � ��������� ���
 htSearch(@fSrchList,tmpSab1,fTable.Handle,alStart,In_Range,@aStart,@aFinish);
 try
  // �������� �������� �� ID
  htValuesOfKey(Result,alDocID,tmpSab1);
 finally
  htClearResults(tmpSab1);
 end;
end;
}
function TAlarmTbl.GetAlarmsOnDoc(aDocID : TDocID) : Sab;
begin
 with fTable do
 begin
  l3FillChar(Result,SizeOf(Sab));
  htSearch(nil, Result, Handle, alDocID, Equal, @aDocID, nil);
 end;
end;

{function TAlarmTbl.GetAlarmsOnDocs(aDocSab : Sab) : Sab;
begin
 l3FillChar(Result,SizeOf(Sab));
 htRecordsByKey(Result,aDocSab);
end;

function TAlarmTbl.FindDocAlarmRec(aRecID : Byte;var AbsNum : LongInt) : Boolean;
var
 RecH    : RHandle;
 lKeyRec : TAlrmRec_key;
begin
 lKeyRec.DocID:=fDocID;
 lKeyRec.RecID:=aRecID;
 AbsNum:=Ht(htRecordByUniq(nil,fTable.Handle,alRec_Key,@lKeyRec,@RecH));
 Result:=AbsNum>0;
end;
}
(**********************************************************************************)
end.
