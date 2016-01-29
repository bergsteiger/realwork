unit DT_FormulaProcessor;

{ $Id: DT_FormulaProcessor.pas,v 1.3 2015/07/02 11:41:29 lukyanets Exp $ }

// $Log: DT_FormulaProcessor.pas,v $
// Revision 1.3  2015/07/02 11:41:29  lukyanets
// Описываем словари
//
// Revision 1.2  2010/09/28 13:06:08  fireton
// - Распределяем память для PChar своими средствами
//
// Revision 1.1  2008/09/18 07:12:29  voba
// - move AskList to DT_AskList, FormulaProcessor to DT_FormulaProcessor
//


interface
(*
  Структура формулы запроса.

  Formula - Term1 Operator Term2 ...

  Operator - [&,|]                И и ИЛИ

  Term - TermID_TermNum=TermData  TermID - Идентификатор вида поиска;
                                  TermNum - Дополнительное числовое значение (м. не быть);
                                  TermData - Данные для поиска.

  Term1 - Dict_NN=ID1,ID2,..IDN   Поиск по значениям в словаре, перечисленные значения,
                                  соединяются по или. NN - номер словаря.

  Term2 - Date_TT=Date1-Date2     Нулевое значение одной из дат означает открытый интервал.
                                  TT - тип даты.

  Term3 - Numb_TT=NumMask         Поиск по номеру с использованием * и ?. TT - тип номера.

  Term4 - Text_NA=TextMask        Пиоиск по контексту. NA - глубина поиска в абзацах.
*)

 TTermType = (tNone,tDict,tDate,tNumb{,tText});
 TTermID = Array [1..4] of Char;
