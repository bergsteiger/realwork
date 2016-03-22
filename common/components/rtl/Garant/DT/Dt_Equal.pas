Unit Dt_Equal;

{ $Id: Dt_Equal.pas,v 1.36 2015/11/25 14:01:48 lukyanets Exp $ }

// $Log: Dt_Equal.pas,v $
// Revision 1.36  2015/11/25 14:01:48  lukyanets
// ��������� ��� ������ �������+������� ��������
//
// Revision 1.35  2015/07/02 07:36:07  lukyanets
// ��������� �������
//
// Revision 1.34  2014/04/17 13:04:31  voba
// - ������� ISab �� DT_Sab � dtIntf
//
// Revision 1.33  2013/12/03 09:55:07  voba
// - ���������� �� ������������ ����������
//
// Revision 1.32  2013/10/30 10:36:40  voba
// - ����� �� fSrchList
//
// Revision 1.31  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.30  2009/05/08 11:10:07  voba
// - ������� TblH �� Handle
//
// Revision 1.29  2009/03/19 08:48:28  voba
// - ������� function TEqualItemsTbl.GetAllEquals �� ISAB
//
// Revision 1.28  2009/03/02 08:11:13  voba
// - ������� ������ ���������� � constructor TPrometTbl.Create
//
// Revision 1.27  2008/03/20 09:48:36  lulin
// - cleanup.
//
// Revision 1.26  2008/02/22 18:26:35  lulin
// - �������� ������ �� ������.
//
// Revision 1.25  2008/02/07 14:44:41  lulin
// - ����� _Tl3LongintList �������� � ����������� ������.
//
// Revision 1.24  2007/08/30 19:41:29  lulin
// - bug fix: �� ��������� ����������.
//
// Revision 1.23  2007/08/14 20:25:14  lulin
// - bug fix: �� ���������� ����������.
//
// Revision 1.22  2007/08/14 19:31:56  lulin
// - ������������ ������� ������.
//
// Revision 1.21  2007/08/14 14:30:08  lulin
// - ������������ ����������� ������ ������.
//
// Revision 1.20  2007/05/25 15:25:53  voba
// - DeleteRecsByKeys ������ ���������� ���������� ��������� � ��������� exception � ������ ������
//
// Revision 1.19  2007/04/26 10:01:43  fireton
// - ����������� DT. ������� DT_Link � DT_Dict �� ������ � ����� ��������.
//
// Revision 1.18  2007/02/22 09:23:14  voba
// - ren DelRecsOnKeys -> DeleteRecsByKeys, _move this to TdtTable
//
// Revision 1.17  2006/10/09 12:09:03  voba
// - code format
//
// Revision 1.16  2005/05/17 09:27:38  lulin
// - new unit: evResultFont.
//
// Revision 1.15  2005/02/14 12:49:34  step
// ������: GetEqualsFor -> _AddEqualsTo
//
// Revision 1.14  2005/02/11 17:37:08  step
// ����������� TEqualItemsTbl.GetEqualsFor
//
// Revision 1.13  2004/12/27 09:14:03  step
// ����������� TEqualItemsTbl.GetEqualsFor
//
// Revision 1.12  2004/12/24 18:34:53  step
// new: TEqualItemsTbl.GetEqualsFor
//
// Revision 1.11  2004/08/03 08:52:51  step
// ������ dt_def.pas �� DtDefine.inc
//
// Revision 1.10  2004/07/01 14:14:27  voba
// - merge newCashe
//
// Revision 1.9.44.1  2004/06/17 18:03:48  step
// � ������� TAbsHtTbl.AddRec � TAbsHtTbl.UpdRec ����� �������� AbsNum.
//
// Revision 1.9  2002/04/03 12:40:09  demon
// - new behavior: add procedure DelAllEqualOnWordIds
//
// Revision 1.8  2002/04/03 11:38:40  demon
// - new behavior: add procedure DelAllEqualOnIDs
//
// Revision 1.7  2002/03/13 15:42:35  demon
// - new behavior: add LoadEqualClassesToTree procedure
//
// Revision 1.6  2001/07/06 14:38:15  demon
// - new behavior: add transactions to all massive operation of Add, Modify and Delete of tbl records
//
// Revision 1.5  2000/12/15 15:36:17  law
// - ��������� ��������� Log.
//

{$I DtDefine.inc}

Interface

uses
 l3Base,
 l3LongintList,

 daTypes,

 ht_Const,
 dt_Types,
 dt_AttrSchema,
 dtIntf,
 dt_Sab,
 dt_ATbl;

Const
{Standart Equal fields}
 eqFID_Fld      = 1;
 eqSID_Fld      = 2;
 eqBothKey      = 3;

 eqOpenFldCount = 2;
 eqOpenFldArr   : Array[1..eqOpenFldCount] of SmallInt = (eqFID_Fld,eqSID_Fld);

