unit ddSegmentScanner;

interface

Uses
 Classes,

 l3Base,
 l3ProtoPersistent,
 l3ObjectRefList,
 l3ProtoObject,
 l3ProtoObjectRefList,
 l3ProtoPersistentRefList,

 k2Interfaces,
 k2Base,

 ddNSRCSegments,
 ddNSRCStackItemList,

 segObjectList,
 segHyperlinkList,
 segSegList
 ;

type
 TddSegmentScanner = class(Tl3ProtoObject)
 private
   FTopicNo: Integer;
   f_Errors: TStrings;
   f_Stack: TddNSRCStackItemList;
   f_Segments: TsegSegList;
   f_Hyperlinks: TsegHyperLinkList;
   f_Objects: TsegObjectList;
   procedure CheckFormula(aText: Tl3String; aStartIndex: Integer);
   function  CheckDecor(aText: Tl3String; aStartIndex: Integer; aBracket: AnsiChar; out theDecor : TsegDecorSegment): Boolean;
   procedure CheckHyperlink(aText: Tl3String; aStartIndex: Integer; aC: AnsiChar);
   procedure DelLast;
   function Last: TddNSRCStackItem;
   procedure OutErrorLog(aMessage: AnsiString);
 protected
  procedure Cleanup; override;
 public
   class procedure SmartTrim(Text: Tl3String);
  constructor Create;
  procedure Scan(aText: Tl3String; aTrim: Boolean; aJustify: AnsiChar);
(*   class procedure SmartSplit(const LeftText, RightText: Tl3String);*)
   property Errors: TStrings read f_Errors;
  property Segments: TsegSegList read f_Segments;
  property Hyperlinks: TsegHyperLinkList read f_Hyperlinks;
   property Objects: TsegObjectList read f_Objects {write f_Objects};
   property TopicNo: Integer read FTopicNo write FTopicNo;
   class procedure SaveDecor(aDecor : TsegDecorSegment; const aGenerator: Ik2TagGenerator); overload;
   class procedure SaveDecor(aType: Tk2Type; const aDecor : AnsiString; const aGenerator: Ik2TagGenerator); overload;
 end;//TddSegmentScanner

implementation

Uses
 SysUtils,
 evNSRCConst,

 l3Interfaces,
 l3Stream,
 l3Parser,
 l3Memory,
 l3Types,
 l3String,
 l3Chars,
 l3Filer,

 k2Tags,

 Math,
 
 evdStyles,
 evdTxtConst,
 evdNativeReader,
 TextSegment_Const
 ;

resourcestring
 //SNSCError_UnclosedLink = 'TOPIC# %d > Незакрытая ссылка в абзаце <<%s>>';
 SNSCError_NoLinkAddress = 'Отсутствие адреса ссылки в абзаце <<%s>>';
 //SNSCError_ShiftConvert = 'TOPIC# %d > Ошибка пребразования смещения ссылки "%s"';
 SNSCError_AdressConvert = 'TOPIC# %d > Ошибка пребразования адреса ссылки "%s"';
 SNSCError_LinkBadFormat = 'CRITICAL ERROR Topic#%d Ошибочный формат ссылки';

constructor TddSegmentScanner.Create;
begin
 inherited;
 f_Segments := TsegSegList.Create;
 f_Hyperlinks := TsegHyperLinkList.Create;
 f_Stack := TddNSRCStackItemList.Create;
 f_Objects := TsegObjectList.Create;
 f_Errors:= TStringList.Create;
end;

class procedure TddSegmentScanner.SaveDecor(aType: Tk2Type; const aDecor : AnsiString; const aGenerator: Ik2TagGenerator);
var
 l_F : Tl3CustomFiler;
 l_Stream : Tl3StringStream;
 l_R : TevdNativeReader;
