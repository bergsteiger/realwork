Unit Dt_Prior;

{ $Id: Dt_Prior.pas,v 1.53 2016/05/26 14:01:24 voba Exp $ }

// $Log: Dt_Prior.pas,v $
// Revision 1.53  2016/05/26 14:01:24  voba
// -k:623267081
//
// Revision 1.52  2016/04/08 11:01:23  voba
// -bf вычисление priority  для групповой операции не работало
//
// Revision 1.51  2015/11/25 14:01:48  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.50  2015/07/02 07:36:07  lukyanets
// Описываем словари
//
// Revision 1.49  2015/04/15 15:29:23  voba
// -bf
//
// Revision 1.48  2014/04/21 15:44:53  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.47  2014/04/21 15:41:53  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.46  2014/04/17 13:04:31  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.45  2014/03/13 11:05:17  voba
//  k:236721575 (Атрибуты в EVD)
//
// Revision 1.44  2014/02/18 10:56:53  voba
//  k:236721575 (Атрибуты в EVD)
//
// Revision 1.43  2013/10/30 10:36:40  voba
// - отказ от fSrchList
//
// Revision 1.42  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.41  2013/01/17 10:11:56  voba
// - перенес интерфейсы в отдельный модуль
//
// Revision 1.40  2010/09/28 13:06:09  fireton
// - Распределяем память для PAnsiChar своими средствами
//
// Revision 1.39  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.38  2010/09/21 11:06:54  fireton
// - переводим деревья с PAnsiChar на Tl3WString
//
// Revision 1.37  2010/03/10 14:09:47  narry
// - не собиралось
//
// Revision 1.36  2009/10/14 11:03:17  voba
// - избавляемся от библиотеки mg
//
// Revision 1.35  2009/07/22 11:27:27  narry
// - изменение доступа к DictServer
//
// Revision 1.34  2009/05/08 11:10:07  voba
// - заменил TblH на Handle
//
// Revision 1.33  2009/03/02 08:15:39  voba
// - изменил список параметров у constructor TPrometTbl.Create
//
// Revision 1.32  2008/04/04 14:49:23  narry
// - не собиралось
//
// Revision 1.31  2008/03/20 09:48:36  lulin
// - cleanup.
//
// Revision 1.30  2008/03/14 13:59:44  voba
// - bug fix
//
// Revision 1.28  2008/03/13 12:52:00  voba
// - add  class TPriorityCash
//
// Revision 1.27  2008/02/07 14:44:41  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.26  2008/02/01 16:41:34  lulin
// - используем кошерные потоки.
//
// Revision 1.25  2007/12/19 12:59:32  fireton
// - Ok теперь локальная переменная (l_Ok)
//
// Revision 1.24  2007/08/14 20:25:14  lulin
// - bug fix: не собиралася Архивариус.
//
// Revision 1.23  2007/08/14 19:31:56  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.22  2007/04/25 07:52:37  fireton
// - Рефакторинг. Уходим от прямых упоминаний имен таблиц в пользу перечислимых типов в DT_Types
//
// Revision 1.21  2007/02/12 16:11:00  voba
// - заменил использование htModifyRecs на вызов TAbsHtTbl.ModifyRecs
// - выделил TdtTable в модуль dt_Table (обертка вокруг функций HyTech по работе с таблицей целиком)
// - выделил функции HyTech по работе с Sab в dt_Sab, потом объект сделаю
//
// Revision 1.20  2005/04/05 10:51:02  step
// new: TPriorTbl._CalcPriorityBy
//
// Revision 1.19  2004/08/03 08:52:50  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.18  2004/07/14 15:27:14  step
// замена Buffering на StartCaching/StopCaching
//
// Revision 1.17  2004/07/01 14:14:27  voba
// - merge newCashe
//
// Revision 1.16.38.1  2004/06/17 18:03:49  step
// В методах TAbsHtTbl.AddRec и TAbsHtTbl.UpdRec убран параметр AbsNum.
//
// Revision 1.16  2003/02/11 10:04:38  voba
// - rename proc: l3NodeActionL2FA -> l3L2IA.
//
// Revision 1.15  2002/12/24 13:02:00  law
// - change: объединил Int64_Seek c основной веткой.
//
// Revision 1.14.4.1  2002/12/24 11:56:43  law
// - new behavior: используем 64-битный Seek вместо 32-битного.
//
// Revision 1.14  2002/02/08 17:09:56  voba
// no message
//
// Revision 1.13  2001/07/06 14:38:15  demon
// - new behavior: add transactions to all massive operation of Add, Modify and Delete of tbl records
//
// Revision 1.12  2000/12/15 15:36:17  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

