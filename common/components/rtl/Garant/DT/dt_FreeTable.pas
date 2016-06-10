unit dt_FreeTable;

// ����������� ������� ������� ��� ������ � FREE

{ $Id: dt_FreeTable.pas,v 1.5 2016/04/18 12:54:15 fireton Exp $ }
// $Log: dt_FreeTable.pas,v $
// Revision 1.5  2016/04/18 12:54:15  fireton
// - ��������� ����������� ������� FREE �� Tl3CardinalList
//
// Revision 1.4  2015/11/26 08:45:44  lukyanets
// ��������� ���������
//
// Revision 1.3  2014/04/17 13:04:31  voba
// - ������� ISab �� DT_Sab � dtIntf
//
// Revision 1.2  2013/10/30 10:36:40  voba
// - ����� �� fSrchList
//
// Revision 1.1  2011/12/14 09:43:03  narry
// ���������� ���� � ������� Sub001 (303171256)
//
// Revision 1.5  2009/06/02 09:37:22  narry
// - ���������� ������ � ����������� �������
//
// Revision 1.4  2009/05/13 13:55:35  voba
// - ������� TblH �� Handle
//
// Revision 1.3  2009/05/04 13:49:24  voba
// - bug fix �������� �� ����������� ��������
//
// Revision 1.2  2008/02/15 08:51:08  fireton
// - l3LongintList
//
// Revision 1.1  2007/05/11 08:24:14  narry
// - ����������� ���� ������
//


interface

uses
 dt_ATbl, dt_Types, dt_Free, dt_Const,
 ht_Const,
 l3Base, l3LongintList, l3CardinalList, l3RecList;

type
(*
  PFreeDiap
  Rec = ^TFreeDiapRec;
  TFreeDiapRec = packed record
   rName: String;
   rFrom: LongWord;
   rTo  : LongWord;
  end;
*)
  TdbFreeTable = class(TAbsHtTbl)
   private
    f_TableFamily: Integer;
    function  NameArrAsStr(aNameArr: TNameArr): string;
   protected
    fFreeRec  : TFreeRec;

    fSrchSab,
    fFreeSab  : SAB;

    fNumList  : Tl3LongintList;
    fListPos  : LongInt;

     // ����� ������������� ����� ���� �����
    function HasIntersection(aName: TTblNameStr; aLowNum, aHiNum: LongWord): Boolean;
    Function    NameForSearch(const aTableName: TTblNameStr): TNameArr;
   public
    procedure   ExcludeFreeFromTable(aName : TTblNameStr; aNum: LongWord);
    procedure   AddInterval(aName: TTblNameStr; aLowNum: LongWord = 1; aHiNum: LongWord = NO_LIMIT);
    procedure ExcludeFreeNumsFromTable(aName : TTblNameStr; aNums: Tl3CardinalList); overload;
     // ���� ������� ������ �������� = aNum, � �� ��������, �� ��� �������� ��������� �� �������.
     // ����� - ���� ������� ��������, ���������� aNum, �� ���� �������� (������ ����!) ���������� �����, �� ��� ����� aNum (������������)
     // �����������: �������� ���������� ������, ��� ��� ������� �����, ��� ������� ��� (�, ��������������, �������, ������ etc.).
     //              �� ������ ���������� ��������� � ���������� ��������� ��������� �� ������� - "��� ����� - ����� �����".
    procedure ExcludeFreeNumsFromTable(aName : TTblNameStr; aFromNum, aToNum: LongWord); overload;
    procedure GetIntervalList(aName: TTblNameStr; theList: Tl3RecList);
    property TableFamily: Integer read f_TableFamily write f_TableFamily;
  end;

implementation

Uses
 SysUtils,
 daSchemeConsts,
 dt_Err,
 l3String,
 ht_Dll, dtIntf, dt_Sab;

function RangeTruncation(var aMinuendStart, aMinuendEnd: LongWord;
                         var aAddedStart, aAddedEnd: Longword;
                         const aSubtrahendStart, aSubtrahendEnd: LongWord): Boolean;
