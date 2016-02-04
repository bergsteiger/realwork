unit nsInternetUtils;
 {* Вспомогательные функции для Интернет-агента }

// Модуль: "w:\common\components\gui\Garant\Nemesis\nsInternetUtils.pas"
// Стереотип: "UtilityPack"

{$Include nscDefine.inc}

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

function IsGarantURL(const anURL: WideString): Boolean;
 {* Определяет, что адрес в домене Гаранта }
function IsLocalDocumentURL(const anURL: WideString): Boolean;
 {* Определяет, что ссылка на внутренний документ }
function ParseLocalDocumentURL(const anURL: WideString;
 out DocID: Integer;
 out SubID: Integer): Boolean;
 {* Разобрать локальную ссылку на документ }
function IsContractConstructorURL(const anURL: WideString): Boolean;
function IsMobileGarantOnlineURL(const anURL: WideString): Boolean;
function NeedOpenLinkInExternalBrowser(const anURL: WideString): Boolean;
function IsObtainRequisitesForMobileAccessURL(const anURL: WideString): Boolean;
function IsMunicipalDecisionsArchiveURL(const anURL: WideString): Boolean;
function NeedOpenLinkInInternalBrowser(const anURL: WideString): Boolean;
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
;

function IsGarantURL(const anURL: WideString): Boolean;
 {* Определяет, что адрес в домене Гаранта }
//#UC START# *49EEF1BA019B_49EEF16603C9_var*
const
 cMask = '^(res\:\/\/.+#)*https?\:\/\/([^\\\.]+\.)*garant.ru($|\_)';
//#UC END# *49EEF1BA019B_49EEF16603C9_var*
begin
//#UC START# *49EEF1BA019B_49EEF16603C9_impl*
 Result := l3Starts('about:', l3PCharLen(anURL), true) or l3CheckStrByPattern(cMask, l3PCharLen(anURL));
//#UC END# *49EEF1BA019B_49EEF16603C9_impl*
end;//IsGarantURL

function IsLocalDocumentURL(const anURL: WideString): Boolean;
 {* Определяет, что ссылка на внутренний документ }
//#UC START# *4BEBC370007F_49EEF16603C9_var*
const
 cMask = '^(res\:\/\/.+#)*https?\:\/\/([^\\\.]+\.)*base.garant.ru($|\_)';
//#UC END# *4BEBC370007F_49EEF16603C9_var*
begin
//#UC START# *4BEBC370007F_49EEF16603C9_impl*
 Result := l3CheckStrByPattern(cMask, l3PCharLen(anURL));
//#UC END# *4BEBC370007F_49EEF16603C9_impl*
end;//IsLocalDocumentURL

function ParseLocalDocumentURL(const anURL: WideString;
 out DocID: Integer;
 out SubID: Integer): Boolean;
 {* Разобрать локальную ссылку на документ }
//#UC START# *4BEBC4090016_49EEF16603C9_var*
var
 l_Pos: Integer;
 l_URL: Il3CString;
 l_InitedDoc: Boolean;

 function lp_Iterate(const aStr : Tl3PCharLen; IsLast: Bool): Bool;
 var
  l_ID: Integer;
  l_Str: String;
 begin
  Result := True;
  l_Str := l3Str(aStr);
  if not l_InitedDoc then
   if TryStrToInt(l_Str, l_ID) then
   begin
    DocID := l_ID;
    l_InitedDoc := True;
   end;
  if (Length(l_Str) > 1) and (l_Str[1] = '#') then
   if TryStrToInt(Copy(l_Str, 2, Length(l_Str) - 1), l_ID) then
    SubID := l_ID;
 end;

const
 cStart = 'base.garant.ru/';
//#UC END# *4BEBC4090016_49EEF16603C9_var*
begin
//#UC START# *4BEBC4090016_49EEF16603C9_impl*
 Result := nsIsLocalDocumentURL(anURL);
 if Result then
 begin
  l_URL := l3CStr(anURL);
  l_Pos := l3Pos(l_URL, cStart);
  if l_Pos = l3NotFound then
   Result := False
  else
  begin
   l3Delete(l_URL, 0, l_Pos + Length(cStart));
   l_InitedDoc := False;
   DocID := 0;
   SubID := 0;
   l3ParseWordsExF(l_URL.AsWStr, l3L2WA(@lp_Iterate),['/']);
   Result := l_InitedDoc;
  end;
 end;
//#UC END# *4BEBC4090016_49EEF16603C9_impl*
end;//ParseLocalDocumentURL

function IsContractConstructorURL(const anURL: WideString): Boolean;
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
end;//IsContractConstructorURL

function IsMobileGarantOnlineURL(const anURL: WideString): Boolean;
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
end;//IsMobileGarantOnlineURL

function NeedOpenLinkInExternalBrowser(const anURL: WideString): Boolean;
//#UC START# *523FE5580232_49EEF16603C9_var*
//#UC END# *523FE5580232_49EEF16603C9_var*
begin
//#UC START# *523FE5580232_49EEF16603C9_impl*
 Result := not nsNeedOpenLinkInInternalBrowser(anURL);
//#UC END# *523FE5580232_49EEF16603C9_impl*
end;//NeedOpenLinkInExternalBrowser

function IsObtainRequisitesForMobileAccessURL(const anURL: WideString): Boolean;
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
end;//IsObtainRequisitesForMobileAccessURL

function IsMunicipalDecisionsArchiveURL(const anURL: WideString): Boolean;
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
end;//IsMunicipalDecisionsArchiveURL

function NeedOpenLinkInInternalBrowser(const anURL: WideString): Boolean;
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
end;//NeedOpenLinkInInternalBrowser
{$IfEnd} // Defined(Nemesis)

end.
