unit ddEntryCollector;

{ $Id: ddEntryCollector.pas,v 1.9 2016/08/24 09:11:09 fireton Exp $ }

// $Log: ddEntryCollector.pas,v $
// Revision 1.9  2016/08/24 09:11:09  fireton
// - автопростановка ссылок, рефакторинг и доработка
//
// Revision 1.8  2016/08/01 15:05:25  fireton
// - переделка автолинкера
//
// Revision 1.7  2014/06/20 12:50:34  fireton
// - пилим автолинковщик на базовые классы
//
// Revision 1.6  2013/04/11 17:14:58  lulin
// - отлаживаем под XE3.
//
// Revision 1.5  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.4  2012/03/11 08:59:05  fireton
// - добавил "Єлочки" в кавычки дл€ подпунктов
//
// Revision 1.3  2011/10/18 12:04:32  fireton
// - "стать€" не попадало в ссылку при перечислении нескольких статей
// - из "ст. ст." в ссылку попадало только одно "ст."
// [$281516839]
//
// Revision 1.2  2011/07/01 11:57:15  fireton
// - у подпунктов бывает сокращение "подп."
//
// Revision 1.1  2011/06/30 13:18:05  fireton
// - выделил TddEntryCollector в отдельный модуль
//

interface

uses
  l3Interfaces,
  l3ProtoObject,
  l3RecList,
  l3RegEx,

  ddDocStructBase
  ;

type
 TddAddrEntryType = (aeChapter, aeHead, aeEntry, aeItem, aeSubitem, aeParagraph, aePart);

 PLinkPrimRec = ^TLinkPrimRec;
 TLinkPrimRec = record
  rStart   : Integer;
  rEnd     : Integer;
  rAddress : TddDocStructElementRec;
  rENum    : String[20];
 end;

 TddEntryCollector = class(Tl3ProtoObject)
 private
  f_RightAligned: Boolean;
  f_SPAddrCluster: Tl3RegularSearch;
  f_SPAddrEntryTypeArray: array [TddAddrEntryType] of Tl3RegularSearch;
  f_SPSingleAddress: Tl3RegularSearch;
  f_SPNumberCluster: Tl3RegularSearch;
  f_SPSingleNumber: Tl3RegularSearch;
  function DetectEntryType(const aStr: Tl3WString; out theType: TddAddrEntryType): Boolean;
  function pm_GetSPAddrCluster: Tl3RegularSearch;
  function pm_GetSPAddrEntryType(aType: TddAddrEntryType): Tl3RegularSearch;
  function pm_GetSPSingleAddress: Tl3RegularSearch;
  function pm_GetSPNumberCluster: Tl3RegularSearch;
  function pm_GetSPSingleNumber: Tl3RegularSearch;
 protected
  procedure Cleanup; override;
  property SPAddrCluster: Tl3RegularSearch read pm_GetSPAddrCluster;
  property SPAddrEntryType[aType: TddAddrEntryType]: Tl3RegularSearch read pm_GetSPAddrEntryType; default;
  property SPSingleAddress: Tl3RegularSearch read pm_GetSPSingleAddress;
  property SPNumberCluster: Tl3RegularSearch read pm_GetSPNumberCluster;
  property SPSingleNumber: Tl3RegularSearch read pm_GetSPSingleNumber;
 public
  constructor Create(aRightAligned: Boolean = True);
  function CollectEntries(aText: PAnsiChar; aStart, aFinish: Integer; aEntryList: Tl3RecList): Boolean;
  class function MakeEntryList: Tl3RecList;
 end;

implementation
uses
 SysUtils,

 l3Const,
 l3Base,
 l3Chars,
 l3String
 ;

