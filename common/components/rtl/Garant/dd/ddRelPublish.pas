unit ddRelPublish;

{ $Id: ddRelPublish.pas,v 1.30 2015/11/26 08:45:43 lukyanets Exp $ }

// $Log: ddRelPublish.pas,v $
// Revision 1.30  2015/11/26 08:45:43  lukyanets
// КОнстанты переехали
//
// Revision 1.29  2015/07/02 07:36:05  lukyanets
// Описываем словари
//
// Revision 1.28  2014/08/26 11:56:14  lukyanets
// Учимся прерывать
//
// Revision 1.27  2014/08/08 10:02:01  lukyanets
// {Requestlink:560730919}. Завели alcuAACImport
//
// Revision 1.26  2014/08/08 06:39:59  lukyanets
// {Requestlink:556143119}. Отцепили alcuRelPublishTask
//
// Revision 1.25  2014/04/17 13:04:46  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.24  2013/12/02 09:27:43  fireton
// - логируем автопополнение справок
//
// Revision 1.23  2013/11/27 09:29:28  fireton
// - логируем автопополнение справок
//
// Revision 1.22  2013/10/28 14:35:24  dinishev
// Для работы тестов.
//
// Revision 1.21  2013/10/28 13:32:20  dinishev
// Лишний модуль.
//
// Revision 1.20  2013/04/26 14:36:29  voba
// - k:434744483
//
// Revision 1.19  2013/04/25 13:49:32  voba
// -bug fix Поток не открыли
//
// Revision 1.18  2013/04/15 05:59:22  narry
// Не собиралось
//
// Revision 1.17  2013/04/11 16:46:28  lulin
// - отлаживаем под XE3.
//
// Revision 1.16  2013/04/09 12:30:20  narry
// Не компилировалось
//
// Revision 1.15  2012/07/02 08:07:17  narry
// Меньше мусора в лог
//
// Revision 1.14  2012/06/21 11:05:17  narry
// Запись в список документов без справки и документов без публикации
//
// Revision 1.13  2012/06/04 13:07:15  narry
// Обновление
//
// Revision 1.12  2012/05/30 09:32:04  narry
// Не распознавался номер статьи
//
// Revision 1.11  2012/05/30 09:05:07  fireton
// - номера статей (К 367210765)
//
// Revision 1.10  2012/05/28 10:28:38  narry
// Не добавлялась в журнал информация об изменении
//
// Revision 1.9  2012/05/28 09:51:09  narry
// Возвращался мусор, если не обрабатывался файл
//
// Revision 1.8  2012/05/24 12:48:19  narry
// Интервал повторяемости в минутах (365825882)
//
// Revision 1.7  2012/05/23 07:52:48  narry
// Сохранять список заблокированных справок (365825718)
//
// Revision 1.6  2012/05/23 07:21:01  narry
// Дополнение к задаче по заливке публикаций (363583844)
//
// Revision 1.5  2012/05/17 10:34:47  narry
// Ссылки внутри добавляемой информации (363574319)
//
// Revision 1.4  2012/05/14 11:25:42  narry
// Повторное добавление информации (363574314)
//
// Revision 1.3  2012/05/14 09:29:29  narry
// Автодополнение справок (269063217)
//
// Revision 1.2  2011/09/09 13:29:48  fireton
// - в исходном файле не номера справок, а номера документов (K278835928)
//
// Revision 1.1  2011/06/23 08:02:32  fireton
// - правим справки на предмет источников опубликования
//

interface

{$I ddDefine.inc}

uses
 Classes,
 ddProgressObj, ddRelPublishFilter,
 ddDocTextFilterer,
 l3Interfaces,
 l3LongintList, l3ProtoObject, DT_Types, l3Filer, l3Base, dtIntf, dt_Sab, l3Parser;