begin
 if (aDecor = '') then
  Exit;
 l_F := Tl3CustomFiler.Create;
 try
  l_Stream := Tl3StringStream.Create;
  try
   l_Stream._String.AsString := aDecor; 
   l_F.Mode := l3_fmRead;
   l_F.Stream := l_Stream;
   try
    l_R := TevdNativeReader.Create;
    try
     l_R.Start;
     try
      l_R.StartChild(aType);
      try
       l_R.Generator := aGenerator;
       try
        l_R.Filer := l_F;
        try
         l_R.Read;
        finally
         l_R.Filer := nil;
        end;//try..finally
       finally
        l_R.Generator := nil;
       end;//try..finally
      finally
       l_R.Finish;
      end;//try..finally
     finally
      l_R.Finish;
     end;//try..finally
    finally
     FreeAndNil(l_R);
    end;//try..finally
   finally
    l_F.Stream := nil;
   end;//try..finally
  finally
   FreeAndNil(l_Stream);
  end;//try..finally
 finally
  FreeAndNil(l_F);
 end;//try..finally
end;

class procedure TddSegmentScanner.SaveDecor(aDecor : TsegDecorSegment; const aGenerator: Ik2TagGenerator);
var
 l_F : Tl3CustomFiler;
 l_Stream : Tl3StringStream;
 l_R : TevdNativeReader;
begin
 aGenerator.StartChild(k2_typTextSegment);
 try
  SaveDecor(k2_typTextSegment, aDecor.Decor, aGenerator);
  aGenerator.AddIntegerAtom(k2_tiStart, aDecor.Start);
  aGenerator.AddIntegerAtom(k2_tiFinish, aDecor.Finish);
 finally
  aGenerator.Finish;
 end;//try..finally
end;

function TddSegmentScanner.CheckDecor(aText: Tl3String; aStartIndex: Integer; aBracket: AnsiChar; out theDecor : TsegDecorSegment): Boolean;

var
 l_Finish : Integer;

 procedure l_DeleteFromCurrentChar(aLen: Integer);
 begin//l_DeleteFromCurrentChar
  aText.Delete(aStartIndex, aLen);
  Dec(l_Finish, aLen);
 end;//l_DeleteFromCurrentChar

var 
 l_StartMask : Tl3WString;
 l_MaskPos : Integer;
 l_BracketCount : Integer;
begin
 Result := false;
 theDecor := nil;
 l_Finish := aText.FindChar(Succ(aStartIndex), aBracket);
 if (l_Finish <> -1) then
 begin
  // Вместо формулы может приехать картинка
  l_StartMask := l3PCharLen(AnsiUpperCase(evNSRCConst.cDecor));
  l_MaskPos := l3Pos(aText.AsPCharLen, l_StartMask, False);
  if (l_MaskPos <> -1) and
     (aStartIndex < l_MaskPos) and
     (l_MaskPos < l_Finish) then
  begin
   theDecor := TsegDecorSegment.Create;
   try
    theDecor.Start := Succ(aStartIndex);
    theDecor.Finish := theDecor.Start;
    if (aBracket = ev_NSRCFormula) then
    begin
     l_DeleteFromCurrentChar(l_StartMask.SLen + 1);
    end//aBracket = ev_NSRCFormula
    else
    begin
     Inc(aStartIndex);
     l_DeleteFromCurrentChar(l_StartMask.SLen);
    end;//aBracket = ev_NSRCFormula
    theDecor.Decor := '';
    Assert(aText.Ch[aStartIndex] = evdOpenBracket, 'После ' + evNSRCConst.cDecor + ' должна быть фигурная скобка');
    l_BracketCount := 1;
    l_DeleteFromCurrentChar(1);
    while (aStartIndex < aText.Len) do
    begin
     if (aText.Ch[aStartIndex] = evdOpenBracket) then
      Inc(l_BracketCount)
     else
     if (aText.Ch[aStartIndex] = evdCloseBracket) then
     begin
      Dec(l_BracketCount);
      if (l_BracketCount <= 0) then
      begin
       l_DeleteFromCurrentChar(1);
       break;
      end;//l_BracketCount <= 0
     end;//aText.Ch[aStartIndex] = evdCloseBracket
     theDecor.Decor := theDecor.Decor + aText.Ch[aStartIndex];
     l_DeleteFromCurrentChar(1);
    end;//while (aStartIndex < aText.Len)
    Assert(l_BracketCount = 0, 'Непарные фигурные скобки');
    Assert(aText.Ch[l_Finish] = aBracket, 'Непарные скобки формул');
    if (aBracket = ev_NSRCFormula) then
    begin
     aText.Delete(l_Finish, 1);
     theDecor.Finish := l_Finish;
    end;//aBracket = ev_NSRCFormula
    Result := true;
   except
    FreeAndNil(theDecor);
    raise;
   end;//try..except
  end//(l_MaskPos <> -1) and (l_MaskPos < l_Finish)
 end;//l_Finish <> -1
