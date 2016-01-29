// $Id: ddKTExtractor.pas,v 1.39 2015/07/02 07:36:05 lukyanets Exp $

{ Библиотека "DD"    }
{ Автор: БабанинВ.      }
{ Модуль: ddKTExtractor - вынимает "ключевые темы" (КТ) из текста документа, формат словаря описан в [K:168231952]}
{ Начат: 12.01.2004 19:54 }
{ $Id: ddKTExtractor.pas,v 1.39 2015/07/02 07:36:05 lukyanets Exp $ }

// $Log: ddKTExtractor.pas,v $
// Revision 1.39  2015/07/02 07:36:05  lukyanets
// Описываем словари
//
// Revision 1.38  2014/04/29 14:06:17  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.37  2014/04/17 13:04:46  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.36  2014/04/09 14:19:33  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.35  2014/04/08 14:17:10  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.34  2014/04/07 06:53:33  dinishev
// Bug fix: не компилировались проекты.
//
// Revision 1.33  2014/03/06 17:23:27  lulin
// - избавляемся от теговых обёрток.
//
// Revision 1.32  2014/02/24 11:40:28  fireton
// - используем keywords вместо надежды, что индексы совпадут
//
// Revision 1.31  2014/02/18 13:34:33  lulin
// - избавляемся от ненужного списка.
//
// Revision 1.30  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.29  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.28  2013/04/19 13:10:10  lulin
// - портируем.
//
// Revision 1.27  2013/04/11 17:14:58  lulin
// - отлаживаем под XE3.
//
// Revision 1.26  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.25  2012/11/01 09:43:24  lulin
// - забыл точку с запятой.
//
// Revision 1.24  2012/11/01 07:45:49  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.23  2012/10/10 10:13:29  narry
// Падал при отсутствии словаря
//
// Revision 1.22  2012/07/16 11:15:35  voba
// - новый фильтр для КТ
//
// Revision 1.21  2012/06/04 09:29:46  voba
// - k:370377660
//
// Revision 1.20  2012/02/28 12:35:03  narry
// AV при обращению к Parser.Filer
//
// Revision 1.19  2011/11/14 12:51:40  narry
// В справке остались Ключевые темы (297714202)
//
// Revision 1.18  2011/09/14 12:31:11  narry
// Форматирование текста - дополнение (283613953)
//
// Revision 1.17  2011/05/13 14:58:42  fireton
// - не собирался Архивариус (у Tl3Parser.Create пропал параметр)
//
// Revision 1.16  2011/01/12 09:12:37  voba
// - k : 249339673
//
// Revision 1.15  2011/01/12 07:45:13  voba
// - k : 249339673
//
// Revision 1.14  2010/11/24 15:31:43  fireton
// - переводим на ZipForge
//
// Revision 1.13  2010/11/23 10:38:13  narry
// К242846053. Не расставлять КТ в постановлениях ВАС
//
// Revision 1.12  2010/11/12 17:02:42  fireton
// - шифруем файл ключевых тем
//
// Revision 1.11  2010/11/12 15:20:22  fireton
// - проставляем ключевые темы в названии документа
//
// Revision 1.10  2010/10/01 08:59:57  voba
// - k:235865224
//
// Revision 1.9  2010/09/29 13:53:51  voba
// - k : 233017620
//
// Revision 1.8  2010/09/24 12:10:36  voba
// - k : 235046326
//
// Revision 1.7  2010/05/19 07:27:47  voba
// - K:213255164
//
// Revision 1.6  2010/05/19 07:26:45  voba
// - K:213255164
//
// Revision 1.5  2009/11/16 07:31:25  voba
// - cc
//
// Revision 1.4  2009/11/13 07:07:01  narry
// - обновление
//
// Revision 1.2  2009/11/12 12:41:15  voba
// - bug fix
//
// Revision 1.1  2009/11/12 12:37:51  voba
// no message
//

unit ddKTExtractor;

interface
{.$DEFINE DebugOut}
uses
 SysUtils,
 Classes,
 k2Types, k2Interfaces,
 k2TagFilter, k2TagGen,
 k2TagTerminator,
 l3Types, l3Base, l3ProtoObject,
 l3TempMemoryStream,
 l3FieldSortRecList,
 l3KeyWrd,
 evdBufferedFilter,
 dt_Types,
 dtIntf, dt_Sab,
 dt_Doc,
 ddTypes, l3Interfaces, l3LongintList;

