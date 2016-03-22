unit m4DictScanner;

interface
uses

 l3Base,
 l3ProtoObject,
 l3ObjectRefList,
 l3String,
 l3Interfaces,

 m4DictTypes,
 m4Word,
 m4WordIDStr,
 m4WordIDStrList,
 m4WordIDStrListPrim,
 m4WordList;



type
 Tm4Segment = record
  //первые два поля не переставлять. Порядок важен!
  rWLen  : integer; // количество слов в сегменете
  rWOffs : integer; // порядковый номер первого слова в разбираемой фразе
  rOffs  : integer; // смещение сегмента в символах
  rLen   : integer; // длина сегмента в символах
 end;

 Tm4FoundDictItemProc = function(aID : Tm4DictItemAddr; aSegment : Tm4Segment) : boolean;
 Tm4PreProcessProc = function(var aID : Tm4DictItemAddr; var aSegment : Tm4Segment) : boolean;

 (*
  Ищет элементы словаря в поданном тексте
  Сначала заполняется словарь процедурой AddToDict(const aDictItem : Tl3WString; aDictItemID : Tm4DictItemID; aDictID : Integer = 0);
  aDictItemID и aDictID некии идентификаторы, для однозначного определения элемента словаря
  можно искать одновременно по нескольким словарям (например, Типы и Органы)
  после окончания добавления вызвать procedure AddComplete

  Искать ProcessStr(const aStr : Tl3WString; aFoundProc : Tm4FoundDictItemProc; aPreProcessWord : Tm4PreProcessProc = nil);

  aFoundProc - callback функция в которую передается информация о найденном
  В случае, если несколько найденных частично или полностью перекрываются, то предпочтение отдается
  более длинным (по количеству слов), при одинаковой длине тем, которые ближе к началу строки.

  в aFoundProc отдаются по порядку следования в тексте
  Перед поиском и формированием словаря все слова нормализуются

  aPreProcessWord - препроцессор, используется для доставания дат и номеров.
  Может использоваться для предварительного анализа текущего слова и того что за ним.
 *)


 Tm4DictScanner = class(Tl3ProtoObject)
  private
   fDictHasBeenChanged: Boolean;
   fWordDict  : Tm4WordList;
   fDictItems : Tm4WordIDStrList;
   fWordInterval : Integer; // интервал количество слов) между словами, при котором фраза еще не рвется
                            // например при поиске "бухгалтерский учет" должно найтись "бухгалтерский и налоговый учет" если интервалне менее двух
   fSoftOverlap : boolean;  // смягченные условия отсеивания перекрывающихся элементов: удаляем только меньшие по количеству слов элементы
                            // например в тексте "налоговый и бухгалтерский учет" будут найденны как "налоговый учет" так и "бухгалтерский учет"
                            // если конечно fWordInterval позволит
  public
   constructor Create;

   procedure Cleanup;
    override;

   procedure AddToDict(const aDictItem : Tl3WString; aDictItemID : Tm4DictItemID; aDictID : Integer = 0);
    {* - добавляет словарный элемент}

   procedure AddComplete;
    {* - закончили добавлять элементы}

   procedure ProcessStr(const aStr : Tl3WString; aFoundProc : Tm4FoundDictItemProc; aPreProcessWord : Tm4PreProcessProc = nil);
    {* - Сканирует строку на совпадение со словарем}
   property WordInterval : integer read fWordInterval write fWordInterval;

   property SoftOverlap : boolean read fSoftOverlap write fSoftOverlap;

 end;

 function  L2FoundDictItemProc(Action: Pointer): Tm4FoundDictItemProc; register;
 procedure FreeFoundDictItemProc(var Stub: Tm4FoundDictItemProc); register;

 function  L2PreProcessProc(Action: Pointer): Tm4PreProcessProc; register;
 procedure FreePreProcessProc(var Stub: Tm4PreProcessProc); register;

 function MakeSegment(aOffs : integer; aLen : integer) : Tm4Segment;

 procedure DebugOut(aDScan : Tm4DictScanner);