Interface

Uses
  SysUtils,
  daTypes,
  HT_Const,
  l3Interfaces,
  l3Variant,
  l3Types, l3Base,
  l3LongintList,
  l3FieldSortRecList,
  l3IDList,
  k2Interfaces,
  Dt_Const, Dt_Types,
  dtIntf,
  dt_Sab,
  dt_AttrSchema,
  DT_ATbl
  ;

Const
 prSour_fld   = 1;
 prType_fld   = 2;
 prResult_fld = 3;
 prBoth_key   = 4;

 MinPriority  : word = 999;
 MaxPriority  : word = 0;
Type
  TPriorTbl = Class(TPrometTbl)
   public
    Constructor Create(aFamily : TFamilyID); Reintroduce;

    function    GetPriorityOnList(SourSab,TypeSab : Sab;WithRefresh : Boolean) : Word;
    function    CalcPriorityBy(const aSourIds, aTypeIds: Il3IDList; aWithRefresh: Boolean): Word;
    function    GetPriorityOnValue(aSour,aType : TDictID;WithRefresh : Boolean) : Word;

    Procedure   ImportPriorityFromFile(aFile : TFileName;ConvertFromOEM : Boolean; WithDropData : Boolean);
    Procedure   ExportPriorityToFile(aFile : TFileName;aProgress : Tl3ProgressProc);

    procedure   DeletePriorityOnDictID(aID : TDictID; aType : TdaDictionaryType);
  end;

  TPriorityCash = class(Tl3Base)
  private
   fRecList : Tl3FieldSortRecList;
   procedure Cleanup; override;
  public
   constructor Create(aFamily : TFamilyID); Reintroduce;
   function CalcPriorityBy(const aSourceIDs, aTypeIDs: Il3IntegerList): Word; overload;
   function CalcPriorityBy(const aSourceIDs, aTypeIDs: Il3IDList): Word; overload;
   function CalcPriorityBy(aSourceList, aTypeList: Tl3Tag): Word; overload;
   function CalcPriorityBy(aSourceID, aTypeID: TDictID): Word; overload;
  end;


  TPriorityList = class(Tl3Base)
  private
   fFamily : TFamilyID;
   fPriorCursor : ISabCursor;
   fCursorCurIndex : Integer;

   procedure Cleanup; override;
   function  CalcPriorityData(const aDocIDValue : ISab) : ISabCursor;
  public
   constructor Create(aFamily : TFamilyID; const aDocIDValue : ISab); Reintroduce;
   function    GetPriority(aDocID : TDocID): Word;
  end;

(*
Все сложнее
Из GDK
"Обязательно присутствие в таблице пустой строки и пустого столбца (с "пустым" Source и с "пустым" Type),
на пересечении которых обязательно должно стоять какое-нибудь число, означающее минимальную юридическую силу
у действующих документов, например, 999. Эта ситуация указывает на то, что данный(е) параметр(ы) неизвестны
(например, пустая строка означает все другие органы, не перечисленные в таблице). В этом случае для юридической
силы берётся значение, написанное на пересечении неизвестного органа (“пустой” строки) и известного типа.
Если такое значение не указано, берётся значение, стоящее на пересечении пустой строки и пустого столбца."
Сейчас "пустые" Source и "пустые" Type хранятся но не учитываются в рассчетах
*)

function GetProirityTbl(aFamily : TFamilyID = 1) : TPriorityCash;



Implementation
uses
     vtDebug,
     WinTypes, Classes,
     l3Tree_Tlb,
     l3Nodes, l3MinMax,
     daSchemeConsts,
     HT_Dll,
     dt_Err, dt_Dict,
     dt_Doc, Dt_Link, Dt_LinkServ,
     dt_DictIntf,
     m2xltlib,
     //MGExFStr,MGBufStr,
     l3Stream,
     l3String,
     m0Const,
     k2Tags;