type
 TddRelPublishCorrector = class(Tl3ProtoObject)
 private
 private
  f_ExtDocID: Integer;
  f_Filer: Tl3DOSFiler;
  f_Filterer: TddDocumentTextFilterer;
  f_Filter : TddRelPublishFilter;
  f_Locked: Tl3LongintList;
  f_IntRelID: Integer;
  f_Line: Tl3WString;
  f_LockHandle: TJLHandle;
  f_Missed: Integer;
  f_MissedList: TStrings;
  f_RDCursor: ISabCursor;
  f_RDIDList: Tl3LongintList;
  f_RestrictedDocs: ISab;
  f_Text: Tl3String;
  f_Aborted: Boolean;
  procedure CreateRestrictedDocs(const aRegionID: Tl3LongintList);
  procedure DestroyRestrictedDocs;
  procedure DocError(const aDocID: TDocID; const aMsg: AnsiString);
  procedure Lock(aRelID, aDocID: TDocID);
  function lp_ReadNextLine: Boolean;
  procedure ParseFile(out theTotal, theWorked: Integer);
  function ParseTopicAndArticle(aLine: Tl3WString; out theTopic, theArticle: Integer): Boolean;
  function ReadOnlyAccGroup(aDocID: TDocID): Boolean;
  procedure SaveLocked;
  procedure UnLock;
  function ValidFile(const aFileName: AnsiString): Boolean;
 public
  procedure AbortProcess;
  procedure Execute(const aFileName: AnsiString; out theTotal, theWorked, theMissed: Integer;
      aMissedList: TStrings; theLocked: Tl3LongintList; const aRegionID: Tl3LongintList; aProgressor: TddProgressObject);
 end;

implementation
uses
 SysUtils,

 l3String,
 l3Chars,

 daTypes,
 daSchemeConsts,
 
 DT_Const,
 DT_LinkServ,
 DT_Doc,
 dt_Query,
 Dt_Lock, DT_err, l3Types, Math, ddAppConfig, dt_AttrSchema, l3Stream, l3FileUtils, l3IniFile,
 DT_Serv, l3LongintListPrim;

procedure TddRelPublishCorrector.AbortProcess;
begin
  f_Aborted := True;
end;

procedure TddRelPublishCorrector.CreateRestrictedDocs(const aRegionID: Tl3LongintList);
var
 l_List: Tl3LongintList;
 l_Q   : TdtQuery;
begin
  l_List := Tl3LongintList.Make;
  try
   // переданные на обработку в регионы  [MagicNumbers].RegionID

   if Assigned(aRegionID) then
     l_List.Assign(aRegionID);
   l_Q := TdtDictQuery.Create(da_dlAccGroups, l_List);
   try
    f_RestrictedDocs:= l_Q.GetDocIdList;
    f_RDIDList:= dtMakeSortedIDListBySab(f_RestrictedDocs);
    l3System.Msg2Log('Найдено %d "региональных" документов', [f_RestrictedDocs.Count]);
    //f_RestrictedDocs.ValuesOfKey(fid_fld);
    //f_RestrictedDocs.Sort;
    //f_RestrictedDocs.RecordsByKey;
    f_RDCursor:= f_RestrictedDocs.MakeSabCursor([fid_fld]);
   finally
    FreeAndNil(l_Q);
   end;
  finally
   l3Free(l_List);
  end;
end;

procedure TddRelPublishCorrector.DestroyRestrictedDocs;
begin
 f_RDCursor:= nil;
 f_RestrictedDocs:= nil;
 FreeAndNil(f_RDIDList);
end;

procedure TddRelPublishCorrector.DocError(const aDocID: TDocID; const aMsg: AnsiString);
begin
 Inc(f_Missed);
 f_MissedList.Add(Format('%d: %s', [aDocID, aMsg]));
end;

procedure TddRelPublishCorrector.Execute(const aFileName: AnsiString; out theTotal, theWorked,
    theMissed: Integer; aMissedList: TStrings; theLocked: Tl3LongintList; const aRegionID: Tl3LongintList;
    aProgressor: TddProgressObject);
var
 l_Ini : TCfgList;
