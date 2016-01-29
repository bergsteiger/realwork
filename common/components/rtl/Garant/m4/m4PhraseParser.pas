unit m4PhraseParser;

interface
uses

 l3Base,
 l3ProtoObject,
 l3ObjectRefList,
 l3String,
 l3Interfaces,
 l3LingLib,

 m4DictTypes,
 m4DictScanner;

 const
  cDateDictID       = -1;//High(Longint);
  cNumDictID        = -2;//High(Longint) - 1;
  cTextDictID       = -3;//
  cLawcaseNumDictID = -4;
  cGostDictID       = -5;

 // разбирает строку на словарные элементы aDictScanner'ом + дату и номер
 // дата передается как TSTDate в aDictItemID.ID и aDictItemID.rDictionaryID = cDateDictID
 // номер передается в Tm4Segment как фрагмент исходной строки aDictItemID.rDictionaryID = cNumDictID

 procedure DoParsePhrase(const aPhrase : Tl3WString; aDictScanner : Tm4DictScanner; aFoundProc : Tm4FoundDictItemProc);

implementation
uses
 SysUtils,

 l3Types,
 l3Chars,
 l3Date,
 l3MinMax,
 l3RegEx;

var
 gRegSrchForDate    : Tl3RegularSearch;
 gRegSrchForNum     : Tl3RegularSearch;
 gRegSrchForLawcase : Tl3RegularSearch;
 gRegSrchForGost    : Tl3RegularSearch;

function CheckDocNum(var theNumStr: Tl3WString): Boolean;
var
 I : Integer;
 l_ParCount: Integer;
begin
 Result := True;
 // проверяем на невалидные символы в конце строки
 while (theNumStr.SLen > 0) and (theNumStr.S[theNumStr.SLen-1] in ['-','.']) do
  Dec(theNumStr.SLen);
 if theNumStr.SLen > 0 then
 begin
  // а теперь - проверка на парность скобок
  l_ParCount := 0;
  for I := 0 to theNumStr.SLen-1 do
  begin
   case theNumStr.S[I] of
    '(': Inc(l_ParCount);
    ')': if l_ParCount > 0 then
          Dec(l_ParCount)
         else
         begin
          theNumStr.SLen := I; // найдена закрывающая скобка без открывающей, отрезаем всё за ней
          if theNumStr.SLen = 0 then
           Result := False;
          Break;
         end;
   end;
  end;
  if l_ParCount > 0 then  // незакрытые скобки
   Result := False;
 end
 else
  Result := False;
end;


procedure DoParsePhrase(const aPhrase : Tl3WString; aDictScanner : Tm4DictScanner; aFoundProc : Tm4FoundDictItemProc);

 function lFoundDictItem(var aDictItemID : Tm4DictItemAddr; var theSegment : Tm4Segment) : boolean;
 // предобработка, попытка найти даты и номера
 var
  lStr : Tl3PCharLen;
  lREPosition         : Tl3MatchPosition;
  lDay, lMonth, lYear : Integer;

 function lf_ExtractNum(const aNumRegExp: Tl3RegularSearch; aDoCheckNum: Boolean = True): Boolean;
 var
  l_NumStr: Tl3WString;
 begin
  l_NumStr := aNumRegExp.TagParts[0].AsWStr;
  if aDoCheckNum then
   Result := CheckDocNum(l_NumStr)
  else
   Result := True;
  if Result then
  begin
   with l_NumStr do
   begin
    theSegment.rOffs := S - aPhrase.S;
    theSegment.rLen := SLen;
   end;
  end;
 end;

 begin
  Result := True; // продолжать разбор
  with theSegment do
   lStr := l3PCharLen(aPhrase.S + rOffs, aPhrase.SLen - rOffs, aPhrase.SCodePage);

  if gRegSrchForNum.SearchInString(lStr, lREPosition) then
  begin
   if lf_ExtractNum(gRegSrchForNum) then
   begin
    aDictItemID := Tm4DictItemAddr_C(0, cNumDictID);
    Result := False; //остановить обработку токена
   end;
  end
  else
  if gRegSrchForLawcase.SearchInString(lStr, lREPosition) then
  begin
   if lf_ExtractNum(gRegSrchForLawcase) then
   begin
    aDictItemID := Tm4DictItemAddr_C(0, cLawcaseNumDictID);
    Result := False; //остановить обработку токена
   end;
  end
  else
  if gRegSrchForGost.SearchInString(lStr, lREPosition) then
  begin
   lf_ExtractNum(gRegSrchForGost, False);
   aDictItemID := Tm4DictItemAddr_C(0, cGostDictID);
   Result := False; //остановить обработку токена
  end
  else
  if gRegSrchForDate.SearchInString(lStr, lREPosition) then
  begin
   lDay := l3StrToInt(gRegSrchForDate.TagParts[0].AsWStr);
   with gRegSrchForDate.TagParts[1], AsWStr do
    case S[0] of
     '0'..'9' : lMonth := l3StrToInt(AsWStr);
     'Я','я'  : lMonth := 1;
     'Ф','ф'  : lMonth := 2;

     'М','м'  : if S[2] in ['Р','р'] then
                 lMonth := 3
                else
                 lMonth := 5;

     'И','и'  : if S[2] in ['Н','н'] then
                 lMonth := 6
                else
                 lMonth := 7;

     'А','а'  : if S[1] in ['П','п'] then
                 lMonth := 4
                else
                 lMonth := 8;

     'С','с'  : lMonth := 9;
     'О','о'  : lMonth := 10;
     'Н','н'  : lMonth := 11;
     'Д','д'  : lMonth := 12;
    end; // case S[0] of

   lYear := l3StrToInt(gRegSrchForDate.TagParts[2].AsWStr);
   lYear := ExpandYear(lYear);
   theSegment.rLen := lREPosition.Length;
   aDictItemID := Tm4DictItemAddr_C(DMYtoStDate(lDay, lMonth, lYear), cDateDictID);
   Result := False; //остановить обработку токена
  end;
 end;