Constructor TPriorTbl.Create(aFamily : TFamilyID);
begin
 Assert(aFamily <> MainTblsFamily);
 inherited Create(aFamily, ord(ftPriority));
end;

function TPriorTbl.GetPriorityOnList(SourSab,TypeSab : Sab;WithRefresh : Boolean) : Word;
Var
 TmpSab1,
 TmpSab2,
 TmpSab3  : Sab;
begin
 Result:=MinPriority;

 if WithRefresh then
 begin
  htTransferToTable(SourSab, Handle, prSour_fld);
  htTransferToPhoto(TypeSab, SourSab, prType_fld);
 end;

 htRecordsByKey(TmpSab1,SourSab);
 htRecordsByKey(TmpSab2,TypeSab);
 try
  htAndResults(TmpSab3,TmpSab1,TmpSab2);
  try
   if TmpSab3.gFoundCnt<>0
    then
     htKeyMinimum(TmpSab3,prResult_fld,@Result);
  finally
   htClearResults(TmpSab3);
  end;
 finally
  htClearResults(TmpSab1);
  htClearResults(TmpSab2);
 end;
end;

function TPriorTbl.GetPriorityOnValue(aSour,aType : TDictID;
                                      WithRefresh : Boolean) : Word;
Var
 AbsN : LongInt;
begin
 //if WithRefresh then RefreshSrchList;
 ClearFullRec;
 PutToFullRec(prSour_fld,aSour);
 PutToFullRec(prType_fld,aType);
 AbsN:=Ht(htRecordByUniq(nil,Handle,prBoth_key,fFullRecord, nil));
 if AbsN<>0
  then
   begin
    GetFullRec(AbsN,False);
    GetFromFullRec(prResult_fld,Result);
   end
  else
   Result:=MinPriority;
end;

Const
 MaxNameSize = 4000;

Procedure TPriorTbl.ImportPriorityFromFile(aFile : TFileName;ConvertFromOEM : Boolean;
                                           WithDropData : Boolean);
Const
 cErrorID = High(TDictID) - 1;
Var
 TmpPChar,
 TypeArr   : PAnsiChar;
 TblFl     : Tl3FileStream;
 CtrlChar  : Char;
 CurSour   : TDictID;
 I,
 StartPos,
 CurLength,
 TypeCount,
 Prior,
 FullSize  : LongInt;
 TmpNode   : Il3Node;

 TypeRoot,
 SourRoot  : TDictRootNode;