begin
 if ValidFile(aFileName) then
 begin
  f_MissedList:= aMissedList;
  f_MissedList.Clear;
  f_Locked:= theLocked;
  f_Locked.Clear;
  f_Missed := 0;
  {$IFNDEF InsiderTest}
  CreateRestrictedDocs(aRegionID);
  {$ENDIF InsiderTest}
  try
   f_Filer := Tl3DOSFiler.Make(aFileName);
   try
    if aProgressor <> nil then
    begin
     f_Filer.Indicator.NeedProgressProc:= True;
     f_Filer.Indicator.OnProgressProc:= aProgressor.ProcessUpdate;
    end; // aProgressor <> nil
    f_Filer.CodePage:= cp_OEM;
    {$IFDEF LogRelPublish}
    l3System.Msg2Log('* открываем файл');
    {$ENDIF}
    f_Filer.Open;
    f_Filter := TddRelPublishFilter.Create;
    try
     f_Filterer := TddDocumentTextFilterer.Create;
     try
      f_Filterer.Filter := f_Filter;
      {$IFDEF LogRelPublish}
      l3System.Msg2Log('* начало парсинга файла');
      {$ENDIF}
      ParseFile(theTotal, theWorked);
      if f_Aborted then
       Exit;
      {$IFNDEF InsiderTest}
      SaveLocked;
      {$ENDIF InsiderTest}
      theMissed:= f_Missed;
     finally
      FreeAndNil(f_Filterer);
     end;
    finally
     FreeAndNil(f_Filter);
    end;
   finally
    FreeAndNil(f_Filer);
   end;
  finally
   DestroyRestrictedDocs;
  end;
  {$IFNDEF InsiderTest}
  l_Ini := TCfgList.Create(ConcatDirName(GlobalHtServer.Family[CurrentFamily].Path, 'base.ini'));
  try
   l_Ini.Section := 'Autosp.cfg';
   l_Ini.WriteParamDateTime('FileDate', FileDateTime(aFileName));
   l_Ini.WriteParamInt('FileSize', GetFileSize(aFileName));
  finally
   FreeAndNil(l_Ini);
  end;
  {$ENDIF InsiderTest}
 end
 else
 begin
  {$IFDEF LogRelPublish}
  l3System.Msg2Log('* Файл невалиден (не проходит проверку по base.ini)');
  {$ENDIF}
  theTotal:= 0;
  theWorked:= 0;
  theMissed:= 0;
 end;
end;

procedure TddRelPublishCorrector.Lock(aRelID, aDocID: TDocID);
begin
 try
  f_LockHandle := LockServer.FullLockDoc(CurrentFamily, aDocID);
  if f_LockHandle = -1 then
  begin
   DocError(f_ExtDocID, 'справка занята пользователем');
   f_Locked.Add(f_ExtDocID);
  end;
 except
  on E: Exception do
   if E is EHtErrors then
   begin
    case (E as EHtErrors).ErrorValue of
     ecAccessDenied: DocError(f_ExtDocID, 'доступ запрещен');
    else
     DocError(f_ExtDocID, 'не удалось захватить справку');
    end;
   end
   else
   begin
    l3System.Msg2log('ошибка захвата справки ' + E.Message);
    raise;
   end;
 end; // try-except
end;

function TddRelPublishCorrector.lp_ReadNextLine: Boolean;
begin
 l3AssignNil(f_Line);
 if not f_Filer.EOF then
  repeat
   f_Text.Clear;
   f_Text.CodePage:= cp_ansi;
   f_Text.Append(f_Filer.Readln);
   f_Text.Trim;
   f_Line := f_Text.AsWStr;
  until (not l3IsNil(f_Line)) or f_Filer.EOF;
 Result := not l3IsNil(f_Line);
end;

procedure TddRelPublishCorrector.ParseFile(out theTotal, theWorked: Integer);
var
 l_ArticleNo: Integer;
 l_Pos: Integer;
 l_IntDocID: TDocID;
 l_Tmp: Boolean;
 l_IsRel: Boolean;
