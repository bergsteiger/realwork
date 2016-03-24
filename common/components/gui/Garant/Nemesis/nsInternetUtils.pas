unit nsInternetUtils;
 {* Вспомогательные функции для Интернет-агента }

// Модуль: "w:\common\components\gui\Garant\Nemesis\nsInternetUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsInternetUtils" MUID: (49EEF16603C9)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
;

const
 {* URL адреса, открываемые во встроенном браузере }
 InternalBrowserURLArr: array [0 .. 2] of AnsiString = ('www.garant.ru'
 , 'mirror2.garant.ru'
 , 'forum.garant.ru'
 );

function nsIsGarantURL(const anURL: WideString): Boolean;
 {* Определяет, что адрес в домене Гаранта }
function nsIsLocalDocumentURL(const anURL: WideString): Boolean;
 {* Определяет, что ссылка на внутренний документ }
function nsParseLocalDocumentURL(const anURL: WideString;
 out DocID: Integer;
 out SubID: Integer): Boolean;
 {* Разобрать локальную ссылку на документ }
function nsIsContractConstructorURL(const anURL: WideString): Boolean;
function nsIsMobileGarantOnlineURL(const anURL: WideString): Boolean;
function nsNeedOpenLinkInExternalBrowser(const anURL: WideString): Boolean;
function nsIsObtainRequisitesForMobileAccessURL(const anURL: WideString): Boolean;
function nsIsMunicipalDecisionsArchiveURL(const anURL: WideString): Boolean;
function nsNeedOpenLinkInInternalBrowser(const anURL: WideString): Boolean;
function nsIsMailtoURL(const anURL: WideString): Boolean;
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , l3RegEx
 , l3String
 , l3Const
 , l3Interfaces
 , l3Base
 , l3Types
 , SysUtils
 , l3LongintList
;

function nsIsGarantURL(const anURL: WideString): Boolean;
 {* Определяет, что адрес в домене Гаранта }
//#UC START# *49EEF1BA019B_49EEF16603C9_var*
const
 cMask = '^(res\:\/\/.+#)*https?\:\/\/([^\\\.]+\.)*garant.ru($|\_)';
//#UC END# *49EEF1BA019B_49EEF16603C9_var*
begin
//#UC START# *49EEF1BA019B_49EEF16603C9_impl*
 Result := l3Starts('about:', l3PCharLen(anURL), true) or l3CheckStrByPattern(cMask, l3PCharLen(anURL));
//#UC END# *49EEF1BA019B_49EEF16603C9_impl*
end;//nsIsGarantURL

function nsIsLocalDocumentURL(const anURL: WideString): Boolean;
 {* Определяет, что ссылка на внутренний документ }
//#UC START# *4BEBC370007F_49EEF16603C9_var*
const
 cMask = '^(res\:\/\/.+#)*https?\:\/\/([^\\\.]+\.)*base.garant.ru($|\_)';
//#UC END# *4BEBC370007F_49EEF16603C9_var*
begin
//#UC START# *4BEBC370007F_49EEF16603C9_impl*
 Result := l3CheckStrByPattern(cMask, l3PCharLen(anURL));
//#UC END# *4BEBC370007F_49EEF16603C9_impl*
end;//nsIsLocalDocumentURL

function nsParseLocalDocumentURL(const anURL: WideString;
 out DocID: Integer;
 out SubID: Integer): Boolean;
 {* Разобрать локальную ссылку на документ }
//#UC START# *4BEBC4090016_49EEF16603C9_var*
type
 TnsLocalDocumentURLKind = (ns_ukInvalid, ns_ukDocID, ns_ukDocIDWithSubID,
  ns_ukDocIDWithPageNumber, ns_ukFull);