end;

procedure TddSegmentScanner.CheckFormula(aText: Tl3String; aStartIndex: Integer);
var
 l_Finish: Long;
 l_PartText: AnsiString;  

 function lp_FindPart(const aPart: AnsiString): Boolean;
 var
  l_S, l_F: Integer;
 begin
  Result := False;
  l_S := l3Pos(aText.AsPCharLen, l3PCharLen(aPart), False);
  if l_S <> -1 then
  begin
   l_S := Succ(l_S) + Length(aPart);
   l_F := Min(aText.FindChar(l_S, ';'), l_Finish);
   if l_F = -1 then
    l_F := l_Finish;
   l_PartText := Copy(aText.AsString, l_S, l_F - l_S + 1);
   Result := True;
  end; // l_S <> -1
 end; // lp_FindPart

 procedure l_DeleteFromCurrentChar(aLen: Integer);
 begin//l_DeleteFromCurrentChar
  aText.Delete(aStartIndex, aLen);
  Dec(l_Finish, aLen);
 end;//l_DeleteFromCurrentChar

var
 l_StartMask : Tl3WString;
 l_MaskPos : Integer;
 l_Formula: TsegFormula;
 l_Picture: TsegPicture;
 l_Decor : TsegDecorSegment;
begin
 if CheckDecor(aText, aStartIndex, ev_NSRCFormula, l_Decor) then
  try
//   Assert(false);
(*   f_Objects.Add(l_Decor);*)
   Exit;
  finally
   FreeAndNil(l_Decor);
  end;//try..finally
 l_Finish := aText.FindChar(Succ(aStartIndex), ev_NSRCFormula);
 if l_Finish <> -1 then
 begin
  // Вместо формулы может приехать картинка
  l_StartMask := l3PCharLen(AnsiString('PIC:'));
  l_MaskPos := l3Pos(aText.AsPCharLen, l_StartMask, False);
  if (l_MaskPos <> -1) and
     (aStartIndex < l_MaskPos) and
     (l_MaskPos < l_Finish) then
  begin
   // Это картинка pic:<путь к файлу с картинкой>;topic:12345;bloffs:2;height:120;width:120
   l_Picture := TsegPicture.Create;
   try
    l_Picture.Start := Succ(aStartIndex);
    // fileName
    if lp_FindPart('PIC:') then
     l_Picture.FileName := l_PartText;
    // Topic
    if lp_FindPart('TOPIC:') then
     l_Picture.DocID := StrToIntDef(l_PartText, -1);
    // BaseLineOffset
    if lp_FindPart('BLOFFS:') then
     l_Picture.BaseLineOffset := StrToIntDef(l_PartText, 0);
    // DPI
    if lp_FindPart('RES:') then
     l_Picture.DPI := StrToIntDef(l_PartText, 72);
    // HEIGHT
    if lp_FindPart('HEIGHT:') then
     l_Picture.Height := StrToIntDef(l_PartText, 0);
    // WIDTH
    if lp_FindPart('WIDTH:') then
     l_Picture.Width := StrToIntDef(l_PartText, 0);
    //
    f_Objects.Add(l_Picture);
   finally
    FreeAndNil(l_Picture);
   end;//try..finally
  end//(l_MaskPos <> -1) and (l_MaskPos < l_Finish)
  else
  begin
   // Это формула
   l_Formula := TsegFormula.Create;
   try
    l_Formula.Start := Succ(aStartIndex);
    l_Formula.Text := Copy(aText.AsString, aStartIndex + 2, l_Finish - aStartIndex - 1);
    f_Objects.Add(l_Formula);
   finally
    FreeAndNil(l_Formula);
   end;//try..finally
  end;//(l_MaskPos <> -1) and (l_MaskPos < l_Finish)
  aText.Delete(aStartIndex, l_Finish - aStartIndex + 1);
  aText.Insert('*', aStartIndex);
 end;//l_Finish <> -1