begin
 f_Text:= Tl3String.Create;
 try
  theTotal:= 0;
  theWorked:= 0;
  while True do
  begin
   if f_Aborted then
    Exit;
   if not lp_ReadNextLine then
    Break;
   if not l3Same(f_Line, l3PCharLen('[text]'), True) then
    Continue;
   if not lp_ReadNextLine then
    Break;
   f_Filter.PubText := l3CStr(f_Line);
   {$IFDEF LogRelPublish}
   l3System.Msg2Log('* строка: "%s"', [l3Str(f_Line)]);
   {$ENDIF}
   if not lp_ReadNextLine then
    Break;
   if not l3Same(f_Line, l3PCharLen('[topics]'), True) then
    Continue;
   while lp_ReadNextLine do
   begin
    if f_Aborted then
     Exit;
    if f_Line.S[0] = '=' then
     Break;
    {
    l_Pos := ev_lPAnsiCharIndex(' ', f_Line);
    if l_Pos < 0 then
     l_Pos := ev_lPAnsiCharIndex(cc_Tab, f_Line);
    if l_Pos > 0 then
     f_Line.SLen := l_Pos;
    }
    f_Line := l3Trim(f_Line);
    //f_ExtDocID := l3StrToIntDef(f_Line, -1);
    if ParseTopicAndArticle(f_Line, f_ExtDocID, l_ArticleNo) then
    begin
     {$IFDEF LogRelPublish}
     l3System.Msg2Log('* Попытка добавления в справку топика %d (с номером статьи %d)', [f_ExtDocID, l_ArticleNo]);
     {$ENDIF}
     Inc(theTotal);
     f_IntRelID:= 0;
     l_IntDocID := Linkserver(CurrentFamily).Renum.ConvertToRealNumber(f_ExtDocID);
     if DocumentServer(CurrentFamily).CheckDoc(l_IntDocID, True, l_IsRel) then
     begin
      if l_IsRel then
      begin
       f_IntRelID:= l_IntDocID;
       l_IntDocID:= DocumentServer(CurrentFamily).FileTbl.GetDocIdOnRelated(f_IntRelID);
      end
      else
       f_IntRelID := DocumentServer(CurrentFamily).FileTbl.GetRelated(l_IntDocID, l_Tmp);
     end; // DocumentServer(CurrentFamily).CheckDoc(l_IntDocID, True, l_IsRel)
     if f_IntRelID = 0 then
     begin
      DocError(f_ExtDocID, 'справка документа отсутствует в базе');
      {$IFDEF LogRelPublish}
      l3System.Msg2Log('* справка не найдена');
      {$ENDIF}
      f_Locked.Add(f_ExtDocID);
      Continue;
     end;
     {$IFDEF LogRelPublish}
     l3System.Msg2Log('* блокируем справку');
     {$ENDIF}
     Lock(f_intRelID, l_IntDocID);
     {$IFDEF LogRelPublish}
     l3System.Msg2Log('* справка заблокирована');
     {$ENDIF}
     try
      if ReadOnlyAccGroup(l_IntDocID) then
      begin
       {$IFDEF LogRelPublish}
       l3System.Msg2Log('* справка не допускает редактирования');
       {$ENDIF}
       DocError(f_ExtDocID, 'Группа доступа не допускает редактирование');
       f_Locked.Add(f_ExtDocID);
      end; // ReadOnlyAccGroup(f_intRelID)
      if f_Aborted then
       Exit;
      f_Filter.NextDoc;
      f_Filter.ArticleNo := l_ArticleNo;
      f_Filterer.ProcessOneID(f_IntRelID);
      case f_Filter.WorkResult of
       wrNotFound     :
        begin
         {$IFDEF LogRelPublish}
         l3System.Msg2Log('* в справке нет строки опубликования');
         {$ENDIF}
         DocError(f_ExtDocID, 'строка опубликования в справке не найдена');
         f_Locked.Add(f_ExtDocID);
        end;
       wrAlreadyExist :
        begin
         //DocError(f_ExtDocID, 'источник опубликования уже присутствует в справке');
         {$IFDEF LogRelPublish}
         l3System.Msg2Log('* уже присутствует...');
         {$ENDIF}
        end;
       wrDidTheJob    :
        begin
         {$IFDEF LogRelPublish}
         l3System.Msg2Log('* успешно!');
         {$ENDIF}
         LinkServer(CurrentFamily).LogBook.PutLogRec(l_IntDocID, acScriptHadled_AddPublInfo);
         Inc(theWorked);
        end;
      end;
     finally
      {$IFDEF LogRelPublish}
      l3System.Msg2Log('* разблокируем справку');
      {$ENDIF}
      Unlock;
      {$IFDEF LogRelPublish}
      l3System.Msg2Log('* справка разблокирована');
      {$ENDIF}
     end;
    end;
   end;
  end;
 finally
  FreeAndNil(f_text);
 end;