const
 //Общая регулярка
 cBaseDocumentMask: String = 'https?\:\/\/(base.garant.ru)\/[0-9]+\/?([0-9]+)(\/)?(#(block_)?[0-9]+)$';
 //Только номер документа
 cDocIDOnlyMask: String = 'https?\:\/\/(base.garant.ru)\/[0-9]+\/?$';
 //Номер документа с сабом
 cDocIDWithSubIDMask: String = 'https?\:\/\/(base.garant.ru)\/[0-9]+\/(#(block_)?[0-9]+)$';
 //Номер документа со страницей
 cDocIDWithPageNumberMask: String = 'https?\:\/\/(base.garant.ru)\/[0-9]+\/[0-9]+\/?$';
 //Номер документа со страницей и сабом:
 cDocIDWithPageNumAndSubIDMask: String = 'https?\:\/\/(base.garant.ru)\/[0-9]+\/([0-9]+)(\/)(#(block_)?[0-9]+)$';
 cSharpChar: String = '#';
 cBlockMark: String = '#block_';

 function lp_GetURLKind(const aStr: WideString): TnsLocalDocumentURLKind;
 begin
  if l3CheckStrByPattern(cDocIDWithPageNumAndSubIDMask, l3PCharLen(anURL)) then
   Result := ns_ukFull
  else
  if l3CheckStrByPattern(cDocIDWithSubIDMask, l3PCharLen(anURL)) then
   Result := ns_ukDocIDWithSubID
  else
  if l3CheckStrByPattern(cDocIDWithPageNumberMask, l3PCharLen(anURL)) then
   Result := ns_ukDocIDWithPageNumber
  else
  if l3CheckStrByPattern(cDocIDOnlyMask, l3PCharLen(anURL)) then
   Result := ns_ukDocID
  else
   Result := ns_ukInvalid;
 end;

 function lp_TryParseInt(const aString: String;
  const aAfterSubstrs: array of String; out aVal: Integer): Boolean;
 var
  l_Index: Integer;
  l_SubStrPos: Integer;
  l_SubStrEndPos: Integer;
  l_IntStr: String;
 begin
  Result := False;
  for l_Index := Low(aAfterSubstrs) to High(aAfterSubstrs) do
  begin
   l_SubStrPos := Pos(aAfterSubStrs[l_Index], aString);
   Result := l_SubStrPos <> 0;
   aVal := 0;
   if Result then
   begin
    l_SubStrEndPos := l_SubStrPos + Length(aAfterSubstrs[l_Index]);
    l_IntStr := Copy(aString, l_SubStrEndPos,
     (Length(aString) - l_SubStrEndPos) + 1);
    Result := TryStrToInt(l_IntStr, aVal);
    if Result then
     Break;
   end;
  end;
 end;

 procedure lp_Parse(const aStr: WideString; aNumbers: Tl3LongIntList);
 var
  l_Index: Integer;
  l_LastDigitIndex: Integer;
  l_Number: Integer;
  l_NumberStr: String;
  l_NumberStrLen: Integer;
 begin
  l_LastDigitIndex := 1;
  for l_Index := 1 to Length(aStr) do
  begin
   if (aStr[l_Index] = '/') or (l_Index = Length(aStr)) then
   begin
    l_NumberStrLen := l_Index - l_LastDigitIndex;
    if (l_Index <> Length(aStr)) or (aStr[l_Index] = '/') then
     Dec(l_NumberStrLen);
    l_NumberStr := Copy(aStr, Succ(l_LastDigitIndex), l_NumberStrLen);
    if TryStrToInt(l_NumberStr, l_Number) then
     aNumbers.Add(l_Number)
    else
    if lp_TryParseInt(l_NumberStr, [cSharpChar, cBlockMark], l_Number) then
     aNumbers.Add(l_Number);
    l_LastDigitIndex := l_Index;
   end;
  end;
 end;

const
 cStart = 'base.garant.ru/';
var
 l_Numbers: Tl3LongIntList;
 l_UrlKind: TnsLocalDocumentURLKind;
 l_Url: WideString;
 l_Pos: Integer;
//#UC END# *4BEBC4090016_49EEF16603C9_var*
begin
//#UC START# *4BEBC4090016_49EEF16603C9_impl*
 DocID := 0;
 SubID := 0;
 Result := nsIsLocalDocumentURL(anURL);
 if Result then
 begin
  l_Pos := Pos(cStart, anURL);
  if l_Pos = 0 then
   Result := False
  else
  begin
   l_Url := anURL;
   Delete(l_URL, 0, l_Pos + Length(cStart));
   l_Numbers := Tl3LongIntList.Create;
   try
    lp_Parse(l_Url, l_Numbers);
    l_UrlKind := lp_GetURLKind(anURL);
    Result := l_UrlKind in [ns_ukFull, ns_ukDocIDWithSubID, ns_ukDocIDWithPageNumber, ns_ukDocID];
    case l_UrlKind of
     ns_ukDocIDWithPageNumber:
       DocID := l_Numbers[0];
     ns_ukFull:
      begin
       DocID := l_Numbers[0];
       SubID := l_Numbers[2];
      end;
     ns_ukDocIDWithSubID:
      begin
       DocID := l_Numbers[0];
       SubID := l_Numbers[1];
      end;
     ns_ukDocID:
       DocID := l_Numbers[0];
    end;
   finally
    FreeAndNil(l_Numbers);
   end;
  end;
 end;
//#UC END# *4BEBC4090016_49EEF16603C9_impl*
end;//nsParseLocalDocumentURL

function nsIsContractConstructorURL(const anURL: WideString): Boolean;
//#UC START# *52315BE902FD_49EEF16603C9_var*
const
 cMask = '^(res\:\/\/.+#)*https?\:\/\/([^\\\.]+\.)*service.garant.ru/\constructor($|\_)';
 cTestMask = '^(res\:\/\/.+#)*https?\:\/\/([^\\\.]+\.)*test-service.garant.ru/\constructor($|\_)';
//#UC END# *52315BE902FD_49EEF16603C9_var*
begin
//#UC START# *52315BE902FD_49EEF16603C9_impl*
 Result := l3CheckStrByPattern(cMask, l3PCharLen(anURL)) or
           l3CheckStrByPattern(cTestMask, l3PCharLen(anURL));
//#UC END# *52315BE902FD_49EEF16603C9_impl*
end;//nsIsContractConstructorURL

