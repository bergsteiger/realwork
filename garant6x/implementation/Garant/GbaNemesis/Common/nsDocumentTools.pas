unit nsDocumentTools;

// $Id: nsDocumentTools.pas,v 1.25 2015/02/13 05:44:13 morozov Exp $

// $Log: nsDocumentTools.pas,v $
// Revision 1.25  2015/02/13 05:44:13  morozov
// Не собиралось
//
// Revision 1.24  2015/02/12 10:01:12  morozov
// {RequestLink: 588564313}
//
// Revision 1.23  2014/07/30 14:50:05  kostitsin
// {requestlink: 557316458 }
//
// Revision 1.22  2014/01/15 12:57:42  kostitsin
// {requestlink: 451251129}
//
// Revision 1.21  2013/02/27 10:31:48  kostitsin
// [$431385176]
//
// Revision 1.20  2012/08/03 12:54:05  kostitsin
// [$380616604]
//  - nsDocumentTools
//
// Revision 1.19  2012/03/23 17:55:03  lulin
// - выпиливаем настройки.
//
// Revision 1.18  2011/04/07 10:21:40  lulin
// {RequestLink:259894501}.
//
// Revision 1.17  2011/01/27 12:13:32  lulin
// {RequestLink:248195582}.
// - избавляемся от развесистых макарон.
//
// Revision 1.16  2011/01/26 07:31:21  lulin
// [$251342252].
//
// Revision 1.15  2011/01/25 13:51:35  lulin
// {RequestLink:235872416}.
//
// Revision 1.14  2010/10/26 07:36:35  lulin
// {RequestLink:237994338}.
//
// Revision 1.13  2010/10/12 06:18:17  oman
// Не собирались
//
// Revision 1.12  2010/10/11 11:37:47  lulin
// {RequestLink:235871713}.
//
// Revision 1.11  2010/08/19 11:43:01  oman
// - fix: {RequestLink:233015148}
//
// Revision 1.10  2010/03/22 15:44:13  lulin
// {RequestLink:198672893}.
// - упрощаем сигнатуры фабрик.
//
// Revision 1.9  2010/03/02 13:34:26  lulin
// {RequestLink:193823544}.
//
// Revision 1.8  2010/03/01 16:45:43  lulin
// {RequestLink:193823544}.
//
// Revision 1.7  2009/12/09 13:07:15  lulin
// {RequestLink:124453871}.
//
// Revision 1.6  2009/12/09 09:23:02  lulin
// - убиваем неиспользуемый класс.
//
// Revision 1.5  2009/11/27 11:56:36  oman
// - new: Печать {RequestLink:121157219}
//
// Revision 1.4  2009/10/21 17:39:05  lulin
// - раскладываем модули по правильным местам.
//
// Revision 1.1  2009/10/21 16:25:53  lulin
// - переносим на модель ноды оболочки.
//
// Revision 1.2  2009/09/29 13:44:13  lulin
// {RequestLink:159360578}. №34.
//
// Revision 1.1  2009/09/28 10:33:13  lulin
// - переносим примесь для обработки переключения закладок в более правильное место.
//
// Revision 1.1  2009/09/14 11:28:32  lulin
// - выводим пути и для незавершённых модулей.
//
// Revision 1.54  2009/08/04 11:25:31  lulin
// [$159351827].
//
// Revision 1.53  2009/07/31 17:29:52  lulin
// - убираем мусор.
//
// Revision 1.52  2009/04/15 18:49:38  lulin
// [$143396720]. Основательно перетрясаем модель.
//
// Revision 1.51  2009/02/20 11:31:54  oman
// - fix: Потеряли функциональность (К-137462678)
//
// Revision 1.50  2009/02/20 10:08:28  lulin
// - чистка комментариев.
//
// Revision 1.49  2009/02/10 19:03:13  lulin
// - <K>: 133891247. Вычищаем морально устаревший модуль.
//
// Revision 1.48  2009/02/10 09:49:56  lulin
// - <K>: 133891247. Выделяем интерфейсы логирования.
//
// Revision 1.47  2009/01/28 15:47:09  lulin
// - <K>: 133138664.
//
// Revision 1.46  2008/12/26 14:00:22  oman
// - fix: подключаем MacroReplacer (К-122675365)
//
// Revision 1.45  2008/12/22 15:05:11  oman
// - new: В кэше превью различаем из какой зоны было оно вызвано (К-122675365)
//
// Revision 1.44  2008/10/21 08:25:11  oman
// - fix: Событие печати логируем в правильном месте (К-121155694)
//
// Revision 1.43  2008/09/26 10:43:42  oman
// - fix: Обрезаем имя при DnD (К-109904958)
//
// Revision 1.42  2008/08/14 10:41:46  oman
// - fix: Обрываем технические комментарии в списке (K-108627048)
//
// Revision 1.41  2008/08/14 09:36:50  oman
// - fix: Обрываем технические комментарии в списке (K-108627048)
//
// Revision 1.40  2008/07/16 11:56:41  lulin
// - <K>: 102041902.
//
// Revision 1.39  2008/07/11 11:17:41  lulin
// - bug fix: не собиралась оболочка.
//
// Revision 1.38  2008/01/10 07:23:10  oman
// Переход на новый адаптер
//
// Revision 1.37.4.1  2007/11/20 11:39:01  oman
// Перепиливаем на новый адаптер
//
// Revision 1.37  2007/09/28 07:03:05  mmorozov
// - небольшой рефакторинг _StdRes и _nsSaveDialog;
// - разделяем получение имени файла для диалогов сохранения и временных файлов + сопутствующий рефакторинг (в рамках работы над CQ: OIT5-26809);
//
// Revision 1.36  2007/08/14 19:31:39  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.35  2007/03/16 09:56:35  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.34  2007/03/15 15:19:04  lulin
// - заменяем на свою функцию форматирования строки.
//
// Revision 1.33  2007/02/13 14:33:08  lulin
// - cleanup.
//
// Revision 1.32  2007/02/12 09:58:39  lulin
// - bug fix: искажались входные строковые параметры адаптера.
//
// Revision 1.31  2007/02/09 15:38:13  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.30  2007/02/09 14:51:16  lulin
// - переводим на строки с кодировкой.
//
// Revision 1.29  2007/01/24 10:22:41  oman
// - new: Локализация библиотек - ev (cq24078)
//
// Revision 1.28  2007/01/05 15:23:14  lulin
// - cleanup.
//
// Revision 1.27  2007/01/05 14:59:43  lulin
// - cleanup.
//
// Revision 1.26  2006/07/10 11:55:05  oman
// - new beh: Операции над фрагментами в структуре документа (cq21631).
// - fix: При экспорте фрагмента добавляем суффикс "(фрагмент)"
//
// Revision 1.25  2006/06/08 14:46:04  oman
// - fix: Не передавали в HAFPainter полное имя документа (cq18993)
//
// Revision 1.24  2006/06/07 10:32:21  mmorozov
// - bugfix: при повторном экспорте списка в Word имели системную ошибку, пытались писать в файл, который держал Word. Кроме того при экспорте создавалось два файла, первый пустой без расширения,  второй с расшением с экпортированной информацией (CQ: OIT500021216);
//
// Revision 1.23  2006/04/20 14:25:31  mmorozov
// - new behaviour: отрезаем многоточие при сохрании файла;
//
// Revision 1.22  2006/04/19 13:34:29  oman
// - new beh: перекладываем StdStr в _StdRes
//
// Revision 1.21  2006/03/21 15:03:58  oman
// - new beh: Перекладываем все текстовые константы в три места (StdStr, DebugStr и SystemStr)
//
// Revision 1.20  2005/12/01 06:19:59  lulin
// - реализация preview перенесена в более общую библиотеку.
//
// Revision 1.19  2005/12/01 06:10:34  lulin
// - интерфейс preview перенесен в более общую библиотеку.
//
// Revision 1.18  2005/11/29 07:18:30  mmorozov
// - bugfix: структура TRedactionInfo инициализируется перед использованием;
//
// Revision 1.17  2005/11/28 18:45:05  lulin
// - bug fix: не обновлялось preview после смены размера шрифта.
//
// Revision 1.16  2005/10/19 14:37:15  mmorozov
// cleanup: вычищены не используемые адаптером типы/интерфейсы;
//
// Revision 1.15  2005/10/10 11:43:14  lulin
// - cleanup: используем интерфейсы из правильной библиотеки.
//
// Revision 1.14  2005/09/16 12:01:46  demon
// - new behavior: получение извлечений по новому (пока не работает позиционирование)
//
// Revision 1.13  2005/09/16 10:35:51  ses
// - fix: что бы компилировалось
//
// Revision 1.12  2005/08/29 16:09:10  demon
// - new behavior: Операция Open на ноде теперь возвращает IUnknown
//
// Revision 1.11  2005/08/26 09:52:20  mmorozov
// change: TnsLanguage стал TbsLanguage и переехал в bsTypes;
//
// Revision 1.10  2005/08/22 15:36:43  mmorozov
// - add unit bsTypes;
//
// Revision 1.9  2005/06/30 07:48:05  cyberz
// READY FOR TIE-TEMPLATE GENERATION
//
// Revision 1.8  2005/05/25 14:01:23  demon
// - fix: неверно корректировалось имя для сохраняемого документа
//
// Revision 1.7  2005/03/21 14:03:22  am
// change: добавил параметр в GetSingleDocumentFromList (всегда выполнять автопереход)
//
// Revision 1.6  2005/03/14 14:53:26  lulin
// - new unit: nsDocumentPreview.
//
// Revision 1.5  2005/03/06 14:23:27  am
// change: при экспорте файла проверяем предлагаемое пользователю для сохранения имя на валидность символов
//
// Revision 1.4  2004/12/16 13:48:37  lulin
// - Print-preview списка полностью переведен на новый механизм.
//
// Revision 1.3  2004/11/22 12:34:09  demon
// - new behavior: _CreateBookmark, можно создавать закладку с именем, без учета параграфа
//
// Revision 1.2  2004/10/29 15:22:34  am
// change: убрал старую логику с сравнением имён в GetSingleDocumentFromList
//
// Revision 1.1  2004/10/14 13:39:11  demon
// - new _module: вынесены общедоступные функции работы с документом и его ипостасями.
//

