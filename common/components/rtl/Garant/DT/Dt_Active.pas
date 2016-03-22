unit Dt_Active;

{ $Id: Dt_Active.pas,v 1.44 2015/11/25 14:01:48 lukyanets Exp $ }

// $Log: Dt_Active.pas,v $
// Revision 1.44  2015/11/25 14:01:48  lukyanets
// ��������� ��� ������ �������+������� ��������
//
// Revision 1.43  2014/04/17 13:04:31  voba
// - ������� ISab �� DT_Sab � dtIntf
//
// Revision 1.42  2013/10/30 10:36:40  voba
// - ����� �� fSrchList
//
// Revision 1.41  2011/07/28 08:41:48  voba
// - k : 236721575
//
// Revision 1.40  2010/10/20 10:04:54  voba
// - K : 236720571
//
// Revision 1.39  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.38  2009/06/23 07:32:58  voba
// - �������������� ������� � ���������
//
// Revision 1.37  2009/06/08 13:23:24  voba
// - enh. ���������� ���������. ��������� �� ��������������� atDateNumsChDate, atRelHLink,
//
// Revision 1.36  2009/05/19 12:20:48  voba
// - ���������� ���������
//
// Revision 1.35  2009/05/08 11:10:07  voba
// - ������� TblH �� Handle
//
// Revision 1.34  2009/03/02 07:55:08  voba
// - ������� ������ ���������� � constructor TPrometTbl.Create
//
// Revision 1.33  2008/03/20 09:48:36  lulin
// - cleanup.
//
// Revision 1.32  2008/02/07 14:44:41  lulin
// - ����� _Tl3LongintList �������� � ����������� ������.
//
// Revision 1.31  2008/01/31 20:38:11  lulin
// - ����������� �� �������� ��������������� �������.
//
// Revision 1.30  2007/11/15 14:20:26  voba
// - chng. procedure TActiveIntervalTbl.DelDocActiveInterval ����� �������� �� DocID = 0
//
// Revision 1.29  2007/08/14 20:25:14  lulin
// - bug fix: �� ���������� ����������.
//
// Revision 1.28  2007/08/14 19:31:55  lulin
// - ������������ ������� ������.
//
// Revision 1.27  2007/08/14 14:30:08  lulin
// - ������������ ����������� ������ ������.
//
// Revision 1.26  2007/06/28 11:16:25  voba
// - refact. ����� �� function TAbstractList.GetItem ������ ��������
//
// Revision 1.25  2007/05/25 15:26:32  voba
// - DeleteRecsByKeys ������ ���������� ���������� ��������� � ��������� exception � ������ ������
//
// Revision 1.24  2007/04/25 07:52:37  fireton
// - �����������. ������ �� ������ ���������� ���� ������ � ������ ������������ ����� � DT_Types
//
// Revision 1.23  2007/04/10 11:02:09  voba
// - refact.
//
// Revision 1.22  2007/02/22 09:19:54  voba
// - ren DelRecsOnKeys -> DeleteRecsByKeys, _move this to TdtTable
//
// Revision 1.21  2005/08/03 17:38:06  step
// ��������� ����� FindDocs � ��������� �� ������ Dt_Active � Dt_Doc
//
// Revision 1.20  2004/09/14 15:58:14  lulin
// - ������ ������ Str_Man - ����������� ������ ���� - l3String.
//
// Revision 1.19  2004/08/03 08:52:50  step
// ������ dt_def.pas �� DtDefine.inc
//
// Revision 1.18  2004/07/01 14:14:26  voba
// - merge newCashe
//
// Revision 1.17.14.1  2004/06/17 18:03:48  step
// � ������� TAbsHtTbl.AddRec � TAbsHtTbl.UpdRec ����� �������� AbsNum.
//
// Revision 1.17  2004/03/05 16:50:12  step
// ������ ����
//
// Revision 1.16  2004/03/05 13:05:49  step
// ��������� "packed" � record
//
// Revision 1.15  2004/03/04 14:33:12  step
// � ����. ACTIVE ��������� ���� Typ
//
// Revision 1.14  2003/12/05 16:56:12  voba
// -code clean
//
// Revision 1.13  2003/05/08 08:12:15  voba
// - improvement: ���������� ������������ ��������� � GetActiveDocNumbers (��������� ������)
//
// Revision 1.12  2003/04/28 13:26:11  voba
// - bug fix �� ������������ ���������������� ��������
//
// Revision 1.11  2003/04/21 15:21:57  voba
// - bug fix: ������������� ������ ����� ������
//
// Revision 1.10  2003/04/10 15:24:57  voba
// -bug fix
//
// Revision 1.9  2003/03/18 17:05:23  demon
// - new behavior: �������� AddDocActiveInterval ������ ��������� � ����
// ������� add � edit.
//
// Revision 1.8  2003/03/14 13:15:30  demon
// - del: ��������� minActiveDate, maxActiveDate ���������� � Dt_Const
//
// Revision 1.7  2003/03/14 12:32:48  demon
// - ��������� ��������, ������������ ��� �������� ������ �
// ������ ������.
//
// Revision 1.6  2003/03/13 13:00:46  demon
// - new: ��������� ������� ��� ���������� �������� ��������
//
// Revision 1.5  2003/03/12 14:59:12  demon
// - new: ��������� �������� GetActiveDocNumbers, ��������� ������ ��������
// ���������� �� ���������.
//
// Revision 1.4  2003/03/12 12:10:04  demon
// - ��������� fix
//
// Revision 1.3  2003/03/11 15:48:55  demon
// - new behavior: ��������� ���� ��� �������� ����������������� ���������� � ������ � ���.
//
// Revision 1.2  2003/03/11 15:09:54  demon
// - ��������� ��������� ����
//
// Revision 1.1  2003/03/11 14:14:13  demon
// - new: ������ ������-������� ��� �������� �������� �������� ����������.
// ������ ������� �������� ������� ��� ������ (get, add, del, edit, find)
//