type
 TddKTExtractor = class(Tl3ProtoObject)
 private
  fStatList : Tl3FieldSortRecList;
 protected
  procedure Cleanup; override;
 public
  constructor Create;
  procedure ProcessStr(const aStr : Tl3WString);
  function GetKTString : AnsiString;
 end;

 TddKTExtractorTermFilter = class(Tk2TagTerminator)
 {- "терминирующий" фильтр. Для добавления КТ к существующим докам}
 private
  f_KTExtractor : TddKTExtractor;
  f_ModifiedRecs: Tl3TempMemoryStream;
  f_DocSab : ISab;
  f_DocSabFiller : IValueSetFiller;

  f_KTList: Tl3KeyWords;
  f_DocID : TDocID;
  f_SigString: Tl3String;
  f_SigBT    : Tl3BMTable;
 protected
  procedure Cleanup; override;
  procedure CloseCache;

 public
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  procedure CloseStructure(NeedUndo: Bool); override;
  //class function SetTo(var theGenerator: Tk2TagGenerator; const aDataFileName: AnsiString;
  //    aAllowedSources: Tl3LongintList = nil): Pointer; overload;
 end;

 TddKTExtractorFilter = class(TevdBufferedFilter)
 {- "проходной" фильтр. Для заливки}
 private
  f_Sources: Tl3LongintList;
  F_KTExtractor : TddKTExtractor;
  f_SigString: Tl3String;
  f_SigBT    : Tl3BMTable;
  procedure ExpandSources;
  procedure pm_SetSources(const Value: Tl3LongintList);
 protected
  procedure Cleanup;
   override;
  function IsValidSource(aRoot: Tl3Variant): Boolean;
   {-}
  function  NeedStartBuffering(aID : Integer): Boolean;
   override;

 public
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  procedure CloseStructure(NeedUndo: Bool); override;
  class function SetTo(var theGenerator: Tk2TagGenerator; const aDataFileName: AnsiString;
      aAllowedSources: Tl3LongintList = nil): Pointer; overload;
  property Sources: Tl3LongintList read f_Sources write pm_SetSources;
 end;

procedure LoadKTScan(aFileName : TFileName; aWithAnalise : boolean = false);
 {загрузка словаря}

implementation

uses
 Math, StrUtils,

 TextPara_Const, Document_Const,
 l3StringList, l3Stream, l3Parser,
 l3Chars, l3String,
 l3FileUtils,
 l3BMSearch,

 k2Tags,

 m4DictTypes,
 m4DictScanner,
 l3ProtoObjectRefList,
 ZipForge,

 {m4WordIDStr}
 daTypes,
 HT_Const,
 dt_Misc,
 DT_Dict, DT_Const,
 dt_AttrSchema, DT_DictConst, l3DictionaryPrim, l3Dict, l3PrimString;

const
 sKTStartSignature = ' (ключевые темы: ';

var
 gKTScan : Tm4DictScanner = nil;
 gDictList : Tl3StringList = nil;
 gPairList : Tl3FieldSortRecList = nil;

type
 PStatListRec = ^TStatListRec;
 TStatListRec = packed record
  rIndex   : Integer;
  rCount   : Integer;
  rDivider : Integer;
 end;

 PPairListRec = ^TPairListRec;
 TPairListRec = packed record
  rL : Integer;
  rR : Integer;
 end;

{$IFDEF DebugOut}
procedure Out2Log(aStr : AnsiString);
begin
 l3System.Msg2Log(aStr);
end;
{$ENDIF DebugOut}

//TddKTExtractor
constructor TddKTExtractor.Create;
begin
 inherited;
 fStatList := Tl3FieldSortRecList.Create(SizeOf(TStatListRec), [SizeOf(PStatListRec(0).rIndex), SizeOf(PStatListRec(0).rCount)], [1]);
 fStatList.Sorted := true;
end;

procedure TddKTExtractor.Cleanup;
begin
 l3Free(fStatList);
 inherited;
end;

function TddKTExtractor.GetKTString : AnsiString;
var
 I, J  : Integer;