function nsIsMobileGarantOnlineURL(const anURL: WideString): Boolean;
//#UC START# *523ADD1803CC_49EEF16603C9_var*
const
 cMask = '^(res\:\/\/.+#)*https?\:\/\/([^\\\.]+\.)*i.garant.ru($|\_)';
 cNewInternetMask = '^(res\:\/\/.+#)*https?\:\/\/([^\\\.]+\.)*internet.garant.ru($|\_)';
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=560182136
 cInternalNashMask = '^(res\:\/\/.+#)*https?\:\/\/([^\\\.]+\.)*nash.garant.ru($|\_)';
 cInternalTestIVMask = '^(res\:\/\/.+#)*https?\:\/\/([^\\\.]+\.)*test-iv.garant.ru($|\_)';
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=565253411
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=580688988
//#UC END# *523ADD1803CC_49EEF16603C9_var*
begin
//#UC START# *523ADD1803CC_49EEF16603C9_impl*
 Result := l3CheckStrByPattern(cMask, l3PCharLen(anURL)) OR
  l3CheckStrByPattern(cInternalNashMask, l3PCharLen(anURL)) OR
  l3CheckStrByPattern(cNewInternetMask, l3PCharLen(anURL)) OR
  l3CheckStrByPattern(cInternalTestIVMask, l3PCharLen(anURL));
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=560182136 
//#UC END# *523ADD1803CC_49EEF16603C9_impl*
end;//nsIsMobileGarantOnlineURL

function nsNeedOpenLinkInExternalBrowser(const anURL: WideString): Boolean;
//#UC START# *523FE5580232_49EEF16603C9_var*
//#UC END# *523FE5580232_49EEF16603C9_var*
begin
//#UC START# *523FE5580232_49EEF16603C9_impl*
 Result := not nsNeedOpenLinkInInternalBrowser(anURL);
//#UC END# *523FE5580232_49EEF16603C9_impl*
end;//nsNeedOpenLinkInExternalBrowser

function nsIsObtainRequisitesForMobileAccessURL(const anURL: WideString): Boolean;
//#UC START# *524E5895037F_49EEF16603C9_var*
const
 cMask = '^(res\:\/\/.+#)*https?\:\/\/([^\\\.]+\.)*service.garant.ru/\client($|\_)';
 cTestMask = '^(res\:\/\/.+#)*https?\:\/\/([^\\\.]+\.)*test-service.garant.ru/\client($|\_)';
//#UC END# *524E5895037F_49EEF16603C9_var*
begin
//#UC START# *524E5895037F_49EEF16603C9_impl*
 Result := l3CheckStrByPattern(cMask, l3PCharLen(anURL)) or
           l3CheckStrByPattern(cTestMask, l3PCharLen(anURL));
//#UC END# *524E5895037F_49EEF16603C9_impl*
end;//nsIsObtainRequisitesForMobileAccessURL

function nsIsMunicipalDecisionsArchiveURL(const anURL: WideString): Boolean;
//#UC START# *5524E8BE0065_49EEF16603C9_var*
const
 cMask = '^(res\:\/\/.+#)*https?\:\/\/([^\\\.]+\.)*municipal.garant.ru($|\_)';
 cTestMask = '^(res\:\/\/.+#)*https?\:\/\/([^\\\.]+\.)*test-municipal.garant.ru($|\_)';
//#UC END# *5524E8BE0065_49EEF16603C9_var*
begin
//#UC START# *5524E8BE0065_49EEF16603C9_impl*
 Result := l3CheckStrByPattern(cMask, l3PCharLen(anURL)) or
           l3CheckStrByPattern(cTestMask, l3PCharLen(anURL));;
//#UC END# *5524E8BE0065_49EEF16603C9_impl*
end;//nsIsMunicipalDecisionsArchiveURL

function nsNeedOpenLinkInInternalBrowser(const anURL: WideString): Boolean;
//#UC START# *553A26CA015B_49EEF16603C9_var*
const
 cMask = '^(res\:\/\/.+#)*https?\:\/\/([^\\\.]+\.)*%s($|\_)';
var
 l_Index: Integer;
//#UC END# *553A26CA015B_49EEF16603C9_var*
begin
//#UC START# *553A26CA015B_49EEF16603C9_impl*
 Result := False;
 for l_Index := Low(InternalBrowserURLArr) to High(InternalBrowserURLArr) do
 begin
  Result := l3CheckStrByPattern(Format(cMask, [InternalBrowserURLArr[l_Index]]),
                                l3PCharLen(anURL));
  if Result then
   Break;
 end;
//#UC END# *553A26CA015B_49EEF16603C9_impl*
end;//nsNeedOpenLinkInInternalBrowser

function nsIsMailtoURL(const anURL: WideString): Boolean;
//#UC START# *56F37FFB010E_49EEF16603C9_var*
const
 cMailToMask: String = 'mailto:.*$';
//#UC END# *56F37FFB010E_49EEF16603C9_var*
begin
//#UC START# *56F37FFB010E_49EEF16603C9_impl*
 Result := l3CheckStrByPattern(cMailToMask, l3PCharLen(anURL));
//#UC END# *56F37FFB010E_49EEF16603C9_impl*
end;//nsIsMailtoURL
{$IfEnd} // Defined(Nemesis)

end.