interface

uses
  ActiveX,

  l3Interfaces,
  
  afwInterfaces,

  evInternalInterfaces,

  eeBaseInterfaces,

  bsTypes,

  DocumentUnit,

  nsTypes,
  nsUtils
  {$If not (defined(Monitorings) or defined(Admin))}
  ,
  nsExternalObject,
  nsExternalObjectPrim
  {$IfEnd}
  ;

{$If not (defined(Monitorings) or defined(Admin))}
function CreateFileName(const aDocument: IDocument; aHasSelection: Boolean = false): Il3CString; overload;
  {-}
function CreateFileName(const aDocumentName: Il3CString; aHasSelection: Boolean = false): Il3CString; overload;
  {-}
{$IfEnd}
function CreateBookmark(const aDocument: IDocument;
                        const aPara: TParaId;
                        aIsPara: Bytebool;
                        out aBookmark: IBookmark;
                        aNameWithoutPara: Boolean = false): Boolean;
  {-}
function CreateNamedBookmark(const aDocument: IDocument;
                             const aPara: TParaId;
                             aIsPara: Bytebool;
                             out aBookmark: IBookmark;
                             const aName: Il3CString): Boolean;
  {-}
{$If not defined(Admin) AND not defined(Monitorings)}
function DocumentSaveAs(const aDocument : IDocument;
                        var aName       : Il3CString;
                        HideTechComments: Boolean;
                        const aFormat   : TnsFileFormat = ns_ffRTF): Boolean;
  {-}
{$IfEnd not defined(Admin) AND not defined(Monitorings)}
function nsChangeDocumentState(const aDocument    : IDocument;
                               aLanguage          : TbsLanguage): IDocument;
  {-}