const
 sp_Entry     = '(стат\w+)|(ст\.\s?ст\.)|(ст\.)';
 sp_Chapter   = '(раздел\w*)|(разд\.)';
 sp_Head      = '(глав\w+)|(гл\.\s?гл\.)|(гл\.)';
 sp_Item      = '(пункт\w*)|(п\.\s?п\.)|(п\.)';
 sp_Subitem   = '(подпункт\w*)|(подп\.)|(пп\.\s?пп\.)|(пп\.)';
 sp_Paragraph = '(абзац\w*)|(абз\.)';
 sp_Part      = '(част\w+)|(ч\.)|(чч\.)';

 sp_ItemNumber  = '((\d+)|([CDIVXLMcdivxlm]+)(\.\d+)?(\.\d+)?)'; // число, возможно римское, с точкой или без
 sp_ItemLetter  = '((["УЂ][а-€]["Фї])|(>[а-€]<))'; // буква (может быть в кавычках)
 sp_ItemNumberT = '((["УЂ]{[а-€]}["Фї])|(>{[а-€]}<))|({(\d+)|([CDIVXLMcdivxlm]+)}(\.{\d+})?(\.{\d+})?)'; // паттерн дл€ "выкусывани€" числа
 sp_NumberCluster  = '((((\,\s?)|(\sи\s))?(('+sp_ItemNumber+'\s?\-\s?'+sp_ItemNumber+')|('+sp_ItemNumber+')))+)|((((\,\s?)|(\sи\s))?(('+sp_ItemLetter+'\s?\-\s?'+sp_ItemLetter+')|('+sp_ItemLetter+')))+)';
 sp_NumberClusterT = '((((\,\s?)|(\sи\s))?({'+sp_ItemNumber+'\s?\-\s?'+sp_ItemNumber+'})|({'+sp_ItemNumber+'}))+)|((((\,\s?)|(\sи\s))?({'+sp_ItemLetter+'\s?\-\s?'+sp_ItemLetter+'})|({'+sp_ItemLetter+'}))+)';

 sp_AnyEntry = sp_Entry+'|'+sp_Chapter+'|'+sp_Head+'|'+sp_Item+'|'+sp_Subitem+'|'+sp_Paragraph+'|'+sp_Part;
 // единичный "адрес" - это строка вида "пп.пп. 12-15 п. 10.1 ст. 123", дл€ одного документа их может быть несколько
 sp_SingleAddress  = '('+sp_AnyEntry+'\s*'+sp_NumberCluster+'\s*)+';
 sp_SingleAddressT = '({'+sp_AnyEntry+'}\s*{'+sp_NumberCluster+'}\s*)+';

 sp_AddressClusterT  = '({'+sp_SingleAddress+'}(([\,\;]\s?)|(\s*и\s+))?)+';
 sp_AddressClusterRT = sp_AddressClusterT+'$';
 

const
 cAddrEntryPattern: array [TddAddrEntryType] of string =
     (sp_Chapter, sp_Head, sp_Entry, sp_Item, sp_Subitem, sp_Paragraph, sp_Part);

constructor TddEntryCollector.Create(aRightAligned: Boolean = True);
begin
 inherited Create;
 f_RightAligned := aRightAligned; // ищем адреса, прижатые к правому краю переданной строки или по всей строке
end;

procedure TddEntryCollector.Cleanup;
var
 l_Type: TddAddrEntryType;
begin
 FreeAndNil(f_SPAddrCluster);
 FreeAndNil(f_SPSingleAddress);
 FreeAndNil(f_SPNumberCluster);
 FreeAndNil(f_SPSingleNumber);
 for l_Type := Low(TddAddrEntryType) to High(TddAddrEntryType) do
  FreeAndNil(f_SPAddrEntryTypeArray[l_Type]);
 inherited;
end;

function TddEntryCollector.CollectEntries(aText: PAnsiChar; aStart, aFinish: Integer; aEntryList: Tl3RecList): Boolean;
type
 TElementRec = record
  rNumStr: Tl3WString;
  rNum   : TddElementNumRec;
 end;