Type
 TwkKind = (wkNone, wkLeft, wkRight);

 function WhatKill(I, J : Integer) : TwkKind;
  var
   lPair : TPairListRec;
   Ind   : Integer;
  begin
   Result := wkNone;
   lPair.rL := PStatListRec(fStatList.ItemSlot(I))^.rIndex;
   lPair.rR := PStatListRec(fStatList.ItemSlot(J))^.rIndex;
   if gPairList.FindRecord(lPair, Ind) then
   begin
    if PStatListRec(fStatList.ItemSlot(J))^.rCount * 10 div PStatListRec(fStatList.ItemSlot(I))^.rCount < 15 then
    begin
     Result := wkRight;
     {$IFDEF DebugOut}
     Out2Log(Format('Сравнение "%s" "%s" Убили правый', [l3Str(gDictList.ItemW[lPair.rL]), l3Str(gDictList.ItemW[lPair.rR])]));
     {$ENDIF DebugOut}
    end
    else
    begin
     Result := wkLeft;
     {$IFDEF DebugOut}
     Out2Log(Format('Сравнение "%s" "%s" Убили левый', [l3Str(gDictList.ItemW[lPair.rL]), l3Str(gDictList.ItemW[lPair.rR])]));
     {$ENDIF DebugOut}
    end
   end
   else
   begin
    l3Swap(lPair.rL, lPair.rR);
    if gPairList.FindRecord(lPair, Ind) then
     if PStatListRec(fStatList.ItemSlot(I))^.rCount * 10 div PStatListRec(fStatList.ItemSlot(J))^.rCount < 15 then
     begin
      Result := wkLeft;
      {$IFDEF DebugOut}
      Out2Log(Format('Сравнение "%s" "%s" Убили правый', [l3Str(gDictList.ItemW[lPair.rL]), l3Str(gDictList.ItemW[lPair.rR])]));
      {$ENDIF DebugOut}
     end
     else
     begin
      Result := wkRight;
      {$IFDEF DebugOut}
      Out2Log(Format('Сравнение "%s" "%s" Убили левый', [l3Str(gDictList.ItemW[lPair.rL]), l3Str(gDictList.ItemW[lPair.rR])]));
      {$ENDIF DebugOut}
     end;
   end;
  end;

begin
 if fStatList.Count = 0 then
  Exit;

 // применим делитель
 for I := 0 to Pred(fStatList.Count) do
  with PStatListRec(fStatList.ItemSlot(I))^ do
   rCount := Max((rCount * 100000 div rDivider), 1);

 fStatList.SortBy([-2]); //пересортируем по частоте

 {$IFDEF DebugOut}
 for I := 0 to Pred(fStatList.Count) do
  with PStatListRec(fStatList.ItemSlot(I))^ do
  Out2Log(Format('%d) "%s" [%d]', [I+1, l3Str(gDictList.ItemW[rIndex]), rCount]));
 {$ENDIF DebugOut}
 // убиваем пары
 I := 1;
 while (I < fStatList.Count) and (I <= 4)  do
 begin
  J := 0;
  while J < I do
  begin
   case WhatKill(I, J) of
    wkNone :
     Inc(J);

    wkLeft :
     begin // убиваем левый
      fStatList.Delete(I);
      Dec(I); // поскольку мы текущий удалили, указатель уже встал на следующий, ниже опять сдвигаем, нужно это скомпенсировать
      Break; //Iтый удалили, итерацию с ним заканчиваем
     end;

    wkRight :
     begin // убиваем правый
      fStatList.Delete(J);
      Dec(I);
     end;
   end;
  end;
  Inc(I);
 end;

 //формируем строку
 Result := l3Str(gDictList.ItemW[PStatListRec(fStatList.ItemSlot(0))^.rIndex]);

 for I := 1 to min(Pred(fStatList.Count), 4) do
  Result := Result + ' - ' + l3Str(gDictList.ItemW[PStatListRec(fStatList.ItemSlot(I))^.rIndex]);
 {$IFDEF DebugOut}
  Out2Log(Format('Итог "%s"', [Result]));
 {$ENDIF DebugOut}
 Result := sKTStartSignature + Result + ')';

 fStatList.Clear;       //зачистим список
 fStatList.SortBy([1]); //восстановим сортировку по первому полю для последующего применения
end;


procedure TddKTExtractor.ProcessStr(const aStr : Tl3WString);

 function lFoundDictItem(aDictItemID : Tm4DictItemAddr; aSegment : Tm4Segment) : boolean;
 var
  I : Integer;
  lRec : TStatListRec;
 begin
  if fStatList.FindRecord(aDictItemID.rID, I) then
   Inc(PStatListRec(fStatList.ItemSlot(I))^.rCount)
  else
  begin
   lRec.rIndex := aDictItemID.rID;
   lRec.rCount := 1;
   lRec.rDivider := aDictItemID.rDictionaryID; //туда делитель положили
   fStatList.Add(lRec);
  end;
  Result := True;
 end;

var
 lFDIProcStub : Tm4FoundDictItemProc;
begin
 if gKTScan <> nil then
 begin
   lFDIProcStub := L2FoundDictItemProc(@lFoundDictItem);
   try
    gKTScan.ProcessStr(aStr, lFDIProcStub);
   finally
    FreeFoundDictItemProc(lFDIProcStub);
   end;
 end; // gKTScan <> nil
end;