function nsGetDocumentName(const aDocument : IDocument) : Il3CString;
  {-}
function nsGetDocumentShortName(const aDocument : IDocument) : Il3CString;
  {-}
function nsGetDocumentWarning(const aDocument : IDocument) : Il3CString;
  {-}
function nsGetBookmarkName(const aBookmark : IBookmark) : Il3CString;
  {-}
function nsGetBookmarkComment(const aBookmark : IBookmark) : Il3CString;
  {-}
{$If not (defined(Monitorings) or defined(Admin))}
function nsGetDocumentPreview(const aDocument: IDocument; HideTechComments: Boolean; ForLog: Boolean = False): IafwComplexDocumentPreview;
  {-}
function nsGetRelatedDocPreview(const aDocument: IDocument;
                                HideTechComments: Boolean;
                                ForLog: Boolean = False;
                                ShowBlockNames: Boolean = True): IafwDocumentPreview;
  {-}
{$IfEnd}  

implementation

uses
  Classes,
  SysUtils,

  l3Base,
  l3Stream,
  l3Chars,
  l3String,

  evdStyles,

  evDocumentPreview,
  nevBase,
  nevTools,
  nevInterfaces,
  afwComplexDocumentPreview,

  vcmBase,

  evFormatHAFMacroReplacer,

  nsConst,
  nsSettings,
  nsNodes,
  nsHAFPainter,
  nsDocumentPreview,
  nsExternalObjectModelPart,
{$If not defined(Admin) AND not defined(Monitorings)}
  nsIDocumentDataObject,
{$IfEnd}
  nsDocInfoHAFMacroReplacer,
{$If not defined(Admin) AND not defined(Monitorings)}
  nsChildDocInfoHAFMacroReplacer,
  nsDocumentPrintEvent,
  nsDocumentPreviewWithoutBlockNames,
{$IfEnd}
  nsValueMaps,

  IOUnit,

  DataAdapter,

  StdRes,

  LoggingInterfaces
  {$If not (defined(Monitorings) or defined(Admin))}
  ,
  deDocInfo,
  bsTypesNew,
  nsDocumentToolsNew
  {$IfEnd}
  ;