implementation
uses
 SysUtils,
 l3Types,
 l3FieldSortRecList,

 l3SpellMisc,
 l3LingLib,
 
 //l3RecList,
 m2MemLib
 , vtDebug;

type
 Pm4WordID = ^Tm4WordID;

function MakeSegment(aOffs : integer; aLen : integer) : Tm4Segment;
begin
 with Result do
 begin
  rOffs := aOffs;
  rLen  := aLen;
 end;
end;

function  L2FoundDictItemProc(Action: Pointer): Tm4FoundDictItemProc; register;
asm
          jmp  l3LocalStub
end;{asm}

procedure FreeFoundDictItemProc(var Stub: Tm4FoundDictItemProc); register;
asm
          jmp  l3FreeLocalStub
end;{asm}

function  L2PreProcessProc(Action: Pointer): Tm4PreProcessProc; register;
asm
          jmp  l3LocalStub
end;{asm}

procedure FreePreProcessProc(var Stub: Tm4PreProcessProc); register;
asm
          jmp  l3FreeLocalStub
end;{asm}


type
 Tm4WordAction = function(var aStr : Tl3PCharLen): Boolean;

function  m4L2WA(Action: Pointer): Tm4WordAction; register;
asm
          jmp  l3LocalStub
end;{asm}

procedure m4FreeWA(var Stub: Tm4WordAction); register;
asm
          jmp  l3FreeLocalStub
end;{asm}

procedure m4ParseWordsF(const aStr : Tl3WString; anAction : Tm4WordAction);
  {* - разбирает строку на слова. }
var
 l_Offset      : Longint;
 l_WordFinish  : Longint;
 lExcept       : TCharSet;
 lStr          : Tl3PCharLen;
begin
 lExcept := [];
 try
  if l3IsNil(aStr) then Exit;
  l_Offset := 0;
  while (l_Offset < aStr.SLen) do
  begin
   while (l_Offset < aStr.SLen) and
         (l3IsWordDelim(aStr.S[l_Offset], aStr.SCodePage, lExcept)) do
         //(aStr.S[l_Offset] in aDelim) do
     Inc(l_Offset);
   l_WordFinish := l_Offset;
   while (l_WordFinish < aStr.SLen) and
         not (l3IsWordDelim(aStr.S[l_WordFinish], aStr.SCodePage, lExcept)) do
         //not (aStr.S[l_WordFinish] in aDelim) do
     Inc(l_WordFinish);
   // - здесь добавляем слово
   if (l_WordFinish > l_Offset) then
   begin
    lStr := l3PCharLen(aStr.S + l_Offset, l_WordFinish - l_Offset, aStr.SCodePage);
    if not anAction(lStr) then break;
    l_Offset := lStr.S + lStr.SLen - aStr.S;
    // - смещаемся на следующее слово
   end;//l_WordFinish > l_Offset
  end;//l_Offset < l_S.SLen
 finally
  m4FreeWA(anAction);
 end;//try..finally
end;

{TDictScanner}
constructor Tm4DictScanner.Create;
begin
 Inherited;
 fWordDict  := Tm4WordList.Create;
 fDictItems := Tm4WordIDStrList.MakeSorted;
end;

procedure Tm4DictScanner.Cleanup;
begin
 l3Free(fWordDict);
 l3Free(fDictItems);
 Inherited;
end;

(*
Особенности реализации
 Строится словарь нормализованных слов (fWordDict : Tm4WordList), которым выдается уникальный ID (инкрементальный)
 и адрес первого включения в словарь фраз (если есть фразы начинающиеся с этого слова)

 Одновременно строится словарь фраз (fDictItems : Tm4WordIDStrList) в виде последовательности ID из fWordDict,
 кроме фразы с элементом словаря связаны переданные с фразой идентификаторы (aDictItemID, aDictID)

 Поиск осуществляется перемещением по fDictItems специальных курсоров (TCursorRec) с их последующим анализом.
*)