var
 l_Text: Tl3WString;
 l_AddrClusterPos: Tl3MatchPosition;
 l_AddrIdx: Integer;
 l_AddrStr: Tl3WString;
 l_AddrPos: Tl3MatchPosition;
 l_AddrEntryStr: Tl3WString;
 l_AddrEntryIdx: Integer;
 l_AddrEntryPos: Tl3MatchPosition;
 l_AddrEntryNumStr: Tl3WString;
 l_EntryType: TddAddrEntryType;
 l_ComplexAddrDetected: Boolean; // обрабатываем цепочку подпункт-пункт-стать€
 l_LinkRec: TLinkPrimRec;
 l_ElemArray: array [aeEntry..aeSubitem] of array of TElementRec;

 procedure ClearElements;
 var
  l_EIdx: TddAddrEntryType;
 begin
  for l_EIdx := aeEntry to aeSubitem do
   l_ElemArray[l_EIdx] := nil;
 end;

 procedure ExcavateNumbersFromCluster(const aClusterStr: Tl3WString; const aElement: TddAddrEntryType);
 var
  I: Integer;
  l_RP: Tl3MatchPosition;
  l_NumStr: Tl3WString;
  l_Pos: Integer;
  l_Subnum: Tl3WString;
  l_SubSubnum: Tl3WString;
 begin
  Assert(aElement in [aeEntry..aeSubitem]);
  if (aElement = aeItem) and (l_ElemArray[aeItem] <> nil) then
  begin
   // то, что мы думали было пунктом, на самом деле подпункт
   // надо скопировать данные
   SetLength(l_ElemArray[aeSubItem], Length(l_ElemArray[aeItem]));
   for I := 0 to High(l_ElemArray[aeItem]) do
    l_ElemArray[aeSubItem][I] := l_ElemArray[aeItem][I];
  end;

  l_ElemArray[aElement] := nil;
  if SPNumberCluster.SearchInString(aClusterStr, l_RP) then
  begin
   SetLength(l_ElemArray[aElement], SPNumberCluster.TagParts.Count);
   for I := 0 to Pred(SPNumberCluster.TagParts.Count) do
   begin
    l_ElemArray[aElement][I].rNumStr := SPNumberCluster.TagParts[I].AsWStr;
    l_NumStr := l_ElemArray[aElement][I].rNumStr;
    l_Pos := ev_lpCharIndex('-', l_NumStr);
    if l_Pos <> l3NotFound then
     l_NumStr.SLen := l_Pos;
    if SPSingleNumber.SearchInString(l_NumStr, l_RP) then
    begin

     if SPSingleNumber.TagParts.Count > 1 then
      l_Subnum := SPSingleNumber.TagParts[1].AsWStr
     else
      l_Subnum := cc_EmptyStr;
     if SPSingleNumber.TagParts.Count > 2 then
      l_SubSubnum := SPSingleNumber.TagParts[2].AsWStr
     else
      l_SubSubnum := cc_EmptyStr;
     FillOutEntryNum(l_ElemArray[aElement][I].rNum, SPSingleNumber.TagParts[0].AsWStr, l_Subnum, l_SubSubnum);
    end;
   end;
  end;
 end;

 procedure PutNumToAddrRec(const aIdx: Integer; aType: TddAddrEntryType; var theAddr: TddDocStructElementRec);
 var
  l_Len: Integer;
 begin
  l_Len := Length(l_ElemArray[aType]);
  if (l_Len > 0) and (aIdx < l_Len) then
   case aType of
    aeEntry   : theAddr.rEntry := l_ElemArray[aType][aIdx].rNum;
    aeItem    : theAddr.rItem := l_ElemArray[aType][aIdx].rNum;
    aeSubitem : theAddr.rSubItem := l_ElemArray[aType][aIdx].rNum;
   end;
 end;

 procedure FlushEntries(const aStructType: TddStructType);
 var
  l_PLink: TLinkPrimRec;
  l_MultiType: TddAddrEntryType;
  l_EIdx: TddAddrEntryType;
  l_Len: Integer;
  I: Integer;
 begin
  // ƒл€ начала надо пон€ть, с какого элемента начинать. ≈сли в каком-то из элементов есть
  // перечисление, то начинать будем с него.
  l_MultiType := aeChapter; // aeChapter используем в качестве undefined значени€
  for l_EIdx := aeSubitem downto aeEntry do
  begin
   l_Len := Length(l_ElemArray[l_EIdx]);
   if l_Len > 1 then
    l_MultiType := l_EIdx;
  end;
  l3FillChar(l_PLink, SizeOf(TLinkPrimRec));
  l_PLink.rAddress.rType := aStructType;
  if l_MultiType = aeChapter then // т.е. нету перечислений номера
  begin
   // ставим ссылку на весь адрес
   PutNumToAddrRec(0, aeEntry, l_PLink.rAddress);
   PutNumToAddrRec(0, aeItem, l_PLink.rAddress);
   PutNumToAddrRec(0, aeSubitem, l_PLink.rAddress);
   l_PLink.rStart := l_AddrStr.S - aText;
   l_PLink.rEnd   := l_PLink.rStart + l_AddrStr.SLen;
   aEntryList.Add(l_PLink);
  end
  else
  begin
   // «аполн€ем адресную запись "константными" значени€ми,
   // игнорируем все элементы "ниже" перечисл€емых. “.е. если есть диапазон пунктов,
   // то подпункты не попадают в адрес (потому что така€ строка - это ошибка вообще-то)
   for l_EIdx := aeEntry to l_MultiType do
    PutNumToAddrRec(0, l_EIdx, l_PLink.rAddress);
   // а теперь организуем цикл по перечислению
   l_Len := Length(l_ElemArray[l_MultiType]);
   Dec(l_Len);
   for I := 0 to l_Len do
   begin
    PutNumToAddrRec(I, l_MultiType, l_PLink.rAddress);
    if I = 0 then
     l_PLink.rStart := l_AddrStr.S - aText
    else
     l_PLink.rStart := l_ElemArray[l_MultiType][I].rNumStr.S - aText;
    if I < l_Len then
     l_PLink.rEnd := l_ElemArray[l_MultiType][I].rNumStr.S - aText + l_ElemArray[l_MultiType][I].rNumStr.SLen
    else
     l_PLink.rEnd := l_AddrStr.S - aText + l_AddrStr.SLen;
    aEntryList.Add(l_PLink);
   end;
  end;
 end;