Const
 MaxTermType = 4;
 TermPrefix : Array[1..MaxTermType] of TTermID = ('DICT','DATE','NUMB','TEXT');
 EndTermSet : Set of Char = [#0,')','&','|'];
Type
 TFormulaProcessor = Class
  protected
   fFamily    : TFamilyID;
   fCurDocSab : Sab;

   procedure SetFamily(aFamily : TFamilyID);
   function  GetNum(var Pos : PChar) : LongInt;
   function  GetStDate(var Pos : PChar) : TStDate;
   function  GetText(var Pos : PChar) : PChar;

   function  ProcessTerm(var Pos : PChar) : Sab;
  public
   function  ProcessFormula(aFormula : PChar) : Sab;

   procedure RefreshDocSet;

   Property  Family : TFamilyID read fFamily write SetFamily;
 end;


implementation

uses
 daTypes;

type
 TOperationType = (otNone,otOr,otAnd);

{ TFormulaProcessor }

procedure TFormulaProcessor.SetFamily(aFamily : TFamilyID);
begin
 fFamily:=aFamily;
 if fFamily<>0
  then
   begin
    DocumentServer.Family:=fFamily;
    DocumentServer.FileTbl.RefreshSrchList;
    Ht(htCopyResults(fCurDocSab,DocumentServer.FileTbl.fSrchList));
   end
  else
   begin
    htClearResults(fCurDocSab);
    l3FillChar(fCurDocSab,SizeOf(Sab));
   end;
end;

procedure TFormulaProcessor.RefreshDocSet;
begin
 if fFamily<>0
  then
   begin
    DocumentServer.Family:=fFamily;
    DocumentServer.FileTbl.RefreshSrchList;
    if htResultsType(fCurDocSab) <> Res_NProc
     then
      htClearResults(fCurDocSab);
    Ht(htCopyResults(fCurDocSab,DocumentServer.FileTbl.fSrchList));
   end
end;

function TFormulaProcessor.GetNum(var Pos : PChar) : LongInt;
var
 StartPos : PChar;
 TmpChar  : Char;
 TmpCode  : Integer;
begin
 StartPos:=Pos;
 While Not (Pos[0] in [' ','=',',']) and
       Not (Pos[0] in EndTermSet) do
  Pos:=Pos+1;

 TmpChar:=Pos[0];
 Pos[0]:=#0;
 Val(StartPos,Result,TmpCode);
 Pos[0]:=TmpChar;
end;

function TFormulaProcessor.GetStDate(var Pos : PChar) : TStDate;
var
 StartPos : PChar;
 TmpLen   : Word;
begin
 StartPos:=Pos;
 While Not (Pos[0] in [' ',',','-']) and
       Not (Pos[0] in EndTermSet) do
  Pos:=Pos+1;

 TmpLen:=LongInt(Pos)-LongInt(StartPos);
 Result:=FlexStrLen2StDate(StartPos,TmpLen);
end;

function TFormulaProcessor.GetText(var Pos : PChar) : PChar;
var
 StartPos     : PChar;
 CurPos,
 TmpLen       : Word;
 TextStart,
 TextEnd      : Boolean;
begin
 TmpLen:=0;
 TextStart:=False;
 TextEnd:=False;
 StartPos:=Pos;
 Repeat
  case Pos[0] of
   '"': if TextStart
         then
          begin
           if Pos[1]='"'
            then
             begin
              Pos:=Pos+2;
              Inc(TmpLen);
             end
            else
             TextEnd:=True;
          end
         else
          begin
           TextStart:=True;
           Pos:=Pos+1;
          end;
   else
    begin
     Pos:=Pos+1;
     if TextStart then Inc(TmpLen);
    end;
  end;
 until TextEnd;

 TextStart:=False;
 TextEnd:=False;
 Pos:=StartPos;
 Result := l3StrAlloc(TmpLen+1);
 l3FillChar(Result^,TmpLen+1);
 CurPos:=0;
 Repeat
  case Pos[0] of
   '"': if TextStart
         then
          begin
           if Pos[1]='"'
            then
             begin
              Result[CurPos]:=Pos[0];
              Inc(CurPos);
              Pos:=Pos+2;
             end
            else
             begin
              TextEnd:=True;
              Pos:=Pos+1;
             end;
          end
         else
          begin
           TextStart:=True;
           Pos:=Pos+1;
          end;
   else
    begin
     if TextStart
      then
       begin
        Result[CurPos]:=Pos[0];
        Inc(CurPos);
       end;
     Pos:=Pos+1;
    end;
  end;
 until TextEnd;
end;

function TFormulaProcessor.ProcessTerm(var Pos : PChar) : Sab;
Type
 TOperationFlag = (ofNone,ofNums,ofData);
var
 I         : Byte;
 CurType   : TTermType;
 CurNum    : LongInt;
 CurFlag   : TOperationFlag;

 function GetDictData(var Pos : PChar) : Sab;
 Const
  MaxBufRecords = 100;
 Type
  PDictIDArr = ^TDictIDArr;
  TDictIDArr = Array [0..MaxBufRecords-1] of TDictID;
 var
  SabPos    : LongInt;
  TmpBuf    : Pointer;
  CurType   : TdaDictionaryType;
  Values,
  ResValues : Sab;
 begin
  CurType:=TdaDictionaryType(CurNum);
  LinkServer.Family:=fFamily;
  LinkServer[CurType].RefreshSrchList;
  htCreateEmptySAB(@LinkServer[CurType].fSrchList,Values,
                   LinkServer[CurType].TblH,lnkDictIDFld,Res_Value);
  Ht(htOpenResults(Values,ROPEN_READ,Nil,0));
  try
   SabPos:=0;
   l3System.GetLocalMem(TmpBuf,MaxBufRecords*SizeOf(TDictID));
   try
    Repeat
     case Pos[0] of
      ',',
      ' '  : Pos:=Pos+1;
      else
       begin
        PDictIDArr(TmpBuf)^[SabPos]:=GetNum(Pos);
        Inc(SabPos);
        if (SabPos = MaxBufRecords)
         then
          begin
           Ht(htIncludeResultsBlock(Values,0,TmpBuf,
                                    SabPos*SizeOf(TDictID)));
           SabPos:=0;
          end;
       end;
     end;
    until Pos[0] in EndTermSet;
    if SabPos<>0
     then
      Ht(htIncludeResultsBlock(Values,0,TmpBuf,
                               SabPos*SizeOf(TDictID)));
   finally
    l3System.FreeLocalMem(TmpBuf);
   end;
  finally
   htCloseResults(Values);
  end;
  Ht(htSortResults(ResValues,Values,@lnkDictIDFld,1));
  htClearResults(Values);
  LinkServer[CurType].SrchOnBodies(ResValues,Values,Nil,False);
  htClearResults(ResValues);
  try
   htTransferToPhoto(Values,fCurDocSab,fID_Fld);
   htRecordsByKey(Result,Values);
  finally
   htClearResults(Values);
  end;
 end;

 function GetDateData(var Pos : PChar) : Sab;
 var
  Date1,
  Date2        : TStDate;
  IntervalFlag : Boolean;

  SrchTblH     : HT_Const.THandle;
  SrchList     : LPSAB;

  DateList,
  BlankDateList,
  TypList,
  Res1List,
  Res2List     : SAB;
 begin
  Date1:=0;
  Date2:=0;
  IntervalFlag:=False;
  Repeat
   case Pos[0] of
    '-'  : begin
            IntervalFlag:=True;
            Pos:=Pos+1;
           end;
    ' '  : Pos:=Pos+1;
    else
     begin
      if Date1 = 0
       then
        Date1:=GetStDate(Pos)
       else
        Date2:=GetStDate(Pos);
     end;
   end;
  until Pos[0] in EndTermSet;

  DictServer.Family:=fFamily;
  LinkServer.Family:=fFamily;
  SrchTblH:=DictServer.GroupTbl[da_dlDateNums].TblH;
  DictServer.GroupTbl[da_dlDateNums].RefreshSrchList;
  SrchList:=@DictServer.GroupTbl[da_dlDateNums].fSrchList;

  if (Date1<>0) and (Date2<>0)
   then
    htSearch(SrchList,DateList,SrchTblH,dnDateFld,IN_RANGE,@Date1,@Date2)
   else
    if (Date1<>0)
     then
      begin
       if IntervalFlag
        then
         htSearch(SrchList,DateList,SrchTblH,dnDateFld,GREAT_EQUAL,@Date1,Nil)
        else
         htSearch(SrchList,DateList,SrchTblH,dnDateFld,EQUAL,@Date1,Nil);
      end
     else
      begin
       htSearch(SrchList,Res1List,SrchTblH,dnDateFld,LESS_EQUAL,@Date2,Nil);
       try
        htSearch(SrchList,BlankDateList,SrchTblH,dnDateFld,EQUAL,@BlankDate,Nil);
        try
         htXorResults(DateList,Res1List,BlankDateList);
        finally
         htClearResults(BlankDateList);
        end;
       finally
        htClearResults(Res1List);
       end;
      end;
  if TDNType(CurNum) = dnDoc
   then
    Res1List:=DateList
   else
    begin
     htSearch(SrchList,TypList,SrchTblH,dnTypFld,EQUAL,@CurNum,Nil);
     try
      htAndResults(Res1List,DateList,TypList);
     finally
      htClearResults(DateList);
      htClearResults(TypList);
     end;
    end;

  htValuesOfKey(Res2List,dnIDFld,Res1List);
  htClearResults(Res1List);
  LinkServer[da_dlDateNums].SrchOnBodies(Res2List,Res1List,Nil,True);
  htClearResults(Res2List);
  try
   htTransferToPhoto(Res1List,fCurDocSab,fID_Fld);
   htRecordsByKey(Result,Res1List);
  finally
   htClearResults(Res1List);
  end;
 end;

 function GetNumData(var Pos : PChar) : Sab;
 var
  CurFormula : PChar;

  TmpNum   : PChar;
  TmpLen   : Word;

  SrchTblH : HT_Const.THandle;
  SrchList : LPSAB;

  NumList,
  TypList,
  Res1List,
  Res2List  : SAB;
 begin
  CurFormula:=GetText(Pos);
  try
   DictServer.Family:=fFamily;
   LinkServer.Family:=fFamily;
   SrchTblH:=DictServer.GroupTbl[da_dlDateNums].TblH;
   DictServer.GroupTbl[da_dlDateNums].RefreshSrchList;
   SrchList:=@DictServer.GroupTbl[da_dlDateNums].fSrchList;

   TmpLen:=StrLen(CurFormula);
   if TmpLen<DictServer.GroupTbl[da_dlDateNums].fldLength[dnNumFld]
    then
     begin
      TmpNum := l3StrAlloc(TmpLen+3);
      try
       l3Move(CurFormula^,TmpNum^,TmpLen);
       TmpNum[TmpLen]:=' ';
       TmpNum[TmpLen+1]:='*';
       TmpNum[TmpLen+2]:=#0;
       htSearch(SrchList,NumList,SrchTblH,dnNumFld,WILDCASE,TmpNum,Nil);
      finally
       l3StrDispose(TmpNum);
      end;
     end
    else
     htSearch(SrchList,NumList,SrchTblH,dnNumFld,Equal,CurFormula,Nil);

   if TDNType(CurNum) = dnDoc
    then
     Res1List:=NumList
    else
     begin
      htSearch(SrchList,TypList,SrchTblH,dnTypFld,EQUAL,@CurNum,Nil);
      try
       htAndResults(Res1List,NumList,TypList);
      finally
       htClearResults(NumList);
       htClearResults(TypList);
      end;
     end;

   htValuesOfKey(Res2List,dnIDFld,Res1List);
   htClearResults(Res1List);
   LinkServer[da_dlDateNums].SrchOnBodies(Res2List,Res1List,Nil,True);
   htClearResults(Res2List);
   try
    htTransferToPhoto(Res1List,fCurDocSab,fID_Fld);
    htRecordsByKey(Result,Res1List);
   finally
    htClearResults(Res1List);
   end;
  finally
   l3StrDispose(CurFormula);
  end;
 end;

(*
 function GetTextData(var Pos : PChar) : Sab;
 var
  CurFormula : PChar;
// !!! STUB !!!  
  CurPkgObj  : TmgFamilyPackageSet;
  I,
  DocCount,
  MaxCount,
  ErrPos     : LongInt;
  TmpBuf     : Pointer;
  TextSB     : TmgCharsHandleStream;
  TmpData    : TmgCharsHandle;

  TmpSab1    : Sab;
 begin
  TextSB:=Nil;
  CurFormula:=GetText(Pos);
  try
   DocumentServer.Family:=fFamily;
   // !!! STUB !!!
   // - а здесь был поиск по контексту (по формулам), но он отъехал уже 100 лет
   //   назад - с переходом на новый контекстный поиск.
   CurPkgObj:=TmgFamilyPackageSet.CreateEx(fFamily);
   try
    TextSB:=CurPkgObj.CalcSearchQuery(Nil,CurFormula,Cm0MaxLongInt,CurNum,ErrPos);
   finally
    l3Free(CurPkgObj);
   end;
   try
    htCreateEmptySAB(@fCurDocSab,TmpSab1,DocumentServer.FileTbl.TblH,fId_Fld,Res_Value);
    try
     DocCount:=TextSB.DocCount;
     if DocCount<>0
      then
       begin
        TextSB.SeekFirstData;
        Ht(htOpenResults(TmpSab1,ROPEN_READ,Nil,0));
        try
         if DocCount<=MaxBufRecords then MaxCount:=DocCount
                                    else MaxCount:=MaxBufRecords;
         l3System.GetLocalMem(TmpBuf,MaxCount*SizeOf(LongInt));
         try
          Repeat
           I:=MaxCount;
           TmpData:=TmgCharsHandle.Create;
            try
             TmpData.Number:=Cm0MaxLongInt;
             While (I>=1) and (DocCount<>0) do
              begin
               if TextSB.GetData(TmpData,TmpData.Number)
                then
                 begin
                  PRecArr(TmpBuf)^[I]:=TmpData.Number;
                  Dec(I);
                 end;
               Dec(DocCount);
              end;
            finally
             TmpData.Free;
            end;
           Ht(htIncludeResultsBlock(TmpSab1,0,@PRecArr(TmpBuf)^[I+1],(MaxCount-I)*SizeOf(LongInt)));
          until DocCount=0;
         finally
          l3System.FreeLocalMem(TmpBuf,MaxCount*SizeOf(LongInt));
         end;
        finally
         htCloseResults(TmpSab1);
        end;
       end;
     htRecordsByKey(Result,TmpSab1);
    finally
     htClearResults(TmpSab1);
    end;
   finally
    l3Free(TextSB);
   end;
  finally
   l3StrDispose(CurFormula);
  end;
 end;*)

begin
 CurType:=tNone;
 CurFlag:=ofNone;
 CurNum:=0;
 l3FillChar(Result,SizeOf(Sab));

 if htResultsType(fCurDocSab) = Res_NProc
  then
   exit;

 for I:=1 to MaxTermType do
  if StrLIComp(Pos,@TermPrefix[I],SizeOf(TTermID))=0
   then
    begin
     CurType:=TTermType(I);
     Break;
    end;
 Pos:=Pos+SizeOf(TTermID);

 Repeat
  case Pos[0] of
   '_' : begin
          CurFlag:=ofNums;
          Pos:=Pos+1;
         end;
   '=' : begin
          CurFlag:=ofData;
          Pos:=Pos+1;
         end;
   ' ' : Pos:=Pos+1;
   else
    begin
     if Not (Pos[0] in EndTermSet)
      then
       case CurFlag of
        ofNums : CurNum:=GetNum(Pos);
        ofData : case CurType of
                  tDict : Result:=GetDictData(Pos);
                  tDate : Result:=GetDateData(Pos);
                  tNumb : Result:=GetNumData(Pos);
                  {tText : Result:=GetTextData(Pos);}
                 end;
       end;
    end;
  end;
 until Pos[0] in EndTermSet;
end;

function TFormulaProcessor.ProcessFormula(aFormula : PChar) : Sab;

 function ProcessTermCombination(var Pos : PChar) : Sab;
 var
  TermSab1,
  TermSab2,
  TmpSab       : Sab;
  CurOperation : TOperationType;
 begin
  l3FillChar(TermSab1,SizeOf(Sab));
  CurOperation:=otNone;
  Repeat
   case Pos[0] of
    ' ' : Pos:=Pos+1;
    #0  : begin
           Result:=TermSab1;
           Break;
          end;
    ')' : begin
           Result:=TermSab1;
           Pos:=Pos+1;
           Break;
          end;
    '|' : begin
           CurOperation:=otOr;
           Pos:=Pos+1;
          end;
    '&' : begin
           CurOperation:=otAnd;
           Pos:=Pos+1;
          end;
    '(' : if htResultsType(TermSab1) = Res_NProc
           then
            begin
             Pos:=Pos+1;
             TermSab1:=ProcessTermCombination(Pos);
            end
           else
            begin
             Pos:=Pos+1;
             TermSab2:=ProcessTermCombination(Pos);
             case CurOperation of
              otOr  : htOrResults(TmpSab,TermSab1,TermSab2);
              otAnd : htAndResults(TmpSab,TermSab1,TermSab2);
             end;
             htClearResults(TermSab1);
             htClearResults(TermSab2);
             TermSab1:=TmpSab;
            end;
    else
     if htResultsType(TermSab1) = Res_NProc
      then
       TermSab1:=ProcessTerm(Pos)
      else
       begin
        TermSab2:=ProcessTerm(Pos);
        case CurOperation of
         otOr  : htOrResults(TmpSab,TermSab1,TermSab2);
         otAnd : htAndResults(TmpSab,TermSab1,TermSab2);
        end;
        htClearResults(TermSab1);
        htClearResults(TermSab2);
        TermSab1:=TmpSab;
       end;
   end;
  until False;
 end;

begin
 Result:=ProcessTermCombination(aFormula);
end;

end.