{$I DtDefine.inc}

interface
uses
 l3Base, l3Date,l3DatLst,
 HT_Const,
 Dt_Types,Dt_Const,
 dtIntf, Dt_Sab, Dt_ATbl,
 dt_Link,
 l3LongintList
 ;

const
 (* ��������� ��� ����� ������� *)
 actDocID            = 1;
 actRecID            = 2;
 actTyp              = 3;
 actStart            = 4;
 actFinish           = 5;
 actComment          = 6;
 actRec_Key          = 7; {���������� ����}

 ActiveReadFldCount = 5;
 ActiveReadFldArr : Array[1..ActiveReadFldCount] of SmallInt = (actRecID,
                                                                actTyp,
                                                                actStart,
                                                                actFinish,
                                                                actComment);

type
 (* ��������� ������ ��������� �������� ��������� *)
 PActiveIntervalRec = ^TActiveIntervalRec;
 TActiveIntervalRec = packed record
                       RecID   : Byte;
                       Typ     : Byte;
                       Start,
                       Finish  : TStDate;
                       Comment : Array[1..1000] of Char;
                      end;

 TActiveIntervalTbl = class(TDocAttrTbl)
  public
   constructor Create(aFamID : TFamilyID); reintroduce;

   (* ��������� ��������� ���������������� ������ �������� TActiveFullRec, ���
      ���������, ���������� � property DocID *)
   procedure   GetDocActiveIntervalsList(aDocID : TDocID; aList : Tl3CustomDataList);

   (* ��������� ��������� ���������������� ������ ���������������� ����������
      ��������, ��� ���������, ���������� � property DocID *)
   procedure   GetDocActiveIntervalsIDList(aDocID : TDocID; aList : Tl3LongintList);

   (* ��������� ��������� ����� ��� ��������� ������������ (� ����������� ��
      �������� RecID) �������� �������� ��� ���������, ���������� � property DocID *)
   procedure   AddDocActiveInterval(aDocID : TDocID; aInterval : PActiveIntervalRec);

   (* ��������� ������� ���� �� ���������� �������� ��� ���������, ���������� �
      property DocID*)
   procedure   DelDocActiveInterval(aDocID : TDocID; aRecID : Byte);

   (* ��������� ������� ��� ��������� �������� ��� ���������, ���������� �
      property DocID*)

   (* ��������� ������ �������� ���������� (aList) �� ����� �������� � aDiapason *)
   function    GetActiveDocNumbers(const aDiapason : ISAB) : Tl3LongintList;

    (* ������ ������� ��������� �������� ��� ���� *)
   function    MinDate(aDocID : TDocID) : TstDate;

   (* �������� ��� ��������� ������� *)
   function    GetActiveIntervalsOnDoc(aDocID : TDocID) : Sab;
   //function    GetActiveIntervalsOnDocs(aDocSab : Sab) : Sab;

   (* �������� ��� ������ ���������� ������ � ������� � ���������� �� AbsNum *)
   //function    FindDocActiveIntervalRec(aRecID : Byte;var AbsNum : LongInt) : Boolean;

 end;