begin
 aEntryList.Clear;
 Result := False;
 l_Text := l3PCharLen(aText + aStart, aFinish-aStart+1);
 if SPAddrCluster.SearchInString(l_Text, l_AddrClusterPos) then
 begin
  // последовательно разбираем единичные адреса
  for l_AddrIdx := 0 to Pred(SPAddrCluster.TagParts.Count) do
  begin
   l_AddrStr := l3RTrim(SPAddrCluster.TagParts[l_AddrIdx].AsWStr);
   if SPSingleAddress.SearchInString(l_AddrStr, l_AddrPos) then
   begin
    // последовательно разбираем части адреса и смотрим, что у нас получаетс€ (заполн€ем запись)
    l_AddrEntryIdx := 0;
    l_ComplexAddrDetected := False;
    ClearElements;
    while l_AddrEntryIdx < SPSingleAddress.TagParts.Count do
    begin
     l_AddrEntryStr := SPSingleAddress.TagParts[l_AddrEntryIdx].AsWStr;
     l_AddrEntryNumStr := SPSingleAddress.TagParts[l_AddrEntryIdx+1].AsWStr;
     if DetectEntryType(l_AddrEntryStr, l_EntryType) then
     begin
      case l_EntryType of
       aeEntry, aeItem, aeSubitem:
       begin
        l_ComplexAddrDetected := True;
        ExcavateNumbersFromCluster(l_AddrEntryNumStr, l_EntryType);
       end;

       aeHead:
       if not l_ComplexAddrDetected then
       begin
        ExcavateNumbersFromCluster(l_AddrEntryNumStr, aeEntry);
        FlushEntries(stHead);
        Break;
       end;
       {
       aeChapter:
       if not l_ComplexAddrDetected then
       begin
        ExcavateNumbersFromCluster(l_AddrEntryNumStr, aeEntry);
        FlushEntries(stChapter);
        Break;
       end;
       }

       aePart:
       //if l_ComplexAddrDetected then
       begin
        l_ComplexAddrDetected := True;
        ExcavateNumbersFromCluster(l_AddrEntryNumStr, aeItem);
        {
        FlushEntries(stPart);
        Break;
        }
       end;
      end; // case
     end; // if DetectEntryType
     Inc(l_AddrEntryIdx, 2);
    end; // while l_AddrEntryIdx
    if l_ComplexAddrDetected then
     FlushEntries(stEntry);
   end;
  end; // for l_AddrIdx
 end;
 Result := aEntryList.Count > 0;