//TddKTExtractorTermFilter
constructor TddKTExtractorTermFilter.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited;
 f_KTExtractor := TddKTExtractor.Create;
 f_DocSab := MakeSab(DocumentServer(CurrentFamily).FileTbl);
 f_DocSabFiller := f_DocSab.MakeValueSetFiller(docIdFld);
 f_ModifiedRecs := Tl3TempMemoryStream.Create;

 f_SigString := Tl3String.Create;
 f_SigString.AsString := sKTStartSignature;
 f_SigString.MakeBMTable(f_SigBT);

 f_KTList := Tl3KeyWords.Create(l3_dupAccept);              
end;

procedure TddKTExtractorTermFilter.Cleanup;
begin
 CloseCache;
 l3Free(f_ModifiedRecs);
 l3Free(f_KTExtractor);
 l3Free(f_SigString);
 l3Free(f_KTList);
 inherited;
end;

procedure TddKTExtractorTermFilter.CloseCache;
var
 lCurrDocItem : Integer;

 function lApplyModifyUpdate(gRecNo  : LongInt; fpRecord: Pointer) : MFUNC_RET;
 var
  lDocID : TDocID;
  //lFullName : TFullNameStr;
  lFullName : Tl3PCharLen;
  //lStr   : Tl3String;
  l_Pos  : Cardinal;
  l_KW   : Tl3PrimString;
  lKTStr : AnsiString;
  lNameSize : Integer;
  lFilledLen : Integer;
 begin
  Result := MFUNC_SUCCESS;
  with DocumentServer(CurrentFamily).FileTbl do
  begin
   lDocID := PDocID(PAnsiChar(fpRecord) + FldOffset[docIdFld])^;

   l_KW := f_KTList.DRByID[lDocID];
   Assert(l_KW <> nil, 'TddKTExtractorTermFilter.CloseCache: потерялась строка...');
   lKTStr := l_KW.AsString;

   lNameSize := FldLength[fFName_Fld];
   lFullName := l3PCharLen(PAnsiChar(fpRecord) + FldOffset[fFName_Fld], lNameSize);
   lFullName.SLen := l3SizeOfTextArray(lFullName.S, lFullName.SLen);

   if l3SearchStr(lFullName, f_SigBT, f_SigString.AsPCharLen, l_Pos) then
    lFullName.SLen := l_Pos;

   if Length(lKTStr) + lFullName.SLen > lNameSize then
   begin
    lFullName.SLen := cFullNameSize - Length(lKTStr);
    lFullName.S[Pred(lFullName.SLen)] := cc_Ellipsis;
   end;
   StrMove(lFullName.S+lFullName.SLen, PAnsiChar(lKTStr), Length(lKTStr));
   lFilledLen := lFullName.SLen + Length(lKTStr);
   l3FillChar(lFullName.S[lFilledLen], lNameSize - lFilledLen, ord(' '));
  end;
  Inc(lCurrDocItem);
 end;

var
 lHTStub : Pointer;
begin
 lCurrDocItem := 0;
 f_ModifiedRecs.Position := 0;

 f_DocSabFiller := nil;
 f_DocSab.RecordsByKey;

 lHTStub := HTStub3(@lApplyModifyUpdate);
 try
  f_DocSab.ModifyRecs(lHTStub, {aDupIgnore} False(*, {aNeedLock} True*));
 finally
  HTStubFree(lHTStub);
 end;
 f_KTList.Clear;
end;

procedure TddKTExtractorTermFilter.CloseStructure(NeedUndo: Bool);
//var
// lStr   : Tl3String;
// lKTStr : AnsiString;
// lRoot  : _Ik2Tag;
// l_Pos  : Cardinal;
begin
 if CurrentType.IsKindOf(k2_typDocument) then
 begin
//  lKTStr := f_KTExtractor.GetKTString;
  f_KTList.AddKeyWord(f_KTExtractor.GetKTString, f_DocID);
  f_DocSabFiller.AddValue(f_DocID);
 end;
 inherited;
 (*
  if (f_Buffer.Tags <> nil) and (f_Buffer.Tags.Count = 1) then
  begin
   lRoot := f_Buffer.Tags.Top^.Box;
   if IsValidSource(lRoot) and (lRoot.IntA[k2_tiType] <> Ord(dtRelText)) then
   begin
    lStr := Tl3String.Make(lRoot.PAnsiCharLenA[k2_tiName]);

   /////
    if f_SigString.BMSearch(lStr, f_SigBT, l_Pos) then
     lStr.Delete(l_Pos, lStr.Len);
    try
     lKTStr := f_KTExtractor.GetKTString;
     if Length(lKTStr) + lStr.Len > cFullNameSize then
     begin
      lStr.Len := cFullNameSize - Length(lKTStr);
      lStr.St[Pred(lStr.Len)] := cc_Ellipsis;
     end;
     lStr.Append(l3PCharLen(lKTStr));
   ////

     lRoot.PAnsiCharLenA[k2_tiName] := lStr.AsPCharLen;
    finally
     l3Free(lStr);
    end;
   end; // IsValidSource(lRoot)
  end; // (f_Buffer.Tags <> nil) and (f_Buffer.Tags.Count = 1)
 end; // CurrentType.IsKindOf(k2_typDocument)
 inherited;
*)
end;