procedure Tm4DictScanner.AddToDict(const aDictItem : Tl3WString; aDictItemID : Tm4DictItemID; aDictID : Integer = 0);
var
 lWIDStr : Tm4WordIDStr;
 lGetNormWordProc : TllAddStrProc;
 lStop : Boolean; // берем первую попавшуюся словоформу

 procedure GetNormWord(aWord : PAnsiChar; aWordLen : integer);
 var
  lWID : Tm4WordID;
 begin
  if lStop then
   Exit;
  // Добавим в словарь
  lWID := fWordDict.AddWord(l3PCharLen(aWord, aWordLen));
  // добавим в строку
  lWIDStr.Add(lWID);
  lStop := True;
 end;

 function DoWord(var aStr : Tl3WString): Boolean;
 begin
  Result := true;
  lStop := False;
  if not mlmaLemmatize(aStr.S, aStr.SLen, 0{maStopAfterFirst}, lGetNormWordProc) then
   GetNormWord(aStr.S, aStr.SLen);
 end;//DoWord

begin
 lWIDStr := Tm4WordIDStr.Create(Tm4DictItemAddr_C(aDictItemID, aDictID));
 try
  // соберем строку WID
  lGetNormWordProc := L2llAddStrProc(@GetNormWord);
  try
   m4ParseWordsF(aDictItem, m4L2WA(@DoWord));
  finally
   FreellAddStrProc(lGetNormWordProc);
  end;
  if lWIDStr.Count > 0 then
  begin
   fDictHasBeenChanged := True;
   fDictItems.Add(lWIDStr);
  end;
 finally
  l3Free(lWIDStr);
 end;
end;

procedure Tm4DictScanner.AddComplete;
var
 lWIDPred : Tm4WordID;
 lWID     : Tm4WordID;
 lIndex   : Integer;
 J        : Integer;
begin
 lWIDPred := 0;
 with fDictItems do
 begin
  for lIndex := 0 to Pred(Count) do
  begin
   // возмем первый символ WID-строки
   lWID := Items[lIndex].Items[0]; {первый символ}
   if lWIDPred = lWID then Continue;
   lWIDPred := lWID;

   //найдем lWID в fWordDict
   with fWordDict do
    for J := 0 to Pred(Count) do
     if lWID = Items[J].StringID then
     begin
      Tm4Word(Items[J]).FirstWordIDStrID := lIndex;
      break;
     end;
  end;
 end;
 fDictHasBeenChanged := False;
//DebugOut(Self); 
end;