begin
 Result := (aSubtrahendEnd >= aMinuendStart) and (aSubtrahendStart <= aMinuendEnd);
 // Result =  ����� �� ����� ����������� Minuend (�����������) � Subtrahend (����������)

 aAddedStart := NO_LIMIT; // ������, ��� ���� ����� �������� �� ��������� �� ����������

 if Result then
 begin
  // - ���� ������ ���� Subtrahend ������ Minuend (��� ���� ����� �.�. ��� ������, ��� � �������)
  if (aMinuendStart <= aSubtrahendEnd) and (aSubtrahendEnd <= aMinuendEnd) then
  begin
   if aMinuendStart < aSubtrahendStart then // ����� ���� ������?
   begin
    // Subtrahend ��������� ������ Minuend - ���� ������ �������� �� ���
    aAddedStart := aMinuendStart;
    aAddedEnd   := aSubtrahendStart-1;
    aMinuendStart := aSubtrahendEnd+1;
   end
   else
    // ������ �������� ����� ����� Minuend
    aMinuendStart := aSubtrahendEnd + 1
  end

  // - ���� ����� ���� Subtrahend ������ Minuend
  else if (aMinuendStart <= aSubtrahendStart) and (aSubtrahendStart <= aMinuendEnd) then
   // �� �������� ������ ����� Minuend
   aMinuendEnd := aSubtrahendStart - 1

  // - ���� Minuend ������� ���������� ������ Subtrahend
  else if (aSubtrahendStart <= aMinuendStart) and (aMinuendEnd <= aSubtrahendEnd) then
   // �� �������� ��� Minuend ������
   aMinuendStart := aMinuendEnd + 1;
 end;
end;

const
 c_EmptyLimit : SmallInt = 0;

procedure TdbFreeTable.AddInterval(aName: TTblNameStr;
                               aLowNum: LongWord = 1;
                               aHiNum: LongWord = NO_LIMIT);
var
 l_FoundByFreeNum,
 l_FoundByLimit: Sab;
 l_Tmp: LongWord;
 l_Rec: TFreeRec;
begin
 // ������� �������������� ������� ������
 if aLowNum > aHiNum then
 begin
  l_Tmp := aHiNum;
  aHiNum := aLowNum;
  aLowNum := l_Tmp;
 end;
 if aHiNum > NO_LIMIT then aHiNum := NO_LIMIT; 

 // �������� �� ����������� - ���� ����������� ���� ����, �� ����������� ����������.
 if HasIntersection(aName, aLowNum, aHiNum) then
  raise Exception.Create('���������� �������� ����� �������� � ������� FREE, �.�. ��������� �������� � ��� ���������� ����������.');

 // �������� ���������� ���� �������� ����������� �� ��� ��������, � ��� ��������� �������
 if aLowNum = aHiNum then
  aHiNum := c_EmptyLimit;

 // ���������� ����������
 If StartTA(MaxFreeOpTime) then
  Try
   l_Rec.TblName := NameForSearch(aName);
   l_Rec.FreeNum := aLowNum;
   l_Rec.Limit   := aHiNum;

   Ht(htRecordAdd(Handle, @l_Rec));
   SuccessTA;
  except
   RollBackTA;
   raise EHtErrors.CreateInt(ecFreeTblErr);
  end
 else
  raise EHtErrors.CreateInt(ecFreeTblErr);
end;

procedure TdbFreeTable.ExcludeFreeFromTable(aName: TTblNameStr;
                                        aNum: LongWord);
var
 SrchStr : TNameArr;
 l_FoundRec: TFreeFullRec;
 l_FoundRecs: Sab;
 I: Integer;
 l_AllDone: Boolean;
 l_AddStart, l_AddEnd: Longword;
 l_Rec: TFreeRec;