procedure TddKTExtractorTermFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
begin
 if CurrentType.IsKindOf(k2_typDocument) and (AtomIndex = k2_tiInternalHandle) then
  f_DocID := Value.AsInteger;

 if CurrentType.IsKindOf(k2_typTextPara) and (AtomIndex = k2_tiText) and not Value.AsString.Empty then
 begin
  f_KTExtractor.ProcessStr(Value.AsString.AsWStr);
 end;
 inherited; // DoAddAtomEx(AtomIndex, Value);
end;

//TddKTExtractorFilter
constructor TddKTExtractorFilter.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited;
 f_KTExtractor := TddKTExtractor.Create;

 f_SigString := Tl3String.Create;
 f_SigString.AsString := sKTStartSignature;
 f_SigString.MakeBMTable(f_SigBT);
 f_Sources := Tl3LongintList.Create();
end;

procedure TddKTExtractorFilter.Cleanup;
begin
 l3Free(f_KTExtractor);
 l3Free(f_SigString);
 FreeAndNil(f_Sources);
 inherited;
end;

procedure TddKTExtractorFilter.CloseStructure(NeedUndo: Bool);
var
 lStr   : Tl3String;
 lKTStr : AnsiString;
 lRoot  : Tl3Variant;
 l_Pos  : Cardinal;
begin
 if CurrentType.IsKindOf(k2_typDocument) then
 begin
  if (f_Buffer.Tags <> nil) and (f_Buffer.Tags.Count = 1) then
  begin
   lRoot := f_Buffer.Tags.Top^.Box;
   if IsValidSource(lRoot) and (lRoot.IntA[k2_tiType] <> Ord(dtRelText)) then
   begin
    lStr := Tl3String.Make(lRoot.PCharLenA[k2_tiName]);
    if f_SigString.BMSearch(lStr, f_SigBT, l_Pos) then
     lStr.Delete(l_Pos, lStr.Len);
    try
     lKTStr := f_KTExtractor.GetKTString;
     if Length(lKTStr) + lStr.Len > cFullNameSize then
     begin
      lStr.Len := cFullNameSize - Length(lKTStr);
      lStr.St[Pred(lStr.Len)] := cc_Ellipsis;
     end;
     lStr.Append(l3PCharLen(lKTStr));

     lRoot.PCharLenA[k2_tiName] := lStr.AsPCharLen;
    finally
     l3Free(lStr);
    end;
   end; // IsValidSource(lRoot)
  end; // (f_Buffer.Tags <> nil) and (f_Buffer.Tags.Count = 1)
 end; // CurrentType.IsKindOf(k2_typDocument)
 inherited;
end;

function TddKTExtractorFilter.NeedStartBuffering(aID : Integer): Boolean;
begin
 Result := True;
end;

procedure TddKTExtractorFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
begin
 //if CurrentType.IsKindOf(k2_typDocument) and (AtomIndex = k2_tiExternalHandle) then
 // f_DocID:= Value.AsInteger;

 if CurrentType.IsKindOf(k2_typTextPara) and (AtomIndex = k2_tiText) and not Value.AsString.Empty then
 begin
  f_KTExtractor.ProcessStr(Value.AsString.AsWStr);
 end;
 inherited; // DoAddAtomEx(AtomIndex, Value);
end;

procedure TddKTExtractorFilter.ExpandSources;
var
 l_Sab: ISab;
begin
 l_Sab := GetExpandDictIDValueSab(da_dlSources, f_Sources);
 f_Sources.Clear;
 dtCopyValuesSabToList(l_Sab, f_Sources);
 l_Sab := nil;
end;

function TddKTExtractorFilter.IsValidSource(aRoot: Tl3Variant): Boolean;
var
 l_Sources: Tl3Variant;
 l_Source: Tl3Variant;
 i: Integer;
 l_Handle: TDictID;
begin
 Result := True;
 if not f_Sources.Empty then
 begin
  l_Sources:= aRoot.Attr[k2_tiSources];
  if l_Sources.IsValid then
   for i:= 0 to Pred(l_Sources.ChildrenCount) do
   begin
    l_Source:= l_Sources.Child[i];
    l_Handle:= cUndefDictID;
    if l_Source.Attr[k2_tiHandle].IsValid then
     l_Handle:= l_Source.IntA[k2_tiHandle]
    else
    if l_Source.Attr[k2_tiName].IsValid then
     l_Handle:= DictServer(CurrentFamily).Dict[da_dlSources].FindIDByFullPath(l_Source.Attr[k2_tiName].AsWStr);
    if l_Handle <> cUndefDictID then
    begin
     if f_Sources.IndexOf(l_Handle) = -1 then
     begin
      Result:= False;
      break;
     end
    end
    else
    begin
     Result:= False;
     break;
    end
   end; // for i
 end; // not f_Sources.Empty