var
 lFDIProcStub : Tm4PreProcessProc;

begin
 lFDIProcStub := L2PreProcessProc(@lFoundDictItem);
 try
  aDictScanner.ProcessStr(aPhrase, aFoundProc, lFDIProcStub);
 finally
  FreePreProcessProc(lFDIProcStub);
 end;
end;

//january february march april may june july august september october november december

const
 c_GeneralNumberPattern = '((NN?)|(№№?))\_?{[\w\-\\\/\@\*\(\)\.\§'+cc_SoftSpace+']+}';
 c_DocNumPattern        = '^' + c_GeneralNumberPattern;
 c_LawcaseNumPattern    = '^по делу ' + c_GeneralNumberPattern;
 c_DatePattern          = '^(от\s)?{\d\d?}(\.|\s+){(\d\d)|(январ(ь|я))|(феврал(ь|я))|(марта?)|(ма(й|я))|(июн(ь|я))|(июл(ь|я))|(августа?)|(апрел(ь|я))|(сентябр(ь|я))|(октябр(ь|я))|(ноябр(ь|я))|(декабр(ь|я))}(\.|\s+){\d\d(\d\d)?}(\s?г(\.|(ода)))?';
 c_GostPattern          = '^{(ГОСТ(\s+Р)?((\s+(ЕН)|(ИСО)|(МЭК)([\/\\](МЭК)|(ТС)|(ТО)|(ТУ))?)?)?(\s+ТО)?)|(СТ\s+СЭВ)\s+\d[0-9\.\-\:]+\d}';

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\m4\m4PhraseParser.pas initialization enter'); {$EndIf}
 gRegSrchForDate := Tl3RegularSearch.Create;
 gRegSrchForDate.IgnoreCase := true;
 gRegSrchForDate.SearchPattern := c_DatePattern;

 gRegSrchForNum  := Tl3RegularSearch.Create;
 gRegSrchForNum.IgnoreCase := true;
 gRegSrchForNum.SearchPattern := c_DocNumPattern;

 gRegSrchForLawcase  := Tl3RegularSearch.Create;
 gRegSrchForLawcase.IgnoreCase := true;
 gRegSrchForLawcase.SearchPattern := c_LawcaseNumPattern;

 gRegSrchForGost  := Tl3RegularSearch.Create;
 gRegSrchForGost.IgnoreCase := true;
 gRegSrchForGost.SearchPattern := c_GostPattern;

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\m4\m4PhraseParser.pas initialization leave'); {$EndIf}
finalization
 FreeAndNil(gRegSrchForDate);
 FreeAndNil(gRegSrchForNum);
 FreeAndNil(gRegSrchForLawcase);
 FreeAndNil(gRegSrchForGost);
end.