function nsGetDocumentName(const aDocument: IDocument): Il3CString;
var
 l_String: IString;
begin
 if Assigned(aDocument) then
  aDocument.GetName(l_String)
 else
  l_String := nil;
 Result := nsCStr(l_String);
end;

function nsGetDocumentShortName(const aDocument: IDocument): Il3CString;
var
 l_String: IString;
begin
 if Assigned(aDocument) then
  aDocument.GetShortName(l_String)
 else
  l_String := nil;
 Result := nsCStr(l_String);
end;

function nsGetDocumentWarning(const aDocument: IDocument): Il3CString;
var
 l_String: IString;
begin
 if Assigned(aDocument) then
  aDocument.GetWarning(l_String)
 else
  l_String := nil;
 Result := nsCStr(l_String);
end;

function nsGetBookmarkName(const aBookmark : IBookmark) : Il3CString;
var
 l_String : IString;
begin
 if Assigned(aBookmark) then
  aBookmark.GetName(l_String)
 else
  l_String := nil;
 Result := nsCStr(l_String);
end;

function nsGetBookmarkComment(const aBookmark : IBookmark) : Il3CString;
var
 l_String : IString;
begin
 if Assigned(aBookmark) then
  aBookmark.GetComment(l_String)
 else
  l_String := nil;
 Result := nsCStr(l_String);
end;

{$If not (defined(Monitorings) or defined(Admin))}
function CreateFileName(const aDocument: IDocument; aHasSelection: Boolean = false): Il3CString;
begin
 Result := nil;
 if (aDocument <> nil) then
 try
  Result := nsGetDocumentShortName(aDocument);
  Result := CreateFileName(Result, aHasSelection);
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;//try..except
end;//CreateFileName

function CreateFileName(const aDocumentName: Il3CString; aHasSelection: Boolean = false): Il3CString; overload;
begin
 Result := aDocumentName;
 if aHasSelection then
  Result := vcmFmt(str_nevmmFragment, [Result]);
 Result := nsPrepareFileName(Result);
end;
{$IfEnd}

function CreateBookmark(const aDocument: IDocument;
                        const aPara: TParaId;
                        aIsPara: Bytebool;
                        out aBookmark: IBookmark;
                        aNameWithoutPara: Boolean): Boolean;
begin
 Result := False;
 aBookmark := nil;
 if not Assigned(aDocument) then
  Exit;
 try
  aDocument.CreateBookmark(aPara, aIsPara, aBookmark);
 except
  on E: Exception do
  begin
   l3System.Exception2Log(E);
   Exit;
  end;
 end;
 if Assigned(aBookmark) then
  try
   if aNameWithoutPara then
    aBookmark.SetName(nsIStr(nsGetDocumentShortName(aDocument)))
   else
    aBookmark.SetName(nsIStr(vcmFmt(str_BookmarkNamePattern,[nsGetDocumentShortName(aDocument),
                                                         aBookmark.GetParagraph])));
   aBookmark.SetComment(nsIStr(vcmFmt(str_BookmarkCommentPattern, [nsGetDocumentName(aDocument)])));
  except
   on E: Exception do
   begin
    l3System.Exception2Log(E);
    aBookmark := nil;
   end;
  end;//try..except
 if Assigned(aBookmark) then
   Result := True;
end;

function CreateNamedBookmark(const aDocument: IDocument;
                             const aPara: TParaId;
                             aIsPara: Bytebool;
                             out aBookmark: IBookmark;
                             const aName: Il3CString): Boolean;
  {-}
begin
 Result := False;
 aBookmark := nil;
 if not Assigned(aDocument) then
  Exit;
 try
  aDocument.CreateBookmark(aPara, aIsPara, aBookmark);
 except
  on E: Exception do
  begin
   l3System.Exception2Log(E);
   Exit;
  end;
 end;
 if Assigned(aBookmark) then
  try
   aBookmark.SetName(nsIStr(aName));
   aBookmark.SetComment(nsIStr(vcmFmt(str_BookmarkCommentPattern, [nsGetDocumentName(aDocument)])));
  except
   on E: Exception do
   begin
    l3System.Exception2Log(E);
    aBookmark := nil;
   end;
  end;//try..except
 if Assigned(aBookmark) then
   Result := True;