implementation
uses
 SysUtils,
 daSchemeConsts,
 HT_Dll,
 dt_AttrSchema,
 Dt_List, Dt_Err;

(******************************** TActiveIntervalTbl *********************************)

type
 (* ���������� ���� ��� ������ �� ������� *)
 TAIRec_key = record
               DocID   : TDocID;
               RecID   : Byte;
              end;

constructor TActiveIntervalTbl.Create(aFamID : TFamilyID);
var
 CurName : ShortString;
begin
 if aFamID = MainTblsFamily then
  Abort;
 inherited Create(aFamID, atActiveIntervals);
end;

procedure TActiveIntervalTbl.GetDocActiveIntervalsList(aDocID : TDocID; aList : Tl3CustomDataList);
var
 TmpSab,
 DocActives  : Sab;
 TmpMode     : TOpenMode;
 ActivesList : TAbstractList;
 I           : Word;
 SortFld     : SmallInt;
begin
 if (aDocID = 0) then
  raise EHtErrors.CreateInt(ecNotAssigned);

 aList.Clear;

 with fTable do
 begin
  htSearch(nil, tmpSab, Handle, actDocID, Equal, @aDocID, nil);
 end;

 if tmpSab.gFoundCnt > 1 then
 begin
  SortFld:=actStart;
  htSortResults(DocActives,TmpSab,@SortFld,1);
  htClearResults(tmpSab);
 end
 else
  DocActives:=tmpSab;
 try
  if DocActives.gFoundCnt<>0 then
  begin
   aList.DataSize:=SizeOf(TActiveIntervalRec);
   with TmpMode do
   begin
    openMode:=ROPEN_READ;
    FldArr:=@ActiveReadFldArr;
    Count:=ActiveReadFldCount;
   end;
   ActivesList:=TAbstractList.Create(@DocActives,TmpMode);
   try
    ActivesList.ReadForvard:=True;
    for I:=0 to ActivesList.Count-1 do
     aList.Add(ActivesList.GetItem(I));
   finally
    l3Free(ActivesList);
   end;
  end;
 finally
  htClearResults(DocActives);
 end;
end;

(*procedure TActiveIntervalTbl.GetMinPublishDate(aDocID : TDocID) : TStDate;
var
 lSab : ISab;
 lType  : Byte;
begin
 if (aDocID = 0) then
  raise EHtErrors.CreateInt(ecNotAssigned);

 lSab := MakeSab(fTable);
 lSab.Select(actDocID, aDocID);
 lType := Ord(dnPublish);
 lSab.SubSelect(actTyp, lType);
 Result := lSab.GetMinValue(actStart);
end;
*)

function TActiveIntervalTbl.MinDate(aDocID : TDocID) : TstDate;
var
 lSab : ISab;
begin
 lSab := MakeSab(fTable);
 lSab.Select(actDocID, aDocID);
 Result := lSab.GetMinValue(actStart);
end;

procedure TActiveIntervalTbl.GetDocActiveIntervalsIDList(aDocID : TDocID; aList : Tl3LongintList);
var
 tmpSab,
 ValList  : Sab;
 lRecID   : Byte;
begin
 if (aDocID = 0) then
  raise EHtErrors.CreateInt(ecNotAssigned);

 aList.Clear;
 with fTable do
 begin
  htSearch(nil, tmpSab, Handle, actDocID, Equal, @aDocID, nil);
 end;
 try
  if tmpSab.gFoundCnt > 0 then
  begin
   htValuesOfKey(ValList,actRecID,TmpSab);
   try
    if ValList.gFoundCnt>0 then
    begin
     Ht(htOpenResults(ValList,ROPEN_READ,nil,0));
     try
      while htReadResults(ValList,@lRecID,SizeOf(lRecID))<>0 do
       aList.Add(lRecID);
     finally
      htCloseResults(ValList);
     end;
    end;
   finally
    htClearResults(ValList);
   end;
  end;
 finally
  htClearResults(tmpSab);
 end;
end;