begin
 l_AllDone := False;
 SrchStr:=NameForSearch(aName);

 if StartTA(MaxFreeOpTime) then
 try
  // ���������� �� TblName
  htSearch(nil,fSrchSab,Handle,1,EQUAL,@SrchStr,Nil);
  try
   if (fSrchSab.gFoundCnt <> 0) then
   begin
    // ���� ������ ����������
    htSubSearch(fSrchSab,
                l_FoundRecs,
                Handle,
                ftFreeNum,
                EQUAL,
                @aNum,
                nil);
    try
     if l_FoundRecs.gFoundCnt > 0 then
     begin
      Ht(htOpenResults(l_FoundRecs, ROPEN_READ, nil, 0));
      try
       htReadResults(l_FoundRecs, @l_FoundRec, SizeOf(l_FoundRec));
       if (l_FoundRec.Limit = c_EmptyLimit) then // �� ��������
       begin
        Ht(htRecordDelete(Handle, l_FoundRec.RecNo));
        l_AllDone := True;
       end;
      finally
       htCloseResults(l_FoundRecs);
      end;
     end;
    finally
     htClearResults(l_FoundRecs);
    end;

    // ������ ���������� �� ������� - ���� ���������� ��������
    if not l_AllDone then
    begin
     htSubSearch(fSrchSab,
                 l_FoundRecs,
                 Handle,
                 ftLimit,
                 NOT_EQUAL,
                 @c_EmptyLimit,
                 nil); // ��� ���������
     try
      if l_FoundRecs.gFoundCnt > 0 then
      begin
       Ht(htOpenResults(l_FoundRecs, ROPEN_READ, nil, 0));
       try
        for I := 0 to l_FoundRecs.gFoundCnt - 1 do
        begin
         htReadResults(l_FoundRecs, @l_FoundRec, SizeOf(l_FoundRec));

         // ������ � ��������?
         if (aNum >= l_FoundRec.FreeNum) and (aNum <= l_FoundRec.Limit) then
         begin
          // ���������, ����� ��� ���� �� ������� ��������?
          // � ���� ������ ���������� ������ ��������������� ������...
          l_AddStart := NO_LIMIT; // ��������� ���� ������ �� ����������
          if l_FoundRec.FreeNum = aNum then
           l_FoundRec.FreeNum := aNum+1
          else
           if l_FoundRec.Limit = aNum then
            l_FoundRec.Limit := aNum-1
           else // ����� - ������ ���������. ����� �������� �� ���.
           begin
            l_AddStart := aNum+1;
            l_AddEnd   := l_FoundRec.Limit;
            l_FoundRec.Limit := aNum - 1;
           end;
          // ���������� � ���� ��� �� ����������� ���
          if l_FoundRec.FreeNum <= l_FoundRec.Limit then
           Ht(htRecordModify(Handle, l_FoundRec.RecNo, @l_FoundRec.TblName))
          else
           Ht(htRecordDelete(Handle, l_FoundRec.RecNo));
          if l_AddStart <> NO_LIMIT then
          begin
           l_Rec.TblName := l_FoundRec.TblName;
           l_Rec.FreeNum := l_AddStart;
           l_Rec.Limit   := l_AddEnd;
           Ht(htRecordAdd(Handle, @l_Rec));
          end;
          Break;
         end; // if
        end; // for
       finally
        htCloseResults(l_FoundRecs);
       end;
      end; // if
     finally
      htClearResults(l_FoundRecs);
     end;
    end; // if
   end // if
   else
   // ��������� ������ �������� ����� ���������� �����
    AddInterval(aName, Succ(aNum));
  finally
   htClearResults(fSrchSab);
  end;
  SuccessTA;
 except
  RollBackTA;
  raise;
 end;
end;

procedure TdbFreeTable.ExcludeFreeNumsFromTable(aName: TTblNameStr; aNums: Tl3CardinalList);
type
 TTableRec = packed record
               RecNo,
               FreeNum,
               Limit,
               NewFreeNum: LongWord;
               ToDelete: Boolean;
              end;
var
 l_TblName: TNameArr;
 l_AllRecs: Sab;
 l_Rec: TFreeFullRec;
 l_ArrSize: Integer;
 l_TableData: array of TTableRec;

 I,
 J: Integer;
Begin
 if (aNums = nil) or (aNums.Count = 0) then
  Exit;

 l_TblName := NameForSearch(aName);

 // ��������� ������ �� �������
 try
  htSearch(nil,
           l_AllRecs,
           Handle,
           ftTblName,
           EQUAL,
           @l_TblName,
           nil);


  try
   Ht(htOpenResults(l_AllRecs, ROPEN_READ, nil, 0));
   try
    // ��������� ������ � ��������� ������
    l_ArrSize := l_AllRecs.gFoundCnt;
    SetLength(l_TableData, l_ArrSize);

    for I := 0 to l_AllRecs.gFoundCnt - 1 do
    begin
     htReadResults(l_AllRecs, @l_Rec, SizeOf(l_Rec));
     l_TableData[I].RecNo      := l_Rec.RecNo;
     l_TableData[I].FreeNum    := l_Rec.FreeNum;
     l_TableData[I].NewFreeNum := l_Rec.FreeNum;
     l_TableData[I].Limit      := l_Rec.Limit;
     l_TableData[I].ToDelete   := False;
    end;
   finally
    htCloseResults(l_AllRecs);
   end;
  finally
   htClearResults(l_AllRecs);
  end;
  for I := 0 to aNums.Count - 1 do // �������  ������
   for J := 0 to l_ArrSize - 1 do   // ������� �������
   begin
    if l_TableData[J].Limit = c_EmptyLimit then
    begin // ����� ������� ����������
     if (l_TableData[J].FreeNum = aNums[I]) then
     begin
      l_TableData[J].ToDelete := True;
      Break;
     end; // if
    end
    else
    begin // �������� �� ��������� � ��������
     if   (aNums[I] >= l_TableData[J].NewFreeNum)
      and (aNums[I] <= l_TableData[J].Limit) then
     begin
      l_TableData[J].NewFreeNum := aNums[I]; // �������� ����� ����� ���������
      Break;
     end; // if
    end; // if-else
   end; // for
  // for

  // ���������� ��������� ������ � �������
  if StartTA(MaxFreeOpTime) then
   try
    for I := 0 to l_ArrSize - 1 do
    begin
     if l_TableData[I].ToDelete then
      Ht(htRecordDelete(Handle, l_TableData[I].RecNo))
     else if l_TableData[I].FreeNum <> l_TableData[I].NewFreeNum then
     begin
      l_Rec.TblName := l_TblName;
      l_Rec.FreeNum := Succ(l_TableData[I].NewFreeNum);
      l_Rec.Limit   := l_TableData[I].Limit;
      Ht(htRecordModify(Handle, l_TableData[I].RecNo, @l_Rec.TblName));
     end;
    end;

    SuccessTA;
   except
    RollBackTA;
    raise EHtErrors.CreateInt(ecFreeTblErr);
   end
  else
   raise EHtErrors.CreateInt(ecFreeTblErr);

 finally
  l_TableData := nil;
 end;