end;

{$If not defined(Admin) AND not defined(Monitorings)}
function DocumentSaveAs(const aDocument : IDocument;
                        var aName       : Il3CString;
                        HideTechComments: Boolean;
                        const aFormat   : TnsFileFormat): Boolean;
var
 l_SourceStream: InevObjectHolder;
 l_Output: TnsGetGenOutputStruct;
begin
 Result := False;
 if Assigned(aDocument) then
  try
   nsGetText(aDocument, l_SourceStream);
   l_Output := TnsGetGenOutputStruct_Create(aName);
   Result := nsEvdStreamSaveAs(l_SourceStream, l_Output, aFormat, HideTechComments);
  except
   on E: Exception do
    l3System.Exception2Log(E);
  end;//try..except
end;
{$IfEnd not defined(Admin) AND not defined(Monitorings)}

function nsChangeDocumentState(const aDocument : IDocument;
                               aLanguage       : TbsLanguage): IDocument;
var
 l_State: IDocumentState;
begin
 Result := nil;
 if (aDocument <> nil) then
 begin
  aDocument.GetCurrentState(l_State);
  l_State.SetLanguage(aLanguage);
  aDocument.CreateView(l_State, Result);
  if (Result = nil) then // документ не поменялся
   Result := aDocument;
 end;//aDocument <> nil
end;

{$If not (defined(Monitorings) or defined(Admin))}
function nsGetDocumentPreview(const aDocument: IDocument; HideTechComments: Boolean; ForLog: Boolean = False): IafwComplexDocumentPreview;
  {-}
var
 l_Info     : IafwDocumentPreview;
 l_Preview  : IafwDocumentPreview;
 l_Name     : Il3CString;
 l_FullName : Il3CString;
 l_Event: InsEventHolder;
 l_HAF: IafwHAFMacroReplacer;
 l_Key: TevPreviewCacheKey;
begin
 l_Key := evDefaultPreviewCacheKey;
 if HideTechComments then
  l_Key.HiddenStyles := [-ev_saTechComment];
 Result := nil;
 if (aDocument <> nil) then
 begin
  l_HAF := TnsDocInfoHAFMacroReplacer.Make(nil, TdeDocInfo.Make(aDocument));
  l_Name := nsGetDocumentShortName(aDocument);
  l_FullName := nsGetDocumentName(aDocument);
  l_Info := nsGetRelatedDocPreview(aDocument, HideTechComments, ForLog);
  l_Preview := TnsDocumentPreview.Make(TnsIDocumentDataObject.Make(aDocument), l_Key,
                 TnsHAFPainter.Make(l_HAF));
  if ForLog and Supports(Result, InsEventHolder, l_Event) then
   l_Event.SetEvent(TnsDocumentPrintEvent.Make(aDocument, False));
  Result := TafwComplexDocumentPreview.Make(
               l_Preview,
               l_Info);
 end;//aDocument <> nil
end;

function nsGetRelatedDocPreview(const aDocument: IDocument;
                                HideTechComments: Boolean;
                                ForLog: Boolean = False;
                                ShowBlockNames: Boolean = True): IafwDocumentPreview;
var
 l_Rel      : IDocument;
 l_HAF: IafwHAFMacroReplacer;
 l_Key: TevPreviewCacheKey;
 l_DataObject: InevStorable;
 l_HAFPainter: IafwHAFPainter;
begin
 l_Key := evDefaultPreviewCacheKey;
 Result := nil;
 if (aDocument <> nil) then
 begin
  if aDocument.HasRelatedDoc then
  begin
   aDocument.GetRelatedDoc(l_Rel);
   try
    l_HAF := TnsChildDocInfoHAFMacroReplacer.Make(TnsDocInfoHAFMacroReplacer.Make(nil,
     TdeDocInfo.Make(aDocument)), TdeDocInfo.Make(aDocument));
    l_HAFPainter := TnsHAFPainter.Make(TevFormatHAFMacroReplacer.Make(l_HAF,
                  str_nevmmReference.AsCStr)); 
    l_DataObject := TnsIDocumentDataObject.Make(l_Rel);
    if ShowBlockNames then
     Result := TnsDocumentPreview.Make(l_DataObject, l_Key, l_HAFPainter)
    else
     Result := TnsDocumentPreviewWithoutBlockNames.Make(l_DataObject, l_Key, l_HAFPainter);
   finally
    l_Rel := nil;
   end;//try..finally
  end//aDocument.HasRelatedDoc
  else
   Result := nil;
 end;//aDocument <> nil
end;

{$IfEnd}

end.