end;

 function lp_CheckDocID(A, B: Pointer): Long;
 begin
  Result:= CompareValue(Longint(a), Longint(b));
  l3System.Msg2Log('%d %d', [Longint(a), Longint(b)])
 end;


function TddRelPublishCorrector.ParseTopicAndArticle(aLine: Tl3WString; out theTopic, theArticle: Integer): Boolean;
var
 l_ParamNo: Integer;

 function l_OneParam(const aStr: Tl3PCharLen; IsLast: Bool): Bool;
 var
  l_Value: Integer;
 begin
  l_Value := l3StrToIntDef(aStr, 0);
  if l_Value > 0 then
  begin
   Inc(l_ParamNo);
   case l_ParamNo of
    1: theTopic := l_Value;
    2: theArticle := l_Value;
   end;
  end;
  Result := l_ParamNo < 2;
 end;
begin
 Result := False;
 theTopic := 0;
 theArticle := 0;
 l_ParamNo := 0;
 l3ParseWordsExF(aLine, l3L2WA(@l_OneParam), cc_WhiteSpace);
 Result := l_ParamNo > 0;
end;

function TddRelPublishCorrector.ReadOnlyAccGroup(aDocID: TDocID): Boolean;
var
 l_Index: long;
begin
 Result:= False;
 {$IFDEF InsiderTest}
 Exit;
 {$ENDIF InsiderTest}
 //Result:= f_RDCursor.Find(lp_CheckDocID, Pointer(aDocID), 0, Pred(f_RestrictedDocs.Count), l_Index);
 (*
 for l_Index:= 0 to Pred(f_RestrictedDocs.Count) do
 begin
  l3System.Msg2Log('%d', [Longint(f_RDCursor.GetItem(l_Index))]);
  if Longint(f_RDCursor.GetItem(l_Index)) = aDocID then
  begin
   Result:= True;
   break;
  end;
 end;
 *)
 Result:= f_RDIDList.IndexOf(aDocID) <> -1;
end;

procedure TddRelPublishCorrector.SaveLocked;
var
 l_Filer: Tl3DOSFiler;
 i: Integer;
begin
 l_Filer:= Tl3DOSFiler.Make(ConcatDirname(ExtractFileDir(f_Filer.FileName), 'LockedRelated.txt'), l3_fmWrite{l3_fmAppend});
 try
  l_Filer.Open;
  for i:= 0 to f_Locked.hi do
   l_Filer.Writeln(IntToStr(f_Locked[i]));
 finally
  FreeAndNil(l_Filer);
 end;
end;

procedure TddRelPublishCorrector.UnLock;
begin
 LockServer.UnLockDoc(CurrentFamily, f_LockHandle);
end;

function TddRelPublishCorrector.ValidFile(const aFileName: AnsiString): Boolean;
var
 l_PrevFileDateTime: TDateTime;
 l_PrevFileSize: Int64;
 l_Ini: TCfgList;
begin
 Result := False;
 if FileExists(aFileName) then
 begin
  l_Ini := TCfgList.Create(ConcatDirName(GlobalHtServer.Family[CurrentFamily].Path, 'base.ini'));
  try
   l_Ini.Section := 'Autosp.cfg';
   l_PrevFileDateTime := l_Ini.ReadParamDateTimeDef('FileDate', Now);
   l_PrevFileSize:= l_Ini.ReadParamIntDef('FileSize', 0);
   Result:= (GetFileSize(aFileName) <> l_PrevFileSize) or (FileDateTime(aFileName) <> l_PrevFileDateTime);
  finally
   FreeAndNil(l_Ini);
  end;
 end;
end;

end.