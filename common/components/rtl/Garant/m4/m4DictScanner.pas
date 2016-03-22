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
  //������ ��� ���� �� ������������. ������� �����!
  rWLen  : integer; // ���������� ���� � ���������
  rWOffs : integer; // ���������� ����� ������� ����� � ����������� �����
  rOffs  : integer; // �������� �������� � ��������
  rLen   : integer; // ����� �������� � ��������
 end;

 Tm4FoundDictItemProc = function(aID : Tm4DictItemAddr; aSegment : Tm4Segment) : boolean;
 Tm4PreProcessProc = function(var aID : Tm4DictItemAddr; var aSegment : Tm4Segment) : boolean;

 (*
  ���� �������� ������� � �������� ������
  ������� ����������� ������� ���������� AddToDict(const aDictItem : Tl3WString; aDictItemID : Tm4DictItemID; aDictID : Integer = 0);
  aDictItemID � aDictID ����� ��������������, ��� ������������ ����������� �������� �������
  ����� ������ ������������ �� ���������� �������� (��������, ���� � ������)
  ����� ��������� ���������� ������� procedure AddComplete

  ������ ProcessStr(const aStr : Tl3WString; aFoundProc : Tm4FoundDictItemProc; aPreProcessWord : Tm4PreProcessProc = nil);

  aFoundProc - callback ������� � ������� ���������� ���������� � ���������
  � ������, ���� ��������� ��������� �������� ��� ��������� �������������, �� ������������ ��������
  ����� ������� (�� ���������� ����), ��� ���������� ����� ���, ������� ����� � ������ ������.

  � aFoundProc �������� �� ������� ���������� � ������
  ����� ������� � ������������� ������� ��� ����� �������������

  aPreProcessWord - ������������, ������������ ��� ���������� ��� � �������.
  ����� �������������� ��� ���������������� ������� �������� ����� � ���� ��� �� ���.
 *)


 Tm4DictScanner = class(Tl3ProtoObject)
  private
   fDictHasBeenChanged: Boolean;
   fWordDict  : Tm4WordList;
   fDictItems : Tm4WordIDStrList;
   fWordInterval : Integer; // �������� ���������� ����) ����� �������, ��� ������� ����� ��� �� ������
                            // �������� ��� ������ "������������� ����" ������ ������� "������������� � ��������� ����" ���� ���������� ����� ����
   fSoftOverlap : boolean;  // ���������� ������� ���������� ��������������� ���������: ������� ������ ������� �� ���������� ���� ��������
                            // �������� � ������ "��������� � ������������� ����" ����� �������� ��� "��������� ����" ��� � "������������� ����"
                            // ���� ������� fWordInterval ��������
  public
   constructor Create;

   procedure Cleanup;
    override;

   procedure AddToDict(const aDictItem : Tl3WString; aDictItemID : Tm4DictItemID; aDictID : Integer = 0);
    {* - ��������� ��������� �������}

   procedure AddComplete;
    {* - ��������� ��������� ��������}

   procedure ProcessStr(const aStr : Tl3WString; aFoundProc : Tm4FoundDictItemProc; aPreProcessWord : Tm4PreProcessProc = nil);
    {* - ��������� ������ �� ���������� �� ��������}
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
  {* - ��������� ������ �� �����. }
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
   // - ����� ��������� �����
   if (l_WordFinish > l_Offset) then
   begin
    lStr := l3PCharLen(aStr.S + l_Offset, l_WordFinish - l_Offset, aStr.SCodePage);
    if not anAction(lStr) then break;
    l_Offset := lStr.S + lStr.SLen - aStr.S;
    // - ��������� �� ��������� �����
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
����������� ����������
 �������� ������� ��������������� ���� (fWordDict : Tm4WordList), ������� �������� ���������� ID (���������������)
 � ����� ������� ��������� � ������� ���� (���� ���� ����� ������������ � ����� �����)

 ������������ �������� ������� ���� (fDictItems : Tm4WordIDStrList) � ���� ������������������ ID �� fWordDict,
 ����� ����� � ��������� ������� ������� ���������� � ������ �������������� (aDictItemID, aDictID)

 ����� �������������� ������������ �� fDictItems ����������� �������� (TCursorRec) � �� ����������� ��������.
*)