end;

procedure TddKTExtractorFilter.pm_SetSources(const Value: Tl3LongintList);
begin
 f_Sources.Clear;
 if Value <> nil then
  f_Sources.Assign(Value);
 ExpandSources;
end;

class function TddKTExtractorFilter.SetTo(var theGenerator: Tk2TagGenerator; const aDataFileName:
    AnsiString; aAllowedSources: Tl3LongintList = nil): Pointer;
  {-}
var
 l_Filter : TddKTExtractorFilter;
begin
 l_Filter := Create(nil);
 try
  l_Filter.Sources:= aAllowedSources;
  LoadKTScan(aDataFileName);
  l_Filter.Generator := theGenerator;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

var
gFileName : TFileName = '';
gFileSize : int64 = 0;
gFileDate : Longint = 0;

function gCheckDataVersion(aFileName : TFileName) : boolean;
var
 lFileSize : int64;
 lFileDate : Longint;

begin
 lFileSize := SizeOfFile(aFileName);
 lFileDate := FileAge(aFileName);

 Result := IsIdenticalFiles(aFileName, gFileName) and (lFileSize = gFileSize) and (lFileDate = gFileDate);
 if not Result then
 begin
  gFileName := aFileName;
  gFileSize := lFileSize;
  gFileDate := lFileDate;
 end;
end;

procedure LoadKTScan(aFileName : TFileName; aWithAnalise : boolean);
var
 l_Stream    : TStream;
 l_Parser    : Tl3Parser;
 lNeedAddToDict : boolean;
 lListIndex : Integer;
 lStr  : Tl3String;
 lStr2 : Tl3String;
 lDivider : Integer;
 lPair : TPairListRec;

 lKeyWrd : Tl3KeyWord;
 lSortDictList : Tl3StringList;

 lGrafArr : Array of boolean;
 lChainEndArr : Array of boolean;
 lArrDim  : Integer;
 I, J, K, L : Integer;
 lRes : Boolean;
 lChainList : Tl3LongintList;
 lListofChains : Tl3ProtoObjectRefList;
 l_Ext: AnsiString;
 l_Zip : TZipForge;
 l_FName: AnsiString;
 l_ZipFileName: AnsiString;

 function ContainIn(aTestChain : Tl3LongintList; aComparedChain : Tl3LongintList) : Boolean;
  // Проверка что все элементы aTestChain содержатся в aComparedChain
 var
  I : Integer;
  lIndex : Integer;
 begin
  Result := False;
  if aTestChain.Count > aComparedChain.Count then
   Exit;

  for I := 0 to Pred(aTestChain.Count) do
   if not aComparedChain.findData(aTestChain[I], lIndex) then
    Exit;

  Result := True;
 end;

 function GetChainString(aChainList : Tl3LongintList) : AnsiString;
 var
  I : Integer;
 begin
  Result := l3Str(gDictList.ItemW[aChainList[0]]);
  for I := 1 to Pred(aChainList.Count) do
  Result := Result + ' - ' + l3Str(gDictList.ItemW[aChainList[I]]);
 end;

 procedure ExpandChain(aChainList : Tl3LongintList);
 var
  lChainList : Tl3LongintList;
  lLastChainUnit : Integer;
  J : Integer;
  lIndex: Integer;
 begin
  lLastChainUnit := aChainList[Pred(aChainList.Count)];
  if lChainEndArr[lLastChainUnit] then
  begin
   lChainList := Tl3LongintList.Create;
   try
    lChainList.Count := aChainList.Count;
    for J := 0 to Pred(lChainList.Count) do
     lChainList[J] := aChainList[J];
    lListofChains.Add(lChainList);
   finally
    l3Free(lChainList);
   end;
  end
  else
   for J := 0 to pred(lArrDim) do
    if lGrafArr[lLastChainUnit + J * lArrDim] then //если есть связь  x - L, то L не может быть началом цепочки
    begin
     if aChainList.findData(J, lIndex) then
     begin
      aChainList.Add(J);
      {$IFDEF DebugOut}
      Out2Log(Format('!Цикл в цепочке "%s"', [GetChainString(aChainList)]));
      {$ENDIF DebugOut}
      aChainList.Delete(Pred(aChainList.Count));
     end
     else
     begin
      aChainList.Add(J);
      ExpandChain(aChainList);
      aChainList.Delete(Pred(aChainList.Count));
     end;
    end;
 end;