procedure Tm4DictScanner.ProcessStr(const aStr : Tl3WString; aFoundProc : Tm4FoundDictItemProc; aPreProcessWord : Tm4PreProcessProc = nil);
 type
  PCursorRec = ^TCursorRec;
  TCursorRec = record
   rSegment   : Tm4Segment; // координаты фрагмента в исходной строке   !!не переставлять. Порядок важен!!
   rClosed    : boolean; // закрытый курсор, далее обработка не проводится
   case rExtItem : boolean of
    false :
     (
      rLastWordOffs : integer; // порядковый номер последнего найденного слова в разбираемой фразе
      rIndex        : integer; // индекс найденной последовательности в fDictItems
      rIndexFull    : integer; // индекс найденной ПОЛНОЙ последовательности в fDictItems
     );
    True :
     (rDictItemID : Tm4DictItemAddr;) //ID внешнего элемента для передачи вызывающей
  end;

 var
  lCurWordIndex    : Integer;
  lNeedCancelProcess  : Boolean;
  lCursorArray     : Tl3FieldSortRecList;
  //lStop            : Boolean; // берем первую попавшуюся словоформу

  lGetNormWordProc : TllAddStrProc;
  lCurWordSegment  : Tm4Segment;

 procedure DoClose(aCursorIdx : Integer);
 begin
  with PCursorRec(lCursorArray.ItemSlot(aCursorIdx))^ do
  begin
   if rClosed then Exit;
   if rIndexFull >= 0 then  // если уже была найдена полная последовательность закрываем курсор
   begin
    rClosed := True;
    rSegment.rWLen := fDictItems.Items[rIndexFull].Count;
   end
   else //иначе удаляем
    lCursorArray.Delete(aCursorIdx);
  end;
 end;

 procedure AddExtCursor(aDictItemID : Tm4DictItemAddr; aSegment   : Tm4Segment);
 var
  lRec : TCursorRec;
 begin
  with lRec do
  begin
   rDictItemID := aDictItemID;
   rSegment := aSegment;
   rClosed := True;
   rExtItem := True;
  end;
  lCursorArray.Add(lRec);
 end;

 procedure DoChar(aIndex : Integer);
  var
   I : integer;
   J : integer;
   lRec : TCursorRec;
   lNeedAddRec : boolean;

  procedure CloneCursor(aIndex : Integer);
  var
   lRec : TCursorRec;
  begin
   with lCursorArray do
   begin
    lRec := PCursorRec(ItemSlot(aIndex))^;
    lRec.rClosed := false;
    lRec.rIndexFull := -1; // полная последовательность остается в курсоре-источнике
    lRec.rExtItem := false;

    lNeedAddRec := true;
    //Add(lRec); сразу добавлять нельзя, т к буфер с рекордами может перераспредилиться и указатель на I-тый съедет
   end;
  end;

 begin
  lNeedAddRec := false;

  with Tm4Word(fWordDict.Items[aIndex]) do
  begin
   // обработаем существующие курсоры
   with lCursorArray do
    for I := Pred(Count) downto 0 do
    begin
     with PCursorRec(ItemSlot(I))^ do
     begin
      if rClosed then continue;

      if lCurWordIndex - succ(rLastWordOffs) > fWordInterval then //интервал между словами больше максимально допустимого
      begin
       DoClose(I);
       continue;
      end;

      // если в текущем найденном (rIndex) количество "букв" больше чем в курсоре, начнем с него
      if rSegment.rWLen < fDictItems.Items[rIndex].Count then
      begin
       case fDictItems.Items[rIndex].Items[rSegment.rWLen] - StringID of
        0 : // текущий все еще подходит
         begin
          if fWordInterval > 0 then // небольшая оптимизация, которая впрочем может привести к некорресктной работе если на одном месте могут быть две разные нормы одного слова, хотя такой расклад кажется весьма сомнительным. В случае чего можно стереть этот If без потери функциональности
           CloneCursor(I);

          inc(rSegment.rWLen);
          rLastWordOffs := lCurWordIndex;
          //проверим на полную последовательность
          if rSegment.rWLen = fDictItems.Items[rIndex].Count then
          begin
           rIndexFull := rIndex;
           rSegment.rLen  := lCurWordSegment.rOffs - rSegment.rOffs + lCurWordSegment.rLen;
          end;

          Continue;
         end;
        1 : // "буква" в текущей строке (rIndex) больше, дальше не ищем, курсор откатываем на последний полный и закрываем
         begin
          //if fWordInterval = 0 then // уже можно закрывать
          // DoClose(I);
          continue;
         end;
        //-1 : ; // "буква" в текущей строке (rIndex) меньше, будем сканерить следующие строки
       end; //case fWordDict.Items[rIndex]...
      end;
      // сканерим элементы за rIndex
      begin
       for J := Succ(rIndex) to Pred(fDictItems.Count) do
       begin
        // У fDictItems.Items[J] должно
        // 1) длина не меньше чем rSegment.rWLen+1
        // 2) совпасть первые rSegment.rWLen символов с fDictItems.Items[rIndex] и
        if (fDictItems.Items[J].Count <= rSegment.rWLen) or
           (m2MEMCompare(fDictItems.Items[J].ItemSlot(0), fDictItems.Items[rIndex].ItemSlot(0), rSegment.rWLen * SizeOf(Tm4WordID)) <> 0) then
        begin
         //if fWordInterval = 0 then // уже можно закрывать
         // DoClose(I);
         Break;
        end;
        // 3) совпасть rSegment.rWLen+1 символ с StringID
        case fDictItems.Items[J].Items[rSegment.rWLen] - StringID of
         0 : // текущий подходит дальше не ищем
          begin
           if fWordInterval > 0 then // небольшая оптимизация, которая впрочем может привести к некорресктной работе если на одном месте могут быть две разные нормы одного слова, хотя такой расклад кажется весьма сомнительным. В случае чего можно стереть этот If без потери функциональности
            CloneCursor(I);

           rIndex := J;
           inc(rSegment.rWLen);
           rLastWordOffs := lCurWordIndex;
           //проверим на полную последовательность
           if rSegment.rWLen = fDictItems.Items[rIndex].Count then
           begin
            rIndexFull := rIndex;
            rSegment.rLen  := lCurWordSegment.rOffs - rSegment.rOffs + lCurWordSegment.rLen;
           end;

           Break;
          end;
         1 :  //"буква" в строке (J) больше, дальше не ищем, курсор откатываем на последний полный и закрываем
          begin
           //if fWordInterval = 0 then // уже можно закрывать
           // DoClose(I);
           Break;
          end;
         //- 1 : //"буква" в строке (J) меньше, бежим дальше
        end; //case fDictItems.Items[J].ItemSlot(Succ(rSegment.rWLen)) - StringID of

       end; // for J :=
      end;
     end;  //with PCursorRec(ItemSlot(I))^ do
     if lNeedAddRec then
     begin
      Add(lRec);
      lNeedAddRec := false;
     end;
    end;

   if FirstWordIDStrID >= 0 then
   // есть фразы начинающиеся с этого слова
   // добавим новый курсор
   begin
    with lRec do
    begin
     rSegment.rWOffs := lCurWordIndex;
     rLastWordOffs := lCurWordIndex;
     rSegment.rWLen := 1;
     rIndex := FirstWordIDStrID;
     rExtItem := false;
     rClosed := false;
     rSegment.rOffs := lCurWordSegment.rOffs;
     rSegment.rLen  := lCurWordSegment.rLen;

    //проверим на полную последовательность
     if rSegment.rWLen = fDictItems.Items[rIndex].Count then
      rIndexFull := rIndex
     else
      rIndexFull := -1;
    end; // with lRec do
    lCursorArray.Add(lRec);
   end;
  end;
 end;

 procedure CloseCursors;
 // закрывает все полные курсоры, удаляет неполные
 var
  I : integer;
  J : integer;
  lJRec : PCursorRec;
  lNeedCancel : Boolean;
 begin
  if lCursorArray.Count = 0 then Exit;

  //убъем все неполные
  with lCursorArray do
  for I := Pred(Count) downto 0 do
   DoClose(I);

  if lCursorArray.Count = 0 then Exit;


  // отсортируем по длине последовательности, а внутри одинаковой длины по началу
  lCursorArray.Sort;

  // Уберем вложенные и пересекающиеся
  J := 0;
  with lCursorArray do
  while true do
  begin
   lJRec := PCursorRec(lCursorArray.ItemSlot(J));

   for I := Pred(Count) downto succ(J) do
    with PCursorRec(ItemSlot(I))^ do
     if (not fSoftOverlap or (lJRec.rSegment.rWLen > rSegment.rWLen)) and
        (((rSegment.rOffs >= lJRec.rSegment.rOffs) and (rSegment.rOffs < lJRec.rSegment.rOffs + lJRec.rSegment.rLen)) or
        ((rSegment.rOffs + rSegment.rLen - 1 >= lJRec.rSegment.rOffs) and
         (rSegment.rOffs + rSegment.rLen - 1 < lJRec.rSegment.rOffs + lJRec.rSegment.rLen))) then
      Delete(I);

   Inc(J);
   if J >= Count then Break;
  end; //while true do
  
   // пересортируем по rSegment.rWOffs
  if lCursorArray.Count > 1 then
   lCursorArray.SortBy([2]);

  // тут сообщаем вызвавшей программе об оставшихся
  with lCursorArray do
   for I := 0 to Pred(Count) do
    with PCursorRec(lCursorArray.ItemSlot(I))^ do
    begin
     if rExtItem then
      lNeedCancel := not aFoundProc(rDictItemID, rSegment)
     else
      lNeedCancel := not aFoundProc(fDictItems.Items[rIndexFull].ID, rSegment);

     if lNeedCancel then
     begin // вызывающая сказала больше не надо
      lNeedCancelProcess := True;
      Exit;
     end;
    end;
  //почистим список курсоров
  lCursorArray.Clear;
 end;

 procedure DoNormWord(aWord : PAnsiChar; aWordLen : integer);
 var
  lIndex : Integer;
 begin
  //if lStop then
  // Exit;

  if fWordDict.FindData(l3PCharLen(aWord, aWordLen), lIndex, l3_siCaseUnSensitive) then
   DoChar(lIndex);
  {else
   if fWordInterval = 0 then
    CloseCursors;}

  //lStop := True;
 end;

 function DoWord(var aWord : Tl3WString) : Boolean;
 var
  lID : Tm4DictItemAddr;
 begin
  Result := true;
  //lStop := False;

  //вычислим координаты текущего слова в строке
  with lCurWordSegment do
  begin
   rWLen  := 1;
   rWOffs := lCurWordIndex;
   rOffs := aWord.S - aStr.S;
   rLen  := aWord.SLen;
  end;

  if Assigned(aPreProcessWord) and not aPreProcessWord(lID, lCurWordSegment) then
  begin // препроцессор обработал слово
    AddExtCursor(lID, lCurWordSegment);
   (*
   //принудительно закроем существующие
   if fWordInterval = 0 then
    CloseCursors;

   // сообщим вызывающей про найденное препроцесором
   lNeedCancelProcess := not aFoundProc(lID, lCurWordSegment);
   *)

   //сдвинем aWord, что бы парсер знал сколько мы нашли
   with lCurWordSegment do
   begin
    aWord.S := aStr.S + rOffs;
    aWord.SLen := rLen;
   end;
  end
  else
  begin
   if not mlmaLemmatize(aWord.S, aWord.SLen, 0{maStopAfterFirst}, lGetNormWordProc) then
    DoNormWord(aWord.S, aWord.SLen);
  end;

  Inc(lCurWordIndex);
  Result := not lNeedCancelProcess;
 end;//DoWord