end;

function TdbFreeTable.HasIntersection(aName: TTblNameStr; aLowNum, aHiNum: LongWord): Boolean;
var
 l_TblName: TNameArr;
 l_FoundByTblName,
 l_FoundByFreeNum,
 l_FoundByLimit: Sab;
 l_Tmp: LongWord;
begin
 // ��������: ����������� ����� �����, ���� ������� ���� ���� ��������, � ��������
 //           Limit(�.�. ������ �����) > aLowNum  �  FreeNum(�.�. ����� �����) < aHiNum
 Result := False;

 l_TblName := NameForSearch(aName);
 htSearch(nil,
          l_FoundByTblName,
          Handle,
          ftTblName,
          EQUAL,
          @l_TblName,
          nil);
 try
  if l_FoundByTblName.gFoundCnt > 0 then
  begin
   htSubSearch(l_FoundByTblName,
               l_FoundByLimit,
               Handle,
               ftLimit,
               GREAT_EQUAL,
               @aLowNum,
               nil);
   try
    if l_FoundByLimit.gFoundCnt > 0 then
    begin
     htSubSearch(l_FoundByLimit,
                 l_FoundByFreeNum,
                 Handle,
                 ftFreeNum,
                 LESS_EQUAL,
                 @aHiNum,
                 nil);
     try
      Result := l_FoundByFreeNum.gFoundCnt > 0;
     finally
      htClearResults(l_FoundByFreeNum);
     end;
    end; // if
   finally
    htClearResults(l_FoundByLimit);
   end;
  end; // if

  // �� �, ���� � �����, ���� ������ �������� ����� ����� aLowNum, aHiNum, �� ���� - ��������.
  if not Result then
  begin
   htSubSearch(l_FoundByTblName,
               l_FoundByFreeNum,
               Handle,
               ftFreeNum,
               IN_RANGE,
               @aLowNum,
               @aHiNum);
   try
    if l_FoundByFreeNum.gFoundCnt > 0 then
    begin
     htSubSearch(l_FoundByFreeNum,
                 l_FoundByLimit,
                 Handle,
                 ftLimit,
                 EQUAL,
                 @c_EmptyLimit,
                 nil);
     try
      Result := l_FoundByLimit.gFoundCnt > 0;
     finally
      htClearResults(l_FoundByLimit);
     end;
    end; // if
   finally
    htClearResults(l_FoundByFreeNum);
   end;
  end; // if

 finally
  htClearResults(l_FoundByTblName);
 end;
end;

function TdbFreeTable.NameArrAsStr(aNameArr: TNameArr): string;
begin
 SetLength(Result, SizeOf(TNameArr));
 StrLCopy(PChar(Result), @aNameArr, SizeOf(TNameArr));
end;

Function TdbFreeTable.NameForSearch(const aTableName: TTblNameStr): TNameArr;
const
 c_BadFamily = -1;
Var
 TmpStr : ShortString;
Begin
 TmpStr:=UpperCase(aTableName);
 If (TableFamily <> MainTblsFamily)
  and (TableFamily = StrToIntDef(Copy(aTableName, Length(aTableName) - 2, 3), c_BadFamily)) // ��������� 3 ������� �������� ������� ���������
 then
   SetLength(TmpStr,Length(TmpStr)-3);
 l3StringToArray(Result,SizeOf(Result),TmpStr);
end;