procedure TActiveIntervalTbl.AddDocActiveInterval(aDocID : TDocID; aInterval : PActiveIntervalRec);
var
 TmpSab   : Sab;
 AbsNum   : LongInt;
 RecH     : RHANDLE;
 tmpPChar : PChar;
begin
 if (aDocID = 0) then
  raise EHtErrors.CreateInt(ecNotAssigned);

 with fTable do
 begin
  ClearFullRec;
  PutToFullRec(actDocID,aDocID);
  PutToFullRec(actRecID,aInterval^.RecID);
  PutToFullRec(actTyp,aInterval^.Typ);
  PutToFullRec(actStart,aInterval^.Start);
  PutToFullRec(actFinish,aInterval^.Finish);
  tmpPChar:=@(aInterval^.Comment);
  PutToFullRec(actComment,tmpPChar);

  // ������ � ������� ������ � ����� aInterval^.RecID
  AbsNum := Ht(htRecordByUniq(nil, Handle, actRec_Key, FullRecord, @RecH));

  ///������������� aInterval^.RecID
  if aInterval^.RecID <= 0 then
  begin
   htSearch(nil, tmpSab, Handle, actDocID, Equal, @aDocID, nil);
   if tmpSab.gFoundCnt <> 0 then
   begin
    Ht(htKeyMaximum(tmpSab, actRecID, @(aInterval^.RecID)));
    Inc(aInterval^.RecID);
   end
   else
    aInterval^.RecID := 1;

   PutToFullRec(actRecID, aInterval^.RecID);
  end;

  if AbsNum <> 0 then // ������ � ����� aInterval^.RecID ���� � �������
  begin
   HoldRec(AbsNum);
   try
    UpdFRec(AbsNum);
   finally
    FreeRec(AbsNum);
   end
  end 
  else
   AddFRec;
 end;
end;

procedure TActiveIntervalTbl.DelDocActiveInterval(aDocID : TDocID; aRecID : Byte);
var
 AbsNum  : LongInt;
 RecH    : RHANDLE;
begin
 //if (fDocID = 0) then
 // raise EHtErrors.CreateInt(ecNotAssigned);
 with fTable do
 begin
  ClearFullRec;
  PutToFullRec(actDocID,aDocID);
  PutToFullRec(actRecID,aRecID);
  AbsNum := Ht(htRecordByUniq(nil,Handle,actRec_Key,FullRecord,@RecH));
  if AbsNum <> 0 then
   DelRec(AbsNum);
 end;
end;

function TActiveIntervalTbl.GetActiveDocNumbers(const aDiapason : ISAB) : Tl3LongintList;
var
 lCurDate  : TStDate;
 lDateSub  : ISab;
begin
 Result := nil;
 if not aDiapason.IsEmpty then
 begin
  lCurDate := CurrentDate;
  lDateSub := MakeSab(fTable);
  lDateSub.Select(actStart, lCurDate, Less_Equal);
  lDateSub.SubSelect(actFinish, lCurDate, Great_Equal);

  aDiapason.RecordsByKey(actDocId, lDateSub);
  aDiapason.AndSab(lDateSub);

  if not aDiapason.IsEmpty then
  begin
   // ��������� ������ ��������������� ����������, ����������� �� ����
   aDiapason.ValuesOfKey(actDocID);
   Result := dtMakeSortedIDListBySab(aDiapason);
  end;
 end;
end;

function TActiveIntervalTbl.GetActiveIntervalsOnDoc(aDocID : TDocID) : Sab;
begin
 with fTable do
 begin
  l3FillChar(Result,SizeOf(Sab));
  htSearch(nil, Result, Handle, actDocID, Equal, @aDocID, nil);
 end;
end;

{function TActiveIntervalTbl.GetActiveIntervalsOnDocs(aDocSab : Sab) : Sab;
begin
 l3FillChar(Result,SizeOf(Sab));
 htRecordsByKey(Result,aDocSab);
end;

function TActiveIntervalTbl.FindDocActiveIntervalRec(aRecID : Byte;var AbsNum : LongInt) : Boolean;
var
 RecH    : RHandle;
 lKeyRec : TAIRec_key;
begin
 lKeyRec.DocID:=fDocID;
 lKeyRec.RecID:=aRecID;
 AbsNum:=Ht(htRecordByUniq(nil,Handle,actRec_Key,@lKeyRec,@RecH));
 Result:=AbsNum>0;
end;
}
(**********************************************************************************)
end.