end;

function TddEntryCollector.DetectEntryType(const aStr: Tl3WString; out theType: TddAddrEntryType): Boolean;
var
 l_Type: TddAddrEntryType;
 l_RP: Tl3MatchPosition;
begin
 Result := False;
 for l_Type := Low(TddAddrEntryType) to High(TddAddrEntryType) do
  if SPAddrEntryType[l_Type].SearchInString(aStr, l_RP) then
  begin
   Result := True;
   theType := l_Type;
   Exit;
  end;
end;

class function TddEntryCollector.MakeEntryList: Tl3RecList;
begin
 Result := Tl3RecList.Create(SizeOf(TLinkPrimRec));
end;

function TddEntryCollector.pm_GetSPAddrCluster: Tl3RegularSearch;
begin
 if f_SPAddrCluster = nil then
 begin
  f_SPAddrCluster := Tl3RegularSearch.Create;
  f_SPAddrCluster.IgnoreCase := True;
  if f_RightAligned then
   f_SPAddrCluster.SearchPattern := sp_AddressClusterRT
  else
   f_SPAddrCluster.SearchPattern := sp_AddressClusterT;
 end;
 Result := f_SPAddrCluster;
end;

function TddEntryCollector.pm_GetSPAddrEntryType(aType: TddAddrEntryType): Tl3RegularSearch;
begin
 if f_SPAddrEntryTypeArray[aType] = nil then
 begin
  f_SPAddrEntryTypeArray[aType] := Tl3RegularSearch.Create;
  f_SPAddrEntryTypeArray[aType].IgnoreCase := True;
  f_SPAddrEntryTypeArray[aType].SearchPattern := '^'+cAddrEntryPattern[aType];
 end;
 Result := f_SPAddrEntryTypeArray[aType];
end;

function TddEntryCollector.pm_GetSPSingleAddress: Tl3RegularSearch;
begin
 if f_SPSingleAddress = nil then
 begin
  f_SPSingleAddress := Tl3RegularSearch.Create;
  f_SPSingleAddress.IgnoreCase := True;
  f_SPSingleAddress.SearchPattern := sp_SingleAddressT;
 end;
 Result := f_SPSingleAddress;
end;

function TddEntryCollector.pm_GetSPNumberCluster: Tl3RegularSearch;
begin
 if f_SPNumberCluster = nil then
 begin
  f_SPNumberCluster := Tl3RegularSearch.Create;
  f_SPNumberCluster.IgnoreCase := True;
  f_SPNumberCluster.SearchPattern := sp_NumberClusterT;
 end;
 Result := f_SPNumberCluster;
end;

function TddEntryCollector.pm_GetSPSingleNumber: Tl3RegularSearch;
begin
 if f_SPSingleNumber = nil then
 begin
  f_SPSingleNumber := Tl3RegularSearch.Create;
  f_SPSingleNumber.IgnoreCase := True;
  f_SPSingleNumber.SearchPattern := sp_ItemNumberT;
 end;
 Result := f_SPSingleNumber;
end;

end.