end;

procedure TddSegmentScanner.CheckHyperlink(aText: Tl3String; aStartIndex: Integer; aC: AnsiChar);
var
 j              : Longint;
 k              : Longint;
 H              : TsegHyperLink;
 l_DocID        : Longint;
 l_SubID        : Longint;
 l_TokenType    : Tl3TokenType;
 l_HyperLinks   : Tl3String;
 l_LineStream   : Tl3StringStream;
 l_LineParser   : Tl3CustomParser;
 l_DoNotDelete  : Boolean;
 l_SaveCodePage : Long;
begin
 if aText.Ch[aStartIndex] = ev_NSRCHyperlink then
 {Обработка ссылки:
   после первого ev_NSRCHyperlink следует имя ссылки, которое мы оставляем на месте.
   после второго - номера документов}
 begin
   l_DoNotDelete:= False;
   {$IFDEF AdjustPref}
   if (aC = 'P') and (Links.Count = 0) then
   begin
     j:= 0;
     while (aText.Ch[j] = ' ') do
       inc(j);
     if j = i then
       j:= 0
     else
       j:= i;
   end
   else
   {$ENDIF}
     j:= aStartIndex;
   aText.Delete(aStartIndex, 1);
   H:= TsegHyperLink.Create;
   try
     H.Start:= j+1;

     j:= aText.FindChar(Succ(j), ev_NSRCHyperlink);
     { Начался адрес ссылки }
     if j <> -1 {aText.Ch[j] = ev_NSRCHyperlink} then
     begin
       k:= j;
       H.Finish:= j{+1};
       aText.Delete(j, 1);
       l_Hyperlinks:= Tl3String.Create;
       try
        j:= aText.FindChar(Succ(j), ev_NSRCHyperlink);
        l_Hyperlinks.AssignSt(aText.St, k, j, aText.CodePage);
         if (j = -1) or (aText.Ch[j] <> ev_NSRCHyperlink) then
         begin
          l_SaveCodePage:= aText.CodePage;
          aText.CodePage:= cp_ANSI;
          OutErrorLog(aText.AsString);
          aText.CodePage:= l_SaveCodePage;
          l_DoNotDelete:= True;
         end
         else
         if l_Hyperlinks.Empty then
         begin
          l_SaveCodePage:= aText.CodePage;
          aText.CodePage:= cp_ANSI;
           OutErrorLog(Format(SNSCError_NoLinkAddress,
                   [TopicNo, aText.AsString]));
          aText.CodePage:= l_SaveCodePage;
           l_DoNotDelete:= True;
         end
         else
         begin
          l_LineParser := Tl3CustomParser.Create;
          try
           l_LineStream := Tl3StringStream.Create;
           try
            begin
             begin
              try
               l_LineStream._String:= l_Hyperlinks;
               with l_LineParser do
               begin
                CheckFiler.Stream := l_LineStream;
                try
                 CheckKeyWords := false;
                 CheckFloat := false;
                 LineComment  := '';
                 OpenComment  := '';
                 CloseComment := '';
                 WhiteSpace := [];
                 CheckInt := true;
                 WhiteSpace := [#0..cc_HardSpace] - [#1..#7, cc_Tab, cc_SoftEnter, cc_HardEnter, #21]; //Parser.WhiteSpace;
                 WordChars := cc_Digits;//Parser.WordChars;
                 NextToken;
                 while (l_LineParser.TokenType <> l3_ttEOF) do
                 begin
                  {-перебираем номера документов до конца строки}
                  l_DocID := TokenInt; {-берем номер документа}
                  if l_DocID = 0 then
                  begin
                    OutErrorLog(Format(SNSCError_AdressConvert,
                               [TopicNo, l_Hyperlinks.AsString]));
                    break;
                  end
                  else
                  begin
                    NextToken; {-пропускаем номер документа}
                    if (TokenChar = cc_Dot) then
                    begin
                     l_TokenType := NextTokenPrim(l3NextTokenAllFlags - [l3_ntfSkipBlanks, l3_ntfCheckString, l3_ntfCheckDoubleQuotedString]);
                     if (l_TokenType = l3_ttSingleChar) and (TokenChar in cc_WhiteSpaceExt) then
                      l_SubID := 0
                     else
                     begin
                      l_SubID := TokenInt; {-должен быть номер Sub'а}
                      NextTokenSP; {-пропускаем номер Sub'а}
                     end;
                    end
                    else
                     l_SubID := 0;
                    if l_DocID > 0 then
                     H.Add(l_DocID, l_SubID);
                   if TokenChar in cc_WhiteSpaceExt then
                    NextTokenSP;
                  end;
                 end;{while (l_LineParser.TokenType <> l3_ttEOF)}
                finally
                 Filer.Stream := nil;
                end;{try..finally}
               end;{with l_LineParser}
              finally
               l_LineStream._String := nil;
              end;{try..finally}
             end;{Parser.TokenChar = '!'}
            end;{while not EOF}
           finally
            l3Free(l_LineStream);
           end;{try..finally}
           if not H.Targets.Empty then
           begin
            HyperLinks.Add(H);
            if (Last <> nil) and (Last.Start = H.Start) then
             Last.WithText:= True;
           end;
          finally
           l3Free(l_LineParser);
          end;
         end;
       finally
         l3Free(l_Hyperlinks);
         try
          if not l_DoNotDelete then
           aText.Delete(k, j-k+1);
         except
           OutErrorLog(Format(SNSCError_LinkBadFormat, [TopicNo]));
         end;
       end;
     end; // if
   finally
     l3Free(H);
   end;
 end;
end;

procedure TddSegmentScanner.Cleanup;
begin
 l3Free(f_Errors);
 FreeAndNil(f_Stack);
 FreeAndNil(f_Segments);
 FreeAndNil(f_Hyperlinks);
 FreeAndNil(f_Objects);
 inherited;
end;

function TddSegmentScanner.Last: TddNSRCStackItem;
begin
 if f_Stack.Count > 0 then
   Result:= f_Stack.Last
 else
   Result:= nil;
end;

procedure TddSegmentScanner.DelLast;
begin
  if f_Stack.Count > 0 then
    f_Stack.Delete(Pred(f_Stack.Count));
end;

procedure TddSegmentScanner.OutErrorLog(aMessage: AnsiString);
begin
 f_Errors.Add(aMessage);
end;

procedure TddSegmentScanner.Scan(aText: Tl3String; aTrim: Boolean; aJustify:
    AnsiChar);
var
  i, j, k: Longint;
  S: TsegSeg;
  H: TsegHyperLink;
  l_DocID, l_SubID: Longint;
  St: AnsiString;
  SI: TddNSRCStackItem;
  l_HyperLinks: Tl3String;
  l_LineStream    : Tl3StringStream;
  l_LineParser    : Tl3CustomParser;
  l_DoNotDelete   : Boolean;
  l_SaveCodePage  : Long;
  l_Decor : TsegDecorSegment;
begin
 f_Errors.Clear;
 f_Segments.Clear;
 f_Hyperlinks.Clear;
 f_Stack.Clear;
 f_Objects.Clear;
  i:= 0;
  if aTrim then
    SmartTrim(aText);
  l_Decor := nil;
  while i < aText.Len do
  begin
   try
    if aText.Ch[i] in [ev_NSRCColorSelection..ev_NSRCComment, ev_NSRCInvisible..ev_NSRCNotApplied] then
    begin
      if (aText.Ch[i] = ev_NSRCColorSelection) then
       CheckDecor(aText, i, ev_NSRCColorSelection, l_Decor);
      if (Last <> nil) and Last.IsOn(aText.Ch[i]){ and
         ((aText.Ch[i] = #5) and (i=aText.Len-1))} then
      begin { закрываем текущий сегмент }
      // сегмент может охватывать ссылку. В этом случае у него не будет текста
        if Last.WithText then
        begin
         S := TsegSeg.Create(l_Decor, Last, i{+1});
         try
(*          S.Start:= Last.Start;
          s.GetFromStackItem(Last);
          S.Finish:= i{+1};*)

          Last.WithText:= False;
          {Борьба с плохими сегментами}
//          if S.Comment or S.Hidden then
//            S.Finish:= aText.Len-1;
          {----}
          Segments.{Add}Insert(0,S);
         finally
          l3Free(s);
         end;
        end; //LastWithText
        case aText.Ch[i] of
         ev_NSRCColorSelection: Last.ColorSelection:= False;
         ev_NSRCHyperlinkCont: Last.HLContinue:= False;
         ev_NSRCComment: Last.Comment:= False;
         ev_NSRCInvisible: Last.Hidden:= False;
         ev_NSRCOutOfDate: Last.OutOfDate:= False;
         ev_NSRCNotApplied: Last.NotApplied:= False;
        end; // case
        if (Last.ColorSelection = False) and (Last.HLContinue = False) and (Last.Comment = False)
            and (Last.Hidden = False) and (Last.OutOfDate = False) and (Last.NotApplied = False) then
          DelLast;
      end
      else
      begin
        {$IFDEF AdjustPref}
        if aC = 'P' then
        begin
          j:= 0;
          while (aText.Ch[j] = ' ') do
            inc(j);
          if j = i then
            j:= 0
          else
            j:= i;
        end
        else
        {$ENDIF}
          j:= i;
        if (Last = nil) or Last.WithText then
        begin
         SI:= TddNSRCStackItem.Create(l_Decor);
         try
          SI.Start:= j+1;
          f_Stack.Add(SI);
         finally
          FreeAndNil(si);
         end;//try..finally
        end;
        //else
          case aText.Ch[i] of
            ev_NSRCColorSelection: Last.ColorSelection:= True;
            ev_NSRCHyperlinkCont: Last.HLContinue:= True;
            ev_NSRCComment: Last.Comment:= True;
            ev_NSRCInvisible: Last.Hidden:= True;
            ev_NSRCOutOfDate: Last.OutOfDate:= True;
            ev_NSRCNotApplied: last.NotApplied:= True;
          end;
      end;
      aText.Delete(i, 1);
      Dec(i);
    end
    else

    if aText.Ch[i] = ev_NSRCHyperlink then
    begin
    {Обработка ссылки:
      после первого ev_NSRCHyperlink следует имя ссылки, которое мы оставляем на месте.
      после второго - номера документов}
     CheckHyperlink(aText, i, aJustify);
     Dec(i);
    end
    else
    if aText.Ch[i] = ev_NSRCFormula then
    begin
     { 1. Извлекаем формулу
       2. Вместо нее вставляем звездочку}
     CheckFormula(aText, i);
    end
    else
    if (Last <> nil) and not Last.WithText then
    begin
     Last.WithText:= (aText.Ch[i] > ' ') or
                     ((aText.Ch[i] = ' ') and (i = 0)) or
                        ({(aText.Ch[i] = ' ') and} (aText.Ch[i] > ' ')) or
                        ((aText.Ch[i] = ' ') and not aTrim);
    end;
    inc(i);
   finally
    FreeAndNil(l_Decor);
   end;//try..finally
  end;//while i < aText.Len

end;

class procedure TddSegmentScanner.SmartTrim(Text: Tl3String);
var
  i: Integer;
begin
 i:= 0;
 while (Text.Ch[i] < #33) and (i < Text.Len) do
 begin
  if (Text.Ch[i] = #32) then
   Text.Delete(i, 1)
  else
   Inc(i);
 end;
 i:= Text.Len-1;
 while (Text.Ch[i] < #33) and (i >= 0) do
 begin
  if (Text.Ch[i] = #32) then
   Text.Delete(i, 1)
  else
   Dec(i);
 end;
 for i:= 0 to Text.Len-1 do
  if Text.Ch[i] < #32 then
   if (i > 0) and (i < Text.Len-1) then
    if (Text.Ch[i-1] = ' ') and (Text.Ch[i+1] = ' ') then
     Text.Delete(i-1, 1);
end;

end.
 