procedure TdbFreeTable.ExcludeFreeNumsFromTable(aName: TTblNameStr; aFromNum, aToNum: LongWord);
var
 SrchStr : TNameArr;
 l_FoundRec: TFreeFullRec;
 l_Rec: TFreeRec;
 l_FoundRecs,
 l_RecsToDelete: Sab;
 I: Integer;
 l_AddStart, l_AddEnd: Longword;
begin
 SrchStr:=NameForSearch(aName);

 if StartTA(MaxFreeOpTime) then
 try
  // ���������� �� TblName
  htSearch(nil,fSrchSab,Handle,1,EQUAL,@SrchStr,Nil);
  try
   if (fSrchSab.gFoundCnt <> 0) then
   begin
    // ���� "��������� ������"
    // ��������� �� �������� "���������� ������"
    htSubSearch(fSrchSab,
                l_FoundRecs,
                Handle,
                ftLimit,
                EQUAL,
                @c_EmptyLimit,
                nil);
    try
     if l_FoundRecs.gFoundCnt > 0 then
     begin
      // ��������� �� ��������� � ��������
      htSubSearch(l_FoundRecs,
                  l_RecsToDelete,
                  Handle,
                  ftFreeNum,
                  IN_RANGE,
                  @aFromNum,
                  @aToNum);
      try
       if l_RecsToDelete.gFoundCnt > 0 then
        htDeleteRecords(l_RecsToDelete);
      finally
       htClearResults(l_RecsToDelete);
      end;
     end;
    finally
     htClearResults(l_FoundRecs);
    end;

    // ���� ���������� ���������
    // ��������� �� �������� ���������� "���������� ������"
    htSubSearch(fSrchSab,
                l_FoundRecs,
                Handle,
                ftLimit,
                NOT_EQUAL,
                @c_EmptyLimit,
                nil); // ��� ���������
    try
     if l_FoundRecs.gFoundCnt > 0 then
     begin
      Ht(htOpenResults(l_FoundRecs, ROPEN_READ, nil, 0));
      try
       for I := 0 to l_FoundRecs.gFoundCnt - 1 do
       begin
        htReadResults(l_FoundRecs, @l_FoundRec, SizeOf(l_FoundRec));

        if RangeTruncation(l_FoundRec.FreeNum,
                           l_FoundRec.Limit,
                           l_AddStart, l_AddEnd,
                           aFromNum,
                           aToNum) then // ����� ����� �����������?
        begin
         if l_FoundRec.FreeNum <= l_FoundRec.Limit then
         begin
          Ht(htRecordModify(Handle, l_FoundRec.RecNo, @l_FoundRec.TblName));
          if l_AddStart <> NO_LIMIT then // �������� ���������...
          begin
           l_Rec.TblName := l_FoundRec.TblName;
           l_Rec.FreeNum:=l_AddStart;
           l_Rec.Limit := l_AddEnd;
           Ht(htRecordAdd(Handle, @l_Rec));
          end;
         end
         else
          Ht(htRecordDelete(Handle, l_FoundRec.RecNo));
        end; // if
       end; // for
      finally
       htCloseResults(l_FoundRecs);
      end;
     end; // if
    finally
     htClearResults(l_FoundRecs);
    end;
   end; // if
  finally
   htClearResults(fSrchSab);
  end;
  SuccessTA;
 except
  RollBackTA;
  raise;
 end;
end;

procedure TdbFreeTable.GetIntervalList(aName: TTblNameStr; theList: Tl3RecList);
var
 l_Sab  : ISab;
 l_Iter : TdtRecAccessProc;
 l_Res  : Tl3RecList;
 l_Name : TNameArr;

 function Iterator(aRec : PFreeRec) : Boolean; register;
 var
  l_ResRec: TFreeRec;
 begin
  Result := True;
  l_ResRec.TblName := aRec.TblName;
  l_ResRec.FreeNum := aRec.FreeNum;
  l_ResRec.Limit   := aRec.Limit;
  theList.Add(l_ResRec);
 end;

begin
 l_Sab := MakeSab(Self);
 try
  l_Name := NameForSearch(aName);
  l_Sab.Select(ftTblName, l_Name);
  if l_Sab.Count > 0 then
  begin
   l_Sab.Sort([ftFreeNum]);
   //l_Res := Tl3RecList.Create(SizeOf(TFreeRec));
   l_Iter := L2RecAccessProc(@Iterator);
   try
    l_Sab.IterateRecords(l_Iter, [ftTblName, ftFreeNum, ftLimit]);
   finally
    FreeRecAccessProc(l_Iter);
   end;
  end;
 finally
  l_Sab := nil;
 end;
end;


end.