Type
 PEqualRec = ^TEqualRec;
 TEqualRec = Record
              FirstID,
              SecondID : Longint;
             end;

 TEqualItemsTbl = Class(TPrometTbl)
  protected

  public
   Constructor Create(aFamily : TFamilyID; aDLType : TdaDictionaryType); Reintroduce;

   Function  GetEqual(aField : SmallInt;aID : LongInt) : SAB;
   function  GetAllEquals : ISAB;
   procedure AddEqualsTo(aIDs: Tl3LongintList); // ��������� � aIDs �������������

   Function  CheckEqualPair(aFirstID,aSecondID : LongInt) : Boolean;

   Procedure AddEqual(aFirstID,aSecondID : LongInt);
   Procedure DelEqual(aFirstID,aSecondID : LongInt);
   Procedure DelEqualOnID(aField : SmallInt;aID : LongInt);
   Procedure DelAllEqualOnID(aID : LongInt);
   procedure DelAllEqualOnIDs(aIDs : Sab);
   procedure DelAllEqualOnWordIds(aIDs : Sab);
 end;

Implementation

Uses
 daSchemeConsts,
 HT_Dll,
 Dt_Const, SysUtils, Dt_Err, l3DynamicArrayEx, l3Memory, l3Types;

(********************* TEqualItemsTbl **************************)

constructor TEqualItemsTbl.Create(aFamily : TFamilyID; aDLType : TdaDictionaryType);
begin
 Assert(aFamily <> MainTblsFamily);
 inherited Create(aFamily, Ord(cDLPassports[aDLType].rDict), atpEQ);
end;

function TEqualItemsTbl.GetEqual(aField : SmallInt;aID : LongInt) : SAB;
var
 TmpSab : Sab;
begin
 l3FillChar(Result,SizeOf(SAB));
 htSearch(nil, TmpSab, Handle, aField, EQUAL, @aID, Nil);
 Try
  If aField = eqFID_Fld
   then
    htValuesOfKey(Result,eqSID_Fld,TmpSab)
   else
    htValuesOfKey(Result,eqFID_Fld,TmpSab);
 finally
  htClearResults(TmpSab);
 end;
end;

function TEqualItemsTbl.GetAllEquals : ISAB;
begin
 Result := MakeAllRecords(Self);
 Result.Sort([eqFID_Fld]);
end;

Function TEqualItemsTbl.CheckEqualPair(aFirstID,aSecondID : LongInt) : Boolean;
Var
 TmpRec : TEqualRec;
 RecH   : RHandle;
 AbsN   : LongInt;
Begin
 Result := False;
 With TmpRec do
  Begin
   FirstID := aFirstID;
   SecondID := aSecondID;
  end;
 AbsN := Ht(htRecordByUniq(Nil, Handle, eqBothKey, @TmpRec, @RecH));
 Result := (AbsN > 0);
end;

Procedure TEqualItemsTbl.AddEqual(aFirstID,aSecondID : LongInt);
Begin
 ClearFullRec;
 PutToFullRec(eqFID_Fld,aFirstID);
 PutToFullRec(eqSID_Fld,aSecondID);
 AddFRec;
end;

Procedure TEqualItemsTbl.DelEqual(aFirstID,aSecondID : LongInt);
Var
 TmpRec : TEqualRec;
 RecH   : RHandle;
 AbsN   : LongInt;
Begin
 With TmpRec do
  Begin
   FirstID:=aFirstID;
   SecondID:=aSecondID;
  end;
 AbsN:=Ht(htRecordByUniq(Nil,Handle,eqBothKey,@TmpRec,@RecH));
 If AbsN > 0
  then
   DelRec(AbsN);
end;

Procedure TEqualItemsTbl.DelEqualOnID(aField : SmallInt;aID : LongInt);
Var
 TmpSab : Sab;
Begin
 l3FillChar(TmpSab,SizeOf(SAB));
 htSearch(nil, TmpSab, Handle, aField, EQUAL, @aID, Nil);
 Try
  If (TmpSab.gFoundCnt<>0) then
   if StartTA then
    try
     Ht(htDeleteRecords(TmpSab));
     SuccessTA;
    except
     RollBackTA;
     raise;
    end;
 finally
  htClearResults(TmpSab);
 end;
end;

Procedure TEqualItemsTbl.DelAllEqualOnID(aID : LongInt);
Var
 TmpSab : Sab;
Begin
 l3FillChar(TmpSab,SizeOf(SAB));
 htSearch(nil,TmpSab,Handle,eqFID_Fld,EQUAL,@aID,Nil);
 Try
  If (TmpSab.gFoundCnt<>0) then
   if StartTA then
    try
     Ht(htDeleteRecords(TmpSab));
     SuccessTA;
    except
     RollBackTA;
     raise;
    end;
 finally
  htClearResults(TmpSab);
 end;

 l3FillChar(TmpSab,SizeOf(SAB));
 htSearch(nil,TmpSab,Handle,eqSID_Fld,EQUAL,@aID,Nil);
 Try
  If (TmpSab.gFoundCnt<>0) then
   if StartTA then
    try
     Ht(htDeleteRecords(TmpSab));
     SuccessTA;
    except
     RollBackTA;
     raise;
    end;
 finally
  htClearResults(TmpSab);
 end;