const
 cDefDivider = 10;

var
 lCheckVersion : Boolean;
begin
 l_ZipFileName := ChangeFileExt(aFileName, '.zip');

 if FileExists(l_ZipFileName) then
  lCheckVersion := gCheckDataVersion(l_ZipFileName)
 else
  if FileExists(aFileName) then
   lCheckVersion := gCheckDataVersion(l_ZipFileName)
  else
   raise EInOutError.CreateFmt('Файл ключевых тем (%s) не найден', [aFileName]);

 if lCheckVersion then
 begin
  if gKTScan <> nil then
   Exit;
 end
 else
 begin
  l3Free(gKTScan);
  l3Free(gDictList);
  l3Free(gPairList);
 end;
 
 lDivider := cDefDivider;
 gKTScan := Tm4DictScanner.Create;
 gDictList := Tl3StringList.Create;
 lSortDictList := Tl3StringList.Create;
 try

  gPairList := Tl3FieldSortRecList.Create(SizeOf(TPairListRec), [SizeOf(PPairListRec(0).rL), SizeOf(PPairListRec(0).rR)], [1, 2]);
  //gPairList.Sorted := true;

  lNeedAddToDict := True;

  if FileExists(l_ZipFileName) then
  begin
   l_Zip := TZipForge.Create(nil);
   try
    l_Zip.FileName := l_ZipFileName;
    l_Zip.Password := 'Run-time error 216';
    l_Zip.OpenArchive;
    l_FName := ExtractFileName(aFileName);
    if LowerCase(ExtractFileExt(l_FName)) = '.zip' then
     l_FName := ChangeFileExt(l_FName, '.csv');
    l_Stream := TMemoryStream.Create;
    l_Zip.ExtractToStream(l_FName, l_Stream);
    l_Stream.Seek(0, soFromBeginning);
   finally
    FreeAndNil(l_Zip);
   end;
  end
  else
   l_Stream := Tl3FileStream.Create(aFileName, l3_fmRead);

  try
   l_Parser := Tl3Parser.Create;
   try
    l_Parser.CheckFloat := False;
    l_Parser.CheckInt   := False;
    l_Parser.CheckHex   := False;

    l_Parser.CheckFiler.COMStream := l3Stream2IStream(l_Stream);
    try
     l_Parser.WhiteSpace := [';'];
     l_Parser.WordChars := cc_AllChars - [';', #13, #10];

     l_Parser.NextTokenSp;

     while l_Parser.TokenType <> l3_ttEOF do
     begin

      if l_Parser.TokenType = l3_ttEOL then
      begin
       lNeedAddToDict := True;
       lDivider := cDefDivider;
      end
      else
      begin
       lStr := l_Parser.TokenLongString;
       if lStr.Len > 0 then
       begin
        if lStr.Ch[0] = '[' then  // имеется в виду [pair]
        begin
         l_Parser.NextTokenSp;
         break; // переходим к загрузке пар
        end;

        if lNeedAddToDict then
        begin
         if lStr.Ch[0] = '/' then
          lDivider := l3StrToInt(lStr.Offset(1).AsWStr)
         else
         begin
          lKeyWrd := Tl3KeyWord.Create(lStr, 0);
          try
           lListIndex := gDictList.Add(lKeyWrd);
           lKeyWrd.StringID := lListIndex;

           lSortDictList.Add(lKeyWrd);

           lNeedAddToDict := False;
           gKTScan.AddToDict(lKeyWrd.AsPCharLen, lListIndex, lDivider);
          finally
           l3Free(lKeyWrd);
          end;
         end;
        end
        else
         gKTScan.AddToDict(lStr.AsPCharLen, lListIndex, lDivider);
       end;
      end;
      l_Parser.NextTokenSp;
     end;

     gKTScan.AddComplete;

     if aWithAnalise then
     begin
      lArrDim  := gDictList.Count;
      SetLength(lGrafArr, lArrDim * lArrDim);
      SetLength(lChainEndArr, lArrDim);
     end;

     // загруза пар
     lSortDictList.Sorted := True;
     while l_Parser.TokenType <> l3_ttEOF do
     begin
      lStr := l_Parser.TokenLongString;
      if lStr.Len = 0 then
       l_Parser.NextTokenSp
      else
      begin
       lPair.rL := lSortDictList.IndexOf(lStr.AsPCharLen);
       if lPair.rL >= 0 then
        lPair.rL := lSortDictList.Items[lPair.rL].StringID
       {$IFDEF DebugOut}
       else
        Out2Log(Format('Строка "%s" не найдена в словаре', [lStr.AsString]))
       {$ENDIF DebugOut}
       ;

       l_Parser.NextTokenSp;
       if l_Parser.TokenType = l3_ttEOL then
        Assert(false, 'Ошибка формата');
       lStr2 := l_Parser.TokenLongString;

       lPair.rR := lSortDictList.IndexOf(lStr2.AsPCharLen);
       if lPair.rR >= 0 then
        lPair.rR := lSortDictList.Items[lPair.rR].StringID
       {$IFDEF DebugOut}
       else
        Out2Log(Format('Строка "%s" не найдена в словаре', [lStr.AsString]))
       {$ENDIF DebugOut}
        ;

       if not ((lPair.rL = -1) or (lPair.rR = -1)) then
       begin
        gPairList.Add(lPair);
        if aWithAnalise then
         lGrafArr[lPair.rL + lPair.rR * lArrDim] := True;
       end;

       l_Parser.NextTokenSp;
       if (l_Parser.TokenType <> l3_ttEOL) and (l_Parser.TokenType <> l3_ttEOF) then
        Assert(false, 'Ошибка формата');

      end;
     end;

     gPairList.Sorted := True;

     if aWithAnalise then
     begin
      gPairList.Clear; // будем новый набирать

      // набъем массив концов цепочек lChainEndArr
      for I := 0 to pred(lArrDim) do
      begin
       lRes := True;
       for J := 0 to pred(lArrDim) do
        if lGrafArr[I + J * lArrDim] then //если есть связь  I - J, то I не может быть концом цепочки
        begin
         lRes := False;
         Break;
        end;
       if lRes then
        lChainEndArr[I] := True;
      end;

      // Построение полных цепочек

      lChainList := Tl3LongintList.Create;
      try
       lListofChains := Tl3ProtoObjectRefList.Create;
       try
        for I := 0 to pred(lArrDim) do
        begin
         lRes := True; // I может быть началом цепочки
         for J := 0 to pred(lArrDim) do
          if lGrafArr[J + I * lArrDim] then //если есть связь  x - L, то L не может быть началом цепочки
          begin
           lRes := False;
           Break;
          end;

         if not lRes then Continue;

         lListofChains.Clear;
         lChainList.Clear;
         lChainList.Add(I);
         ExpandChain(lChainList);

         // проверяем на вложенность
         for J := pred(lListofChains.Count) downto 0 do
          for K := pred(lListofChains.Count) downto 0 do // можно и в нормальную сторону крутить
           if (J <> K) and ContainIn(Tl3LongintList(lListofChains[J]), Tl3LongintList(lListofChains[K])) then
           begin
           {$IFDEF DebugOut}
            Out2Log(Format('!Вложенная цепочка "%s" в "%s"', [GetChainString(Tl3LongintList(lListofChains[J])), GetChainString(Tl3LongintList(lListofChains[K]))]));
           {$ENDIF DebugOut}
            lListofChains.Delete(J);
            Break;
           end;

         // выводим в отчет
         for J := 0 to Pred(lListofChains.Count) do
         begin
          {$IFDEF DebugOut}
          if Tl3LongintList(lListofChains[J]).Count >= 3 then
           Out2Log(Format('Цепочка "%s"', [GetChainString(Tl3LongintList(lListofChains[J]))]));
          {$ENDIF DebugOut}

          with Tl3LongintList(lListofChains[J]) do
          for K := 0 to Pred(Pred(Count)) do
          begin
           lPair.rL := Items[K];
           for L := Succ(K) to Pred(Count) do
           begin
            lPair.rR := Items[L];
            gPairList.Add(lPair);
           end;
          end;
         end;
        end;

        {$IFDEF DebugOut}
        Out2Log('!Финальный набор цепочек');
        for J := 0 to Pred(gPairList.Count) do
         with PPairListRec(gPairList.ItemSlot(J))^ do
          Out2Log(Format('%s;%s', [l3Str(gDictList.ItemW[rL]), l3Str(gDictList.ItemW[rR])]));
        {$ENDIF DebugOut}
       finally
        l3Free(lListofChains);
       end;
      finally
       l3Free(lChainList);
      end;
     end;
    finally
     l_Parser.Filer.COMStream := nil;
    end;
   finally
    l3Free(l_Parser);
   end;
  finally
   l3Free(l_Stream);
  end;
 finally
  l3Free(lSortDictList);
 end;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\dd\ddKTExtractor.pas initialization enter'); {$EndIf}
 //LoadKTScan('D:\3\kt.csv');
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\dd\ddKTExtractor.pas initialization leave'); {$EndIf}
finalization
 l3Free(gKTScan);
 l3Free(gDictList);
 l3Free(gPairList);
end.