begin
 if fDictHasBeenChanged then
  AddComplete;
 lNeedCancelProcess := False;
 lCurWordIndex := 0;
 lCursorArray := Tl3FieldSortRecList.Create(SizeOf(TCursorRec), [SizeOf(PCursorRec(0).rSegment.rWLen), SizeOf(PCursorRec(0).rSegment.rWOffs)], [-1, 2]);

 try
  lGetNormWordProc := L2llAddStrProc(@DoNormWord);
  try
   m4ParseWordsF(aStr, m4L2WA(@DoWord));
  finally
   FreellAddStrProc(lGetNormWordProc);
  end;
  if not lNeedCancelProcess then CloseCursors;  // закроем последнюю серию
 finally
  l3Free(lCursorArray);
 end;
end;

procedure DebugOut(aDScan : Tm4DictScanner);
var
 I, J : Integer;
begin
  dbgAppendToLogLN('-=WordDict=-');

  with aDScan.fWordDict do
  begin
   dbgAppendToLogLN(Format('Count = %d', [Count]));

   for I := 0 to Pred(Count) do
    with Tm4Word(Items[I]) do
    dbgAppendToLogLN(Format('[#%d] %s (%d)', [StringID, AsString, FirstWordIDStrID]));
  end;

  dbgAppendToLogLN('');
  dbgAppendToLogLN('-=DictItems=-');

  with aDScan.fDictItems do
  begin
   dbgAppendToLogLN(Format('Count = %d', [Count]));
   for I := 0 to Pred(Count) do
   begin
    with Items[I] do
    begin
     dbgAppendToLog(Format('(%d) [#%d.%d]', [I, ID.rDictionaryID, ID.rID]));
     for J := 0 to Pred(Count) do
      dbgAppendToLog(Format(' %d', [Items[J]]));
     dbgAppendToLogLN('');
    end;
   end;
  end;
end;

end.