procedure Tm4DictScanner.AddToDict(const aDictItem : Tl3WString; aDictItemID : Tm4DictItemID; aDictID : Integer = 0);
var
 lWIDStr : Tm4WordIDStr;
 lGetNormWordProc : TllAddStrProc;
 lStop : Boolean; // ����� ������ ���������� ����������

 procedure GetNormWord(aWord : PAnsiChar; aWordLen : integer);
 var
  lWID : Tm4WordID;
 begin
  if lStop then
   Exit;
  // ������� � �������
  lWID := fWordDict.AddWord(l3PCharLen(aWord, aWordLen));
  // ������� � ������
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
  // ������� ������ WID
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
   // ������ ������ ������ WID-������
   lWID := Items[lIndex].Items[0]; {������ ������}
   if lWIDPred = lWID then Continue;
   lWIDPred := lWID;

   //������ lWID � fWordDict
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
   rSegment   : Tm4Segment; // ���������� ��������� � �������� ������   !!�� ������������. ������� �����!!
   rClosed    : boolean; // �������� ������, ����� ��������� �� ����������
   case rExtItem : boolean of
    false :
     (
      rLastWordOffs : integer; // ���������� ����� ���������� ���������� ����� � ����������� �����
      rIndex        : integer; // ������ ��������� ������������������ � fDictItems
      rIndexFull    : integer; // ������ ��������� ������ ������������������ � fDictItems
     );
    True :
     (rDictItemID : Tm4DictItemAddr;) //ID �������� �������� ��� �������� ����������
  end;

 var
  lCurWordIndex    : Integer;
  lNeedCancelProcess  : Boolean;
  lCursorArray     : Tl3FieldSortRecList;
  //lStop            : Boolean; // ����� ������ ���������� ����������

  lGetNormWordProc : TllAddStrProc;
  lCurWordSegment  : Tm4Segment;

 procedure DoClose(aCursorIdx : Integer);
 begin
  with PCursorRec(lCursorArray.ItemSlot(aCursorIdx))^ do
  begin
   if rClosed then Exit;
   if rIndexFull >= 0 then  // ���� ��� ���� ������� ������ ������������������ ��������� ������
   begin
    rClosed := True;
    rSegment.rWLen := fDictItems.Items[rIndexFull].Count;
   end
   else //����� �������
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
    lRec.rIndexFull := -1; // ������ ������������������ �������� � �������-���������
    lRec.rExtItem := false;

    lNeedAddRec := true;
    //Add(lRec); ����� ��������� ������, � � ����� � ��������� ����� ������������������ � ��������� �� I-��� ������
   end;
  end;

 begin
  lNeedAddRec := false;

  with Tm4Word(fWordDict.Items[aIndex]) do
  begin
   // ���������� ������������ �������
   with lCursorArray do
    for I := Pred(Count) downto 0 do
    begin
     with PCursorRec(ItemSlot(I))^ do
     begin
      if rClosed then continue;

      if lCurWordIndex - succ(rLastWordOffs) > fWordInterval then //�������� ����� ������� ������ ����������� �����������
      begin
       DoClose(I);
       continue;
      end;

      // ���� � ������� ��������� (rIndex) ���������� "����" ������ ��� � �������, ������ � ����
      if rSegment.rWLen < fDictItems.Items[rIndex].Count then
      begin
       case fDictItems.Items[rIndex].Items[rSegment.rWLen] - StringID of
        0 : // ������� ��� ��� ��������
         begin
          if fWordInterval > 0 then // ��������� �����������, ������� ������� ����� �������� � ������������� ������ ���� �� ����� ����� ����� ���� ��� ������ ����� ������ �����, ���� ����� ������� ������� ������ ������������. � ������ ���� ����� ������� ���� If ��� ������ ����������������
           CloneCursor(I);

          inc(rSegment.rWLen);
          rLastWordOffs := lCurWordIndex;
          //�������� �� ������ ������������������
          if rSegment.rWLen = fDictItems.Items[rIndex].Count then
          begin
           rIndexFull := rIndex;
           rSegment.rLen  := lCurWordSegment.rOffs - rSegment.rOffs + lCurWordSegment.rLen;
          end;

          Continue;
         end;
        1 : // "�����" � ������� ������ (rIndex) ������, ������ �� ����, ������ ���������� �� ��������� ������ � ���������
         begin
          //if fWordInterval = 0 then // ��� ����� ���������
          // DoClose(I);
          continue;
         end;
        //-1 : ; // "�����" � ������� ������ (rIndex) ������, ����� ��������� ��������� ������
       end; //case fWordDict.Items[rIndex]...
      end;
      // �������� �������� �� rIndex
      begin
       for J := Succ(rIndex) to Pred(fDictItems.Count) do
       begin
        // � fDictItems.Items[J] ������
        // 1) ����� �� ������ ��� rSegment.rWLen+1
        // 2) �������� ������ rSegment.rWLen �������� � fDictItems.Items[rIndex] �
        if (fDictItems.Items[J].Count <= rSegment.rWLen) or
           (m2MEMCompare(fDictItems.Items[J].ItemSlot(0), fDictItems.Items[rIndex].ItemSlot(0), rSegment.rWLen * SizeOf(Tm4WordID)) <> 0) then
        begin
         //if fWordInterval = 0 then // ��� ����� ���������
         // DoClose(I);
         Break;
        end;
        // 3) �������� rSegment.rWLen+1 ������ � StringID
        case fDictItems.Items[J].Items[rSegment.rWLen] - StringID of
         0 : // ������� �������� ������ �� ����
          begin
           if fWordInterval > 0 then // ��������� �����������, ������� ������� ����� �������� � ������������� ������ ���� �� ����� ����� ����� ���� ��� ������ ����� ������ �����, ���� ����� ������� ������� ������ ������������. � ������ ���� ����� ������� ���� If ��� ������ ����������������
            CloneCursor(I);

           rIndex := J;
           inc(rSegment.rWLen);
           rLastWordOffs := lCurWordIndex;
           //�������� �� ������ ������������������
           if rSegment.rWLen = fDictItems.Items[rIndex].Count then
           begin
            rIndexFull := rIndex;
            rSegment.rLen  := lCurWordSegment.rOffs - rSegment.rOffs + lCurWordSegment.rLen;
           end;

           Break;
          end;
         1 :  //"�����" � ������ (J) ������, ������ �� ����, ������ ���������� �� ��������� ������ � ���������
          begin
           //if fWordInterval = 0 then // ��� ����� ���������
           // DoClose(I);
           Break;
          end;
         //- 1 : //"�����" � ������ (J) ������, ����� ������
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
   // ���� ����� ������������ � ����� �����
   // ������� ����� ������
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

    //�������� �� ������ ������������������
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
 // ��������� ��� ������ �������, ������� ��������
 var
  I : integer;
  J : integer;
  lJRec : PCursorRec;
  lNeedCancel : Boolean;
 begin
  if lCursorArray.Count = 0 then Exit;

  //����� ��� ��������
  with lCursorArray do
  for I := Pred(Count) downto 0 do
   DoClose(I);

  if lCursorArray.Count = 0 then Exit;


  // ����������� �� ����� ������������������, � ������ ���������� ����� �� ������
  lCursorArray.Sort;

  // ������ ��������� � ��������������
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
  
   // ������������� �� rSegment.rWOffs
  if lCursorArray.Count > 1 then
   lCursorArray.SortBy([2]);

  // ��� �������� ��������� ��������� �� ����������
  with lCursorArray do
   for I := 0 to Pred(Count) do
    with PCursorRec(lCursorArray.ItemSlot(I))^ do
    begin
     if rExtItem then
      lNeedCancel := not aFoundProc(rDictItemID, rSegment)
     else
      lNeedCancel := not aFoundProc(fDictItems.Items[rIndexFull].ID, rSegment);

     if lNeedCancel then
     begin // ���������� ������� ������ �� ����
      lNeedCancelProcess := True;
      Exit;
     end;
    end;
  //�������� ������ ��������
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

  //�������� ���������� �������� ����� � ������
  with lCurWordSegment do
  begin
   rWLen  := 1;
   rWOffs := lCurWordIndex;
   rOffs := aWord.S - aStr.S;
   rLen  := aWord.SLen;
  end;

  if Assigned(aPreProcessWord) and not aPreProcessWord(lID, lCurWordSegment) then
  begin // ������������ ��������� �����
    AddExtCursor(lID, lCurWordSegment);
   (*
   //������������� ������� ������������
   if fWordInterval = 0 then
    CloseCursors;

   // ������� ���������� ��� ��������� �������������
   lNeedCancelProcess := not aFoundProc(lID, lCurWordSegment);
   *)

   //������� aWord, ��� �� ������ ���� ������� �� �����
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
  if not lNeedCancelProcess then CloseCursors;  // ������� ��������� �����
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