end;

Procedure TEqualItemsTbl.DelAllEqualOnIDs(aIDs : Sab);
begin
 DeleteRecsByKeys(aIDs,eqFID_Fld);
 DeleteRecsByKeys(aIDs,eqSID_Fld);
end;

procedure TEqualItemsTbl.DelAllEqualOnWordIDs(aIDs : Sab);
var
 lLongSab      : Sab;
 lCurWordValue : Word;
 lCurValue,
 lPos          : Longint;
begin
 Ht(htOpenResults(aIDs,ROPEN_READ,nil,0));
 try
  HtCreateEmptySAB(nil,lLongSab,Handle,eqFID_Fld,Res_Value);
  try
   Ht(htOpenResults(lLongSab,ROPEN_READ,nil,0));
   lPos:=0;
   try
    while (htReadResults(aIDs,@lCurWordValue,SizeOf(lCurWordValue))<>0) do
    Begin
     lCurValue:=lCurWordValue;
     Ht(htIncludeResultsItem(lLongSab,lPos,@lCurValue));
     Inc(lPos);
    end;
   finally
    htCloseResults(lLongSab);
   end;

   DelAllEqualOnIDs(lLongSab);
  finally
   htClearResults(lLongSab);
  end;
 finally
  htCloseResults(aIDs);
 end;
end;

procedure TEqualItemsTbl.AddEqualsTo(aIDs: Tl3LongintList);
const
 c_Marked = -1;
var
 //l_Iter: TValuesIterator;
 //l_Rec: TEqualRec;
 l_Arr: Tl3DynamicArrayEx;
 l_ArrIndex: Integer;
 J: Integer;
 K: Integer;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 begin
  Result := True;
  PEqualRec(l_Arr[l_ArrIndex])^ := PEqualRec(aItemPtr)^;
 end;

 procedure MarkEqualsFor(aID: Integer); // �����������
 var
  I: Integer;
 begin
  for I := 0 to l_Arr.Count - 1 do
   if PEqualRec(l_Arr[I])^.FirstID = aID then     // ���, �����
   begin
    PEqualRec(l_Arr[I])^.FirstID := c_Marked;      // ������ �������
    MarkEqualsFor(PEqualRec(l_Arr[I])^.SecondID);
   end;
 end;

var
 lSab : ISab;
 lRAProcStub : TdtRecAccessProc;
begin
 if (aIds = nil) or (aIds.Count = 0) then
  Exit;

 // �������� ��� ������ �� ������� � ���. ������
 l_Arr := Tl3DynamicArrayEx.Create(SizeOf(TEqualRec));
 try
  lSab := MakeAllRecords(Self);
  //RefreshSrchList;
  l_Arr.Capacity := lSab.Count;
  lRAProcStub := L2RecAccessProc(@lRecAccessProc);
  try
   lSab.IterateRecords(lRAProcStub, [eqFID_Fld, eqSID_Fld]);
  finally
   FreeRecAccessProc(lRAProcStub);
  end;


  {lHTSab := lSab.HTSab;
  l_Iter := TValuesIterator.Create(lHTSab, eqOpenFldArr, Self);
  try
   l_ArrIndex := 0;
   while not l_Iter.EOF do
   begin
    l_Iter.Read(eqFID_Fld, l_Rec.FirstId);
    l_Iter.Read(eqSID_Fld, l_Rec.SecondId);
    PEqualRec(l_Arr[l_ArrIndex])^ := l_Rec;
    Inc(l_ArrIndex);
    l_Iter.Next;
   end;
  finally
   L3Free(l_Iter);
  end; }

  // ���������� ����� �������������.
  // ��� ��������� �������� (� ��� ����� ������ SecondId) ������ �� �������������,
  // � ������ �������� ����. �������:   FirstId := c_Marked � ���� ����.
  for K := 0 to aIds.Count - 1 do
   MarkEqualsFor(Longint(aIDs.Items[K])); // ������ ��������

  // ����������� ��������� (����������) �������� � aIds
  // ��������! �������� �������� �� ������� (�������� aIds.Clear �� ������)
  aIds.Duplicates := l3_dupIgnore;
  for J := 0 to l_Arr.Count - 1 do
   if PEqualRec(l_Arr[J])^.FirstID = c_Marked then // ���� ����� �������
    aIds.Add(PEqualRec(l_Arr[J])^.SecondID);

 finally
  l3Free(l_Arr);
 end;
end;

end.