begin
 TypeRoot:=DictServer(TblFamily).DictRootNode[da_dlTypes].Use;
 try
  SourRoot:=DictServer(TblFamily).DictRootNode[da_dlSources].Use;
  try
   TblFl := Tl3FileStream.Create(aFile,l3_fmRead);
   try
    FullSize:=TblFl.Size;
    CtrlChar:=#00;
    if WithDropData then DropTblData;
    { Расчет количества типов }
    TypeCount:=0;
    Repeat
     TblFl.ReadBuffer(CtrlChar,1);
     if CtrlChar=#9 then
      Inc(TypeCount);
    until CtrlChar=#13;
    TypeArr := l3StrAlloc(SizeOf(TDictID)*TypeCount);
    l3FillChar(TypeArr^,SizeOf(TDictID)*TypeCount);
    TmpPChar := l3StrAlloc(MaxNameSize);
    StartCaching;
    try
     { Считывание массива типов }
     TblFl.Seek(1,soBeginning);
     I:=0;
     StartPos:=1;
     CtrlChar:=#00;
     Repeat
      TblFl.ReadBuffer(CtrlChar,1);
      if (CtrlChar=#9) or
         (CtrlChar=#13) then
       begin
        CurLength:=TblFl.Position-1-StartPos;
        if CurLength > 0 then
         begin
          l3FillChar(TmpPChar^,MaxNameSize);
          TblFl.Seek(-(CurLength+1),soCurrent);
          TblFl.ReadBuffer(TmpPChar^,CurLength);
          if ConvertFromOEM then m2XLTConvertBuff(TmpPChar,CurLength,Cm2XLTOEM2ANSI);
          TmpNode:=l3SearchByPath(TypeRoot,l3PCharLen(TmpPChar));
          if TmpNode<>Nil then
           PDictIDArr(TypeArr)^[I]:=TDictID((TmpNode as IDictItem).Handle)
          else
           PDictIDArr(TypeArr)^[I] := cErrorID;
          Inc(I);
          TblFl.Seek(1,soCurrent);
         end;
        StartPos:=TblFl.Position;
       end;
     until CtrlChar=#13;
     TblFl.Seek(1,soCurrent);
     { Обработка остальных строк таблицы }
     try
      Repeat
       StartPos:=TblFl.Position;
       CurSour:=0;
       Repeat
        TblFl.ReadBuffer(CtrlChar,1);
        if CtrlChar=#9 then
         begin
          CurLength:=TblFl.Position-1-StartPos;
          if CurLength>0 then
           begin
            l3FillChar(TmpPChar^,MaxNameSize);
            TblFl.Seek(-(CurLength+1),soCurrent);
            TblFl.ReadBuffer(TmpPChar^,CurLength);
            if ConvertFromOEM then m2XLTConvertBuff(TmpPChar,CurLength,Cm2XLTOEM2ANSI);
            TmpNode:=l3SearchByPath(SourRoot, l3PCharLen(TmpPChar));
            if TmpNode<>Nil then
             CurSour:=TDictID((TmpNode as IDictItem).Handle)
            else
             CurSour := cErrorID;
            TblFl.Seek(1,soCurrent);
           end
          else
           CurSour:=0;
         end
       until CtrlChar=#9;

       StartPos:=TblFl.Position;
       I:=0;
       Repeat
        TblFl.ReadBuffer(CtrlChar,1);
        if (CurSour <> cErrorID) and
           ((CtrlChar=#9) or (CtrlChar=#13)) then
         begin
          CurLength:=TblFl.Position-1-StartPos;
          if CurLength > 0 then
           begin
            l3FillChar(TmpPChar^,MaxNameSize);
            TblFl.Seek(-(CurLength+1),soCurrent);
            TblFl.ReadBuffer(TmpPChar^,CurLength);
            Prior:=StrToIntDef(StrPas(TmpPChar),0);
            TblFl.Seek(1,soCurrent);
           end
          else
           Prior:=MinPriority;
          if PDictIDArr(TypeArr)^[I] <> cErrorID then
           begin
            ClearFullRec;
            PutToFullRec(prSour_fld,CurSour);
            PutToFullRec(prType_fld,PDictIDArr(TypeArr)^[I]);
            PutToFullRec(prResult_fld,Prior);
            try
             AddFRec;
            except
            end;
           end;
          Inc(I);
          StartPos := TblFl.Position;
         end;
       until CtrlChar=#13;
       TblFl.Seek(1,soCurrent);
      until TblFl.Position = FullSize;
     except
     end;
    finally
     l3StrDispose(TypeArr);
     l3StrDispose(TmpPChar);
     StopCaching;
     UpdateTbl;
    end;
   finally
    l3Free(TblFl);
   end;
  finally
   l3Free(SourRoot);
  end;
 finally
  l3Free(TypeRoot);
 end;
end;

Procedure TPriorTbl.ExportPriorityToFile(aFile : TFileName;aProgress : Tl3ProgressProc);
Const
 Suffix   : Array [1..2] of Char = #13#10;
 Perforat : Char = #9;
Var
 TblFl    : Tl3FileStream;
 J,I      : LongInt;
 CurSour,
 CurType  : TDictID;
 CurPrior : Word;
 PrStr    : ShortString;

 tmpLen   : LongInt;
 tmpStr   : AnsiString;

 TypeRoot,
 SourRoot : TDictRootNode;


 function IterHandler1(CurNode : Il3Node) : Boolean; far;
 begin
  if not CurNode.HasChild
   then
    begin
     TblFl.WriteBuffer(Perforat,1);
     tmpStr:=l3GetFullPathStr(TypeRoot,CurNode);
     tmpLen:=Length(tmpStr);
     m2XLTConvertBuff(PAnsiChar(tmpStr),tmpLen,Cm2XLTANSI2OEM);
     TblFl.WriteBuffer(PAnsiChar(tmpStr)^,tmpLen);
    end;
  Result:=False;
 end;

 function IterHandler3(CurNode : Il3Node) : Boolean; far;
 begin
  if not CurNode.HasChild
   then
    begin
     if Assigned(aProgress)
      then
       aProgress(piCurrent,I*(DictServer(TblFamily).DictList[da_dlTypes].Count)+J+1,'');

     TblFl.WriteBuffer(Perforat,1);
     CurType:=(CurNode as IDictItem).Handle;
     CurPrior:=GetPriorityOnValue(CurSour,CurType,False);
     if CurPrior<>MinPriority
      then
       begin
        PrStr:=IntToStr(CurPrior);
        TblFl.WriteBuffer(PrStr[1],Length(PrStr));
       end;
    end;
  Result:=False;
 end;

 function IterHandler2(CurNode : Il3Node) : Boolean; far;

  function IterHandler4(CurNode : Il3Node) : Boolean; far;
  begin
   IterHandler3(CurNode);
  end;

 begin
  if not CurNode.HasChild
   then
    begin
     tmpStr:=l3GetFullPathStr(SourRoot,CurNode);
     tmpLen:=Length(tmpStr);
     m2XLTConvertBuff(PAnsiChar(TmpStr),tmpLen,Cm2XLTANSI2OEM);
     TblFl.WriteBuffer(PAnsiChar(TmpStr)^,tmpLen);
     CurSour:=(CurNode as IDictItem).Handle;
     J:=0;

     CurType:=0;                       // вывод значения ячейки с 0 типом
     TblFl.WriteBuffer(Perforat,1);
     CurPrior:=GetPriorityOnValue(CurSour,CurType,False);
     if CurPrior<>MinPriority then
      begin
       PrStr:=IntToStr(CurPrior);
       TblFl.WriteBuffer(PrStr[1],Length(PrStr));
      end;

     l3IterateSubTreeF(TypeRoot,l3L2NA(@IterHandler4),0);
     TblFl.WriteBuffer(Suffix,2);
    end;
  Result:=False;
 end;


begin
 TypeRoot:=DictServer(TblFamily).DictRootNode[da_dlTypes].Use;
 try
  SourRoot:=DictServer(TblFamily).DictRootNode[da_dlSources].Use;
  try
   TblFl:=Tl3FileStream.Create(aFile,l3_fmWrite);
   try
    if Assigned(aProgress) then
     aProgress(piStart,DictServer(TblFamily).DictList[da_dlSources].Count*DictServer(TblFamily).DictList[da_dlTypes].Count,
               'Экспорт таблицы приоритетов');


    //if RecCount = 0 then Exit;

    { Вывод массива типов }
    TblFl.WriteBuffer(Perforat,1); // вывод ячейки для нулевого типа
    l3IterateSubTreeF(TypeRoot,l3L2NA(@IterHandler1),0);
    TblFl.WriteBuffer(Suffix,2);
    { Вывод всего остального }

    J:=0;                           // начало вывода строчки для нулевого органа
    CurSour:=0;
    CurType:=0;
    TblFl.WriteBuffer(Perforat,1);
    CurPrior:=GetPriorityOnValue(CurSour,CurType,False);  // минимальный приоритет
    PrStr:=IntToStr(CurPrior);
    TblFl.WriteBuffer(PrStr[1],Length(PrStr));

    l3IterateSubTreeF(TypeRoot,l3L2NA(@IterHandler3),0);
    TblFl.WriteBuffer(Suffix,2);   // конец вывода строчки для нулевого органа

    I:=0;
    l3IterateSubTreeF(SourRoot,l3L2NA(@IterHandler2),0);
   finally
    if Assigned(aProgress) then aProgress(piEnd,0,'');
    l3Free(TblFl);
   end;
  finally
   l3Free(SourRoot);
  end;
 finally
  l3Free(TypeRoot);
 end;
end;

procedure TPriorTbl.DeletePriorityOnDictID(aID : TDictID; aType : TdaDictionaryType);
var
 lField : ThtField;
begin
 Case aType of
  da_dlTypes   : lField := prType_fld;
  da_dlSources : lField := prSour_fld;
  else exit;
 end;

 with MakeSab(Self) do
 begin
  Select(lField, aID);
  DeleteFromTable;
 end;
end;

function TPriorTbl.CalcPriorityBy(const aSourIds, aTypeIds: Il3IDList;
                                  aWithRefresh: Boolean): Word;
var
 l_SourIds,
 l_TypeIds: Sab;
 l_List: Il3IDList;
 l_ListIndex: Longint;
 l_FillBufferProc: TFillBufferProc;

 function fn_CopyListToBuffer(aBuffer: Pointer; aBufSize: Longint): Longint;
 var
  l_WrittenAmount: Longint;
 begin
  l_WrittenAmount := 0;
  while (l_ListIndex < l_List.Count)
    and (l_WrittenAmount < aBufSize div SizeOf(TDictID)) do
  begin
   PDictID(PAnsiChar(aBuffer) + l_WrittenAmount * SizeOf(TDictID))^ := l_List.Items[l_ListIndex];
   Inc(l_ListIndex);
   Inc(l_WrittenAmount);
  end;
  Result := l_WrittenAmount * SizeOf(TDictID);
 end;

begin
 l_FillBufferProc := L2FillBufferProc(@fn_CopyListToBuffer);
 try
  l_List := aSourIds;
  l_ListIndex := 0;
  l_SourIds := BuildSab(l_FillBufferProc, Self, prSour_fld);
  try
   l_List := aTypeIds;
   l_ListIndex := 0;
   l_TypeIds := BuildSab(l_FillBufferProc, Self, prType_fld);
   try
    Result := GetPriorityOnList(l_SourIds, l_TypeIds, aWithRefresh);
   finally
    htClearResults(l_TypeIds);
   end;
  finally
   htClearResults(l_SourIds);
  end;
 finally
  FreeFillBufferProc(l_FillBufferProc);
 end;
end;

{TPriorityCash}
Type
 PPriorRec = ^TPriorRec;
 TPriorRec = record
  rSID : TDictID;
  rTID : TDictID;
  rPriority : word;
 end;

constructor TPriorityCash.Create(aFamily : TFamilyID);
var
 lPriorSab : ISab;
begin
 inherited Create;
 lPriorSab := MakeSab(LinkServer(aFamily).PriorTbl);
 lPriorSab.Select(prResult_fld, MinPriority, LESS);
 fRecList := dtMakeRecListBySab(lPriorSab, [], [1, 2]);
end;

procedure TPriorityCash.Cleanup;
begin
 l3Free(fRecList);
 inherited;
end;

function TPriorityCash.CalcPriorityBy(const aSourceIDs, aTypeIDs: Il3IDList): Word;
var
 lTIdx  : Integer;
 lSIdx  : Integer;
 lIndex : Integer;
 lRec   : TPriorRec;
begin
 Result := MinPriority;

 for lSIdx := 0 to Pred(aSourceIds.Count) do
  for lTIdx := 0 to Pred(aTypeIds.Count) do
  begin
   lRec.rSID := aSourceIds[lSIdx];
   lRec.rTID := aTypeIds[lTIdx];

   if fRecList.FindRecord(lRec, lIndex) then
    Result := Min(Result, PPriorRec(fRecList.ItemSlot(lIndex))^.rPriority);
  end;
end;

function TPriorityCash.CalcPriorityBy(aSourceID, aTypeID: TDictID): Word;
var
 lRec   : TPriorRec;
 lIndex : Integer;
begin
 lRec.rSID := aSourceID;
 lRec.rTID := aTypeID;
 if fRecList.FindRecord(lRec, lIndex) then
  Result := PPriorRec(fRecList.ItemSlot(lIndex))^.rPriority
 else
  Result := MinPriority;
end;

function TPriorityCash.CalcPriorityBy(const aSourceIDs, aTypeIDs: Il3IntegerList): Word;
var
 lTIdx  : Integer;
 lSIdx  : Integer;
 lIndex : Integer;
 lRec   : TPriorRec;
begin
 Result := MinPriority;

 for lSIdx := 0 to Pred(aSourceIds.Count) do
  for lTIdx := 0 to Pred(aTypeIds.Count) do
  begin
   lRec.rSID := aSourceIds[lSIdx];
   lRec.rTID := aTypeIds[lTIdx];

   if fRecList.FindRecord(lRec, lIndex) then
    Result := Min(Result, PPriorRec(fRecList.ItemSlot(lIndex))^.rPriority);
  end;
end;

function TPriorityCash.CalcPriorityBy(aSourceList, aTypeList: Tl3Tag): Word;
var
 lTIdx  : Integer;
 lSIdx  : Integer;
 lIndex : Integer;
 lRec   : TPriorRec;
begin
 Result := MinPriority;

 for lSIdx := 0 to Pred(aSourceList.ChildrenCount) do
  for lTIdx := 0 to Pred(aTypeList.ChildrenCount) do
  begin
   lRec.rSID := aSourceList.Child[lSIdx].IntA[k2_tiHandle];
   lRec.rTID := aTypeList.Child[lTIdx].IntA[k2_tiHandle];

   if fRecList.FindRecord(lRec, lIndex) then
    Result := Min(Result, PPriorRec(fRecList.ItemSlot(lIndex))^.rPriority);
  end;
end;


var
 gPriorityCash : TPriorityCash = nil;
 // ну типа тут должен быть массив по семействам, но пока не надо

procedure FreeCacheObj;
begin
 l3Free(gPriorityCash);
end;

function GetProirityTbl(aFamily : TFamilyID) : TPriorityCash;
begin
 assert(aFamily = 1, 'Dt_Prior.GetProirityTbl реализовано только для Family = 1');

 if gPriorityCash = nil then
 begin
  l3System.AddExitProc(FreeCacheObj);
  gPriorityCash := TPriorityCash.Create(aFamily);
 end;

 Result := gPriorityCash;
end;

{TPriorityList}
constructor TPriorityList.Create(aFamily : TFamilyID; const aDocIDValue : ISab);
begin
 inherited Create;
 fFamily := aFamily;

 fPriorCursor := CalcPriorityData(aDocIDValue);
 fCursorCurIndex := 0;
end;

procedure TPriorityList.Cleanup;
begin
 //l3Free(fRecList);
 inherited;
end;

type
 PDSTRecAcc = ^TDSTRecAcc;
 TDSTRecAcc = packed record
  rDocID  : TDocID;
  rSource : TDictID;
  rType   : TDictID;
 end;

function TPriorityList.GetPriority(aDocID : TDocID): Word;
var
 lRec : PDSTRecAcc;
begin
 Result := MinPriority;
 if (fPriorCursor = nil) or (fCursorCurIndex >= fPriorCursor.Count) then Exit;

 repeat
  lRec := PDSTRecAcc(fPriorCursor.GetItem(fCursorCurIndex));
  if lRec^.rDocID = aDocID then
   Result := Min(Result, GetProirityTbl.CalcPriorityBy(lRec^.rSource, lRec^.rType))
  else
   if lRec^.rDocID > aDocID then
    break;
  Inc(fCursorCurIndex);
 until fCursorCurIndex >= fPriorCursor.Count;
end;

function TPriorityList.CalcPriorityData(const aDocIDValue : ISab) : ISabCursor;
 var
  lSourSab : ISab;
  lTypeSab : ISab;
  lPriorSab : ISab;

  lSTJSab   : IJoinSab;

 const
  lZero : byte = 0;

 begin
  lSourSab := MakeSabCopy(aDocIDValue);

  //отбираем толька с невыставленным fPriorFlag_fld
  lSourSab.RecordsByKey;
  lSourSab.SubSelect(fPriorFlag_fld, lZero);
  if lSourSab.Count = 0 then Exit;

  lSourSab.ValuesOfKey(fId_Fld);

  lTypeSab := MakeSabCopy(lSourSab);

  lSourSab.TransferToPhoto(lnkDocIDFld, LinkServer(fFamily)[atSources]);
  lSourSab.RecordsByKey;

  lTypeSab.TransferToPhoto(lnkDocIDFld, LinkServer(fFamily)[atTypes]);
  lTypeSab.RecordsByKey;

  //lSourSab + lTypeSab
  lSTJSab := MakeJoinSab(lSourSab, lnkDocIDFld,
                         lTypeSab, lnkDocIDFld{, DRAFT_ALL});


  lSTJSab.SortJoin([JFRec(LinkServer(fFamily)[atSources], lnkDocIDFld)]);

  Result := lSTJSab.MakeJoinSabCursor([JFRec(LinkServer(fFamily)[atSources], lnkDocIDFld),
                                          JFRec(LinkServer(fFamily)[atSources], lnkDictIDFld),
                                          JFRec(LinkServer(fFamily)[atTypes], lnkDictIDFld)
                                         ]);

 end;


end.
